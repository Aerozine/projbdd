<?php
session_start();
require_once "fonctions_db.php";

try{
	$_SESSION['html3']="";
	$ma_db=connexion();
	if(	 isset($_POST["action"])){
		if(isset($_POST["choix"])){
			$_SESSION['html1']="<H1>Modification de l'arrêt ".$_POST["choix"]."</H1>";
			$_SESSION['html2']="<form action='q8.php' method='POST'>";
			$_SESSION['html2'].=update_arret($ma_db,$_POST["choix"]);
			$_SESSION['html2'].="</form>";
		}
		else{
			$_SESSION['html1']="<H1> Les arrets</H1>"."sélectionnez une valeur";
		}
	}
	else{
		if(isset($_POST["action2"])){
			
			$_SESSION['html1']=maj_arret($ma_db);
		}
		else{
			$_SESSION['html1']="";
		}	
		$_SESSION['html1'].="<H1> Les arrets</H1>";
		$_SESSION['html2']="";
		$_SESSION['html2']="<form action='q8.php' method='POST'>";
		$_SESSION['html2'].="<input type='submit' name='action'>";
		$_SESSION['html2'].=select_arret($ma_db);
		$_SESSION['html2'].="</form>";
		
	}

}
catch (Exception $ex) {
    die("ERREUR FATALE : ". $ex->getMessage().'<form><input type="button" value="Retour" onclick="history.go(-1)"></form>');
}
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="style/display.css">
	<title>Arrêts </title>
</head>
<body>
	
 <?php 
 echo $_SESSION['html1'];
 echo $_SESSION['html2'];
 echo $_SESSION['html3'];
  ?>
</body>
</html>
