const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');
const uniqid = require('uniqid');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const filePath = 'offres.json';

// Endpoint pour ajouter une offre
app.post('/offres', async (req, res) => {
    const data = req.body;
    let offres = [];
    if (fs.existsSync(filePath)) {
      offres = JSON.parse(fs.readFileSync(filePath));
    }
    const newOfferData = {
      id: uniqid(),
      intitule: data.intitule,
      description: data.description,
      dateCreation: data.dateCreation,
      dateActualisation: data.dateActualisation,
      lieuTravail: data.lieuTravail,
      romeCode: data.romeCode,
      romeLibelle: data.romeLibelle,
      appellationLibelle: data.appellationlibelle, // Correction de la clé de données
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
  
    const offersData = JSON.parse(fs.readFileSync(filePath));
    offersData.push(newOfferData);
    fs.writeFileSync(filePath, JSON.stringify(offersData, null, 2));
  
    try {
        const response = await fetch('http://localhost/offres/client.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                id: newOfferData.id, // Inclure l'ID dans les données envoyées
                data: data, // Autres données
            }),
                });
    
        const contentType = response.headers.get('content-type');
        if (contentType && contentType.includes('application/json')) {
            const apiResponse = await response.json();
            console.log('Response from PHP API:', apiResponse);
            res.status(201).json({ message: 'Offer added successfully' });
        } else {
            const textResponse = await response.text(); // Récupérer le texte de la réponse
            console.error('Invalid server response:', textResponse);
            throw new Error('Invalid server response - not JSON');
        }
    } catch (error) {
        console.error('Error communicating with PHP API:', error);
        res.status(500).json({ error: 'An error occurred while communicating with the PHP API' });
    }
    
});

// Endpoint pour afficher toutes les offres

  
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname,'index.html'));
  });
  
  app.use('/public/css', express.static(path.join(__dirname, 'public/css'), { 'extensions': ['css'] }));

// Endpoint pour afficher une offre spécifique par son ID
app.get('/offres/:id', (req, res) => {
  const id = req.params.id;
  // Logique pour récupérer une offre spécifique par son ID
  // Assurez-vous de gérer les cas où l'offre n'est pas trouvée

  res.json(offre);
});

// Endpoint pour mettre à jour une offre spécifique par son ID
app.put('/offres/:id', (req, res) => {
  const id = req.params.id;
  const newData = req.body;
    
  
  res.json({ message: 'Offre mise à jour avec succès' });
});

// Endpoint pour supprimer une offre spécifique par son ID
// Endpoint pour supprimer une offre spécifique par son ID
app.delete('/offres/:id', (req, res) => {
  const id = req.params.id;
  // Logique pour supprimer une offre spécifique par son ID
  // Assurez-vous de gérer les erreurs et de renvoyer la réponse appropriée

  // Lire les offres depuis le fichier
  const offres = JSON.parse(fs.readFileSync(filePath));

  // Trouver l'index de l'offre à supprimer
  const index = offres.findIndex(offre => offre.id === id);

  // Vérifier si l'offre existe
  if (index !== -1) {
    // Supprimer l'offre du tableau
    offres.splice(index, 1);

    // Écrire les offres mises à jour dans le fichier
    fs.writeFileSync(filePath, JSON.stringify(offres, null, 2));

    // Envoyer une réponse indiquant que l'offre a été supprimée avec succès
    res.json({ message: 'Offre supprimée avec succès' });
  } else {
    // Envoyer une réponse indiquant que l'offre n'a pas été trouvée
    res.status(404).json({ error: 'Offre non trouvée' });
  }
});


app.get('/add', (req,res) => {
 res.sendFile(path.join(__dirname, 'add.html'));
});

app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
