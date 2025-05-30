const db = require('../db');

class CommandeProducts{
    constructor(commandeProductsData){
        this.quantite = commandeProductsData.quantite;
        this.libelle_produit = commandeProductsData.libelle_produit;
        this.minia_produit = commandeProductsData.minia_produit;
        this.prix_produit = commandeProductsData.prix_produit;
        this.nom_produit = commandeProductsData.nom_produit;
        this.num_commande = commandeProductsData.num_commande;
    }

    static async findByNum(num){
        try {
            const [row] = await db.execute('select c.idCommande as num_commande, p.title as nom_produit, p.prix as prix_produit, p.miniature as minia_produit, t.libelle as libelle_produit, c.quantite as quantite from composer c join produit p on idProduit = p.id join type t on p.idType = t.id where c.idCommande = ?', [num]);
            if (row.length > 0) {
                const formattedRows = row.map(row => {
                    return {
                        ...row,
                        prix_produit: parseFloat(row.prix_produit).toFixed(2), // Formatage du prix
                    };
                });
                return formattedRows;
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des produit de la commande");
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

module.exports = CommandeProducts;