package cbnet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class SendMessage extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException {
        String message,senderID,receiverID;
        message = req.getParameter("msg");
        senderID = req.getParameter("sender");
        receiverID = req.getParameter("receiver");
        FileManager manager = new FileManager();
        try {
            manager.writeMessage(FileManager.MESSAGE_SEND, message, senderID, receiverID);
            manager.writeMessage(FileManager.MESSAGE_RECEIVE, message, senderID, receiverID);
        }
        catch(UnknownTypeException ex) {
            ex.printStackTrace();
        }
        PrintWriter pw = new PrintWriter(res.getOutputStream());
        pw.println("SENT");
    }

}