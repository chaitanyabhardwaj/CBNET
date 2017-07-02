<!DOCTYPE html><html lang="en-US" dir="ltr"><head><meta charset="utf-8" /><title>CBNET Messages</title><meta name="description" content="CBNET is a web-app made, so that machines and boxes can come to live. CBMUSIC is also a production of CBNET. Come along and do things without moving an inch. Be Lazy, be awesome!"/><meta name="author" content="Chaitanya Bhardwaj" /><base href="messages.jsp" target="_blank" /><meta name="referrer" content="origin-when-cross-origin" /><link rel="icon" type="image/x-icon" href="resources/favicon.png" /><link rel="stylesheet" type="text/css" media="screen and (max-width: 700px)" href="stylesheets/messagessmall.css" /><link rel="stylesheet" type="text/css" media="screen and (min-width:701px)" href="stylesheets/messageslarge.css"><link rel="stylesheet" type="text/css" href="stylesheetsbasicstyle.css"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
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
	});
</script>
</head><body>
	<header>
		<h1>CBNET</h1>
	</header>
	<main>
		<div class="container" id="outer-container">
			<ul id="message-list">
				<%
					String userList[] = request.getAttribute("new_messages");
					for(int i = 0; i < userList.length; i++)
						out.println("<li class='message-card'>" + userList[i] + "</li>");
				%>
			</ul>
		</div>
		<form method="POST" action="MessageRead" id="open-message-form">
			<input type="text" name="senderID" id="senderID" value="">
			<input type="text" name="receiverID" id="receiverID" value="">
		</form>
	</main>
	<footer>
		CBNET<br/>&copy; 2017
	</footer>
</body></html>