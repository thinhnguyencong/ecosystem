use curve25519_dalek::scalar::Scalar;
use rand::{ RngCore};

mod keys;
pub use keys::*;

mod pure_rust_backend;
use pure_rust_backend::*;
use super::abe::hex;

const HKDF_INFO: &[u8; 5] = b"ecies";

const AES_IV_LENGTH: usize = 12;

type AesKey = [u8; 32];
type SharedSecret = [u8; 32];

/// Generate a keypair, ready for use in ECIES
pub fn generate_keypair<R: RngCore>(rng: &mut R) -> (SecretKey, PublicKey) {
    let secret = SecretKey::generate(rng);
    let public = PublicKey::from_secret(&secret);
    (secret, public)
}

/// Encrypt a message using ECIES, it can only be decrypted by the receiver's SecretKey.
pub fn encrypt<R: RngCore>(
    receiver_pub: &PublicKey,
    msg: &[u8],
    rng: &mut R,
) -> Result<Vec<u8>, Error> {
    let (ephemeral_sk, ephemeral_pk) = generate_keypair(rng);

    let aes_key = encapsulate(&ephemeral_sk, &receiver_pub);
    let encrypted = aes_encrypt(&aes_key, msg, rng)?;

    let mut cipher_text = Vec::with_capacity(PUBLIC_KEY_LENGTH + encrypted.len());
    cipher_text.extend(ephemeral_pk.to_bytes().iter());
    cipher_text.extend(encrypted);

    Ok(cipher_text)
}

/// Decrypt a ECIES encrypted ciphertext using the receiver's SecretKey.
pub fn decrypt(receiver_sec: &SecretKey, ciphertext: &[u8]) -> Result<Vec<u8>, Error> {
    if ciphertext.len() <= PUBLIC_KEY_LENGTH {
        return Err(Error::DecryptionFailedCiphertextShort);
    }

    let ephemeral_pk = PublicKey::from_bytes(&ciphertext[..PUBLIC_KEY_LENGTH])?;
    let encrypted = &ciphertext[PUBLIC_KEY_LENGTH..];
    let aes_key = decapsulate(&receiver_sec, &ephemeral_pk);

    let decrypted = aes_decrypt(&aes_key, encrypted).map_err(|_| Error::DecryptionFailed)?;

    Ok(decrypted)
}

fn generate_shared(secret: &SecretKey, public: &PublicKey) -> SharedSecret {
    let public = public.to_point();
    let secret = Scalar::from_bits(secret.to_bytes());
    let shared_point = public * secret;
    let shared_point_compressed = shared_point.compress();

    let output = shared_point_compressed.as_bytes().to_owned();

    output
}

fn encapsulate(emphemeral_sk: &SecretKey, peer_pk: &PublicKey) -> AesKey {
    let shared_point = generate_shared(emphemeral_sk, peer_pk);

    let emphemeral_pk = PublicKey::from_secret(emphemeral_sk);

    let mut master = [0u8; 32 * 2];
    master[..32].clone_from_slice(emphemeral_pk.0.as_bytes());
    master[32..].clone_from_slice(&shared_point);

    hkdf_sha256(&master)
}

fn decapsulate(sk: &SecretKey, emphemeral_pk: &PublicKey) -> AesKey {
    let shared_point = generate_shared(sk, emphemeral_pk);

    let mut master = [0u8; 32 * 2];
    master[..32].clone_from_slice(emphemeral_pk.0.as_bytes());
    master[32..].clone_from_slice(&shared_point);

    hkdf_sha256(&master)
}

/// Error types
use thiserror::Error;

#[derive(Debug, Error)]
pub enum Error {
    /// Encryption failed
    #[error("ecies: encryption failed")]
    EncryptionFailed,

    /// Encryption failed - RNG error
    #[error("ecies: encryption failed - RNG error")]
    EncryptionFailedRng,

    /// Decryption failed
    #[error("ecies: decryption failed")]
    DecryptionFailed,

    /// Decryption failed - ciphertext too short
    #[error("ecies: decryption failed - ciphertext too short")]
    DecryptionFailedCiphertextShort,

    /// Invalid public key bytes
    #[error("ecies: invalid public key bytes")]
    InvalidPublicKeyBytes,

    /// Invalid secret key bytes
    #[error("ecies: invalid secret key bytes")]
    InvalidSecretKeyBytes,
}