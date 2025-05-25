const db = require('../db');

class Product{
    constructor(productData){
        this.title = productData.title;
        this.describ = productData.descrip;
        this.prix = productData.prix;
        this.type = productData.type;
        this.minia = productData.minia;
        this.caracteristiques = productData.caracteristiques;
        this.stock = productData.stock;
        this.id = productData.id;
    }

    static async findAll(){
        try {
            const [row] = await db.execute('select p.id, title, description, prix, miniature, caracteristiques, stock, p.updateAt, p.deleteAt, p.createAt, t.libelle as libelletype from produit p, type t where p.idType = t.id order by p.createAt desc');
            if (row.length > 0) {
                const formattedRows = row.map(row => {
                    return {
                        ...row,
                        prix: parseFloat(row.prix).toFixed(2), // Formatage du prix
                    };
                });
                return formattedRows;
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des produits");
            throw error;
        }
    }
    static async create(productData) {
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
    }
}

module.exports = Product;