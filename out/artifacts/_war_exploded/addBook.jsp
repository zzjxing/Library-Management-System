<%@ page language="java" import="java.sql.*" contentType="text/html;charset=utf-8"%>
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
<br>
<%
    request.setCharacterEncoding("utf-8");
    String bna=request.getParameter("bna");
    String author=request.getParameter("author");
    String publish=request.getParameter("publish");
    String pbyear=request.getParameter("pbyear");
    String state=request.getParameter("state");
    String book_category=request.getParameter("book_category");
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
    }//连接数据库失败返回到注册
    if(bna.equals("书名")){
        response.sendRedirect("/addBook.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from book where bna = '" +bna + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加失败，该图书信息已存在！');window.location.href='/addBook.html';</script>");

    }
    else{
        PreparedStatement sql =conn.prepareStatement("insert into book values('"+bna+"','"+author+"','"+publish+"','"+pbyear+"','"+state+"','"+book_category+"')");
        try {
            sql.executeUpdate();
        } catch (SQLException e) {
            sql.close();
            conn.close();
            out.println("<script language = 'javaScript'> alert('数据库更新失败，请联系管理员！');window.location.href='/addBook.html';</script>");
        }
        sql.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加成功！');window.location.href='/addBook.html';</script>");
    }
%>
</body>
</html>