const db = require('../db');

class Type{
    constructor(typeData){
        this.libelle = typeData.libelle;
        this.id = productData.id;
    }

    static async findAll(){
        try {
            const [row] = await db.execute("SELECT id, libelle FROM type WHERE DeleteAt IS NULL");
            if (row.length > 0) {
                return row
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des type");
            throw error;
        }
    }
}

module.exports = Type;