const express = require("express");
const productRouter = express.Router();
const jwt = require("jsonwebtoken");

const Product = require('../models/product_Model')
const auth = require('../middleware/auth')


// - Get All Product -


productRouter.post("/api/product", async (req, res) => {
    const {token} = req.body;
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
    try{
        const verified = jwt.verify(token, "passwordKey");

        /*if (!verified){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }*/

        const product = await Product.findAll();
        res.json({product});

    }catch (e){
        if(e.message === "invalid signature"){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }else{
            res.status(500).json({error: e.message});
        }
    }
});

productRouter.post("/api/product/create", async (req, res) => {
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
});

productRouter.post("/api/product/update", async (req, res) => {
    const {id, title, description, prix, idType, miniature, caracteristiques, stock, token} = req.body;

    if (!token) {
        return res.status(401).json({ "message": "Aucun token d'authentification, accès refusé" });
    }

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
            prix: prix || 0,
            idType,
            miniature: miniature == 'No_Image' ? null : miniature || null,
            caracteristiques: caracteristiques || null,
            stock: stock || 0
        };

        // Mise à jour du stock
        const productUpdate = await Product.update(id, productData);
        res.status(200).json(productUpdate); // Retourne le message de succès ou d'erreur
    } catch (e) {
        if (e.message === "invalid signature") {
            return res.status(401).json({ "message": "Vérification du token échoué, autorisation refusée" });
        } else {
            res.status(500).json({ "error": e.message });
        }
    }
});

productRouter.post("/api/product/update-stock", async (req, res) => {
    const { id, stock, token } = req.body;

    if (!token) {
        return res.status(401).json({ "message": "Aucun token d'authentification, accès refusé" });
    }

    try {
        const verified = jwt.verify(token, "passwordKey");

        if (!verified) {
            return res.status(401).json({ "message": "Vérification du token échoué, autorisation refusée" });
        }

        // Validation des données
        if (!id || stock === undefined) {
            return res.status(400).json({ "message": "L'ID du produit et le stock sont obligatoires." });
        }

        // Mise à jour du stock
        const result = await Product.update(id, stock);
        res.status(200).json(result); // Retourne le message de succès ou d'erreur
    } catch (e) {
        if (e.message === "invalid signature") {
            return res.status(401).json({ "message": "Vérification du token échoué, autorisation refusée" });
        } else {
            res.status(500).json({ "error": e.message });
        }
    }
});

module.exports = productRouter;