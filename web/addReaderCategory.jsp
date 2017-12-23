<%@ page language="java" import="java.sql.*" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>addReaderCategory</title>
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
    String cana=new String(request.getParameter("cana").getBytes("ISO-8859-1"),"UTF-8");
    String days=new String(request.getParameter("days").getBytes("ISO-8859-1"),"UTF-8");
    String nums=new String(request.getParameter("nums").getBytes("ISO-8859-1"),"UTF-8");
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
    if(cana==null){
        response.sendRedirect("/addReaderCategory.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from reader_category where name = '" + cana + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加失败，请添加当前列表不存在的类别！');window.location.href='/addReaderCategory.html';</script>");

    }
    else{
        PreparedStatement sql =conn.prepareStatement("insert into reader_category(name,days,nums)values(?,?,?)");
        sql.setString(3,nums);
        sql.setString(2,days);
        sql.setString(1,cana);
        try {
            sql.executeUpdate();
        } catch (SQLException e) {
            conn.close();
            out.println("<script language = 'javaScript'> alert('数据库更新失败，请联系管理员！');window.location.href='/addReaderCategory.html';</script>");
        }
        sql.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加成功！');window.location.href='/addReaderCategory.html';</script>");
    }
%>
</body>
</html>