// Endpoint für den Login
app.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        // SQL-Query für den Login
        const query = `
            SELECT * FROM p_patienten WHERE p_email = ?;
        `;

        // SQL-Query ausführen
        connection.query(query, [username], async (error, results) => {
            if (error) {
                console.error('Fehler beim Login:', error);
                res.status(500).send('Fehler beim Login');
            } else {
                // Benutzer gefunden
                if (results.length > 0) {
                    const passwordMatch = await bcrypt.compare(password, results[0].p_passwort);
                    if (passwordMatch) {
                        console.log('Erfolgreich eingeloggt');
                        res.status(200).send('Erfolgreich eingeloggt');
                    } else {
                        console.log('Falsches Passwort');
                        res.status(401).send('Falsches Passwort');
                    }
                } else {
                    console.log('Benutzer nicht gefunden');
                    res.status(404).send('Benutzer nicht gefunden');
                }
            }
        });
    } catch (error) {
        console.error('Fehler beim Login:', error);
        res.status(500).send('Fehler beim Login');
    }
});
