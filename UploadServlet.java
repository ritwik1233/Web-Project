import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.util.List;
import java.util.Date;
@WebServlet("/upload")
@MultipartConfig(maxFileSize = 16177215)	// upload file's size up to 16MB
public class UploadServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// database connection settings
	private String dbURL = "";
	private String dbUser = "";
	private String dbPass = "";
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
			
/*------------------------------------------*/
	        String name1="Name1";
	        String name="Name";
	        String topic="";
	        String leader="";
	        String analyst="";
	        String descript="";
	        InputStream input=null;
	        File f1=null;
			// gets values of text fields

	      
	        if(ServletFileUpload.isMultipartContent(request)){
	            try {
	            	 
				            DiskFileItemFactory factory=new DiskFileItemFactory();
				            ServletFileUpload upload=new ServletFileUpload(factory);
				            List<FileItem> items=upload.parseRequest(request);
				            Iterator<FileItem> iter=items.iterator();
				            while(iter.hasNext()){
				            	FileItem item=iter.next();
				            	if(!item.isFormField()){
				            		name1 = item.getName();
				            		System.out.println("File Name1: "+name1 );
				            		
				            		name = new File(item.getName()).getName();
				            		f1=new File(name);
			                        item.write(f1);
				            		input=new FileInputStream(f1);
				            		
				            	}
				            	if(item.isFormField()){
				            		
				            		if (item.getFieldName().equals("topic")){
				            		    topic = item.getString();
				            		    System.out.println("Topic: "+topic );
				            		}
				            		if (item.getFieldName().equals("leader")){
				            		    leader = item.getString();
				            		    System.out.println("Leader Name: "+leader );
				            		}
				            		if (item.getFieldName().equals("analyst")){
				            		    analyst = item.getString();
				            		    System.out.println("Analyst Name: "+analyst );
				            		}
				            		if (item.getFieldName().equals("description")){
				            		    descript = item.getString();
				            		    System.out.println("Leader Name: "+descript );
				            		}
				            	}
			            	
				            }
				            
	            	} catch (Exception ex) {}         
	          
	        }
		
	        String namer=name1.replace(' ', '_');
	        
/*------------------------------------------*/	
	        
	    Date dat1=new Date();
	    SimpleDateFormat ft =new SimpleDateFormat("E dd.MM.yyyy 'at' hh:mm:ss a zzz"); 
	    String date=ft.format(dat1).toString().substring(4,14);
		
		Connection conn = null;	// connection to the database
		String message = null;	// message will be sent back to client
		   
     	try {
			// connects to the database
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

			// constructs SQL statement
			String sql = "INSERT INTO REQUESTS (FILEID, TOPIC, ANALYST, LEADER, EXTRACTOR, DESCRIPTION, "
					+ "FILE1, EXT, STATUS, GEN_DT, STRT_DT, END_DT) values (FILEID_seq.nextval,?, ?, ?, ?,?, ?, ?, ?,?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, topic);
			statement.setString(2, analyst);
			statement.setString(3, leader);
			statement.setString(4, "");
			statement.setString(5, descript);
			statement.setString(7, namer);
			statement.setInt(8, 0);
			statement.setString(9, date);
			statement.setString(10, "");
			statement.setString(11, "");
			
			
			if (input != null) {
				// fetches input stream of the upload file for the blob column
				statement.setBlob(6, input);
			}

			// sends the statement to the database server
			int row = statement.executeUpdate();
			if (row > 0) {
				message = "File uploaded and saved into database";
			}
		} catch (SQLException ex) {
			message = "ERROR: " + ex.getMessage();
			ex.printStackTrace();
		} finally {
			if (conn != null) {
				// closes the database connection
				try {
					conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			// sets the message in request scope
			request.setAttribute("Message", message);
			
			// forwards to the message page
			getServletContext().getRequestDispatcher("/uploadSuccessful.jsp").forward(request, response);
		}
	}

}