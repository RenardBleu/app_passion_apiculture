const express = require("express");
const typeRouter = express.Router();
const jwt = require("jsonwebtoken");

const Type = require('../models/type_Model')
const auth = require('../middleware/auth')


// - Get All Product -


typeRouter.post("/api/type", async (req, res) => {
    const {token} = req.body;
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
    try{
        const verified = jwt.verify(token, "passwordKey");

        /*if (!verified){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }*/

        const type = await Type.findAll();
        res.json({type});

    }catch (e){
        if(e.message === "invalid signature"){
            return res.status(401).json({"message": "Vérification du token échoué, autorisation refusée"});
        }else{
            res.status(500).json({error: e.message});
        }
    }
});

module.exports = typeRouter;