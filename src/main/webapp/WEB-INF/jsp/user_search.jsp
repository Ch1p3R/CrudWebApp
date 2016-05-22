<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Searched user</title>
    <style>
    <%@include file='/WEB-INF/css/main.css' %>
    </style>
</head>
<body>
<a href="../../">Back to main menu</a>
<br/>
<br><br>
<h1>Users search</h1>

<form action="/users/search/">
    <div class="row">
        <div class="search">Search Users: <input type='text' name='searchName' id='searchName'/> <button type="submit">Search</button></div>
    </div>
</form>

<c:if test="${empty usersList}">
    <br>
    <center><b>User not found! ;( </b></center>
    </c:if>
<c:if test="${!empty usersList}">

    <table class="firstTable">
        <th>ID</th>
        <th>Name</th>
        <th>Age</th>
        <th>isAdmin</th>
        <th>Created Date</th>
        <c:if test="${empty user.timeStamp}">
            <th>Edit | Delete</th>
        </c:if>
        <c:forEach items="${usersList}" var="currUser">
            <tr>
                <td>${currUser.id}</td>
                <td>${currUser.name}</td>
                <td>${currUser.age}</td>
                <td>${currUser.isAdmin}</td>
                <td>${currUser.timeStamp}</td>
                <c:if test="${empty user.timeStamp}">
                    <td><a href="<c:url value='/users/edit/${currUser.id}'>
           <c:param name="page" value="${page}" />
           </c:url>">Edit</a>
                        <b>|</b>
                        <a href="<c:url value='/users/remove/${currUser.id}'>
              <c:param name="page" value="${page}" />
           </c:url>">Delete</a></td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</c:if>

<br>
<br>
<form action="/users">
    <button class="buttonBack" type="submit">Back</button>
</form>
</body>
</html>
