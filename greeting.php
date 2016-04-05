#!/usr/bin/php
<?php
	$user = exec('whoami');
	$today = date('l') .' the '. date('jS') .' of '. date('F');
	$ending = array('Shall we play a game?',
					'How about a nice game of chess?');

	// Greeting
	if (date('G') >= 17 || date('G') < 5) $greeting = "Good Evening";
	else if (date('G') >= 12)             $greeting = "Good Afternoon";
	else if (date('G') < 12)              $greeting = "Good Morning";



	$say = $greeting .' '. $user .', today is '. $today . '. ' . rand_array_element($ending);
	
	echo $say;
	exec('espeak "'. $say .'"');
	
function rand_array_element($array) {
	$key = array_rand($array, 1);
	return $array[$key];
}

?>
