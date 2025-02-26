const express = require("express");
const { realtimeDb } = require("../config/firebase"); 

const userRouter = express.Router();

router.post("/update-status-realtime", async (req, res) => {
  const { uid, active } = req.body;

  if (!uid || active === undefined) {
    return res.status(400).json({ error: "Missing parameters" });
  }

  try {
    await realtimeDb.ref(`users/${uid}`).update({
      active: active,
      lastSeen: Date.now(),
    });

    return res.json({ success: true, message: "User status updated in Realtime Database!" });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
