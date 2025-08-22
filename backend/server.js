const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());

const PORT = process.env.PORT || 3000;

// Simple health check
app.get("/api/health", (req, res) => {
  res.json({ ok: true, env: process.env.NODE_ENV || "development", time: new Date().toISOString() });
});

// Demo endpoint used by the frontend
// To show an update in the video, change v1 -> v2 and push to master
app.get("/api/hello", (req, res) => {
  res.json({
    message: "Hello from backend v1",
    version: "v1",
    serverTime: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`[backend] listening on port ${PORT}`);
});
