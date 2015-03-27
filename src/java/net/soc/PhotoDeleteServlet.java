package net.soc;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdk.nashorn.internal.runtime.Version;

/**
 * Servlet implementation class UploadServlet
 */
public class PhotoDeleteServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        HttpSession session = request.getSession();        
        int user_id = Integer.parseInt(session.getAttribute("id").toString());
        String hash = String.valueOf(session.getAttribute("hash"));

        if ((new AuthBean()).checkAuth(user_id, hash)) {//check user authentication
            removeAvatarFromDB(user_id);
        }
        
        //moving back
        response.sendRedirect(getServletContext().getContextPath() + "/edit_profile.jsp");
    }

    private boolean removeAvatarFromDB(int user_id) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            con = (Connection) DriverManager.getConnection(DBConnect.MYSQL_SERVER, DBConnect.MYSQL_USER, DBConnect.MYSQL_PASSWORD);
            st = (Statement) con.createStatement();
            st.executeUpdate("UPDATE profiles SET photo='' WHERE id='"+ user_id +"'");
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                if (rs != null) { rs.close(); }
                if (st != null) { st.close(); }
                if (con != null) { con.close(); }
            } catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return false;
    }
}