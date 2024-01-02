const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 3001;

// Statische Dateien im "public"-Ordner verfügbar machen
app.use(express.static(path.join(__dirname, 'public')));

// Routen-Handler für die Wurzel-URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

app.listen(port, () => {
    console.log(`App läuft auf Port ${port}`);
});

// Datenbankanbindung 

const mysql = require('mysql2');

// Verbindungsdaten
const connection = mysql.createConnection({
  host: 'n2o93bb1bwmn0zle.chr7pe7iynqr.eu-west-1.rds.amazonaws.com',
  user: 'yew35uqf7sg87wv2',
  password: 'r8v2qjt9v4dw366q',
  database: 'ctj5xspgksi2kx59',
  port: 3306
});

// Verbindung herstellen
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
  } else {
    console.log('Connected to MySQL database');
  }
});

// Verbindung schließen, wenn sie nicht mehr benötigt wird
connection.end();

