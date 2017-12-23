<%@ page language="java" import="java.sql.*" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>addBookCategory</title>
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
    String na=new String(request.getParameter("bcna").getBytes("ISO-8859-1"),"UTF-8");
    int flag=0;
%>
<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://127.0.0.1:3306/图书馆管理系统db?useUnicode=true&characterEncoding=utf-8";
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
    if(na.equals("类别名称：Politik，Economy，Military, Medicine等")){
        response.sendRedirect("/addBookCategory.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from book_category where bcna ='"+na+"'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加失败，请添加当前列表不存在的图书类别！');window.location.href='/addBookCategory.html';</script>");

    }
    else{
        PreparedStatement sql =conn.prepareStatement("insert into book_category(bcna)values(?)");
        sql.setString(1,na);
        try {
            sql.executeUpdate();
        } catch (SQLException e) {
            conn.close();
            out.println("<script language = 'javaScript'> alert('数据库更新失败，请联系管理员！');window.location.href='/addBookCategory.html';</script>");
        }
        sql.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加成功！');window.location.href='/addBookCategory.html';</script>");
    }
%>
</body>
</html>