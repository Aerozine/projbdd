<?php
require_once "fonctions_db.php";



// Tables autorisées pour éviter injection
$tables = ['agence', 'horaire', 'exception'];
$table="";
// Si une table est sélectionnée
if(isset($_POST['table'])){
    $table= $_POST['table'];
    $filters = [];


    if (in_array($table, $tables)) { //fct php
        try{
            // Connexion à la base
            $pdo = connexion();
            // Préparation des champs dynamiquement selon la table choisie
            $stmt = $pdo->query("describe $table;"); 
            // describe idem que show columns from $table
            $stmt->execute();
            $stmt-> setfetchmode(PDO::FETCH_ASSOC);
            $columns=$stmt->fetchall();
            //$columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
            // var_dump($columns);
            
            // Construction de la requête avec WHERE si des filtres sont définis
            $sql = "SELECT * FROM $table";
            $where = [];
            $params = [];

            foreach ($columns as $ligne) {

                if (!empty($_POST[$ligne['Field']])) {
                    $col=$ligne['Field'];
                    //echo $col;
                    //echo $ligne['Type'];
                    if (strpos($ligne['Type'],"char") >0) {
                        // Texte : contrainte de contenance pour char varchar ->le type contient char ->strpos
                        $where[] = "$col LIKE :$col";
                        $params[":$col"] = "%" . $_POST[$col] . "%";
                    }else {
                        // contrainte d'égalité nombre, date et time
                        $where[] = "$col = :$col";
                        $params[":$col"] = $_POST[$col];
                    }
                }
            }

            if ($where) {
                $sql .= " WHERE " . implode(" AND ", $where); 
                 // implode :  Join array elements with a string
                //echo $sql;
            }

            $query = $pdo->prepare($sql);
            $query->execute($params);
            $results = $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch (Exception $ex) {
            die("ERREUR FATALE : ". $ex->getMessage().'<form><input type="button" value="Retour" onclick="history.go(-1)"></form>');
        }
    }    
}
?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="style/display.css">
  <title>Recherche dans les tables</title>
</head>
<body>
    <h1>Recherche filtrée</h1>

    <form method="POST">
        <label for="table">Choisir une table :</label>
        <select name="table" id="table" onchange="this.form.submit()">
            <option value="">--Choisir--</option>
            <?php foreach ($tables as $t): ?>
                <option value="<?= $t ?>" <?= $table == $t ? 'selected' : '' ?>><?= $t ?></option>
            <?php endforeach; ?>
        </select>
    </form>

    <?php 
    if (isset($columns) ) { //si on a choisit une table  
        echo"<form method='POST'>";
        echo "<input type='hidden' name='table' value='$table'>";
        echo "<h2>Filtres pour la table <?= $table ?></h2>";
        foreach ($columns as $ligne){
                $col=$ligne['Field'];
                echo "<label>".substr($col,strpos($col,"_")+1).":</label>";
                echo "<input type='text' name='".$col."' value='".
                        ($_POST[$col] ?? "")."'><br>";
                // ?? si $_POST[$col] est vide alors ""
        }
        echo "<input type='submit' value='Filtrer'> 
             </form>";
    } 
    if (!empty($results)){
        echo "<h2>Résultats</h2>";
        echo "<table >";
        echo " <tr>";
        foreach (array_keys($results[0]) as $col){
                echo "<th>".substr($col,strpos($col,"_")+1)."</th>";
        }
        echo "</tr>";
        foreach ($results as $row){
                echo "<tr>";
                foreach ($row as $val){
                        echo "<td>".htmlentities($val)."</td>";
                }
                echo "</tr>";
        }    
        echo "</table>";
    }    
    elseif ($table && isset($results)){
        echo "<p>Aucun résultat trouvé.</p>";
    }
    ?>
</body>
</html>
