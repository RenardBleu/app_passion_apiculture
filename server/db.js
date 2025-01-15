require('dotenv').config();
const mysql = require('mysql2');

// Use the environment variables in your app
const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME;

// Configuration de la connexion à MySQL
const db = mysql.createConnection({
    host: dbHost, // Remplacez par l'IP de votre serveur MySQL
    user: dbUser,         // Nom d'utilisateur de la base de données
    password: dbPassword,     // Mot de passe de la base de données
    database: dbName            // Nom de la base de données
  });

module.exports = db;