<%@ page import = "java.util.Arrays" %>
<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Messages</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="messages.jsp" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/messagessmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/messageslarge.css"><link rel="stylesheet" type="text/css" href="stylesheets/basicstyle.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('.message-card').click(function() {
			var senderID = $(this).html();
			senderID = userID.trim();
			var receiverID = '<%= request.getAttribute("username") %>';
			receiverID = receiverID.trim();
			$('#senderID').val(senderID)
			$('#receiverID').val(receiverID);
			$('#open-message-form').submit();
		});
		$('#compose-button').click(function() {
			$('#compose-message-container').slideDown('slow');
			$('#outer-container').css({'-webkit-filter':'grayscale(80%)','filter':'grayscale(80%)'});
		});
		$('#send-compose-button').click(function() {
			var receiverID = '<%= request.getAttribute("username") %>';
			receiverID = receiverID.trim();
			var composeReceiverID = $('#compose-receiverID').val();
			composeReceiverID = composeReceiverID.trim();
			var msg = $('#compose-message-area').val();
			msg = msg.trim();
			if(composeReceiverID === "") {
				printError("Please specify the ID to whom you wanna send your message.");
				return;
			}
			if(msg === "") {
				printError("The message is empty. Thodi toh sharam kar li hoti yaar!");
				return;
			}
			var params = {
				sender : receiverID,
				receiver : compose-receiverID,
				msg : msg
			};
			$.post("SendMessage", $.param(params), function(res) {
				if(res == "SENT") {
					printError("SENT");
					$('#compose-message-container').slideUp('slow');
					$('#outer-container').css({'-webkit-filter':'grayscale(0%)','filter':'grayscale(0%)'});
				}
			});
		});

		function printError(msg) {
			$('#error-container').html(msg);
			$('#error-container').fadeIn('slow');
			var timer = setInterval(function() {
				$('#error-container').fadeOut('slow');
				clearInterval(timer);
			},5000);
		}

	});
</script>
</head><body>
	<header>
		<h1>CBNET</h1>
	</header>
	<main>
		<div id="error-container"></div>
		<div class="container" id="compose-message-container">
			<textarea id="compose-message-area">
				Hey there!
			</textarea>
			<input type="text" name="compose-receiverID" id="compose-receiverID" placeholder="Send To?">
			<button type="button" id="send-compose-button"><img src="resources/send-message.png" alt="SEND" id="send-button-img"></button>
		</div>
		<div class="container" id="outer-container">
			<div class="container" id="compose-message">
				<button id="compose-button" type="button">COMPOSE</button>
			</div>
			<ul id="message-list">
				<%
					Object u, o[]; String userList[];
					if((u = request.getAttribute("new_messages")) == null) {
						userList = new String[1];
						userList[0] = "No messages! It hurts, isn't it XD";
						out.println("<li id='no-message'>" + userList[0] + "</li>");
					}
					else {
						o = (Object[])u;
						userList = Arrays.copyOf(o, o.length, String[].class);
						for(int i = 0; i < userList.length; i++)
							out.println("<li class='message-card'>" + userList[i] + "</li>");
					}
				%>
			</ul>
		</div>
		<form method="POST" action="MessageRead" id="open-message-form">
			<input type="text" name="senderID" id="senderID" >
			<input type="text" name="receiverID" id="receiverID" >
		</form>
	</main>
	<footer>
		CBNET<br/>&copy; 2017
	</footer>
</body></html>