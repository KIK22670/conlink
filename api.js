// api.js
const express = require('express');
const router = express.Router();
const client = require('./connection.js');

// Middleware, um die Verbindung zu öffnen
router.use((req, res, next) => {
    client.connect();
    next();
});

router.get('/aerzte', (req, res) => {
    client.query('SELECT * FROM a_aerzte', (err, result) => {
        if (!err) {
            res.send(result.rows);
        } else {
            console.error(err);
            res.status(500).send('Internal Server Error');
        }
    });
});

router.post('/register', (req, res) => {
    const { email, password, confirmPassword, p_id } = req.body;

    if (password !== confirmPassword) {
        return res.status(400).json({ error: 'Passwords do not match' });
    }

    // Füge den Benutzer zur Datenbank hinzu, ohne u_id explizit anzugeben
    const query = 'INSERT INTO u_userverwaltung (u_email, u_passwort, u_p_id) VALUES ($1, $2, $3) RETURNING *';
    const values = [email, password, p_id]; // Verwende p_id für u_p_id

    client.query(query, values, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        res.status(201).json({ message: 'User registered successfully', user: result.rows[0] });
    });
});




// Middleware, um die Verbindung zu schließen
router.use((req, res, next) => {
    client.end();
    next();
});

module.exports = router;
