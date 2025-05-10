<!DOCTYPE html>
<html>

<head>
    <title>Formulaire d'ajout de services</title>
</head>

<body>
    Formulaire d'ajout de services
    <BR>
    <form method="post" action="service_form.php">
        <input type="text" name="nom" placeholder="Nom du service" required>
        <BR>
        <label>
            <input type="text" name="date_debut" placeholder="Date de début" required>  
            <input type="text" name="date_fin" placeholder="Date de fin" required> Format des dates : "année-mois-jour",tout en nombre
        </label>
        <BR>
        <input type="checkbox" name="lundi" value ="1"> Lundi
        <BR>
        <input type="checkbox" name="mardi" value ="1"> Mardi
        
        <BR>
        <input type="checkbox" name="mercredi" value ="1"> Mercredi
        
        <BR>
        <input type="checkbox" name="jeudi" value ="1"> Jeudi
        
        <BR>
        <input type="checkbox" name="vendredi" value ="1"> Vendredi
        
        <BR>
        <input type="checkbox" name="samedi" value ="1"> Samedi
        
        <BR>
        <input type="checkbox" name="dimanche" value ="1"> Dimanche

        <BR>
        <label>
            <textarea name="exception"  rows="5" cols="40" placeholder="Exception "></textarea> Format : "année-mois-jour code",tout en nombre pour la date et pour le code mettre EXCLUS ou INCLUS le tout avec une ligne par exception
        </label>
        <BR>
        <input type="submit" name="submit" value="Soumettre">
    </form>
    <p>
        <?php
        require_once "fonctions_db.php";
        // $bdd = new PDO('mysql:host=db;dbname=group06;charset=utf8', 'group06', 'secret');
        $bdd = connexion();
        if (isset($_POST['submit']) && $_POST['submit'] == 'Soumettre') {
            try {
                $bdd->beginTransaction();
                
                $sql = 'INSERT INTO service(serv_id,serv_nom,serv_lundi,serv_mardi,serv_mercredi,serv_jeudi,serv_vendredi,serv_samedi,serv_dimanche,serv_date_debut,serv_date_fin) VALUES (:ID,:NOM,:LUNDI,:MARDI,:MERCREDI,:JEUDI,:VENDREDI,:SAMEDI,:DIMANCHE,:DATE_DEBUT,:DATE_FIN)';
                $statement_service = $bdd->prepare($sql);  
                
                $c = $bdd->query('SELECT COUNT(*) AS COUNT FROM service')->fetch();
                $id = $c['COUNT']+1;
                $statement_service->bindParam(':ID', $id, PDO::PARAM_INT);

                $statement_service->bindParam(':NOM',  $_POST['nom'], PDO::PARAM_STR);

                if(isset($_POST['lundi'])){
                    $statement_service->bindValue(':LUNDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':LUNDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['mardi'])){
                    $statement_service->bindValue(':MARDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':MARDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['mercredi'])){
                    $statement_service->bindValue(':MERCREDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':MERCREDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['jeudi'])){
                    $statement_service->bindValue(':JEUDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':JEUDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['vendredi'])){
                    $statement_service->bindValue(':VENDREDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':VENDREDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['samedi'])){
                    $statement_service->bindValue(':SAMEDI',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':SAMEDI',  FALSE, PDO::PARAM_BOOL);
                }

                if(isset($_POST['dimanche'])){
                    $statement_service->bindValue(':DIMANCHE',  TRUE, PDO::PARAM_BOOL);
                } else {
                    $statement_service->bindValue(':DIMANCHE',  FALSE, PDO::PARAM_BOOL);
                }

                $date_debut=trim($_POST['date_debut']);
                $date_fin=trim($_POST['date_fin']);
                
                $regex_date = '/^([^\s-]+)-([^\s-]+)-([^\s-]+)$/';
                if(!preg_match($regex_date, $date_debut) || !preg_match($regex_date, $date_fin)){
                    $bdd->rollBack();
                    die("Format de date incorrect.");
                    return;  
                }
                $debut = new DateTime($date_debut);
                $fin = new DateTime($date_fin);

                if ($debut > $fin) {
                    $bdd->rollBack();
                    die("La date de fin donnée est avant la date de début donnée.");
                    return;  
                }

                $statement_service->bindParam(':DATE_DEBUT',  $date_debut, PDO::PARAM_STR);
                $statement_service->bindParam(':DATE_FIN',  $date_fin, PDO::PARAM_STR);
                
                
                $res_service = $statement_service->execute();

                if ($res_service) { 
                    echo $statement_service->rowCount() . " ligne(s) insérée(s) pour service<BR>" ;
                } else {
                    print_r($statement_service->errorInfo());
                    $bdd->rollBack();
                    echo "<p>Rollback: aucune ligne insérée pour service</p><BR>" ;
                    return;
                }

                
                if($_POST['exception']!=''){
                    $lines = preg_split('/\r\n|\r|\n/', $_POST['exception']);
                    $regex_exception = '/^([^\s-]+)-([^\s-]+)-([^\s-]+)\s+([^\s]+)$/';
                    foreach($lines as $line){
                        if($line==''){
                            break;
                        }
                        $line=trim($line);
                        if(!preg_match($regex_exception, $line)){
                            $bdd->rollBack();
                            die("Format d'exception incorrect");
                            return;
                        }
                        $sql = 'INSERT INTO exception(exc_service,exc_date,exc_code) VALUES (:SERVICE_ID,:DATE,:CODE)';
                        $statement_exception = $bdd->prepare($sql);  
                        $statement_exception->bindParam(':SERVICE_ID', $id, PDO::PARAM_INT);
                        $parts = explode(" ", trim($line));
                        $statement_exception->bindParam(':DATE', $parts[0], PDO::PARAM_STR);
                
                        if($parts[1]=='INCLUS'){
                            $statement_exception->bindValue(':CODE',1 , PDO::PARAM_STR);
                        } else if($parts[1]=='EXCLUS'){
                            $statement_exception->bindValue(':CODE',2 , PDO::PARAM_STR);
                        } else {
                            $bdd->rollBack(); 
                            die("Erreur dans le code de l'exception");
                            return;  
                        }
                        $res_exception = $statement_exception->execute();

                        if ($res_exception) { 
                            echo $statement_exception->rowCount() . " ligne(s) insérée(s) pour exception <BR>" ;
                        } else {
                            print_r($statement_exception->errorInfo());
                            $bdd->rollBack();
                            echo "<p>Rollback: aucune ligne insérée pour exception </p><BR>" ;
                            return;
                        }
                        
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
    </p>

</body>

</html>