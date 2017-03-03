package sunly.weekend.assignment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Search extends HttpServlet {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {            
            String pid = request.getParameter("pid");           
            String redirectPage = "customer.jsp";
            if((pid != null) || (pid.equals(""))) redirectPage="customer.jsp?searchId=" + pid;
            response.sendRedirect(redirectPage);   
        } catch (Exception e) {
            e.printStackTrace();
        }
    } 

}
