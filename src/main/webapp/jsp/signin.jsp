<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.motionblue.mi.login.LoginService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Spring security</title>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

    

</head>
<body>
<script>
    function get_msg(message) {
        var move = '70px';
        jQuery('#message').text(message);
        jQuery('#message').animate({
             top : '+=' + move
        }, 'slow', function() {
             jQuery('#message').delay(1000).animate({ top : '-=' + move }, 'slow');
        });
    }

    <c:if test="${error == 'true'}">
    jQuery(function() {
        get_msg("로그인 실패하였습니다.");
    });

    </c:if>

    function signin() {
        $.ajax({
             url : './signinDo',
             data: $('form input').serialize(),
             type: 'POST',
             dataType : 'json',
             beforeSend: function(xhr) {
                  xhr.setRequestHeader("Accept", "application/json");
             }
        }).done(function(body) {
			console.log(body);
			alert(body);
             var message = body.response.message;
             var error = body.response.error;
             if (error) get_msg(message);

             if (error == false) {
                  var url = '${referer}';
                  if (url == '') url = '<c:url value="/mypage" />';
                  location.href = url;
             }
        });
    }
    </script>    

    <div>
    	<div id="message" style="width:300px;position:absolute; top:-60px;border: 1px;border-color: #000;">로그인에 실패하셨습니다.</div>
    </div>

    <div style="margin-top:100px;">
    <form action="./signinDo" method="post">
     	아이디 : <input type="text" id="userId" name="userId">
     	비밀번호 : <input type="password" id="userPw" name="userPw">
    	<button type="submit">Sign in</button>
    	<button type="button" onclick="signin();">Ajax Sign in</button>
    </form>
	</div>
</body>
</html>
