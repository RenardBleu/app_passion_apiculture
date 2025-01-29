const express = require("express");
const productRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const Product = require('../models/product')
const auth = require('../middleware/auth')


// - Get All Product -


productRouter.post("/api/product", async (req, res) => {
    const {token} = req.body;
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
        
    const verified = jwt.verify(token, "passwordKey");

    if (!verified){
        res.status.json(401).json({"message": "Vérification du token échoué, autorisation refusé"})
    }
    try{
        console.log("📩 Données reçues :", req.body);

        const product = await Product.findAll();
        res.json({product});

    }catch (e){
        res.status(500).json({error: e.message});
    }
});

module.exports = productRouter;