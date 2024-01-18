const express = require('express');
const bodyParser = require('body-parser');
const { readFileSync, writeFileSync } = require('fs');
const { parseString, Builder } = require('xml2js');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

const builder = new Builder();
app.get('/affichage', (req, res) => {
  const xslData = readFileSync('affichage.xsl', 'utf-8');
  res.set('Content-Type', 'application/xml');
  res.send(xslData);
});
app.post('/ajouter-donnee', (req, res) => {
  const query = decodeURIComponent(req.body.query);

  const xmlData = readFileSync('xml.xml', 'utf-8');

  parseString(xmlData, (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Erreur lors de la conversion XML en objet JavaScript');
    }

    const updatedData = result;

    const cneMatch = query.match(/<cne>([^<]*)<\/cne>/);
    const cinMatch = query.match(/<cin>([^<]*)<\/cin>/);
    const code_apogeMatch = query.match(/<code_apoge>([^<]*)<\/code_apoge>/);
    const nomMatch = query.match(/<nom>([^<]*)<\/nom>/);
    const prenomMatch = query.match(/<prenom>([^<]*)<\/prenom>/);
    const passwordMatch = query.match(/<password>([^<]*)<\/password>/);
    const etablissementMatch = query.match(/<etablissement>([^<]*)<\/etablissement>/);
    const ville_infoMatch = query.match(/<ville_info>([^<]*)<\/ville_info>/);
    const niveauMatch = query.match(/<ville>([^<]*)<\/ville>/);
    const date_naissanceMatch = query.match(/<date_naissance>([^<]*)<\/date_naissance>/);
    const adresseMatch = query.match(/<adresse>([^<]*)<\/adresse>/);
    const code_postalMatch = query.match(/<code_postal>([^<]*)<\/code_postal>/);
    const num_teleMatch = query.match(/<num_tele>([^<]*)<\/num_tele>/);

    const choix_de_filieres_LPMatch = query.match(/<choix_de_filieres_LP>([^<]*)<\/choix_de_filieres_LP>/);
    const FiliereMatch = query.match(/<filiere>([^<]*)<\/filiere>/);
    const AnneeMatch = query.match(/<Annee>([^<]*)<\/Annee>/);
    const NoteMatch = query.match(/<Note>([^<]*)<\/Note>/);
    const travailMatch = query.match(/<travail>([^<]*)<\/travail>/);
    const nbr_anneeMatch = query.match(/<nbr_annee>([^<]*)<\/nbr_annee>/);

    const Note1Match = query.match(/<note1>([^<]*)<\/note1>/);
    const classement1Match = query.match(/<classement1>([^<]*)<\/classement1>/);
    const nbr_condidat1Match = query.match(/<nbr_condidat1>([^<]*)<\/nbr_condidat1>/);

    const Note2Match = query.match(/<note2>([^<]*)<\/note2>/);
    const classement2Match = query.match(/<classement2>([^<]*)<\/classement2>/);
    const nbr_condidat2Match = query.match(/<nbr_condidat2>([^<]*)<\/nbr_condidat2>/);


    const cneValue = cneMatch ? cneMatch[1] : '';
    const cinValue = cinMatch ? cinMatch[1] : '';
    const code_apogeValue = code_apogeMatch ? code_apogeMatch[1] : '';
    const nomValue = nomMatch ? nomMatch[1] : '';
    const prenomValue = prenomMatch ? prenomMatch[1] : '';
    const passwordValue = passwordMatch ? passwordMatch[1] : '';
    const etablissementValue = etablissementMatch ? etablissementMatch[1] : '';
    const ville_infoValue = ville_infoMatch ? ville_infoMatch[1] : '';
    const niveauValue = niveauMatch ? niveauMatch[1] : '';
    const date_naissanceValue = date_naissanceMatch ? date_naissanceMatch[1] : '';
    const adresseValue = adresseMatch ? adresseMatch[1] : '';
    const code_postalValue = code_postalMatch ? code_postalMatch[1] : '';
    const num_teleValue = num_teleMatch ? num_teleMatch[1] : '';
    const choix_de_filieres_LPValue = choix_de_filieres_LPMatch    ? choix_de_filieres_LPMatch[1] : '';
    const FiliereValue = FiliereMatch    ? FiliereMatch[1] : '';
    const AnneeValue = AnneeMatch    ? AnneeMatch[1] : '';
    const NoteValue = NoteMatch   ? NoteMatch[1] : '';
    const travailValue = travailMatch   ? travailMatch[1] : '';
    const nbr_anneeValue = nbr_anneeMatch   ? nbr_anneeMatch[1] : '';

    const note1Value = Note1Match   ? Note1Match[1] : '';
    const classement1Value = classement1Match   ? classement1Match[1] : '';
    const nbr_condidat1Value = nbr_condidat1Match   ? nbr_condidat1Match[1] : '';

    const note2Value = Note2Match   ? Note2Match[1] : '';
    const classement2Value = classement2Match   ? classement2Match[1] : '';
    const nbr_condidat2Value = nbr_condidat2Match   ? nbr_condidat2Match[1] : '';

    const newUserData = {
      cne: [cneValue],
      cni: [cinValue],
      code_apoge: [code_apogeValue],
      nom: [nomValue],
      prenom: [prenomValue],
      password: [passwordValue],
      etablissement: [etablissementValue],
      ville_info: [ville_infoValue],
      niveau: [niveauValue],
      date_naissance: [date_naissanceValue],
      adresse: [adresseValue],
      code_postal: [code_postalValue],
      num_tele: [num_teleValue],       
      choix_de_filieres_LP: [choix_de_filieres_LPValue],       
      Filiere: [FiliereValue],       
      Annee: [AnneeValue],       
      Note: [NoteValue],       
      travail: [travailValue],       
      nbr_annee: [nbr_anneeValue],       

      note1: [note1Value],       
      classement1: [classement1Value],       
      nbr_condidat1: [nbr_condidat1Value],  

      note2: [note2Value],       
      classement2: [classement2Value],       
      nbr_condidat2: [nbr_condidat2Value],  
    };

    // Insérer la nouvelle entrée au début de la liste des "user_data"
    updatedData.Condidats.Condidat.push(newUserData);

    const updatedXml = builder.buildObject(updatedData);

    // Supprimer l'en-tête XML de la chaîne XML générée
    const xmlWithoutHeader = updatedXml.replace(/<\?xml[^\?]+\?>/i, '');

    // Ajouter la ligne <?xml-stylesheet type="text/xsl" href="transformer.xsl"?>
    const xmlWithStylesheet = `<?xml-stylesheet type="text/xsl" href="affichage2.xsl"?>\n${xmlWithoutHeader}`;

    writeFileSync('xml.xml', xmlWithStylesheet);

    res.send('Donnée ajoutée avec succès !');
    
  });
  
});


