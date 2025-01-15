const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs")

//const {createUser, findUserByEmail, } = require('../models/user')
const User = require('../models/user')

// Sign Up

authRouter.post("/api/signup", async (req, res) => {
    const {nom, prenom, email, password} = req.body;

    const existingUser = await User.findByEmail(email);
    if (existingUser){
        return res.status(400).json({message:"Email deja utilisé par un autre utilisateur !"});
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    const newUser = new User ({
        nom: nom,
        prenom: prenom,
        email: email,
        password: hashedPassword
    });

    newUser = await User.create(newUser);



    /*findUserByEmail(email, (err, row) => {
        if(err){
            console.log("Erreur lors de la verification de l'email")
            return res.status(500).json({message: "Erreur lors de la verification de l'email", status:500})
        }
        if(row){
            console.log("Email deja utilisé")
            return res.status(400).json({message: "Email deja utilisé", status:400})
        }
        createUser(nom, prenom, email, hashedPassword, (err, userId, userName, userLastName, userEmail) => {
            if (err) {
                console.error("Erreur lors de la création de l'utilisateur :", err);
                return res.status(500).json({ message: "Erreur lors de la création de l'utilisateur" });
            }
            console.log("Utilisateur créé avec succès", userId, userName, userLastName, userEmail)
            res.status(201).json({ message: "Utilisateur créé avec succès", status:201 , userId, userName, userLastName, userEmail,});
        });
    });*/
});


// Sign In

/*authRouter.post("/api/signin", async (req, res) => {
    const {email, password} = req.body;
    const hashedPassword = await bcryptjs.hash(password, 8);

    
});*/

module.exports = authRouter;