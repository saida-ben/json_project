<!-- formulaire.xsl -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Formulaire</title>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script type="text/javascript">
          
         function envoyerRequeteXQuery() {

        
            var cneValue = document.getElementById('cne').value;
            var cinValue = document.getElementById('cin').value;
            var code_apogeValue = document.getElementById('code_apoge').value;
            var nomValue = document.getElementById('nom').value;
            var prenomValue = document.getElementById('prenom').value;
            var passwordValue = document.getElementById('password').value;
            var etablissementValue = document.getElementById('etablissement').value;
            var niveauValue = document.getElementById('niveau').value;
            var date_naissanceValue = document.getElementById('date_naissance').value;
            var adresseValue = document.getElementById('adresse').value;
            var code_postalValue = document.getElementById('code_postal').value;
            var num_teleValue = document.getElementById('num_tele').value;
            var choix_de_filieres_LPValue = document.getElementById('choix_de_filieres_LP').value;
            
           
            var travailValue = document.getElementById('travail').value;
            var nbr_anneeValue = document.getElementById('nbr_annee').value;

            var note1Value = document.getElementById('note1').value;
            var classement1Value = document.getElementById('classement1').value;
            var nbr_condidat1Value = document.getElementById('nbr_condidat1').value;
            var note2Value = document.getElementById('note2').value;
            var classement2Value = document.getElementById('classement2').value;
            var nbr_condidat2Value = document.getElementById('nbr_condidat2').value;

            var diplome_typeValue = document.getElementById('diplome_type').value;
            var Specialite_diplomeValue = document.getElementById('Specialite_diplome').value;
            var notediplomeValue = document.getElementById('note_diplome').value;
            var villeValue = document.getElementById('ville').value;
            var niveauValue = document.getElementById('niveau').value;
            
          
            var bacfiliere = document.getElementById('bacfiliere').value;
            var bacnote = document.getElementById('bacnote').value;
            var bacannee = document.getElementById('bacannee').value;
            
         
            var requeteXQuery = `
              let $nouvelleDonnee := <Condidat>
                <informations_personnelles>
                  <nom>${nomValue}</nom>
                  <prenom>${prenomValue}</prenom>
                  <password>${passwordValue}</password>
                  <etablissement>${etablissementValue}</etablissement>
                  <ville>${villeValue}</ville>
                  <niveau>${niveauValue}</niveau>
                </informations_personnelles>

                <informations_generales>
                  <date_naissance>${date_naissanceValue}</date_naissance>
                  <adresse>${adresseValue}</adresse>
                  <code_postal>${code_postalValue}</code_postal>
                  <num_tele>${num_teleValue}</num_tele>
                  <cne>${cneValue}</cne>
                  <cin>${cinValue}</cin>
                  <code_apoge>${code_apogeValue}</code_apoge>
                
                </informations_generales>
                <experience>
                  <travail>${travailValue}</travail>
                  <nbr_annee>${nbr_anneeValue}</nbr_annee>
               </experience>
             
              <Diplome>
                <diplome_type>${diplome_typeValue}</diplome_type>
                <Specialite_diplome>${Specialite_diplomeValue}</Specialite_diplome>
                <note_diplome>${notediplomeValue}</note_diplome>
                <annees_diplomes>
                  <note1>${note1Value}</note1>
                  <classement1>${classement1Value}</classement1>
                  <nbr_condidat1>${nbr_condidat1Value}</nbr_condidat1>
                  <note2>${note2Value}</note2>
                  <classement2>${classement2Value}</classement2>
                  <nbr_condidat2>${nbr_condidat2Value}</nbr_condidat2>
                </annees_diplomes>
              </Diplome>
              <bac>
                   <bacfiliere>${bacfiliere}</bacfiliere>
                   <bacnote>${bacnote}</bacnote>
                   <bacannee>${bacannee}</bacannee>
              </bac>
             

              <choix_de_filieres_LP>${choix_de_filieres_LPValue}</choix_de_filieres_LP>       
             
              
              </Condidat>
              let $baseDeDonnees := db:open('xml.xml', 'update')
              return insert node $nouvelleDonnee as last into $baseDeDonnees//Condidat
            `;
          
            var encodedQuery = encodeURIComponent(requeteXQuery);
          
            axios.post('http://localhost:3000/ajouter-donnee', `query=${encodedQuery}`, {
              headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            })
              .then(function (response) {

                document.getElementById('message').style.display = 'block';

                // Recharger la page après un délai de 2 secondes (2000 millisecondes)
                setTimeout(function () {
                  location.reload();
                }, 2000);              
              })
              .catch(function (error) {
                console.error("Erreur du serveur Express.js:", error.response.status, error.response.statusText);
              });
          }
          
        </script>
        <script>
         function afficherFormulaire() {
           window.location.href = 'xml.xml';  // Redirige vers le formulaire.xsl
         }
       </script>
       <style>
        /* Styles pour le menu */
         .menu {
           position: relative;
           margin: 30px;
           top: 0;
           left: 0;
           right: 0;
           z-index: 100;
           color: #fff;
           display: grid;
           grid-template-rows: 5rem 1fr;
           grid-template-areas: 'top' 'content';
           pointer-events: none;
           opacity: 0.9;
         }
         #message {
          display: none;
          position: fixed;
          top: 0;
          left: 50%;
          transform: translateX(-50%);
          background-color: #4caf50;
          color: #fff;
          padding: 15px;
          width: 80%;
          text-align: center;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          z-index: 9999;
        }
         .menu--open {
           pointer-events: auto;
         }
         
         .menu__top {
           pointer-events: auto;
           z-index: 100;
           padding: 0 3rem;
           grid-area: top;
           display: grid;
           align-items: center;
           grid-template-columns: auto 1fr auto;
           grid-template-areas: 'title nav search';
           justify-content: space-between;
           background: rgba(0, 0, 0, 0.808); /* Couleur de fond transparente */
           border-radius: 40px 20px;
           border: 2px solid black;
         }
         
         .menu__title {
           grid-area: title;
           font-family: 'Castoro Titling', cursive;
           font-weight: 700;
           font-size: 1.5rem;
           margin: 0;
           color: #fff;
          }

        .menu__nav-top {
          grid-area: nav;
          overflow: hidden;
          height: 1.75rem;
          justify-self: center;
        }

         .logo-img {
           position: relative;
           float: left;
           margin-right: 40px;
           margin-left: 50px;
         }

         .menu__nav-top p {
           font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
           margin: 0 1rem;
           color: #fff;
           font-size: large;
           font-weight: bold;
         }
         
         body {
           font-family: 'Arial', sans-serif;
           background-color: #f5f5f5;
           margin: 0;
           padding: 0;
           }
           
           #contenu {
             
             max-width: 600px;
             margin: 50px auto;
             background-color: #fff;
             padding: 20px;
             box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
             border-radius: 5px;
           }
           
           /* Style général du formulaire */
           
           
           form {
            max-width: 600px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
          }
          
          label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
          }
          
          input,
          select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
          }
          
          select {
            margin-bottom: 15px;
          }
          
          input[type="button"] {
            background-color: #4caf50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
          }
          
          input[type="button"]:hover {
            background-color: #45a049;
          }
          
          
          hr {
            border: 1px solid #ddd;
            margin-top: 20px;
          }
          
          #resultat {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
          }
          
          select {
            display: inline-block;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
              }

            /* Style de survol lorsque l'utilisateur passe la souris */
            select:hover {
              border-color: #888;
            }
            
            /* Style du focus lorsqu'il est sélectionné */
            select:focus {
              outline: none;
              border-color: #4d90fe;
              box-shadow: 0 0 5px rgba(77, 144, 254, 0.5);
            }
            
            /* Style des options dans le menu déroulant */
            select option {
              background-color: #fff;
              color: #333;
            }
            
            /* Style de survol des options */
            select option:hover {
              background-color: #f5f5f5;
            }
            
            /* Style de la flèche du menu déroulant (certaines propriétés peuvent ne pas être supportées par tous les navigateurs) */
            select::-ms-expand {
              display: none;
            }
            
            select:after {
              content: '\25BC'; /* flèche vers le bas */
              position: absolute;
              top: 50%;
              right: 10px;
              transform: translateY(-50%);
            }
            button {
              appearance: none; /* Masquer le style par défaut du navigateur */
              -webkit-appearance: none;
              -moz-appearance: none;
              width: 130px;
              height: 40px;
              color: #fff;
              text-align: center;
              font-weight: bold;
              border-radius: 7px;
              padding: 10px 25px;
              background: transparent;
              cursor: pointer;
              transition: all 0.3s ease;
              position: relative;
              display: inline-block;
              box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, 0.5),7px 7px 20px 0px rgba(0, 0, 0, 0.1),4px 4px 5px 0px rgba(0, 0, 0, 0.1);
              outline: none;
              background: rgba(243, 143, 72, 0.909);
              }
              
              button:hover {
                background-color: #97570f;
              }


       </style>

      </head>
      <body>
        <div class="menu">
          <div class="menu__top">
            <img src="l.png" class="logo-img" alt="Logo" width="50" height="50"/>
            <nav class="menu__nav-top">
              <p>Ecole supérieure de technologie de Safi</p>
            </nav>
            <button onclick="afficherFormulaire()">back</button>
          </div>
        </div>
        <div id="contenu">
          
          <div id="message" style="display:none; color:green; margin-top:10px;">
            Donnée ajoutée avec succès !
          </div>

          <form>
            <label>CNE:</label>
            <input type="text" id="cne" name="cne" required="required"/><br/>
            <label>CIN:</label>
            <input type="text" id="cin" required="required"/><br/>
            <label>Code apoge: <input type="text" name="code_apoge" id="code_apoge" /></label><br />
            <label>Nom: <input type="text" name="nom" id="nom" /></label><br />
            <label>Prénom: <input type="text" name="prenom" id="prenom" /></label><br />
            <label>Password: <input type="password" name="password" id="password" /></label><br />
            <label>Etablissement: <input type="text" name="etablissement" id="etablissement" /></label><br />
            <label>ville: <input type="text" name="ville" id="ville" /></label><br />
            <label>Date de naissance: <input type="text" name="date_naissance" id="date_naissance"/></label><br />
            <label>Adresse: <input type="text" name="adresse" id="adresse" /></label><br />
            <label>Code postal: <input type="text" name="code_postal" id="code_postal" /></label><br />
            <label>Niveau: <input type="text" name="niveau" id="niveau" /></label><br />

            <label>Numéro de téléphone: <input type="text" name="num_tele" id="num_tele" /></label><br />
            <label>Choix de filières LP:</label>
            
            <select name="choix_de_filieres_LP" id="choix_de_filieres_LP">
              <option value="MÉCATRONIQUE">MÉCATRONIQUE</option>
              <option value="GESTION_COMPTABLE_ET_FINANCIÈRE">GESTION_COMPTABLE_ET_FINANCIÈRE</option>
              <option value="Ingénierie_des_Systèmes_d’information_et_Réseaux">Ingénierie_des_Systèmes_d’information_et_Réseaux</option>
              <option value="MÉTROLOGIE_QUALITÉ_SÉCURITÉ_ET_ENVIRONNEMENT">DTS-DIPLOME DE TECHNICIEN SPECIALISE</option>
            </select>
            <br />

            <label>travail : <input type="text" name="travail" id="travail"/></label><br />
            <label>nbr_annee : <input type="text" name="nbr_annee" id="nbr_annee" /></label><br />

            
            <label for="diplome_type">diplome_type :</label>
            <select name="diplome_type" id="diplome_type">
              <option value="DEUST-DIPLOME D'ETUDES UNIVERSITAIRES SCIENTIFIQUES ET TECHNIQUES">DEUST-DIPLOME D'ETUDES UNIVERSITAIRES SCIENTIFIQUES ET TECHNIQUES</option>
              <option value="DUT-DIPLOME UNIVERSITAIRE DE TECHNOLOGIE">DUT-DIPLOME UNIVERSITAIRE DE TECHNOLOGIE"</option>
              <option value="BTS-BREVET DE TECHNICIEN SUPERIEUR">BTS-BREVET DE TECHNICIEN SUPERIEUR</option>
              <option value="DTS-DIPLOME DE TECHNICIEN SPECIALISE">DTS-DIPLOME DE TECHNICIEN SPECIALISE</option>
              <option value="CPGE-CLASSES PREPARATOIRES AUX GRANDES ECOLES">CPGE-CLASSES PREPARATOIRES AUX GRANDES ECOLES</option>
            </select>
            <br />
            
            
            <label for="Specialite_diplome">Specialite_diplome :</label>
            <select name="Specialite_diplome" id="Specialite_diplome">
              <option value="ASSISTANCE DENTAIRE">ASSISTANCE DENTAIRE</option>
              <option value="AGENCES DE VOYAGES ANIMATION TOURISTIQUE">DUT-DIPLOME UNIVERSITAIRE DE TECHNOLOGIE</option>
              <option value="AUDIO VISUEL (OPTION: IMAGE)">AUDIO VISUEL (OPTION: IMAGE)</option>
              <option value="ANIMATION TOURISTIQUE">ANIMATION TOURISTIQUE</option>
              <option value="AUDIO VISUEL (OPTION: SON)">AUDIO VISUEL (OPTION: SON)</option>
            </select>
            <br />
            
            <label>note_diplome : <input type="text" name="note_diplome" id="note_diplome"/></label><br />
           
            <label>note1 : <input type="text" name="note1" id="note1" /></label><br />
            <label>classement1 : <input type="text" name="classement1" id="classement1" /></label><br />
            <label>nbr_condidat1 : <input type="text" name="nbr_condidat1" id="nbr_condidat1" /></label><br />
            
            <label>note2 : <input type="text" name="note2" id="note2"/></label><br />
            <label>classement2 : <input type="text" name="classement2" id="classement2" /></label><br />
            <label>nbr_condidat2 : <input type="text" name="nbr_condidat2" id="nbr_condidat2" /></label><br />
            <label>bacfiliere : <input type="text" name="bacfiliere" id="bacfiliere" /></label><br />
            <label>bacnote : <input type="text" name="bacnote" id="bacnote" /></label><br />
            <label>bacannee : <input type="text" name="bacannee" id="bacannee" /></label><br />
            
           
            
            <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery()"/>
          </form>
          <hr/>
          <div id="resultat"></div>
        </div>
      </body>
    </html>
  </xsl:template>
 
   

</xsl:stylesheet>
