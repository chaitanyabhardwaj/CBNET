<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Login</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="login.html" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/loginsmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/loginlarge.css"><link rel="stylesheet" type="text/css" href="stylesheets/basicstyle.css"><link rel="stylesheet" type="text/css" href="stylesheets/new_home_dialog.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('#submit-button').click(function() {
			if(validateInput())
				$('#login-form').submit();
		});
		var heightFactor = $(window).height()/4;
		$('body').css('margin-top', heightFactor);
		function validateInput() {
			var name = $('#username').val();
			var len = name.length();
			if(len > 3) {
				var i;
				for(i = 0; i < len; i++) {
					if(isNaN(name.charAt(i)))
						break;
				}
				if(i == len) {
					printError("The username must contain at least one letter.");
					return false;
				}
				return true;
			}
			return false;
		}
		function printError(msg) {
			$('#error-container').html(msg);
			$('#error-container').fadeIn('slow');
			var timer = setInterval(function() {
				$('#error-container').fadeOut('slow');
				clearInterval(timer);
			},10000);
		}
	});
</script>
</head><body>
<header>
	<h1>CBNET</h1>
</header>
<main>
	<div class="contaienr" id="error-container"></div>
	<div class="container" id="outer-container">
		<div class="container" id="form-container">
			<form method="POST" action="Registered" id="login-form">
				<input type="text" name="username" id="username" placeholder="USERNAME" value='<%= request.getAttribute("username") %>'>
				<input type="password" name="passwd" id="passwd" placeholder="PASSWORD" min="5">
				<div class="help-dialog" id="help-dialog-1">The entered username or password are incorrect, please check again!</div>
				<button type="button" id="submit-button">START</button>
			</form>
		</div>
	</div>
</main>
<footer>
	CBNET<br/>&copy; 2017
</footer>
</body></html>