app.post('/ajouter-donnee1', (req, res) => {
  const query = decodeURIComponent(req.body.query);

  const xmlData = readFileSync('Users.xml', 'utf-8');

  parseString(xmlData, (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Erreur lors de la conversion XML en objet JavaScript');
    }

    const updatedData = result;

    
    const nomMatch = query.match(/<nom>([^<]*)<\/nom>/);
    const prenomMatch = query.match(/<prenom>([^<]*)<\/prenom>/);

    const emailMatch = query.match(/<email>([^<]*)<\/email>/);
    const roleMatch = query.match(/<role>([^<]*)<\/role>/);

    const nomValue = nomMatch ? nomMatch[1] : '';
    const prenomValue = prenomMatch ? prenomMatch[1] : '';
    const emailValue = emailMatch ? emailMatch[1] : '';
    const roleValue = roleMatch ? roleMatch[1] : '';
  
    const newUserData = {
      nom: [nomValue],
      prenom: [prenomValue],
      email: [emailValue],
      role: [roleValue],
    
    };

    // Insérer la nouvelle entrée au début de la liste des "user_data"
    updatedData.Users.User.push(newUserData);

    const updatedXml = builder.buildObject(updatedData);

    // Supprimer l'en-tête XML de la chaîne XML générée
    const xmlWithoutHeader = updatedXml.replace(/<\?xml[^\?]+\?>/i, '');

    // Ajouter la ligne <?xml-stylesheet type="text/xsl" href="transformer.xsl"?>
    const xmlWithStylesheet = `<?xml-stylesheet type="text/xsl" href="affichage.xsl"?>\n${xmlWithoutHeader}`;

    writeFileSync('Users.xml', xmlWithStylesheet);

    res.send('Donnée ajoutée avec succès !');
  });
  
});


app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
