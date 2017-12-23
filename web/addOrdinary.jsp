<%@ page language="java" import="java.sql.*" contentType="text/html;charset=utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>check_ordinary_Register</title>
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
<br>
<%
    request.setCharacterEncoding("utf-8");
    String users=request.getParameter("username");
    String pass=request.getParameter("password");
    int flag=0;
%>
<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://127.0.0.1:3306/图书馆管理系统db";
    String use = "root";
    String password = "";
    Class.forName(driver);
    Connection conn= null;
    try {
        conn = DriverManager.getConnection(url,use,password);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    if (conn==null){
        out.print("数据库连接失败！");
//        response.sendRedirect("/home/ordinary_Register.jsp?errNo");
    }//连接数据库失败返回到注册}

    PreparedStatement pStmt = conn.prepareStatement("select * from ordinary_user where username = '" + users + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加失败！该用户已存在！');window.location.href='/addOrdinary.html';</script>");
    }else{
        PreparedStatement sql =conn.prepareStatement("insert into ordinary_user(username,password)values(?,?)");
        sql.setString(2,pass);
        sql.setString(1,users);
        int rtn=sql.executeUpdate();
        sql.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加成功！');window.location.href='/addOrdinary.html';</script>");
    }
%>
</body>
</html>