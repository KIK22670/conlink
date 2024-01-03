// app.js - Main application file
const express = require('express');
const path = require('path');
const db = require('./db'); // Import your database connection

const app = express();
const port = process.env.PORT || 3001;

// Statische Dateien im "public"-Ordner verfügbar machen
app.use(express.static(path.join(__dirname, 'public')));

// Routen-Handler für die Wurzel-URL
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

// Beispiel: Eine Route für das Abrufen von Daten aus der Datenbank
app.get('/getdata', (req, res) => {
  // Hier kannst du Daten aus der Datenbank abrufen und sie als JSON zurückgeben
  res.json({ message: 'Daten aus der Datenbank abgerufen' });
});

app.listen(port, () => {
  console.log(`App läuft auf Port ${port}`);
});
