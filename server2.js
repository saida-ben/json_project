const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const cors = require('cors');
const path = require('path'); // Importer le module path

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());

// Définir le chemin vers le fichier JSON
const filePath = 'offres.json';
// Définir le répertoire des fichiers statiques
app.use(express.static(path.join(__dirname, 'JSONPROJET')));

// Route pour servir la page HTML contenant le formulaire
app.get('/add', (req, res) => {
  // Envoyer le fichier HTML contenant le formulaire
  res.sendFile(path.join(__dirname,'add.html'));
});
// Route POST pour ajouter une offre
app.post('/ajouter-offre', (req, res) => {
    const data = req.body; // Récupérer toutes les données de la requête

    // Traiter les données ici
    const newUserData = {
      id: uniqid(),
      intitule: data.intitule,
      description: data.description,
      dateCreation: data.dateCreation,
      dateActualisation: data.dateActualisation,
      lieuTravail: {
        libelle: data.lieuTravail.libelle,
        latitude: data.lieuTravail.latitude,
        longitude: data.lieuTravail.longitude,
        codePostal: data.lieuTravail.codePostal,
        commune: data.lieuTravail.commune
      },
      romeCode: data.romeCode,
      romeLibelle: data.romeLibelle,
      appellationLibelle: data.appellationLibelle,
      entreprise: {
        nom: data.entreprise.nom,
        entrepriseAdaptee: data.entreprise.entrepriseAdaptee === 'true' ? true : false
      },
      typeContrat: data.typeContrat,
      typeContratLibelle: data.typeContratLibelle,
      natureContrat: data.natureContrat,
      experienceExige: data.experienceExige,
      experienceLibelle: data.experienceLibelle,
      formations: [
        {
          codeFormation: data.formations.codeFormation,
          domaineLibelle: data.formations.domaineLibelle,
          niveauLibelle: data.formations.niveauLibelle,
          commentaire: data.formations.commentaire,
          exigence: data.formations.exigence
        }
      ],
      langues: [
        {
          libelle: data.langues.libelle,
          exigence: data.langues.exigence
        }
      ],
      competences: [
        {
          code: data.competences.code,
          libelle: data.competences.libelle,
          exigence: data.competences.exigence
        }
      ],
      salaire: {
        libelle: data.salaire.libelle
      },
      dureeTravailLibelle: data.dureeTravailLibelle,
      dureeTravailLibelleConverti: data.dureeTravailLibelleConverti,
      alternance: data.alternance === 'true' ? true : false,
      contact: {
        nom: data.contact.nom,
        coordonnees1: data.contact.coordonnees1,
        coordonnees2: data.contact.coordonnees2,
        coordonnees3: data.contact.coordonnees3
      },
      nombrePostes: data.nombrePostes,
      accessibleTH: data.accessibleTH === 'true' ? true : false,
      qualificationCode: data.qualificationCode,
      qualificationLibelle: data.qualificationLibelle,
      codeNAF: data.codeNAF,
      secteurActivite: data.secteurActivite,
      secteurActiviteLibelle: data.secteurActiviteLibelle,
      origineOffre: {
        origine: data.origineOffre.origine,
        urlOrigine: data.origineOffre.urlOrigine
      }
    };
  
    // Lire le contenu actuel du fichier JSON
    const usersData = JSON.parse(readFileSync('Users.json', 'utf-8'));
  
    // Ajouter le nouvel utilisateur à la liste des utilisateurs
    usersData.push(newUserData);
  
    // Écrire les données mises à jour dans le fichier JSON
    writeFileSync('Users.json', JSON.stringify(usersData));
  
    res.send('Données utilisateur ajoutées avec succès !');
    });


app.listen(port, () => {
    console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
