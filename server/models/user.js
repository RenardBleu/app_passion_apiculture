const db = require('../db');

class User {
    constructor(userData) {
        this.email = userData.email;
        this.password = userData.password;
        this.nom = userData.nom;
        this.prenom = userData.prenom;
        this.id = userData.id; // Ajout de l'ID pour les instances récupérées de la base
    }

    static async create(userData) {
        try {
            const [rows] = await db.execute(
                'INSERT INTO users (nom, prenom, email, mdp) VALUES (?, ?, ?, ?)',
                [userData.nom, userData.prenom, userData.email, userData.password]
            );
            return new User({...userData, id: rows.insertId}); // retourne l'utilisateur créé avec son id
        } catch (error) {
            console.error("Erreur lors de la création de l'utilisateur :", error);
            throw error; // Renvoyer l'erreur pour être gérée par l'appelant
        }
    }

    static async findByEmail(email) {
        try {
            const [rows] = await db.execute('SELECT * FROM users WHERE email = ?', [email]);
            if (rows.length > 0) {
                return rows[0]; // Retourne l'utilisateur trouvé
            }
            return null; // Retourne null si aucun utilisateur n'est trouvé
        } catch (error) {
            console.error("Erreur lors de la recherche par email :", error);
            throw error; // Renvoyer l'erreur pour la gérer plus haut
        }
    }

    static async findById(id) {
        try {
            const [rows] = await db.execute('SELECT * FROM users WHERE id = ?', [id]);
            if (rows.length > 0) {
                return rows[0]; // Retourne l'utilisateur trouvé
            }
            return null; // Retourne null si aucun utilisateur n'est trouvé
        } catch (error) {
            console.error("Erreur lors de la recherche par email :", error);
            throw error; // Retourne l'erreur pour la gérer plus haut
        }
    }
}


module.exports = User;