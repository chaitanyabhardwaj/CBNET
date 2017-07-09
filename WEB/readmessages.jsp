<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Messages</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="readmessages.jsp" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/readmessagessmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/readmessageslarge.css"><link rel="stylesheet" type="text/css" href="stylesheets/basicstyle.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('#send-button').click(function() {
			var m = $('#msg').val();
			m = m.trim();
			if(m != "") {
				var params = {
					msg : m,
					sender : '<%= request.getAttribute("senderID") %>',
					receiver : '<%= request.getAttribute("receiverID") %>'
				};
				$.post("SendMessage", $.param(params), function(res) {
					displayToast("SENT");
					$('#msg').val("");
				});
			}
		});

		function displayToast(msgs) {
			$('#toast-container').html(msgs);
			$('#toast-container').fadeIn('slow');
			var timer = setInterval(function() {
				$('#toast-container').fadeOut('slow');
				clearInterval(timer);
			},3000);
		}

	});
</script>
</head><body>
	<header>
		<h1>CBNET</h1>
	</header>
	<main>
		<div class="container" id="outer-container">
			<div class="container" id="message-display">
				<%= request.getAttribute("message") %>
			</div>
			<div class="container" id="message-send">
				<input type="text" name="msg" id="msg" placeholder="Type To Send">
				<button type="button" id="send-button">SEND</button>
				<div id="toast-container"></div>
			</div>
		</div>
	</main>
	<footer>
		CBNET<br/>&copy; 2017
	</footer>
</body></html>
