require('dotenv').config();

const express = require('express');
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const typeRouter = require("./routes/type");
const commandeRouter = require("./routes/commande");
const tagRouter = require("./routes/tag");
const commandeProductRouter = require("./routes/commande_product");

const app = express();
const PORT = process.env.PORT;

// Middleware pour parser le body des requêtes en JSON
app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(typeRouter);
app.use(commandeRouter);
app.use(tagRouter);
app.use(commandeProductRouter);

app.listen(PORT, () => {
  console.log(`▮ Serveur API en écoute sur http://localhost:${PORT}`);
});


app.get('/ping', (req, res) => {
  const startTime = Date.now(); // Capture du temps avant réponse

  // Simuler une réponse pour mesurer le ping
  setImmediate(() => {
    const latency = Date.now() - startTime; // Calcul du ping
    res.json({ message: 'pong', ping: `${latency}ms` });
  });
});

// Connexion à MySQL
/*db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à MySQL:', err);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});*/
/*app.get('/connect/:nom', (req, res) => {
  // Capture le paramètre 'nom' de l'URL
  const nom = '%'+req.params.nom+'%';
  // Crée la requête SQL avec un paramètre pour le nom
  const sql = 'SELECT nom, prenom, email FROM users WHERE nom LIKE ?';
  db.query(sql, [nom], (err, results) => {
  if (err) {
  return res.status(500).send(err);
  }
  if (results.length === 0) {
  // Si aucune nation n'est trouvée, renvoyer une erreur 404
  return res.status(404).json({ message: 'Nation not found' });
  }
  // Si des résultats sont trouvés, renvoyer les données
  res.json(results);
  });
});*/

// Démarrage du serveur
