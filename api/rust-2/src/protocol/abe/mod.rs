pub(crate) mod hex;
use k256::{PublicKey as WalletPublicKey, ecdsa:: {VerifyingKey as WalletVerifyingKey, signature::Verifier as WalletVerifier, signature::Signature as WalletSignature}};
use serde::{
    de::DeserializeOwned,
    Serialize
};
use deflate::deflate_bytes;
use serde_cbor::{
    ser::to_vec_packed,
    from_slice
};
use std::time::Duration;
use rand::RngCore;
use rabe::{
    error::RabeError,
    schemes::{
        bsw,
    },
    utils::{
        policy::pest::PolicyLanguage,
    }
};
use actix_web::{middleware::Logger, App};
use super::ecies::{PublicKey as EncryptionPublicKey, SecretKey as EncryptionSecretKey, self};
use ed25519_dalek::{
    Signature as Ed25519Signature, 
    Verifier as Ed25519Verifier, 
    Keypair as Ed25519Keypair,
    PUBLIC_KEY_LENGTH, 
    SECRET_KEY_LENGTH, 
    KEYPAIR_LENGTH, 
    SIGNATURE_LENGTH, 
    SecretKey as Ed25519SecretKey, 
    PublicKey as Ed25519PublicKey};
use crate::auth::UserData;

use super::{kdcerror::Error, cache};

const PUBLIC_PARAMETER: &'static str = "2dd38b37d4091c05f0311e25d6bbe9988b1911d243356d636ab367b486369bddc6ab1c2dc9309a44314d114d64239b9d9ed828afe8c8a4c419d2cba9a6b03aa28c5d24844c5e8bd0acec8ffa073ef7dc7bbedf02521e2911fc7a017f0fd5bb180c656a1e6d58a88d02b586bf92f61a4542f7f07a4f9132c35a2d11124b49b7f555ca167c5cfecb885e9849107e68ca6b3ae9e9b01636b156b714e51a19e444c8571429da72f38f40a7224afea2692b07bd323fe5587dda5d686289edd0650f4db53c522e915a64521b3f60d4b8181b1e88bd9e301788e158b7f4feb0e7a212d898ac11c5891eaf22520b0f9eb0cc8e60bcc6afeb3618332d4f57c2c1943e6337b0b306c67d3ede2ca5b199da9c6678b5f87574e3b6cfb8793e337d7f7e7b2b62f6bca2bc3bb2fb1a2c9cac71ede91101a131f61ee7e85eab27e1e8c8c51d8f7f0ed181d2a05434f9e9623516dc88e3311d6945e439cdd3d7b59a177ca8031477ca26deaaa1679019911b5cc22f9c86d5b61a5f8b2783c684160d69b0e49cff6d48396dc96f27b26de056c851cc2e6f6f8183419d71c7a3a22af2dcbef2f7c32fd631ad2360df72bf71a1805b0d7f77feae46e93f81a06d2c559ea27e4827b48767a562da1fabb5b1cb6d42d29f9bd9096ad4d1c2f6360a0dab621e6d1754ee7d49ec1baac9330bccd87e02fa7eae333e83be12ec6830bb7c69963f0af5c2d19389151342f52ffbe6b2b2e99b5925c7218e776b97b95caf400da7927e593bff2cc83e3e0766eccb0f10a95423718f52d526c6f0e7de34b97d673dee3dfc76456bd69829962525d3f6397da89adf7763c3d20ba775583d1008497aa576fa5c0c89738ba9eef7ff83ae014f96a65ff098d09a2dcd1b049d8a638855e8258b9cfdb22049afb917ffd35be246d8af1e04f5cb84f3fbb6d81eb6527afdee8e8272fe7be5ecf37e2cba4451d9997533612037d7d5e80adc47688267dd39d25b9fb838471a735fb02fc61525c291a4c86fec126098b6b0847508ce1ab9a42f6da9f5672a833242b782f96ef038c9c5e60a2cda9e59873f6d0b857a45e6f2d0410f2e212e8b0b944dc9b8b57059c7650ff0921d9090f267b5ce207d07ec9316d6846468b6ccb73db6d2a8b276c25981e09e63ec14ae87211c37aa9b57f935b1a1aba84a1e64af784368650f16a7f3cf044660ab8e2a5cabb52e0261eee1010c93b0102cda34c24e896244cfb7ed2ae9a38be20fd8a3c922e6ec7831bf0e53bc3133ebc91f0b6149717ba9ef74f006a1a5a2a6cf3634340865bf79dc8c5639fbc3754bfef3d1b54c2f50258bc7cb6e8bf2bf7e8e5e5c926fbb93f779c88d7cc894cdc3e5b8cbfa57e3e3cdac69604d8aeabcc3fa54c2ab8e2855d163b576431ed61cc9e1ed3c8cf153ec28c7e9eb2fa09fd61850e6327965beabb9684af27729bd0a36ea139afea3aa6c78773dfdbe23f6d025906a4f48fccf0564121a2da1ccde87fc1d03cbb4839f1bf203dc40cee9bd231d764905fd5e9445ce9b25cdf35d8bf8ced367e219c1d81f19a0e5351e9900e5ca1b616edadd52987864453b9b0aaf125a76bd568ed5ce4a5bdc11b65f89ce60ad466248a386691e2f1ba4fe973a361cf3a4ff01";
const MASTER_KEY: &'static str = "011301ecfea200841bab91143c550cb6f41baa98177f632179621b1bfc4faf96cb1f121b0786d667a834c6f801a300a200841be3b9f26c4a9ef1721bc7ca39d8b4a3ecb31bae1f95a62038b06f1b1440e4f37949455901841bafb755489e9ba4501b8e48de404e9203081b69f942c3a0dc555e1b0127639ad6b064cd01a200841ba218f8def9a303431b8b21777f1d660f3f1b4c738c05b79429bb1b057411f7b0d8646301841b1e14c04a28006ecc1b10d698bd321fb0b81b749408e1e3011c881b1558fee438a2331102a200841b06fe5a77673982741beb84c828656684d51b1474eabbc0f804df1b0850df1d9cd6547a01841b542b81f98d8e7bfa1b2c5576ec93612b901bce1c9ab07d54a6681b0fffc754be493d03";

