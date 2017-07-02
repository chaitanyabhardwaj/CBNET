<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Home</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="home.jsp" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/homesmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/homelarge.css"><link rel="stylesheet" type="text/css" href="stylesheets/basicstyle.css"><link rel="stylesheet" type="text/css" href="stylesheets/new_home_dialog.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
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
<!-- NEW USER GUIDING SCRIPT -->
<script>
	$(document).ready(function() {
		var helpDialogCount = $('.help-dialog').length;
	    displayHelpDialog(helpDialogCount);

		function displayHelpDialog(n) {
			var i = 0, timer;
			timer = setInterval(function() {
				if(i < n) {
					$("#help-dialog-"+i).fadeIn(fast);
					if(i > 0)
						$("#help-dialog-"+(i-1)).fadeOut(fast);
				}
				else {
					clearInterval(timer);
				}
			},5000);
		}
	});
</script>
</head><body>
	<header>
		<h1>CBNET</h1>
	</header>
	<main>
		<div class="help-dialog" id="help-dialog-1">
			Hey there! Welcome to CBNET, a WEB APP to message, share and control other systems over a network!
		</div>
		<div class="container" id="outer-container">
			<div id="message-card" class="card">
				<div class="counter">
					<span class="counter-text">
						<% 
							Object o; int n; 
							if((o = request.getAttribute("message-count")) == null) n = 0;
							else n = (int) o;
							out.print(n); 
						%>
					</span>
					<div class="help-dialog" id="help-dialog-2">This shows the number of messages in your inbox</div>
				</div>
				<h3 class="card-title">Messages</h3>
				<div class="help-dialog" id="help-dialog-3">
					This is a card. You can access different functions by clicking on your cards.
				</div>
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
