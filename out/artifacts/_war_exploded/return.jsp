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
    String id=request.getParameter("id");
    String bna=request.getParameter("bna");
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
    if((id.equals("读者身份证号"))||(bna.equals("书名"))){
        response.sendRedirect("/return.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from reader where id = '" +id + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){

        PreparedStatement pStmt2 = conn.prepareStatement("select * from borrow where (curdate()-startdate)<=(select days from reader_category,reader where reader_category.name=reader.reader_categoryna and reader.id = '"+id+"')" );
        ResultSet rs2 = pStmt2.executeQuery();
        if(rs2.next()){
            PreparedStatement sql =conn.prepareStatement("update borrow set enddate=curdate() where id='"+id+"' and bna='"+bna+"'");
            sql.executeUpdate();
            PreparedStatement sql2 =conn.prepareStatement("update reader_state set nums=nums-1 where id='"+id+"'");
            sql2.executeUpdate();
            conn.close();
            out.println("<script language = 'javaScript'> alert('归还成功！');window.location.href='/return.html';</script>");
        }
        else
        {
            PreparedStatement sql =conn.prepareStatement("update borrow set enddate=curdate() where id='"+id+"' and bna='"+bna+"'");
            sql.executeUpdate();
            PreparedStatement sql2 =conn.prepareStatement("update reader_state set nums=nums-1 where id='"+id+"'");
            sql2.executeUpdate();
            PreparedStatement sql3 =conn.prepareStatement("update borrow_state set arrear='1' where id='"+id+"'");
            sql3.executeUpdate();
            conn.close();
            out.println("<script language = 'javaScript'> alert('归还超期，需要缴费！');window.location.href='/return.html';</script>");
        }
    }
    else{
        conn.close();
        out.println("<script language = 'javaScript'> alert('不存在该读者信息！请先确认该读者信息！');window.location.href='/addReader.html';</script>");

    }

%>
</body>
</html>