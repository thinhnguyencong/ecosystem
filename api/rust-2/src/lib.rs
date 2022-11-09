use jni::objects::{JClass, JList, JObject, JString};
use jni::sys::{jboolean, jobject, jobjectArray, jstring};
use jni::JNIEnv;
use serde::Deserialize;
mod auth;
mod protocol;
use crate::protocol::kdcerror::Error;
use deflate::deflate_bytes;
use ed25519_dalek::{
    Keypair as Ed25519Keypair, PublicKey as Ed25519PublicKey, SecretKey as Ed25519SecretKey,
    Signature as Ed25519Signature, Signer, Verifier as Ed25519Verifier, KEYPAIR_LENGTH,
    PUBLIC_KEY_LENGTH, SECRET_KEY_LENGTH, SIGNATURE_LENGTH,
};
use k256::PublicKey as WalletPublicKey;
use protocol::abe::hex;
use protocol::ecies::{self, PublicKey as EncryptionPublicKey, SecretKey as EncryptionSecretKey};
use rabe::{error::RabeError, schemes::bsw, utils::policy::pest::PolicyLanguage};
use rand::RngCore;
use serde::{de::DeserializeOwned, Serialize};
use serde_cbor::{from_slice, ser::to_vec_packed};
use std::time::{SystemTime, UNIX_EPOCH};
extern crate libc;

use std::ffi::{CStr,CString};
const PUBLIC_PARAMETER: &'static str = "2dd38b37d4091c05f0311e25d6bbe9988b1911d243356d636ab367b486369bddc6ab1c2dc9309a44314d114d64239b9d9ed828afe8c8a4c419d2cba9a6b03aa28c5d24844c5e8bd0acec8ffa073ef7dc7bbedf02521e2911fc7a017f0fd5bb180c656a1e6d58a88d02b586bf92f61a4542f7f07a4f9132c35a2d11124b49b7f555ca167c5cfecb885e9849107e68ca6b3ae9e9b01636b156b714e51a19e444c8571429da72f38f40a7224afea2692b07bd323fe5587dda5d686289edd0650f4db53c522e915a64521b3f60d4b8181b1e88bd9e301788e158b7f4feb0e7a212d898ac11c5891eaf22520b0f9eb0cc8e60bcc6afeb3618332d4f57c2c1943e6337b0b306c67d3ede2ca5b199da9c6678b5f87574e3b6cfb8793e337d7f7e7b2b62f6bca2bc3bb2fb1a2c9cac71ede91101a131f61ee7e85eab27e1e8c8c51d8f7f0ed181d2a05434f9e9623516dc88e3311d6945e439cdd3d7b59a177ca8031477ca26deaaa1679019911b5cc22f9c86d5b61a5f8b2783c684160d69b0e49cff6d48396dc96f27b26de056c851cc2e6f6f8183419d71c7a3a22af2dcbef2f7c32fd631ad2360df72bf71a1805b0d7f77feae46e93f81a06d2c559ea27e4827b48767a562da1fabb5b1cb6d42d29f9bd9096ad4d1c2f6360a0dab621e6d1754ee7d49ec1baac9330bccd87e02fa7eae333e83be12ec6830bb7c69963f0af5c2d19389151342f52ffbe6b2b2e99b5925c7218e776b97b95caf400da7927e593bff2cc83e3e0766eccb0f10a95423718f52d526c6f0e7de34b97d673dee3dfc76456bd69829962525d3f6397da89adf7763c3d20ba775583d1008497aa576fa5c0c89738ba9eef7ff83ae014f96a65ff098d09a2dcd1b049d8a638855e8258b9cfdb22049afb917ffd35be246d8af1e04f5cb84f3fbb6d81eb6527afdee8e8272fe7be5ecf37e2cba4451d9997533612037d7d5e80adc47688267dd39d25b9fb838471a735fb02fc61525c291a4c86fec126098b6b0847508ce1ab9a42f6da9f5672a833242b782f96ef038c9c5e60a2cda9e59873f6d0b857a45e6f2d0410f2e212e8b0b944dc9b8b57059c7650ff0921d9090f267b5ce207d07ec9316d6846468b6ccb73db6d2a8b276c25981e09e63ec14ae87211c37aa9b57f935b1a1aba84a1e64af784368650f16a7f3cf044660ab8e2a5cabb52e0261eee1010c93b0102cda34c24e896244cfb7ed2ae9a38be20fd8a3c922e6ec7831bf0e53bc3133ebc91f0b6149717ba9ef74f006a1a5a2a6cf3634340865bf79dc8c5639fbc3754bfef3d1b54c2f50258bc7cb6e8bf2bf7e8e5e5c926fbb93f779c88d7cc894cdc3e5b8cbfa57e3e3cdac69604d8aeabcc3fa54c2ab8e2855d163b576431ed61cc9e1ed3c8cf153ec28c7e9eb2fa09fd61850e6327965beabb9684af27729bd0a36ea139afea3aa6c78773dfdbe23f6d025906a4f48fccf0564121a2da1ccde87fc1d03cbb4839f1bf203dc40cee9bd231d764905fd5e9445ce9b25cdf35d8bf8ced367e219c1d81f19a0e5351e9900e5ca1b616edadd52987864453b9b0aaf125a76bd568ed5ce4a5bdc11b65f89ce60ad466248a386691e2f1ba4fe973a361cf3a4ff01";
const MASTER_KEY: &'static str = "011301ecfea200841bab91143c550cb6f41baa98177f632179621b1bfc4faf96cb1f121b0786d667a834c6f801a300a200841be3b9f26c4a9ef1721bc7ca39d8b4a3ecb31bae1f95a62038b06f1b1440e4f37949455901841bafb755489e9ba4501b8e48de404e9203081b69f942c3a0dc555e1b0127639ad6b064cd01a200841ba218f8def9a303431b8b21777f1d660f3f1b4c738c05b79429bb1b057411f7b0d8646301841b1e14c04a28006ecc1b10d698bd321fb0b81b749408e1e3011c881b1558fee438a2331102a200841b06fe5a77673982741beb84c828656684d51b1474eabbc0f804df1b0850df1d9cd6547a01841b542b81f98d8e7bfa1b2c5576ec93612b901bce1c9ab07d54a6681b0fffc754be493d03";

