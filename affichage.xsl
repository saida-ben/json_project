<!-- affichage.xsl -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

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

          button {
            appearance: none; /* Masquer le style par défaut du navigateur */
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

          table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 10px;
          }

          thead {
            background-color: #333;
            color: #fff;
          }

          thead a {
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
            font-weight: bold;
          }

          tr {
            transition: background-color 0.3s;
          }

          tr:hover {
            background-color: #f5f5f5;
          }

          th, td {
            padding: 15px;
            text-align: left;
          }

          tbody tr:nth-child(even) {
            background-color: #f9f9f9;
          }

          tbody tr:nth-child(odd) {
            background-color: #fff;
          }

          /* Nouveau style pour la fenêtre modale */
          .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            z-index: 999;
          }
          .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 20px;
            z-index: 1000;
            width: 700px;
          }
          
          #contenu {
            text-align: left;
          }
          
          form {
            margin-bottom: 10px;
          }
          
          label {
            display: block;
            margin-bottom: 5px;
          }
          
          input,
          select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
          }
          
          input[type="button"] {
            background-color: #db871a;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
          }
          
          input[type="button"]:hover {
            background-color: #ad7908;
          }
          
          hr {
            border: 0;
            height: 1px;
            background-color: #ccc;
            margin: 10px 0;
          }
          
          #resultat {
            margin-top: 10px;
            color: #333;
          }
          
        </style>

        <script type="text/javascript">
          
          function envoyerRequeteXQuery() {
             var nomValue = document.getElementById('nom').value;
             var prenomValue = document.getElementById('prenom').value;
             var emailValue = document.getElementById('email').value;
             var roleSelect = document.getElementById('role');
             var roleValue = roleSelect.options[roleSelect.selectedIndex].text;

             var requeteXQuery = `
               let $nouvelleDonnee := <User>
                 <nom>${nomValue}</nom>
                 <prenom>${prenomValue}</prenom>
                 <email>${emailValue}</email>
                 <role>${roleValue}</role>
               </User>
               let $baseDeDonnees := db:open('Users.xml', 'update')
               return insert node $nouvelleDonnee as last into $baseDeDonnees//User
             `;
           
             var encodedQuery = encodeURIComponent(requeteXQuery);
           
             axios.post('http://localhost:3000/ajouter-donnee1', `query=${encodedQuery}`, {
               headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
             })
             .then(function (response) {
               console.log(response.data);
             })
             .catch(function (error) {
               console.error("Erreur du serveur Express.js :", error.response.status, error.response.statusText);
             });
         }
           
         function envoyerRequeteXQuery2() {
          var nomValue = document.getElementById('nom1').value;
       
          
          var requeteXQuery = `
            let $nouvelleDonnee := <Permission>
              <nom>${nomValue}</nom>
          
            </Permission>
            let $baseDeDonnees := db:open('Users.xml', 'update')
            return insert node $nouvelleDonnee as last into $baseDeDonnees//Permission
          `;
        
          var encodedQuery = encodeURIComponent(requeteXQuery);
        
          axios.post('http://localhost:3000/ajouter-donnee3', `query=${encodedQuery}`, {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          })
          .then(function (response) {
            console.log(response.data);
          })
          .catch(function (error) {
            console.error("Erreur du serveur Express.js :", error.response.status, error.response.statusText);
          });
      }
      function envoyerRequeteXQuery3() {
        var nomValue = document.getElementById('nom2').value;
        var permissionSelect = document.getElementById('perm2');
        var permissionId = permissionSelect.value;  // Récupérer la valeur de l'ID de la permission
      
        var requeteXQuery = `
          let $nouvelleDonnee := <Role>
            <nom>${nomValue}</nom>
            <permission>${permissionId}</permission> <!-- Utiliser l'ID de la permission -->
          </Role>
          let $baseDeDonnees := db:open('Users.xml', 'update')
          return insert node $nouvelleDonnee as last into $baseDeDonnees//Role
        `;
      
        var encodedQuery = encodeURIComponent(requeteXQuery);
      
        axios.post('http://localhost:3000/ajouter-donnee2', `query=${encodedQuery}`, {
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
          function afficherUsers() {
            window.location.href = 'Users.xml';  // Redirige vers le formulaire.xsl
          }

          function afficherCondidats() {
            window.location.href = 'xml.xml';  // Redirect to the form
          }

          function afficherFormulaire() {
            window.location.href = 'User.xml';  // Redirect to the form
          }

          function afficherPopupForm() {
            var popupForm = document.getElementById("popupForm");
            popupForm.style.display = "block";
          }
          function afficherPopupForm1() {
            var popupForm = document.getElementById("popupForm1");
            popupForm.style.display = "block";
          }
          function afficherPopupForm2() {
            var popupForm = document.getElementById("popupForm2");
            popupForm.style.display = "block";
          }
          function cacherPopupForm() {
            var popupForm = document.getElementById("popupForm");
            popupForm.style.display = "none";
          }
          function cacherPopupForm1() {
            var popupForm1 = document.getElementById("popupForm1");
            popupForm1.style.display = "none";
          }
          function cacherPopupForm2() {
            var popupForm2 = document.getElementById("popupForm2");
            popupForm2.style.display = "none";
          }
        </script>
        
      </head>
      <body style="margin: 20px;">
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

        <h1>Liste de Users</h1>
        <table>
          <button onclick="afficherPopupForm()" style="margin-left: 140px;">Ajouter</button>


          <thead>
            <tr>    
              <th>Nom</th>
              <th>Prénom</th>
              <th>Email</th>
              <th>Role</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="Lp/Users/User"/>
          </tbody>
        </table>

        <h1>Liste de Roles</h1>
        <table>
          <button onclick="afficherPopupForm2()" style="margin-left: 140px;">Ajouter</button>
          <thead>
            <tr>   
              <th>Nom</th>
              <th>permission</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="Lp/Roles/Role"/>
          </tbody>
        </table>
        <h1>Liste de Permissions</h1>
        <table>
          <button onclick="afficherPopupForm1()" style="margin-left: 140px;">Ajouter</button>

          <thead>
            <tr>    
              <th>nom</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="Lp/Permissions/Permission"/>
          </tbody>
        </table>

        <!-- ... (votre code pour d'autres éléments) ... -->

        <div id="popupForm" class="popup">
          <div id="contenu">
              <form>
                <label>nom:</label>
                <input type="text" id="nom" required="required"/><br/>
                <label>prenom:</label>
                <input type="text" id="prenom" required="required"/><br/>
                <label>email:</label>
                <input type="email" id="email" required="required"/><br/>
                <label>Role:</label>
            
              <select id="role" required="required">
                <xsl:for-each select="Lp/Roles/Role">
                  <option>
                    <xsl:value-of select="nom"/>
                  </option>
                </xsl:for-each>
              </select><br/>
                <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery()"/>
              </form>
          <input type="button" value="Fermer" onclick="cacherPopupForm()"/>
            <hr/>
            <div id="resultat"></div>
          </div>
        </div>
        <div id="popupForm1" class="popup">
          <div id="contenu">
              <form>
                <label>permission:</label>
                <input type="text" id="nom1" required="required"/><br/>
             
                <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery2()"/>
              </form>
          <input type="button" value="Fermer" onclick="cacherPopupForm1()"/>
            <hr/>
            <div id="resultat"></div>
          </div>
        </div>
        <div id="popupForm2" class="popup">
          <div id="contenu">
              <form>
                <label>nom:</label>
                <input type="text" id="nom2" required="required"/><br/>
                <label>Permission:</label>
                <select id="perm2" required="required">
                  <xsl:for-each select="Lp/Permissions/Permission">
                    <option value="{nom}">
                      <xsl:value-of select="nom"/>
                    </option>
                  </xsl:for-each>
                </select><br/>
                <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery3()"/>
              </form>
          <input type="button" value="Fermer" onclick="cacherPopupForm2()"/>
            <hr/>
            <div id="resultat"></div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="User">
    <tr>
      <td><xsl:value-of select="nom"/></td>
      <td><xsl:value-of select="prenom"/></td>
      <td><xsl:value-of select="email"/></td>
      <td><xsl:value-of select="role"/></td>
    </tr>
  </xsl:template>
  <xsl:template match="Role">
    <tr>
      <td><xsl:value-of select="nom"/></td>
      <td><xsl:value-of select="permission"/></td>
    </tr>
  </xsl:template>
  <xsl:template match="Permission">
    <tr>
      <td><xsl:value-of select="nom"/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
