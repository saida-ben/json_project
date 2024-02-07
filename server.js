const express = require('express');
const bodyParser = require('body-parser');
const { readFileSync, writeFileSync, existsSync } = require('fs');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json()); // Ajout de la configuration pour traiter les données JSON
app.use(cors());

// Vérifiez si le fichier Users.json existe, sinon créez-le avec un tableau vide
if (!existsSync('Users.json')) {
  writeFileSync('Users.json', '[]');
}

app.post('/ajouter-donnee1', (req, res) => {
  const { nom, prenom, email } = req.body; // Récupérer les données utilisateur de la requête

  // Créer un objet utilisateur avec les données reçues
  const newUser = {
    nom: nom,
    prenom: prenom,
    email: email
  };

  // Lire le contenu actuel du fichier JSON
  const usersData = JSON.parse(readFileSync('Users.json', 'utf-8'));
 // Lire le contenu actuel du fichier JSON

 // Vérifier si un utilisateur avec le même email existe déjà
 const existingUser = usersData.find(user => user.email === email);
 if (existingUser) {
   return res.status(400).send('Un utilisateur avec cet email existe déjà.');
 }

  // Ajouter le nouvel utilisateur à la liste des utilisateurs
  usersData.push(newUser);

  // Écrire les données mises à jour dans le fichier JSON
  writeFileSync('Users.json', JSON.stringify(usersData));

  res.send('Données utilisateur ajoutées avec succès !');
});


app.delete('/supprimer-utilisateur/:email', (req, res) => {
  const email = req.params.email;

  // Lire le contenu actuel du fichier JSON
  let usersData = JSON.parse(readFileSync('Users.json', 'utf-8'));

  // Filtrer les utilisateurs pour supprimer celui avec l'email spécifié
  usersData = usersData.filter(user => user.email !== email);

  // Écrire les données mises à jour dans le fichier JSON
  writeFileSync('Users.json', JSON.stringify(usersData));

  res.send(`Utilisateur avec l'email ${email} supprimé avec succès !`);
});

app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
