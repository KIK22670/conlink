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
app.use(express.urlencoded({ extended: false }));
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
    // Check if the email is already registered
    const checkEmailQuery = {
      text: 'SELECT * FROM u_userverwaltung WHERE u_email = $1',
      values: [emailregister],
    };

    const emailCheckResult = await client.query(checkEmailQuery);

    if (emailCheckResult.rows.length > 0) {
      // Email is already registered
      return res.status(400).json({ error: 'Email already exists' });
    }

    // If email is not registered, proceed with registration
    const hashedPassword = await bcrypt.hash(passwortregister, 10);

    const insertUserQuery = {
      text: 'INSERT INTO u_userverwaltung(u_email, u_passwort) VALUES($1, $2) RETURNING *',
      values: [emailregister, hashedPassword],
    };

    const result = await client.query(insertUserQuery);
    console.log(result);
    res.status(201).json({ message: 'User registered successfully' });
    res.redirect('/login.html');
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.post('/login', async (req, res) => {
  try {
    const { email, passwort } = req.body;

    // Log Request Body
    console.log('Request Body:', req.body);

    // Check if password is provided
    if (!passwort) {
      console.log('Password is required');
      return res.status(400).json({ error: 'Password is required' });
    }

    // Database Query
    const query = {
      text: 'SELECT * FROM u_userverwaltung WHERE LOWER(u_email) = LOWER($1)',
      values: [email.toLowerCase()],
    };
    
    const result = await client.query(query);

    // Log Database Query Result
    console.log('Database Query Result:', result.rows);

    if (result.rows.length === 1) {
      console.log('User found in the database');
      const user = result.rows[0];

      if (user.u_passwort) {
        console.log('User has a hashed password');

        // Check if hashed password is defined
        if (bcrypt.compareSync(passwort, user.u_passwort)) {
          console.log('Password comparison successful');
          res.status(200).json({ message: 'Login successful' });
        } else {
          console.log('Incorrect email or password');
          res.status(401).json({ error: 'Invalid email or password' });
        }
      } else {
        console.log('User does not have a hashed password');
        res.status(401).json({ error: 'Invalid email or password' });
      }
    } else {
      console.log('No user found with the provided email');
      res.status(401).json({ error: 'Invalid email or password' });
    }
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ error: error.message });
  }
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
