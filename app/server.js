const express = require("express");
const app = express();

app.use(express.json());

// Simple GET API

app.get("/health", (req, res) => {
  res.json({ status: "healthy" });
});

app.get("/games", (req, res) => {
  res.json([
    { id: 1, name: "Call of Duty 2", year: 2005 },
    { id: 2, name: "Far Cry 3", year: 2012 },
    { id: 3, name: "Prototype 1", year: 2009 },
  ]);
});

app.post("/games", (req, res) => {
  const game = req.body;
  res.json({
    message: "New game has been saved",
    data: game,
  });
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
