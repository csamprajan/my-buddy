// import { Environment, EnvironmentUtils } from './environment'

const LOCAL_VAULT_URL = 'http://localhost:3001';
const DEV_VAULT_URL = 'https://vault.dev.affinidi.com';
const PROD_VAULT_URL = 'https://vault.affinidi.com';

// const envToWebVaultUrlMap = {
//   [Environment.LOCAL]: LOCAL_VAULT_URL,
//   [Environment.DEVELOPMENT]: DEV_VAULT_URL,
//   [Environment.PRODUCTION]: PROD_VAULT_URL,
// }
class EnvironmentUtils {
  static String fetchEnvironment() {
    // Implement logic to fetch the current environment (e.g., dev, staging, prod)
    return 'prod'; // Replace with actual logic
  }
}

const envToWebVaultUrlMap = {
  'local': LOCAL_VAULT_URL,
  'dev': DEV_VAULT_URL,
  'prod': PROD_VAULT_URL,
};

const SHARE_PATH = '/login';
const CLAIM_PATH = '/claim';

class VaultUtils {
  static String buildShareLink(String request, String clientId) {
    final env = EnvironmentUtils.fetchEnvironment();
    final params = Uri.parse('').queryParameters;
    params['request'] = request;
    params['client_id'] = clientId;
    final queryString = params.toString();
    return '${envToWebVaultUrlMap[env] ?? PROD_VAULT_URL}${SHARE_PATH}?${queryString}';
  }

  static String buildClaimLink(String credentialOfferUri) {
    final env = EnvironmentUtils.fetchEnvironment();
    final params = Uri.parse('').queryParameters;
    params['credential_offer_uri'] = credentialOfferUri;
    final queryString = params.toString();
    return '${envToWebVaultUrlMap[env] ?? PROD_VAULT_URL}${CLAIM_PATH}?${queryString}';
  }
}
