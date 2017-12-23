<%--
  Created by IntelliJ IDEA.
  User: Bool
  Date: 2017/11/20
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="java.io.*,java.util.*,java.sql.*" %>--%>
<%--<%@ page import="javax.servlet.http.*,javax.servlet.*" %>--%>


<%@ page language="java" import="java.util.*,java.sql.*,java.net.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>
<body>
<%      //接收用户名和密码
    String user = new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");
    String pwd = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/图书馆管理系统db";
    String username = "root";
    String password = "";
    Class.forName("com.mysql.jdbc.Driver");//加载驱动
    Connection conn = DriverManager.getConnection(url,username,password);//得到连接
    PreparedStatement pStmt = conn.prepareStatement("select * from admin_user where username = '" + user + "' and password = '" + pwd + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        response.sendRedirect("/admin_index.html");
    }else{
        rs.close();
        pStmt.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('登录失败！请检查登录信息是否正确！');window.location.href='/adminLogin.html';</script>");
    }
%>
</body>
</html>







