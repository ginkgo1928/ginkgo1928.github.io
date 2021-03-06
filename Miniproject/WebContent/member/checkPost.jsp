<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소</title>
<link rel="stylesheet" href="../css/checkPost.css">
</head>
<body>

<form name="" method="post" action="/Miniproject/member/checkPost.do">
<table border="1" width="100%" cellpadding="2" cellspacing="1">
<tr>
	<td width="70" align="center">시도</td>
	<td>
		<select name="sido" style="width:100px;">
			<option>시도선택</option>
			<option value="서울">서울</option>
			<option value="인천">인천</option>
			<option value="대전">대전</option>
			<option value="대구">대구</option>
			<option value="울산">울산</option>
			<option value="세종">세종</option>
			<option value="광주">광주</option>
			<option value="경기">경기</option>
			<option value="강원">강원</option>
			<option value="전남">전남</option>
			<option value="전북">전북</option>
			<option value="경남">경남</option>
			<option value="경북">경북</option>
			<option value="충남">충남</option>
			<option value="충북">충북</option>
			<option value="부산">부산</option>
			<option value="제주">제주</option>
		</select>
	</td>
	<td align="center" width="100">시.군.구 </td>
	<td><input type="text" name="sigungu"></td>
</tr>

<tr>
	<td align="center">도로명</td>
	<td colspan="3">
		<input type="text" name="roadname" size="35">
		<input type="submit" value="검색">
	</td>			
</tr>


<tr>
	<td align="center">우편번호</td>
	<td colspan="3" align="center">주소</td>
</tr>

<c:if test="${list!=null}">
	<!--el,jstl(DTO자료형은 필요 없다.이름만 있으면 되!) -->
	<!--zipcodeDTO<--(데이터 줄게0)list-->
	
	<c:forEach var="zipcodeDTO" items="${list}">
	
	<!--get생략가능, 밑으로 내려 쓰지마! 인식 못해! -->
	<c:set var="address">
	${zipcodeDTO.sido
	} ${zipcodeDTO.sigungu
	} ${zipcodeDTO.yubmyundong 
	} ${zipcodeDTO.ri
	} ${zipcodeDTO.roadname 
	} ${zipcodeDTO.buildingname}
	</c:set>
	
	<tr>
		<td align="center">${zipcodeDTO.zipcode}</td>
		<td colspan="3">
		<a id="addressA" href="#" onclick="checkPostClose('${zipcodeDTO.zipcode}','${address}')">${address}</a>
		</td>
	</tr>
	</c:forEach>
</c:if>	
</table>
</form>
</body>
<script src="../js/member.js" type="text/javascript"></script>
</html>

