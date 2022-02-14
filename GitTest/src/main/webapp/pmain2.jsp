<%@page import="com.pplus.model.RecVideoDTO"%>
<%@page import="com.pplus.model.VideoDAO"%>
<%@page import="com.pplus.model.VideoDTO"%>
<%@page import="com.pplus.model.RecBookDAO"%>
<%@page import="com.pplus.model.RecBookDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@page import="com.pplus.model.BookDAO"%>
<%@page import="com.pplus.model.BookDTO"%>
<%@page import="com.pplus.model.PMemberDAO"%>
<%@page import="org.apache.tomcat.websocket.PerMessageDeflate"%>
<%@page import="com.pplus.model.PMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
PMemberDTO member = (PMemberDTO) session.getAttribute("member");

PMemberDAO dao = new PMemberDAO();
BookDAO bookDao = new BookDAO();
VideoDAO videoDao = new VideoDAO();
RecBookDAO recDaobook = new RecBookDAO();
ArrayList<RecBookDTO> recbooklist = (ArrayList<RecBookDTO>) session.getAttribute("recbooklist");
ArrayList<RecVideoDTO> recvideolist = (ArrayList<RecVideoDTO>) session.getAttribute("recvideolist");

ArrayList<BookDTO> booklist = null;
ArrayList<VideoDTO> videolist = null; 
// 로그인
if (member != null) {
	if (member.getUser_type1() == null) {
		// 유형조사를 안했을 때
		int[] array = new int[12];
		Random rd = new Random();
		for (int a = 0; a <= array.length - 1; a++) {
	array[a] = rd.nextInt(877);
	for (int b = 0; b < a; b++) {
		if (array[b] == array[a]) {
			a--;
			break;
		}
	}
		}
		booklist = bookDao.bookSelectAll(array);
		videolist = videoDao.videoSelectAll(array);
		request.setAttribute("booklist", booklist);
		request.setAttribute("videolist", videolist);
	} else if (recbooklist != null) {
		// 로그인 유형조사 했을 때

	}
} else {
	// 로그인 안했을 떄
	int[] array = new int[12];
	Random rd = new Random();
	for (int a = 0; a <= array.length - 1; a++) {
		array[a] = rd.nextInt(877);
		for (int b = 0; b < a; b++) {
	if (array[b] == array[a]) {
		a--;
		break;
	}
		}
	}
	booklist = bookDao.bookSelectAll(array);
	videolist = videoDao.videoSelectAll(array);
	request.setAttribute("booklist", booklist);
	request.setAttribute("videolist", videolist);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="jquery-3.6.0.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty member}">
			<a href="plogin.jsp">로그인</a>
			<a href="pjoin.jsp">회원가입</a>

		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${member.member_id=='admin'}">
					<a href="#">회원관리</a>
					<a href="plogout.jsp">로그아웃</a>
					<p>안녕2</p>

				</c:when>
				<c:otherwise>
					<a href="pmypage.jsp">마이페이지</a>
					<a href="plogout.jsp">로그아웃</a>
					<a href="ptype.jsp">유형조사</a>
					<a href="scheduleset.jsp">스케줄등록</a>
					<a href="scheduleindex.jsp">스케줄목록</a>
					<c:choose>
						<c:when test="${empty member.user_type1}">
							<script langauge="javascript">
								window.open("ptype2.jsp", "ptype",
												"width=800, height=300, left=100, top=50");
							</script>
						</c:when>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	<hr>
	<c:choose>
		<c:when test="${empty member}">
			<%
			for (int i = 0; i < booklist.size(); i++) {
			%>
			<a href="BookintCon?num=<%=booklist.get(i).getBook_num()%>"> <img
				src=<%=booklist.get(i).getBook_img()%> width="100">
			</a>
			<%
			}
			%>
			<hr>
			<%
			for (int i = 0; i < videolist.size(); i++) {
			%>
			<a href="VideointCon?num=<%=videolist.get(i).getVideo_num()%>"> <img
				src=<%=videolist.get(i).getVideo_thumbnail()%> width="100">
			</a>
			<%
			}
			%>
		</c:when>

		<c:otherwise>
			<c:choose>

				<c:when test="${empty member.getUser_type1() }">
					<%
					for (int i = 0; i < booklist.size(); i++) {
					%>
					<a href="BookintCon?num=<%=booklist.get(i).getBook_num()%>"> <img
						src=<%=booklist.get(i).getBook_img()%> width="100">
					</a>
					<%
					}
					%>
					<hr>
					<%
					for (int i = 0; i < videolist.size(); i++) {
					%>
					<a href="VideointCon?num=<%=videolist.get(i).getVideo_num()%>">
						<img src=<%=videolist.get(i).getVideo_thumbnail()%> width="100">
					</a>
					<%
					}
					%>

				</c:when>

				<c:otherwise>
					<table>

						<tr>
							<%
							for (int i = 0; i < recbooklist.size(); i++) {
							%>
							<td colspan="2"><a
								href="BookintCon?num=<%=recbooklist.get(i).getBook_num()%>">
									<img src=<%=recbooklist.get(i).getBook_img()%> width="80">
							</a></td>
							<%
							}
							%>
						</tr>
						<tr>
							<%
							for (int i = 0; i < recbooklist.size(); i++) {
							%>
							<td><button id="wish" name="wish">위시</button></td>
							<td id="wishcnt">0</td>
							<%
							}
							%>
						</tr>

					</table>
					<hr>
					<%
					for (int i = 0; i < recvideolist.size(); i++) {
					%>
					<a href="VideointCon?num=<%=recvideolist.get(i).getVideo_num()%>">
						<img src=<%=recvideolist.get(i).getVideo_thumbnail()%> width="80">
					</a>
					<%
					}
					%>

				</c:otherwise>
			</c:choose>
		</c:otherwise>

	</c:choose>
	<script src="jquery-3.6.0.min.js"></script>
	<script>
	var bSubmit = 0;
	
	$("#wish").click( function(){
		if(bSubmit==0){
			$("#wish").css("color","red");
			bSubmit=1;
			
			$.ajax({
				type : "post",
				url : "WishCon.do"
				async : true,
				data : {"bSubmit" : bSubmit},
				success : function(result) {
					alert("Wishlist에 등록되었습니다.")
					$("#wishcnt").html(result)
				},
				error : function(){
					alert("서버요청실패");
				}
			});
		} else {
			$("#wish").css("color","black");
			bSubmit =0;
			
			$.ajax({
				type : "post",
				url : "WishCon.do"
				async : true,
				data : {"bSubmit" : bSubmit},
				success : function(result) {
					alert("Wishlist에 제거되었습니다.")
					$("#wishcnt").html(result)
				},
				error : function(){
					alert("서버요청실패");
				}
			});
		}
	});
	
	</script>
</body>
</html>