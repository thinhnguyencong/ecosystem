use std::{
    fmt::{Display, Formatter, Result},
    num::ParseIntError,
};
use super::ecies::Error as ECIESError;
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Error {
    details: String,
}

impl Error {
    /// Creates a new Error
    pub fn new(msg: &str) -> Error {
        Error {
            details: msg.to_string(),
        }
    }
}
impl From<ParseIntError> for Error {
    fn from(item: ParseIntError) -> Self {
        Error {
            details: String::from("Cannot convert integer to hex string"),
        }
    }
}
impl From<k256::ecdsa::Error> for Error {
    fn from(item: k256::ecdsa::Error) -> Self {
        Error {
            details: item.to_string(),
        }
    }
}
impl From<ECIESError> for Error {
    fn from(item: ECIESError) -> Self {
        match item {
            ECIESError::DecryptionFailed => Error {
                details: String::from("Decryption failed"),
            },
            ECIESError::EncryptionFailed => Error {
                details: String::from("Encryption failed"),
            },
            ECIESError::EncryptionFailedRng => Error {
                details: String::from("Encryption failed - RNG error"),
            },
            ECIESError::DecryptionFailedCiphertextShort => Error {
                details: String::from("Decryption failed - ciphertext too short"),
            },
            ECIESError::InvalidPublicKeyBytes => Error {
                details: String::from("Invalid public key bytes"),
            },
            ECIESError::InvalidSecretKeyBytes => Error {
                details: String::from("Invalid secret key bytes"),
            },
            _ => Error {
                details: String::from("Unknown error during encryption"),
            }
        }
        
    }
}
impl Display for Error {
    fn fmt(&self, f: &mut Formatter) -> Result {
        write!(f, "Error: {}", self.details)
    }
}

impl std::error::Error for Error {}
