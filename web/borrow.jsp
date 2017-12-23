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
//    String startday=request.getParameter("startday");
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
        response.sendRedirect("/borrow.html");
    }

    PreparedStatement pStmt = conn.prepareStatement("select * from reader where id = '" +id + "'");
    ResultSet rs = pStmt.executeQuery();
    if(rs.next()){

        PreparedStatement pStmt2 = conn.prepareStatement("select * from reader_state where arrears='0' and id = '"+id+"' and nums<(select nums from reader_category,reader where reader_category.name=reader.reader_categoryna and reader.id = '"+id+"')");
        ResultSet rs2 = pStmt2.executeQuery();
        if(rs2.next()){
            PreparedStatement pStmt3 = conn.prepareStatement("select * from book where bna='"+bna+"'");
            ResultSet rs3 = pStmt3.executeQuery();
            PreparedStatement pStmtNum = conn.prepareStatement("select count(*) from borrow ");
            ResultSet rsNum = pStmtNum.executeQuery();
            rsNum.next();
            int Num=rsNum.getInt(1)+1;
            if(rs3.next()) {
                PreparedStatement sql1 =conn.prepareStatement("insert into borrow values('"+id+"','"+bna+"',curdate(),NULL,'"+Num+"')");
                try {
                    sql1.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                PreparedStatement sql4 =conn.prepareStatement("update reader_state set nums=nums+1 where id = '"+id+"'");
                sql4.executeUpdate();
                sql1.close();
                conn.close();
                out.println("<script language = 'javaScript'> alert('借阅成功！');window.location.href='/borrow.html';</script>");
            }
            else{
                conn.close();
                out.println("<script language = 'javaScript'> alert('对不起，书库不存在该图书！');window.location.href='/borrow.html';</script>");
            }
            } }
    else{
        conn.close();
        out.println("<script language = 'javaScript'> alert('不存在该读者信息！请先添加该读者信息！');window.location.href='/addReader.html';</script>");

    }

%>
</body>
</html>