const secret_key_bytes: [u8; 32] = [
    // TODO: obsfucate this
    // sk: 0212131415161718011213141516171811212114151617251259720328742796
    // pk: 87696894d52af2fe0c0bd9bea740d62b341ef8cd9dbbf2e82417e933922ad30d
    0x02, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x01, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
    0x11, 0x21, 0x21, 0x14, 0x15, 0x16, 0x17, 0x25, 0x12, 0x59, 0x72, 0x03, 0x28, 0x74, 0x27, 0x96,
];

#[derive(Debug, Serialize, Deserialize)]
struct DMSDecrytionKey {
    attributes: Vec<String>,
    secret_key: bsw::CpAbeSecretKey,
    associated_public: String,
    key_id: String
}

fn retrieve_mk() -> bsw::CpAbeMasterKey {
    let mk: bsw::CpAbeMasterKey = ser_dec(MASTER_KEY).unwrap();
    mk
}
fn retrieve_pk() -> bsw::CpAbePublicKey {
    let pk: bsw::CpAbePublicKey = ser_dec(PUBLIC_PARAMETER).unwrap();
    pk
}
fn ser_dec<T: DeserializeOwned>(hex: &str) -> Result<T, Error> {
    use inflate::inflate_bytes;

    match hex::decode_hex(hex) {
        Ok(byte_slice) => match inflate_bytes(&byte_slice) {
            Ok(parsed_bin) => match from_slice(&parsed_bin) {
                Ok(parsed_res) => Ok(parsed_res),
                Err(e) => {
                    return Err(Error::new(&format!(
                        "from_slice: {}",
                        e.to_string().as_str()
                    )))
                }
            },
            Err(e) => {
                return Err(Error::new(&format!(
                    "inflate_bytes: {}",
                    e.to_string().as_str()
                )))
            }
        },
        Err(e) => return Err(Error::new(&format!("read_raw: {}", e.to_string().as_str()))),
    }
}
fn retrieve_ed25519_keypair(secret: &[u8]) -> Ed25519Keypair {
    let sk = Ed25519SecretKey::from_bytes(&secret[..SECRET_KEY_LENGTH]).unwrap();
    let pk: Ed25519PublicKey = (&sk).into();
    Ed25519Keypair {
        public: pk,
        secret: sk,
    }
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_vn_grooo_dms_ffi_Native_testNative(
    env: JNIEnv,
    _class: JClass,
    input: JString,
    input2: JString,
) -> jstring {
    let input: String = env
        .get_string(input)
        .expect("Couldn't get java string!")
        .into();
    let input2: String = env
        .get_string(input2)
        .expect("Couldn't get java string!")
        .into();
    let output = env
        .new_string(format!("Hello, {} and {}!", input, input2))
        .expect("Couldn't create java string!");
    output.into_inner()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn encrypt(
    public_data: *const libc::c_char,
    hex_data: *const libc::c_char,
) -> *const libc::c_char {
    let s1= unsafe { CStr::from_ptr(hex_data)};
    let str1 = s1.to_str().unwrap(); 
    let result_data = hex::decode_hex(&str1);
    let s2= unsafe { CStr::from_ptr(public_data)};
    let str2 = s2.to_str().unwrap(); 
    let public_data = hex::decode_hex(&str2);
    if let Ok(result_data) = result_data {
        if let Ok(public_data) = public_data {
            let pk_parsed_result = EncryptionPublicKey::from_bytes(&public_data);
            match pk_parsed_result {
                Ok(pk_1) => {
                    let mut csprng = rand::thread_rng();
                    let encrypted = ecies::encrypt(&pk_1, &result_data, &mut csprng);
                    match encrypted {
                        Ok(encrypted) => {
                            let hex_result = hex::encode_hex(&encrypted);
                            CString::new(hex_result.as_bytes()).unwrap().into_raw()
                        }
                        Err(_) => {
                            return CString::new("!!!Must be hex data".to_string().as_bytes()).unwrap().into_raw();
                        }
                    }
                }
                Err(e) => {
                    println!("error {:?}", e);
                    return CString::new("!!!Invalid public data".to_string().as_bytes()).unwrap().into_raw();
                }
            }
        } else {
            return CString::new("!!!Must be hex data".to_string().as_bytes()).unwrap().into_raw();
        }
    } else {
        return CString::new("!!!Must be hex data".to_string().as_bytes()).unwrap().into_raw();
    }
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_vn_grooo_dms_ffi_Native_encrypt0(
    env: JNIEnv,
    _class: JClass,
    hex_data: JString,
) -> jstring {
    let input: String = env
        .get_string(hex_data)
        .expect("Couldn't get java string!")
        .into();
    let result_data = hex::decode_hex(&input);
    if let Ok(result_data) = result_data {
        let sk_1 = EncryptionSecretKey::from_bytes(&secret_key_bytes).unwrap();
        let pk_1 = EncryptionPublicKey::from_secret(&sk_1);
        let mut csprng = rand::thread_rng();
        let encrypted = ecies::encrypt(&pk_1, &result_data, &mut csprng);
        match encrypted {
            Ok(encrypted) => {
                let hex_result = hex::encode_hex(&encrypted);
                env.new_string(hex_result)
                    .expect("Couldn't create java string!")
                    .into_inner()
            }
            _ => env
                .new_string(format!("!!!Must be hex data"))
                .expect("Couldn't create java string!")
                .into_inner(),
        }
    } else {
        env.new_string(format!("!!!Must be hex data"))
            .expect("Couldn't create java string!")
            .into_inner()
    }
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_vn_grooo_dms_ffi_Native_decrypt0(
    env: JNIEnv,
    _class: JClass,
    hex_encrypted: JString,
) -> jstring {
    let input: String = env
        .get_string(hex_encrypted)
        .expect("Couldn't get java string!")
        .into();
    let result_data = hex::decode_hex(&input);
    if let Ok(result_data) = result_data {
        let sk_1 = EncryptionSecretKey::from_bytes(&secret_key_bytes).unwrap();
        let encrypted = ecies::decrypt(&sk_1, &result_data);
        match encrypted {
            Ok(encrypted) => {
                let hex_result = hex::encode_hex(&encrypted);
                env.new_string(hex_result)
                    .expect("Couldn't create java string!")
                    .into_inner()
            }
            _ => env
                .new_string(format!("!!!Must be hex data"))
                .expect("Couldn't create java string!")
                .into_inner(),
        }
    } else {
        env.new_string(format!("!!!Must be hex data"))
            .expect("Couldn't create java string!")
            .into_inner()
    }
}
#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_vn_grooo_dms_ffi_Native_sign0(
    env: JNIEnv,
    _class: JClass,
    hex_data: JString,
) -> jstring {
    let input: String = env
        .get_string(hex_data)
        .expect("Couldn't get java string!")
        .into();
    let result_data = hex::decode_hex(&input);
    if let Ok(result_data) = result_data {
        let shared_keypair = retrieve_ed25519_keypair(&secret_key_bytes);
        let signature: Ed25519Signature = shared_keypair.sign(&result_data);
        let signature_hex = hex::encode_hex(&signature.to_bytes());
        env.new_string(signature_hex)
            .expect("Couldn't create java string!")
            .into_inner()
    } else {
        env.new_string(format!("!!!Must be hex data"))
            .expect("Couldn't create java string!")
            .into_inner()
    }
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn verify(
    hex_data: *const libc::c_char,
    hex_signature: *const libc::c_char,
) -> bool {
    let s1 = unsafe { CStr::from_ptr(hex_data) };
    let str1 = s1.to_str().unwrap();

    let s2 = unsafe { CStr::from_ptr(hex_signature) };
    let str2 = s2.to_str().unwrap();

    let hex_data = hex::decode_hex(&str1); 
    match hex_data {
        Ok(hex_data) => match hex::decode_hex(&str2) {
            Ok(hex_signature) => {
                let result = Ed25519Signature::from_bytes(&hex_signature);
                match result {
                    Ok(signature) => {
                        let shared_keypair = retrieve_ed25519_keypair(&secret_key_bytes);
                        if shared_keypair.verify(&hex_data, &signature).is_ok() {
                            return true;
                        } else {
                            return false;
                        }
                    }
                    _ => {
                        return false;
                    }
                }
            }
            _ => {
                return false;
            }
        },
        _ => {
            return false;
        }
    }
    true
}
fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern fn generate_key(
    attributes: *const libc::c_char,
    associated_public: *const libc::c_char,
    user_id: *const libc::c_char,
) -> *const libc::c_char{
    let s1= unsafe { CStr::from_ptr(attributes)};
    let str1 = s1.to_str().unwrap(); 
    let s2= unsafe { CStr::from_ptr(associated_public)};
    let str2 = s2.to_str().unwrap();
    let s3= unsafe { CStr::from_ptr(user_id)};
    let str3 = s3.to_str().unwrap();
    let attrs: Vec<String> = str1
        .rsplit("::")
        .map(|str| String::from(str))
        .collect();
    println!("[Module] - Attributes gen key: {:?}", attrs);
    let mk = retrieve_mk();
    let pk = retrieve_pk();
    let sk_opt = bsw::keygen(&pk, &mk, &attrs);
    match sk_opt {
        Some(sk) => {
            let start = SystemTime::now();
            let since_the_epoch = start
            .duration_since(UNIX_EPOCH)
            .expect("Time went backwards");
            let new_key_id = format!("{}-{:?}", &str3, since_the_epoch);
            let dms_key = DMSDecrytionKey {
                associated_public: str2.to_string(),
                attributes: attrs,
                secret_key: sk,
                key_id: new_key_id
            };
            let dms_key_hex = ser_enc(dms_key);
            let output = dms_key_hex.as_str();
            return CString::new(output.to_string().as_bytes()).unwrap().into_raw()
        }
        None => 
        CString::new("".to_string().as_bytes()).unwrap().into_raw()
    }
}


#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_vn_grooo_dms_ffi_Native_getPublicParameter(
    env: JNIEnv,
    _class: JClass,
) -> jstring {
    let output = env
        .new_string(format!("{}", PUBLIC_PARAMETER))
        .expect("Couldn't create java string!");
    output.into_inner()
}
fn ser_enc<T: Serialize>(input: T) -> String {
    use rustc_hex::ToHex;
    deflate_bytes(&to_vec_packed(&input).unwrap()).to_hex()
}
