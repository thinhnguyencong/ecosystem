import { KeycloakOAuthStrategy } from "./KeycloakOAuthStrategy.js"

function keycloakOptions(clientId, redirect_uri) {
  const options = {
    idp: process.env.IDENTITY_PROVIDER,
    realm: process.env.REALM,
    authUrl: process.env.KEYCLOAK_DEMO_SSO_AUTH_URL,
    tokenIntrospectUrl: process.env.KEYCLOAK_DEMO_SSO_TOKEN_INTROSPECT,
    scope: process.env.KEYCLOAK_DEMO_SSO_SCOPE,
    tokenUrl: process.env.KEYCLOAK_DEMO_SSO_TOKEN_URL,
    logoutUrl: process.env.KEYCLOAK_DEMO_SSO_LOGOUT
  }
  switch(clientId) {
    case process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID:
      return {
        ...options,
        clientId: process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID,
        clientSecret: process.env.KEYCLOAK_DEMO_SSO_CLIENT_SECRET,
        redirectUri: redirect_uri ?? process.env.SSO_REDIRECT_URI,
      };
    case process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID_2:
      return {
        ...options,
        clientId: process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID_2,
        clientSecret: process.env.KEYCLOAK_DEMO_SSO_CLIENT_SECRET_2,
        redirectUri: redirect_uri ?? process.env.SSO_REDIRECT_URI_2,
      };
    case process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID_3:
      return {
        ...options,
        clientId: process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID_3,
        clientSecret: process.env.KEYCLOAK_DEMO_SSO_CLIENT_SECRET_3,
        redirectUri: redirect_uri ?? process.env.SSO_REDIRECT_URI_3,
      };
  }
}

export class OAuthStrategies {
  constructor(clientId, redirect_uri) {
    this.strategy = new KeycloakOAuthStrategy(keycloakOptions(clientId, redirect_uri))
  }

  getStrategy() {
    // console.log(this.strategy);
    return this.strategy;
  }
}
