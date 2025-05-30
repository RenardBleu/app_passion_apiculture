const db = require('../db');

class Tag{
    constructor(tagData){
        this.libelle = tagData.libelle;
        this.id = tagData.id;
    }

    static async findAll(){
        try {
            const [row] = await db.execute("SELECT id, libelle FROM tag");
            if (row.length > 0) {
                return row
            }
            return null;
        }catch (error){
            console.error("erreur lors de la recherche des tag");
            throw error;
        }
    }
}

module.exports = Tag;