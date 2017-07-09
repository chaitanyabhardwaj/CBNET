package cbnet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class MyMessages extends HttpServlet {
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException {
        String username = req.getParameter("service-name");
        FileManager manager = new FileManager();
        String newMessages[] = manager.listUnreadMessages(username);
        req.setAttribute("new_messages", newMessages);
        req.setAttribute("username",username);
        RequestDispatcher view = req.getRequestDispatcher("messages.jsp");
        view.forward(req, res);
    }
    
}