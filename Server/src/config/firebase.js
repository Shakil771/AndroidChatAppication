const admin = require("firebase-admin");

const serviceAccount = require("/chat-up-6441e-firebase-adminsdk-fbsvc-82a3cc8356.json"); // Firebase Service Account Key

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://your-project-id.firebaseio.com", // Realtime Database URL
});

const firestore = admin.firestore();
const realtimeDb = admin.database();

module.exports = { admin, firestore, realtimeDb };
