<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Home</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="home.jsp" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/homesmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/homelarge.css"><link rel="stylesheet" type="text/css" href="stylesheets/basicstyle.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<!-- INITIALIZATION SCRIPT -->
<script>
	$(document).ready(function() {
		function setDimens() {
			$('.card').height($('.card').width());
			$('.counter').height($('.counter').width());
		}
		$(window).resize(function() {
			setDimens();
		});
		setDimens();
	});
</script>
<!-- CARDS FUNCTIONALITY SCRIPT -->
<script>
	$(document).ready(function() {
		$('#message-card').click(function() {
			$('#call-service').attr('action','MyMessages');
			$('#call-service').submit();
		});
	});
</script>
</head><body>
	<header>
		<h1>CBNET</h1>
	</header>
	<main>
		<div class="container" id="outer-container">
			<div id="message-card" class="card">
				<div class="counter">
					<span class="counter-text">
						<%= request.getAttribute("message-count") %>
					</span>
				</div>
				<h3 class="card-title">Messages</h3>
			</div>
		</div>
		<form id="call-service" method="POST" action="">
			<input type="text" id="service-name" name="service-name" value= '<%= request.getAttribute("username") %>' >
		</form>
	</main>
	<footer>
		CBNET<br/>&copy; 2017
	</footer>
</body></html>
