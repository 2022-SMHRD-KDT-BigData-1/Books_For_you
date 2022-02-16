package com.pplus.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pplus.model.DayplanDAO;
import com.pplus.model.DayplanDTO;
import com.pplus.model.PMemberDTO;

@WebServlet("/DayplanCon")
public class DayplanCon implements iPCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		PMemberDTO member = (PMemberDTO) session.getAttribute("member");
		DayplanDAO dayplanDao = new DayplanDAO();
		String nick = member.getMember_nick();
		int dayplan_num = dayplanDao.dayplanTodayselect(nick);
		if (dayplan_num == 0) {
			String title = request.getParameter("title");
			DayplanDTO dayplan = new DayplanDTO(0, title, null, 0, nick, null, 0, null, null, 0, 0, 0);

			int cnt = dayplanDao.dayplanSet(dayplan);

			if (cnt > 0) {
				dayplan_num = dayplanDao.dayplanTodayselect(nick);
				request.setAttribute("dayplan_num", dayplan_num);

				RequestDispatcher dispatcher = request.getRequestDispatcher("dayplanmain.jsp");
				dispatcher.forward(request, response);
			} else {
				out.print("<script>");
				out.print("alert('일정 등록을 실패하셨습니다.');");
				out.print("location.href='dayplantodayset.jsp';");
				out.print("</script>");
			}

		} else {
			dayplan_num = dayplanDao.dayplanTodayselect(nick);
			request.setAttribute("dayplan_num", dayplan_num);
			out.print("<script>");
			out.print("alert('이미 일정을을 등록하셨습니다.');");
			out.print("</script>");
			RequestDispatcher dispatcher = request.getRequestDispatcher("dayplanmain.jsp");
			dispatcher.forward(request, response);
		}

	}

}
