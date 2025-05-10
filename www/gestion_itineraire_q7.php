<!DOCTYPE html>
<html>

<head>
    <title>Formulaire de destion d'itineraires et de trajets</title>
</head>

<body>
    <?php
    require_once "fonctions_db.php";
    // $bdd = new PDO('mysql:host=db;dbname=group06;charset=utf8', 'group06', 'secret');
    $bdd = connexion();
    $sql = "
        SELECT
            a.iti_id AS id,
            a.iti_nom AS itineraire
        FROM itineraire a
    ";
    $statement_itineraire = $bdd->prepare($sql); 
    $res_itineraire = $statement_itineraire->execute();
    $resultats_itineraire = $statement_itineraire->fetchAll();
    ?>
    <form method="post" action="gestion_itineraire_q7.php">
    <label for="choix_supp_itineraire">Choisissez un itinéraire à supprimer</label>

        <select name="choix_supp_itineraire" >
            <?php
                foreach ($resultats_itineraire as $r){
                    echo "<option value=\"".$r['id']."\">".$r['itineraire']."</option>";
                }
            ?>
        </select>
        <input type="submit" name="supp_submit" value="Supprimer">
    </form>
    <?php
    if(isset($_POST['supp_submit']) && $_POST['supp_submit'] == 'Supprimer'){
        try{
            $bdd->beginTransaction();
            $id = $_POST['choix_supp_itineraire'];
            
            $sql = "DELETE FROM arret_desservi WHERE ad_itineraire_id = :id";
            $statement_supp_arret = $bdd->prepare($sql); 
            $res_supp_arret = $statement_supp_arret->execute(['id' => $id]);

            if ($res_supp_arret) { 
                echo $statement_supp_arret->rowCount() ." ligne(s) supprimées dans ARRET_DESSERVI <BR>" ;
            } else {
                print_r($statement_supp_arret->errorInfo());
                $bdd->rollBack();
                echo "<p>Rollback: aucune ligne n'a été supprimée dans ARRET_DESSERVI</p><BR>" ;
                return;
            }

            $sql = "DELETE FROM horaire WHERE hor_itineraire_id = :id";
            $statement_supp_horraire = $bdd->prepare($sql); 
            $res_supp_horraire = $statement_supp_horraire->execute(['id' => $id]);

            if ($res_supp_horraire) { 
                echo $statement_supp_horraire->rowCount() ." ligne(s) supprimées dans HORRAIRE <BR>" ;
            } else {
                print_r($statement_supp_horraire->errorInfo());
                $bdd->rollBack();
                echo "<p>Rollback: aucune ligne n'a été supprimée dans HORRAIRE</p><BR>" ;
                return;
            }

            $sql = "DELETE FROM trajet WHERE tr_itineraire_id = :id";
            $statement_supp_trajet = $bdd->prepare($sql); 
            $res_supp_trajet = $statement_supp_trajet->execute(['id' => $id]);

            if ($res_supp_trajet) { 
                echo $statement_supp_trajet->rowCount() ." ligne(s) supprimées dans TRAJET <BR>" ;
            } else {
                print_r($statement_supp_trajet->errorInfo());
                $bdd->rollBack();
                echo "<p>Rollback: aucune ligne n'a été supprimée dans TRAJET</p><BR>" ;
                return;
            }

            $sql = "DELETE FROM itineraire WHERE iti_id = :id";
            $statement_supp_itineraire = $bdd->prepare($sql); 
            $res_supp_itineraire = $statement_supp_itineraire->execute(['id' => $id]);

            if ($res_supp_itineraire) { 
                echo $statement_supp_itineraire->rowCount() ." ligne(s) supprimée dans ITINERAIRE <BR>" ;
            } else {
                print_r($statement_supp_itineraire->errorInfo());
                $bdd->rollBack();
                echo "<p>Rollback: aucune ligne n'a été supprimée dans ITINERAIRE </p><BR>" ;
                return;
            }
            $bdd->commit();
            } catch (\PDOException $e) {
                // rollback 
                $bdd->rollBack();    
                // Montrer l'erreur
                die($e->getMessage());
            }
    }
    
    ?>
    <form method="post" action="gestion_itineraire_q7.php">
    <label for="choix_itineraire">Choisissez un itinéraire </label>

        <select name="choix_itineraire" >
            <?php
                foreach ($resultats_itineraire as $r){
                    echo "<option value=\"".$r['id']."\">".$r['itineraire']."</option>";
                }
            ?>
        </select>
        et une direction
        <select name="direction" >
            <option value="0">0</option>
            <option value="1">1</option>
        </select>
        afin de créer un trajet.
        <input type="submit" name="select_submit" value="Selectionner">
    </form>
    <?php
    if(isset($_POST['select_submit']) && $_POST['select_submit'] == 'Selectionner'){
        
        $id_itineraire = $_POST['choix_itineraire'];
        $direction = $_POST['direction'];
        $sql ="
            SELECT
                a.ad_arret_id AS arret_id, 
                a.ad_sequence AS sq
            FROM arret_desservi a WHERE ad_itineraire_id = :id ORDER BY a.ad_sequence ASC";
        $statement_arret = $bdd->prepare($sql); 
        $res_arret = $statement_arret->execute(['id' => $id_itineraire]);
        $resultats_arret = $statement_arret->fetchAll();

        if ($direction == 1) {
            $resultats_arret = array_reverse($resultats_arret);
        }

        $sql = "
            SELECT
                a.serv_id AS service_id,
                a.serv_nom AS service_nom
            FROM service a
        ";
        $service_statement = $bdd->prepare($sql); 
        $res_service = $service_statement->execute();
        $resultats_service = $service_statement->fetchAll();

        ?>
            <form method="post" action="gestion_itineraire_q7.php">
                <input type="hidden" name="choix" value="<?php echo $id_itineraire; ?>">
                <input type="hidden" name="direction" value="<?php echo $direction; ?>">
                <BR>
                Rentrez un ID pour le trajets
                <input type="text" name="trajet_id" required>
                <BR>
                Choix du service
                <select name="service" >
                    <?php
                        foreach ($resultats_service as $r){
                            echo "<option value=\"".$r['service_id']."\">".$r['service_nom']."</option>";
                        }
                    ?>
                </select><BR><BR>
                Selectionnez les gares ou vous voulez vous arrêter, ajouter pour les gare choisi l'heure d'arrivée et l'heure de départ, format : "heure:minutes:secondes",tout en nombre. <BR>
                Attention que la gare de départ n'a pas d'heure d'arrivée et que celle de fin n'a pas d'heure de départ.<BR>
                <?php
                
                foreach ($resultats_arret as $index => $r) {
                    $sql = "SELECT a.arr_nom AS arret_nom FROM arret a WHERE arr_id = :id";
                    $statement_nom = $bdd->prepare($sql); 
                    $res_nom = $statement_nom->execute(['id' => $r['arret_id']]);
                    $nom = $statement_nom->fetch();
                
                    echo "<label>";
                    echo "<input type=\"checkbox\" name=\"arrets[$index][id]\" value=\"".$r['arret_id']."\">".$nom['arret_nom'];
                    echo "</label>";
                    echo "<input type=\"text\" name=\"arrets[$index][arrivee]\" placeholder=\"Heure d'arrivée\">";
                    echo "<input type=\"text\" name=\"arrets[$index][depart]\" placeholder=\"Heure de départ\">";
                    echo "<BR>";
                }
                ?>
                <input type="submit" name="add_submit" value="Soumettre">
            </form>
        <?php
        
    }

    if(isset($_POST['add_submit']) && $_POST['add_submit'] == 'Soumettre'){
        try{
            $service_id = $_POST['service'];
            $trajet_id = $_POST['trajet_id'];
            $id_itineraire = $_POST['choix'];
            $direction = $_POST['direction'];

            $bdd->beginTransaction();
            $sql = 'INSERT INTO trajet(tr_id,tr_service_id,tr_itineraire_id,tr_direction) VALUES (:TRAJET_ID,:SERVICE_ID,:ITINERAIRE_ID,:DIRECTION) ';
            $statement_trajet = $bdd->prepare($sql);
            
            $statement_trajet->bindParam(':TRAJET_ID', $trajet_id, PDO::PARAM_STR);
            $statement_trajet->bindParam(':SERVICE_ID', $service_id, PDO::PARAM_INT);
            $statement_trajet->bindParam(':ITINERAIRE_ID', $id_itineraire, PDO::PARAM_INT);
            $statement_trajet->bindParam(':DIRECTION', $direction, PDO::PARAM_INT);
            

            $res = $statement_trajet->execute();
            
            if ($res) { 
                echo $statement_trajet->rowCount() . " ligne(s) insérée(s) pour trajet<BR>" ;
            } else {
                print_r($statement_trajet->errorInfo());
                $bdd->rollBack();
                echo "<p>Rollback: aucune ligne insérée pour trajet</p><BR>" ;
                return;
            }

            $arrets = $_POST['arrets']; 

            $nombre_arret = 0;

            for ($i = 0; $i < count($arrets); $i++) {
                if (isset($arrets[$i]['id'])) {
                    $nombre_arret ++;
                }
            }
            $var =0;

            $regex_heure = '/^(?:2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9]$/';
            for ($i = 0; $i < count($arrets); $i++) {
                if (isset($arrets[$i]['id'])) {
                    $id_arret = $arrets[$i]['id'];
                    $heure_arrivee = trim($arrets[$i]['arrivee']);
                    $heure_depart = trim($arrets[$i]['depart']);

                    if ($heure_arrivee !== '' && !preg_match($regex_heure, $heure_arrivee)) {
                        $bdd->rollBack();
                        die("Format invalide pour une heure d'arrivée");
                        return;
                    }

                    if ($heure_depart !== '' && !preg_match($regex_heure, $heure_depart)) {
                        $bdd->rollBack();
                        die("Format invalide pour une heure de départ");
                        return;
                    }
            
                    if ($heure_arrivee !== '' && $heure_depart !== '') {
                        if (strtotime($heure_arrivee) >= strtotime($heure_depart)) {
                            $bdd->rollBack();
                            die("Un arret avait une heure d'arrivée étant avant une heure de départ");
                            return;
                        }
                    }

                    if($var==0){
                        $heure_arrivee = NULL;
                    } if($var==$nombre_arret-1) {
                        $heure_depart = NULL;
                    } $var++;

                    $sql = 'INSERT INTO horaire(hor_trajet_id,hor_itineraire_id,hor_arret_id,hor_heure_arrivee,hor_heure_depart) VALUES (:TRAJET_ID,:ITINERAIRE_ID,:ARRET_ID,:HEURE_ARRIVEE,:HEURE_DEPART) ';
                    $statement_horraire = $bdd->prepare($sql);

                    $statement_horraire->bindParam(':TRAJET_ID', $trajet_id, PDO::PARAM_STR);
                    $statement_horraire->bindParam(':ITINERAIRE_ID', $id_itineraire, PDO::PARAM_INT);
                    $statement_horraire->bindParam(':ARRET_ID', $id_arret, PDO::PARAM_INT);
                    $statement_horraire->bindParam(':HEURE_ARRIVEE', $heure_arrivee, PDO::PARAM_STR);
                    $statement_horraire->bindParam(':HEURE_DEPART', $heure_depart, PDO::PARAM_STR);
                    $res_horaire = $statement_horraire->execute();

                    
                }
                
                
            }
            $bdd->commit();
        } catch (\PDOException $e) {
            // rollback 
            $bdd->rollBack();    
            // Montrer l'erreur
            die($e->getMessage());
        }
    }

    ?>

</body>

</html>