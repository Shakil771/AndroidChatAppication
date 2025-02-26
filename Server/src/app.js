const express = require("express");
const userRouter = require("./route/userRoutes");

const app = express();

app.use("/api/user", userRouter)
app.get("/", (req, res) => {
    res.send("<h1>Backend Project Running</h1>"); 
});

module.exports = app;