const secret_key_bytes: [u8; 32] = [
    // TODO: obsfucate this
    // sk: 0212131415161718011213141516171811212114151617251259720328742796
    // pk: 87696894d52af2fe0c0bd9bea740d62b341ef8cd9dbbf2e82417e933922ad30d
    0x02, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x01, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x11, 0x21, 0x21, 0x14, 0x15,
    0x16, 0x17, 0x25, 0x12, 0x59, 0x72, 0x03, 0x28, 0x74, 0x27, 0x96,
];

fn retrieve_ed25519_keypair(secret: &[u8]) -> Ed25519Keypair {
    
    let sk = Ed25519SecretKey::from_bytes(&secret[..SECRET_KEY_LENGTH]).unwrap();
    let pk: Ed25519PublicKey = (&sk).into();
    println!("Public key bytes: {:?} and ", pk);
    Ed25519Keypair{ public: pk, secret: sk }
}

pub fn verify_request(nonce: &str, fpg: &str, pub_wallet: &str, wallet_signature: &str) -> Result<(), Error>{
    let nonce_bytes = hex::decode_hex(nonce)?;
    if nonce_bytes.len() != 64 {
        return Err(Error::new("Nonce must be 64 bytes length"))
    }
    let pub_wallet_bytes = hex::decode_hex(pub_wallet)?;
    let fpg_bytes = hex::decode_hex(fpg)?;
    let fpg_signature : Ed25519Signature = Ed25519Signature::from_bytes(&fpg_bytes)?;
    let shared_keypair = retrieve_ed25519_keypair(&secret_key_bytes);
    if !shared_keypair.verify(&nonce_bytes, &fpg_signature).is_ok() {
        return Err(Error::new("fgp value invalid"))
    }
    let wallet_signature_bytes = hex::decode_hex(wallet_signature)?;
    println!("Omit checking wallet public key");
    Ok(())
    // if let Ok(public_key_wallet) = WalletPublicKey::from_sec1_bytes(&pub_wallet_bytes[..]) {
    //     println!("Public key wallet: {:?}", &public_key_wallet);
    //     let verifying_key = WalletVerifyingKey::from(&public_key_wallet);
    //     let signature : k256::ecdsa::Signature = WalletSignature::from_bytes(&wallet_signature_bytes[..])?;
    //     if verifying_key.verify(&nonce_bytes[..], &signature).is_ok() {
    //         Logger::new(&format!("Verify wallet with public key: {} successfully" , &pub_wallet));
    //         Ok(())
    //     } else {
    //         return Err(Error::new("Verify wallet signature failed"));
    //     }
    // } else {
    //     return Err(Error::new("Invalid wallet public key"));
    // }
}
pub fn gen_nonce(user: &UserData) -> String {
    let mut seed = [0u8; 32];
    rand::thread_rng().fill_bytes(&mut seed);
    let hex = hex::encode_hex(&seed);
    cache::put(&hex, user, Duration::from_secs(60 * 5));
    hex
}
pub fn gen_key(nonce: &str, user: &UserData) -> Result<(String, String), Error>{
    println!("About to generate key for user {} with attributes {:?} ", &user.id, &user.attr);
    let mk = retrieve_mk();
    let pk = retrieve_pk();
    let sk_opt = bsw::keygen(&pk, &mk, &user.attr);
    match sk_opt {
        Some(sk) => {
            let sk_bytes = deflate_bytes(&to_vec_packed(&sk).unwrap());
            let encrypted_key = encrypt_key(nonce, sk_bytes)?;
            let attrs = user.attr.join(";");
            Ok((encrypted_key, attrs))
        }
        None => {
            Err(Error::new("Unable to generate new key"))
        }
    }
}
fn encrypt_key(nonce: &str, sk: Vec<u8>) -> Result<String, Error> {
    let sk_1 = EncryptionSecretKey::from_bytes(&secret_key_bytes).unwrap();
    let pk_1 = EncryptionPublicKey::from_secret(&sk_1);
    println!("Secet key bytes from secret: {}", hex::encode_hex(sk_1.as_bytes()));
    println!("Public key bytes from secret: {}", hex::encode_hex(pk_1.as_bytes()));
    let nonce_bytes = hex::decode_hex(nonce)?;

    let public_key_bytes = &nonce_bytes[32..];
    println!("Public key bytes from encrypt key: {}", hex::encode_hex(&public_key_bytes));
    let pub_key_enc = EncryptionPublicKey::from_bytes(public_key_bytes)?;
    let mut csprng = rand::thread_rng();
    let encrypted = ecies::encrypt(&pk_1, &sk, &mut csprng)?;
    Ok(hex::encode_hex(&encrypted))
}
fn retrieve_mk() -> bsw::CpAbeMasterKey{
    let mk : bsw::CpAbeMasterKey = ser_dec(MASTER_KEY).unwrap();
    mk
}
fn retrieve_pk() -> bsw::CpAbePublicKey{
    let pk : bsw::CpAbePublicKey = ser_dec(PUBLIC_PARAMETER).unwrap();
    pk
}
fn ser_dec<T: DeserializeOwned>(hex: &str) -> Result<T, Error> {
    use inflate::inflate_bytes;

    match hex::decode_hex(hex) {
        Ok(byte_slice) => {
            match inflate_bytes(&byte_slice) {
                Ok(parsed_bin) => {
                    match from_slice(&parsed_bin) {
                        Ok(parsed_res) => Ok(parsed_res),
                        Err(e) => return Err(Error::new(&format!("from_slice: {}", e.to_string().as_str())))
                    }
                },
                Err(e) => return Err(Error::new(&format!("inflate_bytes: {}", e.to_string().as_str())))
            }
        },
        Err(e) => return Err(Error::new(&format!("read_raw: {}", e.to_string().as_str())))
    }
}