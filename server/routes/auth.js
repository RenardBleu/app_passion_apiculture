const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs")

//const {createUser, findUserByEmail, } = require('../models/user')
const User = require('../models/user')

// Sign Up

authRouter.post("/api/signup", async (req, res) => {
    const {nom, prenom, email, password} = req.body;

    const existingUser = await User.findByEmail(email);
    if (existingUser) {
        return res.status(400).json({ msg: "Un utilisateur avec cet email existe déjà." });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);

    let newUser = new User ({
        nom: nom,
        prenom: prenom,
        email: email,
        password: hashedPassword
    });

    newUser = await User.create(newUser);

    res.status(201).json({
        success: true,
        message: "Utilisateur créé avec succès",
        user: newUser
    });
});

// Sign In

authRouter.post("/api/signin", async (req, res) => {
    try{
        const {email, password} = req.body;

        const user = await User.findByEmail(email);
        if(!user){
            return res.status(400).json({
                success: false,
                messsage: "Aucun utilisateur avec cette email"
            });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
    }catch{

    }
});

module.exports = authRouter;