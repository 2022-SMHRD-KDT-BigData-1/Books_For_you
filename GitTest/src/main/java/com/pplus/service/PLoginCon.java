package com.pplus.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pplus.model.EditorDAO;
import com.pplus.model.EditorDTO;
import com.pplus.model.PMemberDAO;
import com.pplus.model.PMemberDTO;
import com.pplus.model.RecBookDAO;
import com.pplus.model.RecBookDTO;
import com.pplus.model.RecVideoDAO;
import com.pplus.model.RecVideoDTO;
import com.pplus.model.ScheduleDAO;
import com.pplus.model.ScheduleDTO;



@WebServlet("/PLoginCon")
public class PLoginCon implements iPCommand {

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		 
		String id =request.getParameter("id");
		String pw = request.getParameter("pw");
		
		PMemberDAO dao =new PMemberDAO();
		RecBookDAO recbookDAO =new RecBookDAO();
		RecVideoDAO recvideodao = new RecVideoDAO();
		ScheduleDAO scheduleDAO = new ScheduleDAO();
		
		PMemberDTO member =dao.pmemberLogin(id, pw);
		
		member=dao.pmemberTypeCheck(member);
		
		ArrayList<RecBookDTO> recbooklist=recbookDAO.recBookSelectAll(member);
		ArrayList<RecBookDTO> wishlistbook = (ArrayList<RecBookDTO>) recbookDAO.recBookWishSelectAll(member.getMember_nick());
		ArrayList<RecVideoDTO> wishlistvideo = (ArrayList<RecVideoDTO>) recvideodao.recVideoWishSelectAll(member.getMember_nick());
		ArrayList<RecVideoDTO> recvideolist = recvideodao.recVideoSelectAll(member);
		ArrayList<ScheduleDTO> schedulelist = scheduleDAO.scheduleSelectAll(member.getMember_nick());
		
		
		
		
		if(member != null) {
			System.out.println(id+"가 로그인");
			
			session.setAttribute("schedulelist", schedulelist);
			session.setAttribute("recbooklist", recbooklist);
			session.setAttribute("recvideolist", recvideolist);
			session.setAttribute("wishlistbook", wishlistbook);
			session.setAttribute("wishlistvideo", wishlistvideo);
			session.setAttribute("member", member);
			response.sendRedirect("pmain.jsp");
			
		} else {
			out.print("<script>");
			out.print("alert('로그인 실패..!');");
			out.print("location.href='pmain.jsp';");
			out.print("</script>");
		}
	}
}