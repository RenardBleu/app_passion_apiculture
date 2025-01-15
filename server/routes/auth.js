const express = require("express");
const authRouter = express.Router();

const {createUser, findUserByEmail} = require('../models/user')
const db = require('../db');

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {nom, prenom, email, password} = req.body;
        const sql = 'SELECT nom, prenom, email FROM users WHERE email LIKE ?';

        const existingUser = await db.query(sql, [email], (err, results));
        if (existingUser){
            return res
            .status(400)
            .json({msg: "User with same email already exists !"});
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
             email,
             password: hashedPassword,
             nom,
             prenom,
        });

        user = await createUser()
        res.json(user);

    } catch (e) {
        res.status(500).json({error: e.message });
    }
})

module.exports = authRouter;