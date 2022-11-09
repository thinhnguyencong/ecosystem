use std::{time::Duration, collections::HashMap};
use serde::{
    Serialize
};

use crate::auth::{UserData, State};


pub fn put<T>(id: &str, data:  T, duration: Duration) where T: Serialize{

    
}
pub fn get(id: &str) -> Option<UserData> {
    Some(UserData {
        id: String::from("usertest"),
        attr: vec![String::from("attr1"), String::from("attr2"), String::from("attr3")],
        state: State::Fresh
    })
}