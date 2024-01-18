<!-- formulaire.xsl -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:user="user.xsd">
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
            var nomValue = document.getElementById('nom').value;
            var prenomValue = document.getElementById('prenom').value;
            var emailValue = document.getElementById('email').value;
            var roleValue = document.getElementById('role').value;
          
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
          
        </script>
        <script>
         function afficherFormulaire() {
           window.location.href = 'Users.xml';  // Redirige vers le formulaire.xsl
         }
       </script>
       <style>
       
        /* Styles pour le menu */
        .menu {
          position: relative;
        margin:30px;
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
      
        form {
          display: flex;
          flex-direction: column;
        }
      
        label {
          margin-bottom: 5px;
        }
      
        input,
        textarea {
          margin-bottom: 15px;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 3px;
          font-size: 14px;
        }
      
        input[type="button"] {
          background: rgb(238, 203, 146);
          background: radial-gradient(circle, rgba(238, 203, 146, 1) 0%, rgba(208, 221, 234, 1) 100%);
          color: black;
          font-weight: bold;
          padding: 14px 20px;
          margin: 8px auto; /* Modification pour centrer le bouton horizontalement */
          border: none;
          cursor: pointer;
          width: 50%;
          opacity: 0.9;
          font-size: 16px;
          border-radius: 10px;
        }
      
        input[type="button"]:hover {
          opacity: 1;
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



        #role {
          /* Styles généraux du select */
          display: inline-block;
          padding: 8px;
          font-size: 16px;
          border: 1px solid #ccc;
          border-radius: 4px;
          box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
        }
/* Style de survol lorsque l'utilisateur passe la souris */
#role:hover {
  border-color: #888;
}

/* Style du focus lorsqu'il est sélectionné */
#role:focus {
  outline: none;
  border-color: #4d90fe;
  box-shadow: 0 0 5px rgba(77, 144, 254, 0.5);
}

/* Style des options dans le menu déroulant */
#role option {
  background-color: #fff;
  color: #333;
}

/* Style de survol des options */
#role option:hover {
  background-color: #f5f5f5;
}

/* Style de la flèche du menu déroulant (certaines propriétés peuvent ne pas être supportées par tous les navigateurs) */
#role::-ms-expand {
  display: none;
}

#role:after {
  content: '\25BC'; /* flèche vers le bas */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
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
        

          <form>

            <label>nom:</label>
            <input type="text" id="nom" required="required"/><br/>
            <label>prenom:</label>
            <input type="text" id="prenom" required="required"/><br/>
            <label>email:</label>
            <input type="email" id="email" required="required"/><br/>
            <label>role:</label>
            <input type="text" id="role" required="required"/><br/>
            <label>Role:</label>
            <select id="role" required="required">
              <xsl:for-each select="/user:schema/user:simpleType[@name='roleType']/user:restriction/user:enumeration">
                <option>
                  <xsl:value-of select="@value"/>
                </option>
              </xsl:for-each>
            </select><br/>
          
            <input type="button" value="Ajouter" onclick="envoyerRequeteXQuery()"/>
          </form>
          <hr/>
          <div id="resultat"></div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
