// db.js - Database connection file
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
        process.exit(1); // Exit the process if unable to connect to the database
    }
    console.log('Connected to MySQL database');
});

// Gracefully close the database connection on process termination
process.on('SIGINT', () => {
    connection.end((err) => {
        if (err) {
            console.error('Error closing MySQL connection:', err);
            process.exit(1); // Exit the process if unable to close the database connection
        } else {
            console.log('MySQL connection closed gracefully');
            process.exit(0); // Exit the process after closing the database connection
        }
    });
});

// Export the connected MySQL object for use in other modules
module.exports = connection;
