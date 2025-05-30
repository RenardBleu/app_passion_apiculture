const db = require('../db');

class Commande{
    constructor(commandeData){
        this.tagLibelle = commandeData.tagLibelle;
        this.idTag = commandeData.idTag;
        this.statut = commandeData.statut;
        this.montant = commandeData.montant;
        this.updateAt = commandeData.updateAt;
        this.createAt = commandeData.createAt;
        this.prenom = commandeData.prenom;
        this.nom = commandeData.nom;
        this.idUser = commandeData.idUser;
        this.num = commandeData.num;
    }

    static async findAll(){
        try {
            const [row] = await db.execute('select c.num as num, c.idUser as idUser, u.nom as nom, u.prenom as prenom, c.idTag as idTag, t.libelle as tagLibelle, c.montant as montant, c.updateAt, c.createAt from commandes c join users u on idUser = u.id join tag t on idTag = t.id order by c.createAt desc');
            if (row.length > 0) {
                const formattedRows = row.map(row => {
                    return {
                        ...row,
                        montant: parseFloat(row.montant).toFixed(2), // Formatage du prix
                    };
                });
                return formattedRows;
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des commandes");
            throw error;
        }
    }
    /*static async create(productData) {
        try {
            const [rows] = await db.execute(
                'INSERT INTO produit (title, description, prix, idType, miniature, caracteristiques, stock) VALUES (?, ?, ?, ?, ?, ?, ?)',
                [productData.title, productData.description, productData.prix, productData.idType, productData.miniature, productData.caracteristiques, productData.stock]
            );
            return new Product({...productData, id: rows.insertId}); // retourne le produit créé avec son id
        } catch (error) {
            console.error("Erreur lors de la création du produit :", error);
            throw error; // Renvoyer l'erreur pour être gérée par l'appelant
        }
    }*/
}

module.exports = Commande;