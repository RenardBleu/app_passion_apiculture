const express = require("express");
const tagRouter = express.Router();
const jwt = require("jsonwebtoken");

const Tag = require('../models/tag_Model')
const auth = require('../middleware/auth')


// - Get All Product -


tagRouter.post("/api/tag", async (req, res) => {
    const {token} = req.body;
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
    try{
        const verified = jwt.verify(token, "passwordKey");

        /*if (!verified){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }*/

        const tag = await Tag.findAll();
        res.json({tag});

    }catch (e){
        if(e.message === "invalid signature"){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }else{
            res.status(500).json({error: e.message});
        }
    }
});

module.exports = tagRouter;