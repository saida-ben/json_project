<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <title>Affichage des Condidats</title>
        <link rel="stylesheet" type="text/css" href="style.css"/>
        <style>
          /* Styles pour le menu */
          .menu {
            position: relative;
            top: 0;
            left: 0;
            right: 0;
            color: #fff;
            display: grid;
            grid-template-rows: 5rem 1fr;
            grid-template-areas: 'top' 'content';
            pointer-events: none;
            opacity: 0.9;
          }
          
          .menu--open {
            pointer-events: auto;
          }
          
          .menu__top {
            pointer-events: auto;
            padding: 0 3rem;
            grid-area: top;
            display: flex;
            align-items: center;
            grid-template-columns: auto 1fr auto;
            grid-template-areas: 'title nav search';
            justify-content: space-between;
            background: rgba(0, 0, 0, 0.808);
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
          
          button {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
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
            box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, 0.5),
              7px 7px 20px 0px rgba(0, 0, 0, 0.1),
              4px 4px 5px 0px rgba(0, 0, 0, 0.1);
            outline: none;
            background: rgba(243, 143, 72, 0.909);
          }
          
          button:hover {
            background-color: #97570f;
          }
          
          .button-wrapper {
            display: flex;
          }
          
          .button-wrapper button:first-child {
            margin-right: 2px;
          }
          
          .button-wrapper button:last-child {
            margin-left: 2px;
          }
          
          body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
          }
          
          h1 {
            background: rgb(238, 203, 146);
            background: radial-gradient(circle, rgba(238, 203, 146, 1) 0%, rgba(208, 221, 234, 1) 100%);
            color: black;
            text-align: center;
            font-weight: bold;
            padding: 14px 20px;
            margin: 8px auto;
            border: none;
            cursor: pointer;
            width: 50%;
            opacity: 0.9;
            font-size: 16px;
            border-radius: 10px;
          }
          
          /* Appliquer le style du tableau aux deux tableaux */
          table,
          .condidats-table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
          }
          
          thead,
          .condidats-table thead {
            background-color: #DCDCDC;
            color: #000;
          }
          
          thead a,
          .condidats-table thead a {
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
            font-weight: bold;
          }
          
          tr,
          .condidats-table tr {
            transition: background-color 0.3s;
          }
          
          tr:hover,
          .condidats-table tr:hover {
            background-color: #f5f5f5;
          }
          
          th,
          td,
          .condidats-table th,
          .condidats-table td {
            padding: 15px;
            text-align: left;
          }
          
          tbody tr:nth-child(even),
          .condidats-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
          }
          
          tbody tr:nth-child(odd),
          .condidats-table tbody tr:nth-child(odd) {
            background-color: #fff;
          }
          
          th a {
            display: inline-block;
            padding: 8px 12px;
            text-decoration: none;
            background: rgba(243, 143, 72, 0.909);
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s;
            text-align: center;
          }
          
          th a:hover {
            background-color: #97570f;
          }
          
          /* Styles pour le popup */
          /* Styles pour le popup */
          #popup-container {
              display: none;
              position: fixed;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
              background: #fff;
              padding: 20px;
              border: 1px solid #ccc;
              border-radius: 10px;
              box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
              width: 50%;
              height: 70%;
              overflow-y: auto;
              z-index: 1000;
              display: flex;
              flex-direction: column;
              align-items: center;
              justify-content: center;
            }
            
            #popup-container h2 {
              text-align: center;
              color: #333;
              font-size: 2rem;
              margin-bottom: 15px;
            }
            
            #popup-container p {
              margin: 20px 10px;
              font-size: 1rem;
              line-height: 1.5;
              color: #555;
              
            }
            
            #popup-container button {
              background-color: #97570f;
              color: #fff;
              border: none;
              padding: 10px 20px;
              font-size: 1rem;
              cursor: pointer;
              border-radius: 5px;
            }
            
            #popup-container div {
              display: flex;
              align-items: center;
              margin-bottom: 10px;
              border-radius: 20px;
              border: 1px solid #ccc; /* Bordure en bas de chaque division */
              padding-left: 50px; /* Espacement pour séparer les divisions */
            }
            
            #popup-container h4 {
              margin-right: 10px;
            }
            
            #popup-container button {
              margin-top: 20px;
            }
            
            #popup-container button:hover {
              background-color: #704a10;
            }
            
            #popup-container .info-group {
              display: flex;
              justify-content: space-between;
              margin-bottom: 10px;
            }
            
            #popup-container .info-group div {
              width: 45%;
              border-right: 1px solid #ccc; /* Bordure à droite de chaque division */
              padding-right: 10px; /* Espacement pour séparer les divisions */
            }
            
            button#ajouter-button {
              position: absolute;
              top: 0;
              left: 0;
              margin-top: 10px;
              margin-left: 10px;
              color: #fff;
              font-weight: bold;
              border-radius: 7px;
              padding: 10px 25px;
              background: rgba(243, 143, 72, 0.909);
              cursor: pointer;
              transition: all 0.3s ease;
              box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, 0.5),
                7px 7px 20px 0px rgba(0, 0, 0, 0.1),
                4px 4px 5px 0px rgba(0, 0, 0, 0.1);
              outline: none;
            }
            
            button#ajouter-button:hover {
              background-color: #97570f;
            }
            tr[data-cne][data-etat="valid"] {
              background-color: red;
              color: white; /* Changer la couleur du texte si nécessaire */
              /* Ajouter d'autres styles au besoin */
          }
          
          tr[data-cne][data-etat="valid"] {
            background-color: red;
            color: white; /* Changer la couleur du texte si nécessaire */
            /* Ajouter d'autres styles au besoin */
          }
        </style>
        
        <script>
          function afficherFormulaire() {
            window.location.href = 'copy.xml';  // Rediriger vers le formulaire
        }
        
        function afficherUsers() {
            window.location.href = 'Users.xml';  // Rediriger vers Users.xml
        }
        
        function Condidatinfo(cne) {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4) {
                    if (xmlhttp.status === 200) {
                        var xmlDoc = xmlhttp.responseXML;
        
                        console.log("XML content:", new XMLSerializer().serializeToString(xmlDoc));
        
                        // Utiliser trim() pour supprimer les espaces autour de la valeur de cne
                        var condidatElement = xmlDoc.evaluate(
                            "//Condidat[normalize-space(informations_generales/cne)='" + cne.trim() + "']",
                            xmlDoc,
                            null,
                            XPathResult.FIRST_ORDERED_NODE_TYPE,
                            null
                        ).singleNodeValue;
        
                        console.log("Selected CNE:", cne);
        
                        if (condidatElement) {
                            var etablissementElement = condidatElement.querySelector('etablissement');
                            var ville_info = condidatElement.querySelector('ville');
                            var niveau = condidatElement.querySelector('niveau');
                            var date_naissance = condidatElement.querySelector('date_naissance');
                            var adresse = condidatElement.querySelector('adresse');
                            var code_postal = condidatElement.querySelector('code_postal');
                            var num_tele = condidatElement.querySelector('num_tele');
                            var note1 = condidatElement.querySelector('note1');
                            var classement1 = condidatElement.querySelector('classement1');
                            var nbr_condidat1 = condidatElement.querySelector('nbr_condidat1');
        
                            var note2 = condidatElement.querySelector('note2');
                            var classement2 = condidatElement.querySelector('classement2');
                            var nbr_condidat2 = condidatElement.querySelector('nbr_condidat2');
                            var Annee = condidatElement.querySelector('Annee');
        
                            var filiere = condidatElement.querySelector('filiere');
                            var nbr_annee = condidatElement.querySelector('nbr_annee');
                            var choix_de_filieres_LP = condidatElement.querySelector('choix_de_filieres_LP');
                            var Note = condidatElement.querySelector('Note');
                            var travail = condidatElement.querySelector('travail');
                            var note_diplome = condidatElement.querySelector('note_diplome');
        
                            var popupContainer = document.getElementById('popup-container');
                            popupContainer.style.display = 'block';
        
                            popupContainer.innerHTML = '<h2>Informations sur le candidat</h2>' +
                                '<div>' +
                                '<h4>etablissement:</h4>' +
                                '<p>' + (etablissementElement ? etablissementElement.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>ville:</h4>' +
                                '<p>' + (ville_info ? ville_info.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>niveau:</h4>' +
                                '<p>' + (niveau ? niveau.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>date_naissance:</h4>' +
                                '<p>' + (date_naissance ? date_naissance.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>adresse:</h4>' +
                                '<p>' + (adresse ? adresse.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>code_postal:</h4>' +
                                '<p>' + (code_postal ? code_postal.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>num_tele:</h4>' +
                                '<p>' + (num_tele ? num_tele.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>choix_de_filieres_LP:</h4>' +
                                '<p>' + (choix_de_filieres_LP ? choix_de_filieres_LP.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>filiere bac:</h4>' +
                                '<p>' + (filiere ? filiere.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>Annee bac:</h4>' +
                                '<p>' + (Annee ? Annee.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>note bac:</h4>' +
                                '<p>' + (Note ? Note.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>nbr_annee de travail:</h4>' +
                                '<p>' + (nbr_annee ? nbr_annee.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>travail:</h4>' +
                                '<p>' + (travail ? travail.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>note1:</h4>' +
                                '<p>' + (note1 ? note1.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>classement1:</h4>' +
                                '<p>' + (classement1 ? note1.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>nbr_condidat1:</h4>' +
                                '<p>' + (nbr_condidat1 ? note1.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>note2:</h4>' +
                                '<p>' + (note2 ? note2.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>classement2:</h4>' +
                                '<p>' + (classement2 ? classement2.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                '<h4>nbr_condidat2:</h4>' +
                                '<p>' + (nbr_condidat2 ? nbr_condidat2.textContent.trim() : 'N/A') + '</p>' +
                                '</div>' +
                                '<div>' +
                                  '<h4>note_diplome:</h4>' +
                                  '<p>' + (note_diplome ? note_diplome.textContent.trim() : 'N/A') + '</p>' +
                                  '</div>' +
                                '<button onclick="fermerPopup()">Fermer</button>';
                        } else {
                            console.error("Condidat not found for cne: " + cne);
                        }
                    } else {
                        console.error("Error loading XML data. Status: " + xmlhttp.status);
                    }
                }
            };
            xmlhttp.open("GET", "xml.xml", true);
            xmlhttp.send();
        }
        
        function fermerPopup() {
            var popupContainer = document.getElementById('popup-container');
            popupContainer.style.display = 'none';
        }
        
        </script>
      </head>
      <body style="margin: 20px;">
        <!-- Added hidden popup container -->

        <div id="popup-container" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; padding: 20px; border: 1px solid #ccc; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
          <h2>Candidate Information</h2>
          <!-- Display candidate information here -->
          <div id="details-template"></div>
          
          <button onclick="fermerPopup()">Fermer</button>
        </div>

        <div class="menu">
          <div class="menu__top button-wrapper">
            <img src="l.png" class="logo-img" alt="Logo" width="50" height="50"/>
            <nav class="menu__nav-top">
              <p>Ecole supérieure de technologie de Safi</p>
            </nav>
            <button onclick="afficherCondidats()">Liste des Condidats</button>
            <button onclick="afficherUsers()">Liste de Users</button>
          </div>
        </div>
        <h1>Liste des Condidats</h1>
        <table class="condidats-table">
          <button onclick="afficherFormulaire()" style="margin-left: 140px;">Ajouter</button>

          <thead>
            <tr>
              <th>CNE</th>
              <th>Code Apoge</th>
              <th>CNI</th>
              <th>Nom</th>
              <th>Prénom</th>
              <th>plus</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="Condidats/Condidat">
              <xsl:sort select="Diplome/note_diplome" order="descending" />
              <xsl:choose>
                <xsl:when test="@etat='valide'">
                  <tr style="background-color: #00FF7F; color: black;" data-cne="{cne}">
                    <td><xsl:value-of select="informations_generales/cne"/></td>
                    <td><xsl:value-of select="informations_generales/code_apoge"/></td>
                    <td><xsl:value-of select="informations_generales/cni"/></td>
                    <td><xsl:value-of select="informations_personnelles/nom"/></td>
                    <td><xsl:value-of select="informations_personnelles/prenom"/></td>
                    <!-- Pass candidate cne to the Condidatinfo function -->
                    <th><a href="#" onclick="Condidatinfo('{informations_generales/cne}')">Plus</a></th>
                  </tr>
                </xsl:when>
                <xsl:when test="@etat='pas traiter'">
                  <tr style="background-color: #fff; color: black;" data-cne="{cne}">
                    <td><xsl:value-of select="informations_generales/cne"/></td>
                    <td><xsl:value-of select="informations_generales/code_apoge"/></td>
                    <td><xsl:value-of select="informations_generales/cni"/></td>
                    <td><xsl:value-of select="informations_personnelles/nom"/></td>
                    <td><xsl:value-of select="informations_personnelles/prenom"/></td>
                    <!-- Pass candidate cne to the Condidatinfo function -->
                    <th><a href="#" onclick="Condidatinfo('{informations_generales/cne}')">Plus</a></th>
                  </tr>
                </xsl:when>
                <xsl:otherwise>
                  <tr style="background-color: #FF0000; color: black;" data-cne="{cne}">
                    <td><xsl:value-of select="informations_generales/cne"/></td>
                    <td><xsl:value-of select="informations_generales/code_apoge"/></td>
                    <td><xsl:value-of select="informations_generales/cni"/></td>
                    <td><xsl:value-of select="informations_personnelles/nom"/></td>
                    <td><xsl:value-of select="informations_personnelles/prenom"/></td>
                    <!-- Pass candidate cne to the Condidatinfo function -->
                    <th><a href="#" onclick="Condidatinfo('{informations_generales/cne}')">Plus</a></th>
                  </tr>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>