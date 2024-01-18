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
            var ville_infoValue = document.getElementById('ville_info').value;
            var niveauValue = document.getElementById('niveau').value;
            var date_naissanceValue = document.getElementById('date_naissance').value;
            var adresseValue = document.getElementById('adresse').value;
            var code_postalValue = document.getElementById('code_postal').value;
            var num_teleValue = document.getElementById('num_tele').value;
          
          
          
            var requeteXQuery = `
              let $nouvelleDonnee := <Condidat>
                <cne>${cneValue}</cne>
                <cin>${cinValue}</cin>
                <code_apoge>${code_apogeValue}</code_apoge>
                <nom>${nomValue}</nom>
                <prenom>${prenomValue}</prenom>
                <password>${passwordValue}</password>
                <etablissement>${etablissementValue}</etablissement>
                <ville>${ville_infoValue}</ville>
                <niveau>${niveauValue}</niveau>
                <date_naissance>${date_naissanceValue}</date_naissance>
                <adresse>${adresseValue}</adresse>
                <ville_info>${ville_infoValue}</ville_info>
                <code_postal>${code_postalValue}</code_postal>
                <num_tele>${num_teleValue}</num_tele>
               
              </Condidat>
              let $baseDeDonnees := db:open('xml.xml', 'update')
              return insert node $nouvelleDonnee as last into $baseDeDonnees//Condidat
            `;
          
            var encodedQuery = encodeURIComponent(requeteXQuery);
          
            axios.post('http://localhost:3000/ajouter-donnee', `query=${encodedQuery}`, {
              headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            })
            .then(function (response) {
              console.log(response.data);
            })
            .catch(function (error) {
              console.error("Erreur du serveur Express.js :", error.response.status, error.response.statusText);
            });
          }
          
        </script>
        <script>
         function afficherFormulaire() {
           window.location.href = 'xml.xml';  // Redirige vers le formulaire.xsl
         }
       </script>
      </head>
      <body>
        <div id="contenu">
         <button onclick="afficherFormulaire()">back</button>

          <form>
            <label>CNE:</label>
            <input type="text" id="cne" required="required"/><br/>
            <label>CIN: <input type="text" name="cin" id="cin" onchange="envoyerRequeteXQuery()"/></label><br/>
            <label>Code apoge: <input type="text" name="code_apoge" id="code_apoge" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Nom: <input type="text" name="nom" id="nom" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Prénom: <input type="text" name="prenom" id="prenom" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Etablissement: <input type="text" name="etablissement" id="etablissement" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Ville: <input type="text" name="ville_info" id="ville_info" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Niveau: <input type="text" name="niveau" id="niveau" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Date de naissance: <input type="text" name="date_naissance" id="date_naissance" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Adresse: <input type="text" name="adresse" id="adresse" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Code postal: <input type="text" name="code_postal" id="code_postal" onchange="envoyerRequeteXQuery()"/></label><br />
            <label>Numéro de téléphone: <input type="text" name="num_tele" id="num_tele" onchange="envoyerRequeteXQuery()"/></label><br />
        
          
            <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery()"/>
          </form>
          <hr/>
          <div id="resultat"></div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
