use serde::{
    Serialize,
    Deserialize
};

#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, Eq)]
pub struct UserData {
    pub id: String,
    pub attr: Vec<String>,
    pub state: State
}

#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, Eq)]
pub enum State{
    Fresh,
    Deactive,
    HasKey
} 
pub fn authenticate(token: &str) -> Result<UserData, ()> {
    Ok(UserData {
        id: String::from("usertest"),
        attr: vec![String::from("attr1"), String::from("attr2"), String::from("attr3")],
        state: State::Fresh
    })
}