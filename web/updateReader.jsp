<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<%
    String oldid=new String(request.getParameter("oldid").getBytes("ISO-8859-1"),"UTF-8");
    String na=new String(request.getParameter("na").getBytes("ISO-8859-1"),"UTF-8");
    String cg=new String(request.getParameter("cg").getBytes("ISO-8859-1"),"UTF-8");
    String id=new String(request.getParameter("id").getBytes("ISO-8859-1"),"UTF-8");
    String call=new String(request.getParameter("call").getBytes("ISO-8859-1"),"UTF-8");
    String updatena = "update reader set name ='"+na+"' where id = '"+oldid+"'";
    String updatecg = "update reader set reader_categoryna ='"+cg+"' where id = '"+oldid+"'";
    String updateid = "update reader set id ='"+id+"' where id = '"+oldid+"'";
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
        rs = sql.executeQuery("select * from reader where id = '" + oldid + "'");
        if(rs.next()){
            if(!cg.equals("读者类别")){
                try {
                    sql.executeUpdate(updatecg);
                } catch (SQLException e) {
                    con.close();
                    out.println("<script language = 'javaScript'> alert('修改失败！请确认读者类别信息是否正确！');window.location.href='/updateReader.html';</script>");
                }
            }
            if(!na.equals("姓名")){
                sql.executeUpdate(updatena);
            }
            if(!id.equals("ID")){
                sql.executeUpdate(updateid);
                if(!call.equals("联系电话")){
                    sql.executeUpdate("update reader set call ='"+call+"' where id =' "+id+"'");
                }
            }
            else if(id.equals("ID")){
                if(!call.equals("联系电话")){
                    sql.executeUpdate("update reader set call ='"+call+"' where id = '"+oldid+"'");
                }
            }
            con.close();
            out.println("<script language = 'javaScript'> alert('修改成功！');window.location.href='/updateReader.html';</script>");
        }
        else{
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请修改当前列表已存在的读者的信息！');window.location.href='/updateReader.html';</script>");
        }
    }catch(Exception e){
        out.print(e);
    }
%>
