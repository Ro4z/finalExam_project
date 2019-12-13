package EnterMainPage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class EnterMainPage
 */
@WebServlet("/EnterMainPage")
public class EnterMainPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnterMainPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id = new String(request.getParameter("id").getBytes("8859_1"), "KSC5601");
		String pwd = request.getParameter("pwd");

		session.setAttribute("id", id);
		session.setAttribute("pwd", pwd);

		String login_suc = "";
		if (id.contains("admin")) {
			login_suc = "AdminPage.jsp";
			response.sendRedirect(login_suc);
		}
		else {
			login_suc = "MainPage.jsp";
			response.sendRedirect(login_suc);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}