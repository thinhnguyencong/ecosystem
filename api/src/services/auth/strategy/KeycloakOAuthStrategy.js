import { OAuthStrategy } from "./OAuthStrategy.js";

export class KeycloakOAuthStrategy extends OAuthStrategy {

  constructor(options) {
    super(options);
    this.idp = options.idp;
    this.realm = options.realm;
    this.authUrl = options.authUrl;
    this.clientId = options.clientId;
    this.clientSecret = options.clientSecret;
    this.scope = options.scope;
    this.redirectUri = options.redirectUri;
    this.tokenUrl = options.tokenUrl;
    this.tokenIntrospectUrl = options.tokenIntrospectUrl;
    this.logoutUrl = options.logoutUrl
  }

  getAuthUrl() {
    return `${this.authUrl}?response_type=code&client_id=${this.clientId}&scope=${this.scope}&redirect_uri=${this.redirectUri}`;
  }

  getLogoutUrl() {
    return `${this.logoutUrl}?post_logout_redirect_uri=${this.redirectUri}/home&client_id=${this.clientId}`;
  }

  getAuthTokenOptions(code) {
    const options = {
      method: "POST",
      uri: this.tokenUrl,
      form: {
        grant_type: "authorization_code",
        client_id: this.clientId,
        client_secret: this.clientSecret,
        redirect_uri: this.redirectUri,
        scope: this.scope,
        code
      }
    };
    return options;
  }

  getATfromRTOptions(refresh_token) {
    const options = {
      method: "POST",
      uri: this.tokenUrl,
      form: {
        grant_type: "refresh_token",
        client_id: this.clientId,
        refresh_token: refresh_token,
        client_secret: this.clientSecret,
      }
    };
    return options;
  }

  getTokenUrlOptions(token) {
    const options = {
      method: "POST",
      uri: this.tokenIntrospectUrl,
      form: {
        client_id: this.clientId,
        client_secret: this.clientSecret,
        token: token
      }
    };
    return options;
  }

  getUser(jwtAccessToken) {
    const user = {
      username: jwtAccessToken.preferred_username,
      name: jwtAccessToken.family_name + " " + jwtAccessToken.given_name
      // roles: jwtAccessToken.resource_access.react.roles
    };
    return user;
  }
}
