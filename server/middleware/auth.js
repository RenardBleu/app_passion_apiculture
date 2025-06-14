const jwt = require("jsonwebtoken");

const auth = async (req, res, next) =>{
    try{
        const token = req.header("x-auth-token");
        if(!token)
            return res.status(401).json({"message": "Aucun token d'authentification, accès refusé"});
        
        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
            return res.status.json(401).json({"message": "Vérification du token échoué, autorisation refusé"})
        req.user = verified.id;
        req.token = token;
        next();
    }catch(err){
        res.status(500).json({error: err.message});
    }
};

module.exports = auth;