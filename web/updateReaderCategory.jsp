<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
    <%
        String oldcana=new String(request.getParameter("oldcana").getBytes("ISO-8859-1"),"UTF-8");
        String newcana=new String(request.getParameter("newcana").getBytes("ISO-8859-1"),"UTF-8");
        String days=new String(request.getParameter("days").getBytes("ISO-8859-1"),"UTF-8");
        String nums=new String(request.getParameter("nums").getBytes("ISO-8859-1"),"UTF-8");
        String condition = "update reader_category set name ='"+newcana+"' where name = "+"'"+oldcana+"'";
        String condition2 = "update reader_category set days ='"+days+"' where name = "+"'"+oldcana+"'";
        String condition3 = "update reader_category set nums ='"+nums+"' where name = "+"'"+oldcana+"'";
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
            rs = sql.executeQuery("select * from reader_category where name = '" + oldcana + "'");
            if(rs.next()){
                if(!newcana.equals("新类别名称"))
                    sql.executeUpdate(condition);
                if(!days.equals("最大借阅天数"))
                    sql.executeUpdate(condition2);
                if(!nums.equals("最大借阅本数"))
                    sql.executeUpdate(condition3);
                con.close();
                out.println("<script language = 'javaScript'> alert('修改成功！');window.location.href='/updateReaderCategory.html';</script>");
            }
            else{
                con.close();
                out.println("<script language = 'javaScript'> alert('修改失败！请修改当前列表已存在的类别！');window.location.href='/updateReaderCategory.html';</script>");
            }
        }catch(Exception e){
            out.print(e);
        }
    %>
