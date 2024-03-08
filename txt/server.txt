const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path'); // Importer le module path
const uniqid = require('uniqid'); // Importer uniqid

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Définir le chemin vers le fichier JSON
const filePath = 'offres.json';

// Route pour servir la page HTML contenant le formulaire
app.get('/add', (req, res) => {
  // Envoyer le fichier HTML contenant le formulaire
  res.sendFile(path.join(__dirname, 'add.html'));
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname,'index.html'));
});

// Route POST pour ajouter une offre
app.post('/ajouter-offre', (req, res) => {
  const data = req.body; // Récupérer toutes les données de la requête

  // Traiter les données ici
  const newOfferData = {
    id: uniqid(),
    intitule: data.intitule,
    description: data.description,
    dateCreation: data.dateCreation,
    dateActualisation: data.dateActualisation,
    lieuTravail: data.lieuTravail,
    romeCode: data.romeCode,
    romeLibelle: data.romeLibelle,
    appellationLibelle: data.appellationlibelle,
    entreprise: data.entreprise,
    typeContrat: data.typeContrat,
    typeContratLibelle: data.typeContratLibelle,
    natureContrat: data.natureContrat,
    experienceExige: data.experienceExige,
    experienceLibelle: data.experienceLibelle,
    formations: data.formations,
    langues: data.langues,
    competences: data.competences,
    salaire: data.salaire,
    dureeTravailLibelle: data.dureeTravailLibelle,
    dureeTravailLibelleConverti: data.dureeTravailLibelleConverti,
    alternance: data.alternance,
    contact: data.contact,
    nombrePostes: data.nombrePostes,
    accessibleTH: data.accessibleTH,
    qualificationCode: data.qualificationCode,
    qualificationLibelle: data.qualificationLibelle,
    codeNAF: data.codeNAF,
    secteurActivite: data.secteurActivite,
    secteurActiviteLibelle: data.secteurActiviteLibelle,
    origineOffre: data.origineOffre
  };

  // Lire le contenu actuel du fichier JSON
  const offersData = JSON.parse(fs.readFileSync(filePath));

  // Ajouter la nouvelle offre à la liste des offres
  offersData.push(newOfferData);

  // Écrire les données mises à jour dans le fichier JSON
  fs.writeFileSync(filePath, JSON.stringify(offersData, null, 2));

  res.send('Données de l\'offre ajoutées avec succès !');
});

app.get('/afficher', (req, res) => {

  const offre = JSON.parse(fs.readFileSync(filePath));
  res.json(offre);
});

app.use('/public/css', express.static(path.join(__dirname, 'public/css'), { 'extensions': ['css'] }));


app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
