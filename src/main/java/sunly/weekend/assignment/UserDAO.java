package sunly.weekend.assignment;

import java.sql.*;

public class UserDAO 	
{
	static Connection currentCon = null;
    static ResultSet rs = null;  
	
    public static UserBean login(UserBean bean) {

    //preparing some objects for connection 
    Statement stmt = null;    

    String username = bean.getUsername();    
    String password = bean.getPassword();   

    String searchQuery = "select * from tb_user where username='" 
    				   + username + "' AND passwd='" + password + "'";
	    
    try 
    {
    	//connect to DB 
        currentCon = ConnectionManager.getConnection();
        stmt=currentCon.createStatement();
        rs = stmt.executeQuery(searchQuery);	        
        boolean more = rs.next();
	       
        // if user does not exist set the isValid variable to false
        if (!more) 
        {
        	System.out.println("Sorry, username or password is invalid!");
            bean.setValid(false);
        } 
	        
        //if user exists set the isValid variable to true
        else if (more) 
        {
        	bean.setValid(true);
        }
     }catch (Exception ex) 
     {
    	 System.out.println("Log In failed: An Exception has occurred! " + ex);
     }    
     //some exception handling
     finally 
     {
    	 if (rs != null){
    		 try {
    			 rs.close();
    		 } catch (Exception e) {}
             rs = null;
         }
	
         if (stmt != null) {
        	 try {
        		 stmt.close();
        	 } catch (Exception e) {}
             stmt = null;
         }
	
         if (currentCon != null) {
            try {
               currentCon.close();
            } catch (Exception e) {}
            currentCon = null;
         }
     }
    return bean;	
  }	
}