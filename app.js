const express = require('express');
const path = require('path');
const morgan = require('morgan');
const client = require('./connection.js');
const apiRouter = require('./api');
const bcrypt = require('bcrypt');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3001;

app.use(morgan('combined'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/node_modules', express.static(path.join(__dirname, 'node_modules')));
app.use(cors()); // Enable CORS

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

app.get('/registration', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'registration.html'));
});

app.post('/registration', async (req, res) => {
  const { emailregister, passwortregister } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(passwortregister, 10);

    const query = {
      text: 'INSERT INTO u_userverwaltung(u_email, u_passwort) VALUES($1, $2)',
      values: [emailregister, hashedPassword],
    };

    const result = await client.query(query);

    console.log(result);
    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.get('/doctor/:id', async (req, res) => {
  try {
    console.log('Anfrage für Arzt mit ID:', req.params.id);

    const doctorId = req.params.id;
    const query = {
      text: 'SELECT * FROM a_aerzte WHERE a_id = $1',
      values: [doctorId],
    };

    const result = await client.query(query);

    console.log('Ergebnis der Datenbankabfrage:', result.rows);

    if (result.error) {
      console.error('Fehler bei der Datenbankabfrage:', result.error);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }

    if (result.rows.length > 0) {
      res.status(200).json(result.rows[0]);
    } else {
      res.status(404).json({ error: 'Arzt nicht gefunden' });
    }
  } catch (error) {
    console.error('Fehler in der Route /doctor/:id:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.use('/api', apiRouter);

app.listen(port, () => {
  console.log(`App läuft auf Port ${port}`);
});
