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