use std::collections::HashMap;

use actix_web::post;
use actix_web::web::{Data, Json, Path};
use actix_web::{web, HttpRequest, HttpResponse, middleware::Logger};
use serde::{Deserialize, Serialize};

use backtrace::Backtrace;
use crate::auth::{self, UserData, State};

use self::abe::verify_request;

pub const APPLICATION_JSON: &str = "application/json";
pub const TEXT_HTML: &str = "text/html";

pub mod abe;
pub mod ecies;
pub mod kdcerror;
mod cache;

#[derive(Debug, Deserialize, Serialize)]
struct GenKeyResponse {
    pub key_material: String,
    pub attr: String,
    pub nonce: String,
}
#[derive(Debug, Deserialize, Serialize)]
pub struct GenKeyRequest {
    nonce: String,
    fpg: String,
    public_wallet: String,
    wallet_signature: String,
}

#[post("/key-request")]
pub async fn key_request(data: Json<GenKeyRequest>, req: HttpRequest) -> HttpResponse {
    if let Some(auth_data) = get_auth_header(&req) {
        let user_data_result = auth::authenticate(&auth_data);
        match user_data_result {
            Ok(user_data) => {
                if user_data.state == State::Deactive {
                    return HttpResponse::NotAcceptable().content_type(TEXT_HTML).body("User is deactived")
                }
                let user_data_from_cache_opt : Option<UserData> = cache::get(&data.nonce);
                match user_data_from_cache_opt {
                    Some(user_data_from_cache) => {
                        if user_data == user_data_from_cache {
                            let verify_request = abe::verify_request(
                                &data.nonce,
                                &data.fpg,
                                &data.public_wallet,
                                &data.wallet_signature,
                            );
                            match verify_request {
                                Err(error) => {
                                    return HttpResponse::Forbidden().content_type(TEXT_HTML).body(error.to_string())
                                }
                                Ok(_) => {
                                }
                            }
                            let gen_key_result = abe::gen_key(&data.nonce, &user_data);
                            match gen_key_result {
                                Ok(result) => {
                                    HttpResponse::Ok()
                                    .content_type(APPLICATION_JSON)
                                    .json(GenKeyResponse {
                                        key_material: result.0,
                                        nonce: String::from(""),
                                        attr: result.1,
                                    })
                                }
                                Err(error) => {
                                    return HttpResponse::InternalServerError().content_type(TEXT_HTML).body(error.to_string())
                                }
                            }
                        } else {
                            return HttpResponse::Forbidden().body("Fobbiden")
                        }
                    }
                    _ => {
                        Logger::new("nonce not found in cache ");
                        return HttpResponse::RequestTimeout().content_type(TEXT_HTML).body("Request Timeout")
                    }
                }
            }
            Err(_) => {
                return HttpResponse::Forbidden().body("Fobbiden")
            }
        }

        
    } else {
        HttpResponse::Ok()
            .content_type(APPLICATION_JSON)
            .json(GenKeyResponse {
                key_material: String::from("aaaaaaaaaaaaaaaaaaaaa"),
                nonce: String::from(""),
                attr: String::from(""),
            })
    }
}
#[post("/key-request-init")]
pub async fn key_request_init(req: HttpRequest) -> HttpResponse {
    match get_auth_header(&req) {
        Some(header) => {
            let user_data = auth::authenticate(&header);
            if let Ok(user_data) = user_data {
                let nonce = abe::gen_nonce(&user_data);
                HttpResponse::Ok()
                .content_type(APPLICATION_JSON)
                .json(GenKeyResponse {
                    key_material: String::from(""),
                    attr: String::from(""),
                    nonce: nonce,
                })
            } else {
                return HttpResponse::Forbidden().body("Fobbiden")
            }
            
        }
        _ => HttpResponse::Forbidden().body("Fobbiden"),
    }
}
#[post("/test-web3")]
pub async fn test_web3(data: Json<GenKeyRequest>, req: HttpRequest) -> HttpResponse {
    if let Some(auth_data) = get_auth_header(&req) {
        let user_data_result = auth::authenticate(&auth_data);
        match user_data_result {
            Ok(user_data) => {
                if user_data.state == State::Deactive {
                    return HttpResponse::NotAcceptable().content_type(TEXT_HTML).body("User is deactived")
                }
                let user_data_from_cache_opt : Option<UserData> = cache::get(&data.nonce);
                match user_data_from_cache_opt {
                    Some(user_data_from_cache) => {
                        if user_data == user_data_from_cache {
                            let verify_request = abe::verify_request(
                                &data.nonce,
                                &data.fpg,
                                &data.public_wallet,
                                &data.wallet_signature,
                            );
                            match verify_request {
                                Err(error) => {
                                    return HttpResponse::Forbidden().content_type(TEXT_HTML).body(error.to_string())
                                }
                                Ok(_) => {
                                }
                            }
                            let gen_key_result = abe::gen_key(&data.nonce, &user_data);
                            match gen_key_result {
                                Ok(result) => {
                                    HttpResponse::Ok()
                                    .content_type(APPLICATION_JSON)
                                    .json(GenKeyResponse {
                                        key_material: result.0,
                                        nonce: String::from(""),
                                        attr: result.1,
                                    })
                                }
                                Err(error) => {
                                    return HttpResponse::InternalServerError().content_type(TEXT_HTML).body(error.to_string())
                                }
                            }
                        } else {
                            return HttpResponse::Forbidden().body("Fobbiden")
                        }
                    }
                    _ => {
                        Logger::new("nonce not found in cache ");
                        return HttpResponse::RequestTimeout().content_type(TEXT_HTML).body("Request Timeout")
                    }
                }
            }
            Err(_) => {
                return HttpResponse::Forbidden().body("Fobbiden")
            }
        }

        
    } else {
        HttpResponse::Ok()
            .content_type(APPLICATION_JSON)
            .json(GenKeyResponse {
                key_material: String::from("aaaaaaaaaaaaaaaaaaaaa"),
                nonce: String::from(""),
                attr: String::from(""),
            })
    }
}
fn get_auth_header<'a>(req: &'a HttpRequest) -> Option<&'a str> {
    req.headers().get("Authorization")?.to_str().ok()
}
fn get_attribiute(auth_data: &str) -> Vec<String> {
    vec![
        String::from("attr1"),
        String::from("attr2"),
        String::from("attr3"),
    ]
}
