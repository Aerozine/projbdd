<!DOCTYPE html>
<html>

<head>
    <title>Formulaire de recherche de gare</title>
</head>
 
<body>
    Formulaire de recherche de gare
    <BR>
    <form method="post" action="gare_form_q6.php">
        <input type="text" name="nom" placeholder="Recherche de gare" required>
        <BR>
        <input type="text" name="filtre" placeholder="Filtre"> Seules les gares avec un nombre d'arrêts, d'arrivées ou de départs suppérieur ou égal à ce nombre seront affiché.
        
        <BR>
        <input type="submit" name="submit" value="Soumettre">
    </form>
    <p>
        <?php
        
        require_once "fonctions_db.php";
        // $bdd = new PDO('mysql:host=db;dbname=group06;charset=utf8', 'group06', 'secret');
        $bdd = connexion();
        if (isset($_POST['submit']) && $_POST['submit'] == 'Soumettre') {
            $chaine = $_POST['nom'];
            $seuil = $_POST['filtre'];
            try{
            
                $sql = "
                        SELECT 
                            a.arr_nom AS gare,
                            s.serv_nom AS service,
                            COUNT(CASE 
                                WHEN h.hor_heure_arrivee IS NOT NULL AND h.hor_heure_depart IS NOT NULL THEN 1 
                            END) AS nb_arrets,
                            COUNT(CASE 
                                WHEN h.hor_heure_arrivee IS NOT NULL AND h.hor_heure_depart IS NULL THEN 1 
                            END) AS nb_arrivees,
                            COUNT(CASE 
                                WHEN h.hor_heure_depart IS NOT NULL AND h.hor_heure_arrivee IS NULL THEN 1 
                            END) AS nb_depart
                        FROM arret a
                        JOIN horaire h ON a.arr_id = h.hor_arret_id
                        JOIN trajet t ON h.hor_trajet_id = t.tr_id
                        JOIN service s ON t.tr_service_id = s.serv_id
                        WHERE LOWER(a.arr_nom) LIKE CONCAT('%', LOWER(:chaine), '%')
                        GROUP BY a.arr_id, a.arr_nom, s.serv_id, s.serv_nom
                        HAVING (:seuil IS NULL OR nb_arrets >= :seuil OR nb_arrivees >= :seuil OR nb_depart >= :seuil)
                        ORDER BY nb_arrets DESC, nb_arrivees DESC, nb_depart DESC;
            ";

                $statement_gare = $bdd->prepare($sql); 
                $res_gare = $statement_gare->execute([':chaine' => $chaine,':seuil' => $seuil]);
                $resultats_gare = $statement_gare->fetchAll();
                if ($resultats_gare){
                    echo "<h2>Résultats</h2>
                        <table border = '1'>
                            <tr>
                                <th>Gare</th>
                                <th>Service</th>
                                <th>Arrêts</th>
                                <th>Arrivées</th>
                                <th>Départs</th>
                            </tr>";
                            foreach ($resultats_gare as $r){
                                echo "<tr>";
                                echo "<td>".$r['gare']."</td>";
                                echo "<td>".$r['service']."</td>";
                                echo "<td>".$r['nb_arrets']."</td>";
                                echo "<td>".$r['nb_arrivees']."</td>";
                                echo "<td>".$r['nb_depart']."</td>";
                                echo "</tr>";
                            }
                            echo "</table>";
                    }
                } catch (\PDOException $e) {

                    // Montrer l'erreur
                    die($e->getMessage());
                }
                
            }
            ?>
    </p>

</body>

</html>