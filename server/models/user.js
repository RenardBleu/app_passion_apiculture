const db = require('../db');

const createUser = (nom, prenom, email, password, callback) => {
        console.log("le mdp hash est : " + password);

        db.query(
            'INSERT INTO users (nom, prenom, email, mdp) VALUES (?, ?, ?, ?)', 
            [nom, prenom, email, password], (err, row) => {
            if (err) {
                return callback(err);
            }
            console.log(row)
            callback(null, row.insertId, nom , prenom, email); // Utiliser results.insertId pour l'ID
        })
};

const findUserByEmail = (email, callback) => {
    db.query("SELECT * FROM users WHERE email = ?", [email], (err, row) => {
        if (err) {
            return callback(err);
        }
        callback(err, row[0]);
    });
};

const findUserById = (id, callback) =>{
    db.query("SELECT * FROM users WHERE id = ?", [id], (err, row) => {
        if (err) {
            return callback(err);
        }
        callback(err, row[0]);
    });
}

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
            const [result] = await db.execute(
                'INSERT INTO users (nom, prenom, email, mdp) VALUES (?, ?, ?, ?)',
                [userData.nom, userData.prenom, userData.email, userData.password]
            );
            return new User({...userData, id: result.insertId}); // retourne l'utilisateur créé avec son id
        } catch (error) {
            console.error("Erreur lors de la création de l'utilisateur :", err);
            throw err; // Renvoyer l'erreur pour être gérée par l'appelant
        }
    }

    static async findByEmail(email, callback) {
        try {
            //console.log(await db.execute('SELECT * FROM users WHERE email = ?', [email]));
            const rows = await db.execute('SELECT COUNT(*) FROM users WHERE email = ?', [email], (err, rows) => {
                if (err) {
                    return callback(err);
                }
    
                if (rows.length === 0) {
                    return callback(null, null); // Important : callback(null, null) pour indiquer "pas trouvé"
                }
    
                callback(null, new User(rows[0]));
            });
            return new User(rows[0]); // Crée une instance de User
        } catch (error) {
            console.error("Erreur lors de la recherche par email :", error);
            throw error;
        }
    }
}


module.exports = User;