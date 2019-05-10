<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Create an account</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href='${contextPath}/resources/css/main.css' rel='stylesheet' type='text/css'>
</head>
<body>
  <div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>
        
        <h2>${ibmWatsonMessage}</h2>
        
        <div class="container">
    <div class="row">
        <div class="col-md-5">
            <div class="panel panel-primary">
                <div class="panel-heading" id="accordion">
                    <span class="glyphicon glyphicon-comment"></span> Chat
                    <div class="btn-group pull-right">
<!--                         <a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"> -->
<!--                             <span class="glyphicon glyphicon-chevron-down"></span> -->
<!--                         </a> -->
                    </div>
                </div>
            <div class="panel-collapse" id="collapseOne">
                <div class="panel-body" id="chat-box-id">
                    <ul class="chat">
                       <!-- 
                       <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span>12 mins ago</small>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li>
                        <li class="right clearfix"><span class="chat-img pull-right">
                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>13 mins ago</small>
                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li>
                        <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span>14 mins ago</small>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li>
                        <li class="right clearfix"><span class="chat-img pull-right">
                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li> -->
                    </ul>
                </div>
                <div class="panel-footer">
                    <div class="input-group">
                        <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
                        <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm" id="btn-chat">
                                Send</button>
                        </span>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>
        
        
    </c:if>
  </div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
  <script src="${contextPath}/resources/js/jquery-1.11.1.min.js"></script>
  <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
  <script src="${contextPath}/resources/js/main.js"></script>
  
  <script>
  $(function() {

	  function DoSomething(){
		  var msg = $("#btn-input").val();
			
			var liLeft = "<li class='left clearfix'><span class='chat-img pull-left'>" +
	                     "<img src='http://placehold.it/50/55C1E7/fff&text=U' alt='User Avatar' class='img-circle' /> " +
	                     "   </span>" +
	                     "       <div class='chat-body clearfix'>" +
	                     "           <div class='header'>" +
	                     "               <strong class='primary-font'>${pageContext.request.userPrincipal.name}</strong> <small class='pull-right text-muted'>" +
	                     "                   <span class='glyphicon glyphicon-time'></span>12 mins ago</small>" +
	                     "           </div>" +
	                     "           <p>" +
	                     msg +
	                     "           </p>" +
	                     "       </div>" +
	                     "   </li>";
			
			$("#chat-box-id ul").append(liLeft);

			$("#btn-input").val("");

			$('#chat-box-id').scrollTop($('#chat-box-id')[0].scrollHeight);
			
			$.ajax({
				  method: "POST",
				  url: "ws/sendMessage",
				  contentType: "application/json",
				  data: JSON.stringify({ message: msg }),
				})
				  .done(function( ret ) {
				    if (ret != null && ret.message != null) {
				    	var liRight = "<li class='right clearfix'><span class='chat-img pull-right'>" +
	                      "      <img src='http://placehold.it/50/FA6F57/fff&text=WA' alt='User Avatar' class='img-circle' />" +
	                      " </span>" +
	                      "      <div class='chat-body clearfix'>" +
	                      "          <div class='header'>" +
	                      "              <small class=' text-muted'><span class='glyphicon glyphicon-time'></span>13 mins ago</small>" +
	                      "              <strong class='pull-right primary-font'>Watson Assistant</strong>" +
	                      "          </div>" +
	                      "         <p> " +
	                                ret.message +
	                      "          </p>" +
	                      "      </div>" +
	                      "  </li>";
			
				    	$("#chat-box-id ul").append(liRight);

				    	$('#chat-box-id').scrollTop($('#chat-box-id')[0].scrollHeight);
				    	
				    	$("#btn-input").val("");
				    }
				  });
	  }

	  $("#btn-input").on('keyup', function (e) {
		    if (e.keyCode == 13) {
		        DoSomething();
		    }
		});
			  
	  
		$("#btn-chat").click(function() {
			DoSomething();
		});
	})
  </script>
  
</body>
</html>
