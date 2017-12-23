<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<%

    String na=new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");

    String updatena = "delete From ordinary_user where username='"+na+"'";

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
        rs = sql.executeQuery("select * from ordinary_user where username = '" + na + "'");
        if(rs.next()){
            if(!na.equals("账号")){
                try {
                    sql.executeUpdate(updatena);
                } catch (SQLException e) {
                    con.close();
                    out.println("<script language = 'javaScript'> alert('修改失败！请确认用户信息是否正确！');window.location.href='/deleteOrdinary.html';</script>");
                }
            }
            con.close();
            out.println("<script language = 'javaScript'> alert('删除成功！');window.location.href='/deleteOrdinary.html';</script>");
        }
        else{
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请修改当前列表已存在的读者的信息！');window.location.href='/deleteOrdinary.html';</script>");
        }
    }catch(Exception e){
        out.print(e);
    }
%>
