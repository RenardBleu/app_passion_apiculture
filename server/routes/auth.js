const express = require("express");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {name, email, password} = req.body

        const existingUser = await User.findOne({email});
    } catch (e) {

    }
})

module.exports = authRouter;