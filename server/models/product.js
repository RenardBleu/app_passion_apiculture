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
            const [row] = await db.execute('SELECT * FROM produit');
            if (row.length > 0) {
                return row;
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des produits");
            throw error;
        }
    }
}

module.exports = Product;