const db = require('../db');

class Product{
    constructor(productData){
        this.title = productData.title;
        this.describ = productData.descrip;
        this.prix = productData.prix;
        this.type = productData.type;
        this.minia = productData.minia;
        this.id = productData.id;
    }

    static async findAll(){
        try {
            const [row] = await db.execute('SELECT p.id, title, description, prix, t.libelle AS type, miniature, UpdateAt, CreateAt, DeleteAt FROM produit p JOIN type t ON p.idType = t.id ORDER BY p.UpdateAt DESC');
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
}

module.exports = Product;