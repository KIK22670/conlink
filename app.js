const express = require('express');
const app = express();
const port = process.env.PORT || 3001; // Ändere die Portnummer auf 3001 oder eine andere, die nicht verwendet wird

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(port, () => {
    console.log(`App läuft auf Port ${port}`);
});
