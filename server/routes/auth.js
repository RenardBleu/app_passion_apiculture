const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require('../models/user_Model')
const auth = require('../middleware/auth')


// - Sign Up -


authRouter.post("/api/signup", async (req, res) => {
    const {nom, prenom, email, password} = req.body; // Récupère les données de la request
    
    const existingUser = await User.findByEmail(email); // Vérifie si l'email est déjà utilisé dans la db
    if (existingUser) {
        return res.status(400).json({ 
            success: false,
            message: "Un utilisateur avec cet email existe déjà." // Renvoie erreur si Oui
        });
    }
    const hashedPassword = await bcryptjs.hash(password, 8); // Hash le mdp entré avec bcrypt

    let newUser = new User ({ // Si Non, créer un nouveau utilisateur
        nom: nom,
        prenom: prenom,
        email: email,
        password: hashedPassword
    });

    newUser = await User.create(newUser); // créer l'utilisateur dans la db

    res.status(201).json({
        success: true,
        message: "Utilisateur créé avec succès", // Renvoi succée et les info du nouvel utilisateur
        user: newUser
    });
});


// - Sign In -


authRouter.post("/api/signin", async (req, res) => {
    try{
        const {email, password} = req.body;

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                message: "Email et mot de passe requis."
            });
        }

        const user = await User.findByEmail(email);
        if(!user){
            return res.status(400).json({
                success: false,
                message: "Email ou mot de passe incorrect"
            });
        }

        if(user.DeleteAt != null){
            return res.status(400).json({
                success: false,
                message: "Le compte a été suprimé"
            });
        }

        const isMatch = await bcryptjs.compare(password, user.mdp);
        if(!isMatch){
            return res.status(400).json({
                success: false,
                message: "Email ou mot de passe incorrect"
            });
        }
        if(user.idRole == 2){
            return res.status(400).json({
                success: false,
                message: "Vous n'êtes pas un administrateur"
            });
        }
        const token = jwt.sign({id: user.id}, "passwordKey", {expiresIn: '1h'});
        const { mdp, ...userWithoutPassword } = user;
        res.json({ token, user: userWithoutPassword});

    }catch (e){
        res.status(500).json({error: e.message});
    }
});


authRouter.post("/tokenIsValid", async (req, res)=>{
    try{
        const token = req.header("x-auth-token");
        if(!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if(!user) return res.json(false);
        res.json(true);
    }catch (e){
        res.status(500).json({error: e.message});
    }
});


//get user data

authRouter.get("/", auth, async (req, res) =>{
    const user = await User.findById(req.user);
    res.json({...user, token: req.token});
});

module.exports = authRouter;