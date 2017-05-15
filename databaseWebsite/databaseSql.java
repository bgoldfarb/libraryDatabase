import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.ResultSetMetaData;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
//import com.mysql.jdbc.Connection;
import java.sql.Connection;
import java.sql.DriverManager;

public class writeToMySQL {

	public static void connection()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Worked");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}


	public static void outputToHTML() throws FileNotFoundException, SQLException{

		connection();
		String host = "jdbc:mysql://127.0.0.1:3306/l";
		String username = "root";
		String password = "databasegroup";

			Connection connect = DriverManager.getConnection(host, username, password);
			System.out.println("Worked again");
			Statement myStmt = connect.createStatement();
			Statement myOtherStmt = connect.createStatement();
			Statement myDiffStmt = connect.createStatement();
			Statement myDivideStmt = connect.createStatement();
			Statement myAgregateStmt = connect.createStatement();
			Statement myInnerStmt = connect.createStatement();
			Statement myOuterStmt = connect.createStatement();
			ResultSet myRsUnion = myStmt.executeQuery("SELECT SSN, Nme FROM EMPLOYEE WHERE SSN IN (SELECT ESSN FROM EMPDEP) UNION SELECT SSN, Nme  FROM EMPLOYEE  WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE);" );
			ResultSet myRsIntersect = myOtherStmt.executeQuery("SELECT SSN, Nme FROM EMPLOYEE WHERE SSN IN (SELECT ESSN FROM EMPDEP) AND SSN IN( SELECT SSN  FROM EMPLOYEE WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE));");
			ResultSet myRsDifference = myDiffStmt.executeQuery("SELECT SSN, Nme FROM EMPLOYEE WHERE Salary > 7000 AND SSN NOT IN( SELECT SSN  FROM EMPLOYEE WHERE SSN IN (SELECT ManagerSSN FROM EMPLOYEE));");
			ResultSet myRsDivide = myDivideStmt.executeQuery("SELECT p.PubID, p.Nme FROM PUBLISHER as p WHERE NOT EXISTS (SELECT * FROM GAME as g WHERE g.PubID != p.PubID);");
			ResultSet myRsAgregate = myAgregateStmt.executeQuery("SELECT b.ID, b.Nme, COUNT(m.MemberID) as mem_count FROM LIBRARY AS b, MEMBER AS m WHERE b.ID = m.LibraryID GROUP BY b.ID, b.Nme;");
			ResultSet myRsInner_Join = myInnerStmt.executeQuery("SELECT b.BranchID, b.Nme as BranchName, e.SSN as EmpSSN, e.Nme as EmpName, e.Dflag as InDepartment, e.Sflag as InSection, d.DeptNo as DeptOrSectNum, d.DeptNme as DeptOrSectName FROM BRANCH as b, EMPLOYEE as e, DEPARTMENT as d WHERE b.BranchID = e.BranchID AND e.DeptNo = d.DeptNo AND e.BranchID = d.BranchID UNION SELECT bb.BranchID, bb.Nme as BranchName, ee.SSN as EmpSSN, ee.Nme as EmpName, ee.Dflag as InDepartment, ee.Sflag as InSection, ss.SectionID as DeptOrSectNum, ss.Nme as DeptOrSectName FROM BRANCH as bb, EMPLOYEE as ee, SECTION as ss WHERE bb.BranchID = ee.BranchID AND ee.SectionID = ss.SectionID AND ee.BranchID = ss.BranchID;");
			ResultSet myRsOuter_Join = myOuterStmt.executeQuery("SELECT CopyID, MemberID as LastHolderID, Nme as LastHolderName FROM MEMBER as m RIGHT OUTER JOIN CURSTATUS c ON m.MemberID=c.LastMID;");
			String stringName= "/Users/briangoldfarb/Desktop/output.html";
			java.sql.ResultSetMetaData rsmd = myRsInner_Join.getMetaData();
			String hi = rsmd.getColumnName(1) + rsmd.getColumnName(2);
			PrintWriter out = new PrintWriter(stringName);
			String union ="";
			String intersect = "";
			String difference = "";
			String divide = "";
			String agregate = "";
			String innerJoin = "";
			String outerJoin = "";
			while(myRsUnion.next()){
				union += ("<pre>" + myRsUnion.getString("Nme")+" "+(myRsUnion.getString("SSN")) + " "  +"</pre>"+"<br></br>");
			}
			while(myRsIntersect.next()){
				intersect += ("<pre>"+ myRsIntersect.getString("Nme") + "   "+(myRsIntersect.getString("SSN"))+ " "  +"</pre>"+"<br></br>");
			}
			while(myRsDifference.next()){
				difference += ("<pre>"+myRsDifference.getString("Nme") + "   "+(myRsDifference.getString("SSN"))+ " " +"</pre>"+"<br></br>");
			}
			while(myRsDivide.next()){
				divide += ("<pre>" + myRsDivide.getString("p.PubID") + "   "+"   "+(myRsDivide.getString("p.Nme"))+ " " +"</pre>"+"<br></br>");
			}
			while(myRsAgregate.next()){
				agregate += ("<pre>" + myRsAgregate.getString("b.ID") + " "+" "+(myRsAgregate.getString("b.Nme"))+ " "+(myRsAgregate.getString("mem_count"))+ " "  +"</pre>"+"<br></br>");
			}

			while(myRsInner_Join.next()){
				innerJoin += ("<pre>"+ myRsInner_Join.getString("BranchID")+" "+(myRsInner_Join.getString("BranchName"))+ " "+(myRsInner_Join.getString("EmpSSN"))+ " "+" "+(myRsInner_Join.getString("EmpName")) + " "+" "+(myRsInner_Join.getString("InDepartment")) + "  " + "   "+(myRsInner_Join.getString("InSection")) + "   "+"   "+(myRsInner_Join.getString("DeptOrSectNum")) + "   "+"   "+(myRsInner_Join.getString("DeptOrSectName"))+ " "+"</pre>" +"<br></br>");
			}

			while(myRsOuter_Join.next()){
				outerJoin =("<pre>" + myRsOuter_Join.getString("CopyID") + "     "+"   "+(myRsOuter_Join.getString("LastHolderID"))+ "             "+(myRsOuter_Join.getString("LastHolderName"))+ " "  +"</pre>"+"<br></br>");
			}

			    out.println("<html>");
		        out.println("<head>");
		        out.print("<title>");
		        out.println("</title>");
		        out.println("<link href=\"/Users/briangoldfarb/Desktop/databaseWebsite/style.css\" rel=\"stylesheet\" type=\"text/css\">");
		        out.println("<script src=\"/Users/briangoldfarb/Desktop/databaseWebsite/jfile.js\" type=\"text/javascript\" ></script>");
		        out.print("<style type=\"text/css\">");
		        out.println("</style>");
		        out.print("</head>");
		        out.print("<body>");
		        out.print("<div id=\"Input_Details\">");
		        out.print("<div class=\"OrderNumsAndMarketCode\">");
		        out.print("<h1>Library Database</h1>");
		        out.print("<div>");
		        out.print("<br></br> Select Query to Run:");
		        out.print("	</div>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionQuery()\">Execute Union</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionIntersect()\">Execute Intersect</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionDifference()\">Execute Difference</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionDivide()\">Execute Divide</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionAgregate()\">Execute Agregate</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionInner_Join()\">Execute Inner_Join</button>");
		        out.print("<br></br>");
		        out.print("<button onclick=\"myFunctionOuter_Join()\">Execute Outer_Join</button>");
		        out.print("<br></br>");

		        out.print("<p id=\"Union\"></p>");
		        out.print("<p id=\"Intersect\"></p>");
		        out.print("<p id=\"Difference\"></p>");
		        out.print("<p id=\"Divide\"></p>");
		        out.print("<p id=\"Aggregate\"></p>");
		        out.print("<p id=\"InnerJoin\"></p>");
		        out.print("<p id=\"OuterJoin\"></p>");


		        out.print("<script>function myFunctionQuery() {document.getElementById(\"Union\").innerHTML = \"UNION <br></br><pre>F_Name  L_Name      SSN</pre>"+union+"\";}</script>");
		        out.print("<script>function myFunctionIntersect() {document.getElementById(\"Intersect\").innerHTML = \"INTERSECT <br></br><pre>Employee_Name     SSN</pre>  "+intersect+"\";}</script>");
		        out.print("<script>function myFunctionDifference() {document.getElementById(\"Difference\").innerHTML = \"DIFFERENCE <br></br><pre>Employee_Name       SSN</pre>  "+difference+"\";}</script>");
		        out.print("<script>function myFunctionDivide() {document.getElementById(\"Divide\").innerHTML = \"DIVIDE <br></br><pre>Pub_ID  Pub_Name</pre>"+divide+"\";}</script>");
		        out.print("<script>function myFunctionAgregate() {document.getElementById(\"Aggregate\").innerHTML = \"AGGREGATE <br></br><pre>B_ID    Branch_Name     Mem_Count</pre>"+agregate+"\";}</script>");
		        out.print("<script>function myFunctionInner_Join() {document.getElementById(\"InnerJoin\").innerHTML = \"INNER_JOIN <br></br><pre>B_ID Branch_Name  EmpSSN    EMP_Name    DFlag SFlag Dept/Sec_NO Dept/Sec_Name</pre>"+innerJoin+"\";}</script>");
		        out.print("<script>function myFunctionOuter_Join() {document.getElementById(\"OuterJoin\").innerHTML = \"OUTER_JOIN <br></br><pre>Copy_ID   Last_Holder_ID    Last_Holder_Name</pre>"+outerJoin+"\";}</script>");
		        out.print("	</div>");
			out.close();


	}



	public static void main(String[] args) throws FileNotFoundException, SQLException {

		outputToHTML();
		connection();
		//connectToMySQL();

	}

}
