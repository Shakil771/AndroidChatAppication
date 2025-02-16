const app = require("./app");
// const connectDatabase = require("./config/db");
// const { serverPort } = require("./secret");
const serverPort = 5002;
const http = require('http');
const initializeSocket = require("./socket");

const server = http.createServer(app);

initializeSocket(server);

server.listen(serverPort, "0.0.0.0", async () => {
  console.log(`Server is running at http://localhost:${serverPort}`);
//   await connectDatabase(); 
});