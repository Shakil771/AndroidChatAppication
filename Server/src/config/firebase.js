const admin = require("firebase-admin");
const dotenv = require("dotenv");
dotenv.config();


const privateKey = process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, "\n");

const serviceAccount = {
  project_id: process.env.FIREBASE_PROJECT_ID,
  private_key_id: process.env.FIREBASE_PRIVATE_KEY_ID,
  private_key: privateKey,
  client_email: process.env.FIREBASE_CLIENT_EMAIL,
  client_id: process.env.FIREBASE_CLIENT_ID,
  auth_uri: process.env.FIREBASE_AUTH_URI,
  token_uri: process.env.FIREBASE_TOKEN_URI,
  auth_provider_x509_cert_url: process.env.FIREBASE_AUTH_PROVIDER_CERT_URL,
  client_x509_cert_url: process.env.FIREBASE_CLIENT_CERT_URL,
  universe_domain: process.env.FIREBASE_UNIVERSE_DOMAIN,
};

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://chat-up-6441e-default-rtdb.firebaseio.com/", // Realtime Database URL
});

const firestore = admin.firestore();
const realtimeDb = admin.database();

module.exports = { admin, firestore, realtimeDb };
