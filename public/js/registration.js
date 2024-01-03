app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.post('/register', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;
    const confirmPassword = req.body['confirm-password'];

    // Überprüfen, ob das Passwort übereinstimmt
    if (password !== confirmPassword) {
        return res.status(400).send('Die Passwörter stimmen nicht überein.');
    }

    // Benutzerdaten in die Datenbank einfügen
    const insertUserQuery = 'INSERT INTO p_patienten (email, passwort) VALUES (?, ?)';
    db.query(insertUserQuery, [email, password], (err, result) => {
        if (err) {
            console.log('Fehler beim Einfügen des Benutzers in die Datenbank: ', err);
            return res.status(500).send('Interner Serverfehler.');
        }

        console.log('Benutzer erfolgreich in die Datenbank eingefügt.');
        res.send('Registrierung erfolgreich.');
    });
});
