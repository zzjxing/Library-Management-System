<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<%
    String oldcana=new String(request.getParameter("oldcana").getBytes("ISO-8859-1"),"UTF-8");
    String newcana=new String(request.getParameter("newcana").getBytes("ISO-8859-1"),"UTF-8");
    String condition = "update book_category set bcna ='"+newcana+"' where bcna = "+"'"+oldcana+"'";
    try{
        Class.forName("com.mysql.jdbc.Driver");
    }catch(ClassNotFoundException e){
        out.print("数据库连接失败！");
    }
    Connection con;
    ResultSet rs;
    try{
        String uri="jdbc:mysql://127.0.0.1/图书馆管理系统db?"+"user=root&password=&characterEncoding=UTF-8";
        con=DriverManager.getConnection(uri);
        Statement sql = con.createStatement();
        rs = sql.executeQuery("select * from book_category where bcna = '" + oldcana + "'");
        if(rs.next()){
            sql.executeUpdate(condition);
            con.close();
            out.println("<script language = 'javaScript'> alert('修改成功！');window.location.href='/updateBookCategory.html';</script>");
        }
        else{
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请修改当前列表已存在的类别！');window.location.href='/updateBookCategory.html';</script>");
        }
    }catch(Exception e){
        out.print(e);
    }
%>
