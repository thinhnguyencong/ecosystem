# Set up
Configurate all the .env file(based on .env.example) then run the following command:
- `docker-compose up -d`

Go to the [Keycloak Admin Console](http://localhost:8080) and login with the username and password you created earlier. (In this example we use admin/admin)

Add some users.

In `Client Details`, switch `On` in Client authentication, so that we can enable the `Credentials tab`. In `Credentials Tab`, we copy the client secret into .env file in api/.env

Open [http://localhost:3000](http://localhost:3000) and [http://localhost:3001](http://localhost:3001) to view it in your browser.

# (Old) SSO with Keycloak and ReactJs, Nodejs

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

This is a react application used to view your cryptocurrency balance of an account and also transfer some token to another account. 

We make use of `Web3` dependency to communicate with a remote Blockchain Test Network called [Testnet BNB](https://testnet.bscscan.com/). 

Using Web3, we can view the current account balance and also transfer tokens from one account to another. 

You can first run the authenticate server Keycloak using the following command :

- `docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:19.0.3 start-dev`

Go to the [Keycloak Admin Console](http://localhost:8080) and login with the username and password you created earlier. (In this example we use admin/admin)

You create a realm call `demo` and 2 client named `wallet` and `auction`, [Getting started Keycloak](https://www.keycloak.org/getting-started/getting-started-docker)

Add some users.

In `Client Details`, switch `On` in Client authentication, so that we can enable the `Credentials tab`. In `Credentials Tab`, we copy the client secret into .env file in api/.env


Next, you can start the application(wallet-management and auction-client) using the folowing command: 
- `npm install`
- `npm start`

Start server : 
- `npm install`
- `npm run dev`

    This runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) and [http://localhost:3001](http://localhost:3001) to view it in your browser.

