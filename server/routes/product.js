const express = require("express");
const productRouter = express.Router();
const bcryptjs = require("bcryptjs");
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

module.exports = productRouter;