<html>
<head>
	<title>Password Encrypter</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<?php

  if ($_SERVER["REQUEST_METHOD"] == "POST") {
    //if (!empty($_POST["pw"]) {
    $pw = htmlspecialchars(stripslashes(trim($_POST["pw"])));
    //}
  } else {
    $pw = "";
}
?>
<body>

    <h2>Password Encrypter</h2>

    <form action="index.php" method="POST">

        Desired password <input type="password" name="pw" value="<?php echo $pw; ?>" />

        <input type="submit" value="Submit">
    </form>
<?php
/**
 * We just want to hash our password using the current DEFAULT algorithm.
 * This is presently BCRYPT, and will produce a 60 character result.
 */
  if ($pw) {
?>
    Below is your encrypted password.
    </br><br />
<?php
	echo password_hash($pw, PASSWORD_DEFAULT);
    echo "<br />";
  }
?>
</body>
</html>
