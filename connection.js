const { Client } = require('pg');

let client;

if (process.env.NODE_ENV === 'production') {
  // Verbindung zur Heroku PostgreSQL-Datenbank
  client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: {
      rejectUnauthorized: false
    }
  });
} else {
  // Lokale Verbindung
  client = new Client({
    host: "localhost",
    user: "postgres",
    port: 5432,
    password: "rootUser",
    database: "postgres"
  });
}

client.connect()
  .then(() => console.log('Connected to the database'))
  .catch(error => console.error('Error connecting to the database', error));

module.exports = client;

const client = require('./db'); // Importieren Sie Ihre PostgreSQL-Client-Instanz

// Funktion zum Abrufen aller Termine
async function getTermine() {
  try {
    const result = await client.query('SELECT * FROM t_termine');
    return result.rows;
  } catch (error) {
    console.error('Error fetching appointments', error);
    throw error;
  }
}

// Funktion zum Löschen eines Termins
async function deleteTermin(terminId) {
  try {
    await client.query('DELETE FROM t_termine WHERE t_id = $1', [terminId]);
  } catch (error) {
    console.error('Error deleting appointment', error);
    throw error;
  }
}

// Funktion zum Bearbeiten eines Termins (falls erforderlich)
async function editTermin(terminId, newData) {
  try {
    // Implementieren Sie die Logik zum Bearbeiten des Termins entsprechend Ihrer Anforderungen
  } catch (error) {
    console.error('Error editing appointment', error);
    throw error;
  }
}

module.exports = { getTermine, deleteTermin, editTermin };


