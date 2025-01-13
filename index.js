require('dotenv').config();

// Use the environment variables in your app
const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME;

const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Middleware pour parser le body des requêtes en JSON
app.use(bodyParser.json());

// Configuration de la connexion à MySQL
const db = mysql.createConnection({
  host: dbHost, // Remplacez par l'IP de votre serveur MySQL
  user: dbUser,         // Nom d'utilisateur de la base de données
  password: dbPassword,     // Mot de passe de la base de données
  database: dbName            // Nom de la base de données
});

// Connexion à MySQL
db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à MySQL:', err);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});

// Démarrage du serveur
app.listen(port, () => {
  console.log(`Serveur API en écoute sur http://localhost:${port}`);
});