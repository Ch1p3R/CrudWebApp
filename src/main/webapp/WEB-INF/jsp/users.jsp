<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
  <head>
    <title>User CRUD</title>
      <style>
      <%@include file='/WEB-INF/css/main.css' %>
      </style>
  </head>
  <body>


  <a class="main" href="../../">Back to main menu</a>
  <br/>

  <h1>Users Data</h1>

<c:if test="${!empty usersList}">
    <form action="/users/search/">
        <div class="row">
            <div class="search">Search Users: <input type='text' name='searchName' id='searchName' placeholder="Enter user id or user name" size="25"/> <button type="submit">Search</button></div>
        </div>
    </form>

    <table class ="firstTable">
    <th>ID</th>
    <th class="col">Name</th>
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

  <ul class="pagination">

      <c:url value="users" var="prev">
          <c:param name="page" value="${page-1}"/>
      </c:url>
      <c:if test="${page > 1 && empty user.timeStamp}">
          <li><a href="<c:out value="${prev}" />" class="prev">Prev</a></li>
      </c:if>
      <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
          <c:choose>
              <c:when test="${page == i.index}">
                  <li><a class="active" href="#"> <span>${i.index}</span></a></li>
              </c:when>
              <c:otherwise>
                  <c:url value="users" var="url">
                      <c:param name="page" value="${i.index}"/>
                  </c:url>
      <li><a  href='<c:out value="${url}"/>'>${i.index}</a></li>
              </c:otherwise>
          </c:choose>
      </c:forEach>
      <c:url value="users" var="next">
          <c:param name="page" value="${page + 1}"/>
      </c:url>
      <c:if test="${page + 1 <= maxPages}">
          <li><a href='<c:out value="${next}" />' class="next">Next</a><li>
      </c:if>
  </ul>

  <a href="<c:url var="post_url" value='/users/add'>
           <c:param name="page" value="${page}" />
           </c:url>
           "></a>

<form:form action="${post_url}" method="POST" commandName="user" >
    <table class="secondTable">
        <c:if test="${!empty user.timeStamp}">
            <tr>
            <td>
                <form:label path="id">
                    <spring:message text="User ID" />
                </form:label>
            </td>
            <td>
                <form:input path="id" readonly="true" disabled="true"/>
                <form:hidden path="id"/>
            </td>
            </tr>
        </c:if>
        <tr>
            <td>
            <form:label path="name">
                <spring:message text="User name" />
            </form:label>
            </td>
            <td>
            <form:input path="name" maxlength="25"/>
            </td>
        </tr>

        <tr>
            <td>
                <form:label path="age">
                    <spring:message text="User age" />
                </form:label>
            </td>
            <td>
                <input type="number" size="5" name="age" min="0" max="120" value="18" path="age"/>
            </td>
        </tr>

        <tr>
            <td>
                <form:label path="isAdmin">
                    <spring:message text="User is admin" />
                </form:label>
            </td>
            <td>
                <form:checkbox path="isAdmin" />
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <c:if test="${!empty user.timeStamp}">

                    <input type="submit"
                           value="<spring:message text="Save"/>"
                    />

                    <form action="/users/">
                        <button type="submit">Cancel</button>
                    </form>
                </c:if>
                <c:if test="${empty user.timeStamp}">
                    <input type="submit"
                           value="<spring:message text="Add new User"/>"/>
                </c:if>

            </td>
        </tr>
  <br>
  </form:form>
    </table>
  </body>

</html>
