<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

		<table border="1">
		<c:set value="0" var="j" />
			<tr>
				<td>
				
				</td>
				<td>
					NO
				</td>
				<td>
					스케줄 이름
				</td>
				<td>
					시작 날 ~ 끝나는 날
				</td>
				<td>
					책 이름
				</td>
				<td>
					하루 학습 분량
				</td>
				<td>
					달성룰
				</td> 
				<td>
					선택
				</td>
			</tr>
			<c:forEach var="i" items="${sessionScope.schedulelist }">
				<tr>
					<td>
						<input type="checkbox" value="${i.schedule_num }" name="delete">
					</td>
					<td>
						<input value="${i.schedule_num }" style="display: none;" name="num">
						<input value="${i.member_nick }" style="display: none;" name="nick">
						${j = j + 1 }
					</td>
					<td>
						${i.schedule_name }
					</td>
					<td>
						${i.schedule_start } ~  ${i.schedule_end }
					</td>
					<td>
						${i.book_title }
					</td>
					<td>
						${i.schedule_day_page }
					</td>
					<td>
						
					</td>
					<td>
						<a href="ScheduleIndexCon.do?num=${i.schedule_num}&nick=${i.member_nick}"><input type="submit" value="확인"></a>
					</td>
				</tr>
			</c:forEach>
			<tr>
					<td colspan="8" align="center">
						<input type="button" name="delete" value="선택삭제">
					</td>
				</tr>
		</table>
		<script type="text/javascript" src="jquery-3.6.0.min">
			var lists = []
			$("input[name = 'delete']:checked").each(function(){
				lists.push($(this).val());
			});
			
			$("#delete").click(function(){
				$.ajax({
					type : "POST",
					data : {'num':lists},
					url : "ScheduleDelete.do",
					datatype : "json",
					success:function(result) {
						if(result == 0){
							alert("삭제 실패");
						}else{
							alert("삭제 성공");
						}
					},
					error : function(){
						alert("서버요청실패");
					}
				});
			});
			
			
			
			
		</script>
	
</body>
</html>