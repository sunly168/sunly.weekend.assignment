<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.PreparedStatement"  %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%!
			public int Converter(String str)
			{ 
				int convrtr=0;
				if(str==null)
		    	{
					str="0";
		    	}
				else if((str.trim()).equals("null"))
		    	{
					str="0";
		    	}
				else if(str.equals(""))
		    	{
					str="0";
		    	}
				
				try{
					convrtr=Integer.parseInt(str);
		    	}
				catch(Exception e)
		    	{
					e.printStackTrace();
		    	}
				
				return convrtr;
			}
		%>
		
		<%
			Connection con = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/customer_managment","root", "123456");
			ResultSet rsPgin = null;
			ResultSet rsRwCn = null;
			PreparedStatement psPgintn=null;
			PreparedStatement psRwCn=null;
			
			int iSwRws=5;			
			int iTotSrhRcrds=9;
			int iTotRslts=Converter(request.getParameter("iTotRslts"));
			int iTotPags=Converter(request.getParameter("iTotPags"));
			int iPagNo=Converter(request.getParameter("iPagNo"));
			int cPagNo=Converter(request.getParameter("cPagNo"));
			int iStRsNo=0;
			int iEnRsNo=0;
			if(iPagNo==0){
				iPagNo=0;
			}
			else{
				iPagNo=Math.abs((iPagNo-1)*iSwRws);
			}	
			
			String condition = "";
			if(request.getParameter("searchId") != null){
				condition = " where cus_phone_number = '" + request.getParameter("searchId") + "' or cus_email_address ='" + request.getParameter("searchId") + "'";
			}			
			String sqlPgintn="SELECT SQL_CALC_FOUND_ROWS * FROM tb_customer " + condition + " limit "+iPagNo+","+iSwRws+"";
			psPgintn=con.prepareStatement(sqlPgintn);
			rsPgin=psPgintn.executeQuery();
			String sqlRwCnt="SELECT FOUND_ROWS() as cnt";
			psRwCn=con.prepareStatement(sqlRwCnt);
			rsRwCn=psRwCn.executeQuery();
			if(rsRwCn.next()){
				iTotRslts=rsRwCn.getInt("cnt");	
			}			
		%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<center>
		<form name="frm" action="Search">
      		<table border="0" width="300" align="center" bgcolor="#a8bce0" style="margin-bottom:7px;">
        		<tr>
        			<td ><b>Phone/Email</b></td>
          			<td><input type="text" name="pid" id="pid">        		       
        			<td><input type="submit" name="submit" value="Search"></td>
        			<td><input type="button" name="addnew" value="Add New" /></td>
        		</tr>
      		</table>
    	</form>
		
		<form name="frm"> 
			<input type="hidden" name="iPagNo" value="<%=iPagNo%>"> 
			<input type="hidden" name="cPagNo" value="<%=cPagNo%>"> 
			<input type="hidden" name="iSwRws" value="<%=iSwRws%>"> 
			<table cellpadding="0" cellspacing="2" border="1" > 
			
			<tr border="1">
				<td><b>id</b></td> 
				<td><b>first_name</b></td> 
				<td><b>last_name</b></td>
				<td><b>gender</b></td>
				<td><b>email_address</b></td>
				<td><b>dob</b></td>
				<td><b>address</b></td>
				<td><b>phone_number</b></td>
				<td><b>date_created</b></td>
				<td><b>date_updated</b></td>
				<td><b>edit</b></td>
				<td><b>delete</b></td>				
			</tr>			
			<%
				while(rsPgin.next())
	  			{
			%>
			<tr>
			<td><%=rsPgin.getString("cus_id")%></td>
			<td><%=rsPgin.getString("cus_first_name")%></td>
			<td><%=rsPgin.getString("cus_last_name")%></td>
			<td><%=rsPgin.getString("cus_gender")%></td>
			<td><%=rsPgin.getString("cus_email_address")%></td>
			<td><%=rsPgin.getString("cus_dob")%></td>
			<td><%=rsPgin.getString("cus_address")%></td>
			<td><%=rsPgin.getString("cus_phone_number")%></td>
			<td><%=rsPgin.getString("date_created")%></td>
			<td><%=rsPgin.getString("date_updated")%></td>
			<td><a href="#">edit</a></td>
			<td><a href="#">delete</a></td>
			<% 
 	 			}
			%>
			<% 
				// Calculate next record start and end position 
				try{ 
					if(iTotRslts<(iPagNo+iSwRws)){ 
						iEnRsNo=iTotRslts; 
					} 
					else { 
						iEnRsNo=(iPagNo+iSwRws); 
					} 
					iStRsNo=(iPagNo+1); 
					iTotPags=((int)(Math.ceil((double)iTotRslts/iSwRws))); 
				} catch(Exception e) { 
					e.printStackTrace(); 
				}
			%>
			<tr>
				<td colspan="12" align="middle">
				<div>
			<% 
				// Create index of pages 
				int i=0; 
				int cPge=0; 
				if(iTotRslts!=0) { 
					cPge=((int)(Math.ceil((double)iEnRsNo/(iTotSrhRcrds*iSwRws)))); 
					int prePageNo=(cPge*iTotSrhRcrds)-((iTotSrhRcrds-1)+iTotSrhRcrds); 
					if((cPge*iTotSrhRcrds)-(iTotSrhRcrds)>0) { 
			%> 
			<a href="customer.jsp?iPagNo=<%=prePageNo%>&cPagNo=<%=prePageNo%>"><< Previous</a> 
			<% } for(i=((cPge*iTotSrhRcrds)-(iTotSrhRcrds-1));i<=(cPge*iTotSrhRcrds);i++) { if(i==((iPagNo/iSwRws)+1)) { %> 
			<a href="customer.jsp?iPagNo=<%=i%>" style="cursor:pointer;color:red"><b><%=i%></b></a> <% } else if(i<=iTotPags) { %> 
			<a href="customer.jsp?iPagNo=<%=i%>"><%=i%></a> 
			<% } } if(iTotPags>iTotSrhRcrds&& i<iTotPags) { %> 
			<a href="customer.jsp?iPagNo=<%=i%>&cPagNo=<%=i%>">>> Next</a> 
			<% } } %> <b>Rows <%=iStRsNo%> - <%=iEnRsNo%> 
			Total Result <%=iTotRslts%></b> </div> </td> </tr> </table> </form> </body> </html> 
			<% try{ if(psPgintn!=null){ psPgintn.close(); } if(rsPgin!=null){ rsPgin.close(); }	if(psRwCn!=null){ psRwCn.close(); } if(rsRwCn!=null){ rsRwCn.close(); } if(con!=null){ con.close(); } } catch(Exception e) { e.printStackTrace(); } %>

	</center>
</body>
</html>