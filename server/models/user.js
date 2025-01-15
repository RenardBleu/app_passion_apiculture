const db = require('../db');

const createUser = (name, email, password, callback) => {
    // Hasher le mot de passe avant de l'enregistrer
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) {
            return callback(err);
        }

        const stmt = db.prepare("INSERT INTO users (nom, prenom, email, mdp) VALUES (?, ?, ?, )");
        stmt.run(name, email, hashedPassword, function(err) {
            if (err) {
                return callback(err); // Gérer les erreurs, par exemple les doublons d'email
            }
            callback(null, this.lastID); // Retourner l'ID du nouvel utilisateur
        });
        stmt.finalize();
    });
};

const findUserByEmail = (email, callback) => {
    db.get("SELECT * FROM users WHERE email = ?", [email], (err, row) => {
      callback(err, row);
    });
  };

const User = db.
module.exports = {
    createUser,
    findUserByEmail
};