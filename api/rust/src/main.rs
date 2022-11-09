#[macro_use]
extern crate actix_web;

use std::{env, io};

use actix_web::{middleware, App, HttpServer};

mod protocol;
mod auth;

#[actix_rt::main]
async fn main() -> io::Result<()>{
    env::set_var("RUST_LOG", "actix_web=debug,actix_server=info");
    env_logger::init();

    HttpServer::new(move || {
        App::new()
            // enable logger - always register actix-web Logger middleware last
            .wrap(middleware::Logger::default())
            // register HTTP requests handlers
            .service(protocol::key_request)
            .service(protocol::key_request_init)

    })
    .bind("0.0.0.0:7777")?
    .run()
    .await
}
