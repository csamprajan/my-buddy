import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { Issuer, generators, BaseClient, AuthorizationParameters } from 'openid-client';
import { startIotaFlow } from './iota/start-redirect-flow';

dotenv.config();

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

const PORT = process.env.PORT || 3001;

type CodeVerifier = string;  // Define a type for codeVerifier

const code_verifier: CodeVerifier = generators.codeVerifier();

const getClient = async (): Promise<BaseClient> => { // Use Promise for asynchronous function
    try {
        const affinidi = await Issuer.discover(process.env.PROVIDER_ISSUER!);
        const client = new affinidi.Client({
            client_id: process.env.PROVIDER_CLIENT_ID!,
            redirect_uris: [process.env.PROVIDER_REDIRECT_URL!],
            response_types: ['code'],
            token_endpoint_auth_method: 'none',
        });
        return client;

    } catch (error) {
        console.error('getClient error:', error);
        throw new Error('getClient failed');  // Throw specific error
    }
};

interface InitParams {
  code_challenge: string;
  code_challenge_method: string;
  response_type: string;
  scope: string;
  state: string;
}

const initializeServer = async () => {

    app.get('/', (req, res, next) => {
        res.json({ success: 'Express' });
    });

    app.use(cors({ credentials: true, origin: true }));
    app.set('trust proxy', 1);

    app.get('/api/affinidi-auth/init', async (req, res, next) => {

        const state = generators.state();
        // const code_verifier = generators.codeVerifier(); // Removed as already defined

        const params: AuthorizationParameters = {
            code_challenge: generators.codeChallenge(code_verifier),
            code_challenge_method: 'S256',
            response_type: 'code',
            scope: 'openid',
            state,
        }

        const client = await getClient();

        const authorizationUrl = client.authorizationUrl(params);

        res.send({ authorizationUrl });
    });

    interface CompleteBody {
        code: string;
        state: string;
    }

    app.post('/api/affinidi-auth/complete', async (req, res, next) => {

        const { code, state }: CompleteBody = req.body; // Use destructuring and type assertion
        if (!code || !state || !code_verifier) {
            res.status(400).send({
                error: 'Invalid data code/state is missing'
            });
            return;
        }
        try {

            const client = await getClient();

            const tokenSet = await client.callback(process.env.PROVIDER_REDIRECT_URL, { code, state },
                { state, code_verifier });
            console.log('tokenSet', tokenSet);

            const id_token = tokenSet.id_token;
            const token = JSON.parse(Buffer.from(id_token!.split('.')[1], 'base64').toString());

            console.log('id_token', token);
            const user = {
                ...token
            };

            res.send({ user });
        } catch (error:any) {
            res.status(400).send({
                error: error.message
            });
        }

    });

      
      app.use('/.well-known/assetlinks.json', express.static('assetlinks.json'));
      app.use('/.well-known/did.json', express.static('879ea1b09c909e90548ff0ac3fb568dc-did-document.json'));
      
      app.use('/testlink', express.static('testlink.html'));
      app.get('/api/iota/start-redirect-flow', startIotaFlow);
    app.listen(PORT, () => {
        console.log(`Server listening on ${PORT}`);
    });

}

initializeServer();