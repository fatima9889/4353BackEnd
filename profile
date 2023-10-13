<?php
	$response = array();
	session_start();

	if (isset($_POST["action"]) && $_POST["action"] == "updateProfile") {
		$name = htmlspecialchars($_POST["name"]);
		$address1 = htmlspecialchars($_POST["address1"]);
		$address2 = htmlspecialchars($_POST["address2"]);
		$city = htmlspecialchars($_POST["city"]);
		$state = htmlspecialchars($_POST["state"]);
		$zip = htmlspecialchars($_POST["zip"]);
		updateProfile($name, $address1, $address2, $city, $state, $zip);
		
	}
	

	function updateProfile($name, $address1, $address2, $city, $state, $zip)
	{
		include 'config.php';
		GLOBAL $response;
		$userid = $_SESSION['id'];
		$stmt = $con->prepare("INSERT INTO `clientinformation`(`userid`, `name`, `address1`, `address2`, `city`, `state`, `zip`) VALUES (?, ?, ?, ?, ?, ?, ?)");
		$stmt->bind_param("sssssss", $userid, $name, $address1, $address2, $city, $state, $zip);

		if ($stmt->execute()) {
			$response['message'] = "Profile Updated successfully";
			$response['status'] = "success";
			$_SESSION['address'] = $address1;
			$_SESSION['state'] = $state;
			

		}else{
			
			$response['message'] = "Unable to update profile.";
			$response['status'] = "failed";

		}
	}
	echo json_encode($response);

?>
