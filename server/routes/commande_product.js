const express = require("express");
const commandeProductsRouter = express.Router();
const jwt = require("jsonwebtoken");

const CommandeProducts = require('../models/commande_products_Model')
const auth = require('../middleware/auth')


// - Get All Product -


commandeProductsRouter.post("/api/commande/products", async (req, res) => {
    const {token, idCommande} = req.body;
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
    try{
        const verified = jwt.verify(token, "passwordKey");

        /*if (!verified){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }*/

        if(idCommande == null){
            return res.status(400).json({
                success: false,
                message: "Numéro de commande non indiqué"
            });
        }

        const commandeProducts = await CommandeProducts.findByNum(idCommande);
        if(!commandeProducts){
            return res.status(400).json({
                success: false,
                message: "Aucun produit dans la commande"
            });
        }

        res.json({commandeProducts});

    }catch (e){
        if(e.message === "invalid signature"){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }else{
            res.status(500).json({error: e.message});
        }
    }
});

/*productRouter.post("/api/product/create", async (req, res) => {
    const {title, description, prix, idType, miniature, caracteristiques, stock, token} = req.body;

    if (!token)
        return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});

    try {
        const verified = jwt.verify(token, "passwordKey");

        if (!verified) {
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }

        // Validation des données
        if (!title || !description || !prix || !idType || !stock) {
            return res.status(400).json({"message": "Tous les champs obligatoires doivent être remplis."});
        }

        const productData = {
            title,
            description,
            prix: prix || 0, // Valeur par défaut si prix est undefined
            idType,
            miniature: miniature || null, // Valeur par défaut si miniature est undefined
            caracteristiques: caracteristiques || "", // Valeur par défaut si caracteristiques est undefined
            stock: stock || 0 // Valeur par défaut si stock est undefined
        };

        const newProduct = await Product.create(productData);
        res.status(201).json({product: newProduct});
    } catch (e) {
        if (e.message === "invalid signature") {
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        } else {
            res.status(500).json({error: e.message});
        }
    }
});*/

module.exports = commandeProductsRouter;