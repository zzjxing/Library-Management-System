<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<%
    String user=new String(request.getParameter("user").getBytes("ISO-8859-1"),"UTF-8");
    String oldpw=new String(request.getParameter("oldPassword").getBytes("ISO-8859-1"),"UTF-8");
    String newpw=new String(request.getParameter("newPassword").getBytes("ISO-8859-1"),"UTF-8");
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
        rs = sql.executeQuery("select * from ordinary_user where username = '" + user + "' and password='"+oldpw+"'");
        if(rs.next()){
            sql.executeUpdate("update ordinary_user set password='"+newpw+"' where username = '" + user + "'");
            con.close();
            out.println("<script language = 'javaScript'> alert('修改成功！请重新登录！');window.location.href='/ordinaryLogin.html';</script>");
        }
        else{
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请检查账户和密码是否正确！');window.location.href='/resetPassword.html';</script>");
        }
    }catch(Exception e){
        out.print(e);
    }
%>
