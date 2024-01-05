// app.js
const express = require('express');
const path = require('path');
const client = require('./connection.js');
const apiRouter = require('./api');

const app = express();
const port = process.env.PORT || 3001;

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

app.use('/api', apiRouter);

app.listen(port, () => {
  console.log(`App läuft auf Port ${port}`);
});
