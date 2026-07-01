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

app.get("/games/genre", (req, res) => {
  res.json([
    { id: 1, name: "War" },
    { id: 2, name: "Sports" },
    { id: 3, name: "Open World" },
  ]);
});

app.get("/games/type", (req, res) => {
  res.json([
    { id: 1, name: "Strategic" },
    { id: 2, name: "Third Person" },
    { id: 3, name: "First Person" },
  ]);
});

app.get("/games/engines", (req, res) => {
  res.json([
    { id: 1, name: "Unreal Engine" },
    { id: 2, name: "Unity" },
    { id: 3, name: "Godot" },
    { id: 4, name: "O3DE" },
  ]);
});

app.get("/games/platform", (req, res) => {
  res.json([
    { id: 1, name: "PC" },
    { id: 2, name: "PlayStation" },
    { id: 3, name: "Xbox" },
  ]);
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
