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
    String na=request.getParameter("na");
    String cg=request.getParameter("cg");
    String id=request.getParameter("id");
    String call=request.getParameter("call");
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
    if(na==null){
        response.sendRedirect("/addReader.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from reader where id = '" +id + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加失败，该读者信息已存在！');window.location.href='/addReader.html';</script>");

    }
    else{
        PreparedStatement sql =conn.prepareStatement("insert into reader values('"+na+"','"+cg+"','"+id+"','"+call+"')");
        try {
            sql.executeUpdate();
        } catch (SQLException e) {
            sql.close();
            conn.close();
            out.println("<script language = 'javaScript'> alert('数据库更新失败，请联系管理员！');window.location.href='/addReader.html';</script>");
        }
        sql.close();
        conn.close();
        out.println("<script language = 'javaScript'> alert('添加成功！');window.location.href='/addReader.html';</script>");
    }
%>
</body>
</html>