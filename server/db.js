require('dotenv').config();
const mysql = require('mysql2/promise');

// Use the environment variables in your app
const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME;

// Configuration de la connexion à MySQL
const db = mysql.createPool({
    host: dbHost, // Remplacez par l'IP de votre serveur MySQL
    user: dbUser,         // Nom d'utilisateur de la base de données
    password: dbPassword,     // Mot de passe de la base de données
    database: dbName,            // Nom de la base de données
    connectTimeout: 1000000
  });

// Test connection à la DB  
db.getConnection().then((connect) => {
  console.log('▮ Connecté à la base de données MySQL', dbName);
  connect.release();
}).catch((err) =>{
  console.log('▮ Erreur de connexion à MySQL:', err)
})

module.exports = db;