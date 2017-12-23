<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<%
    String oldbna=new String(request.getParameter("oldbna").getBytes("ISO-8859-1"),"UTF-8");
    String bna=new String(request.getParameter("bna").getBytes("ISO-8859-1"),"UTF-8");
    String author=new String(request.getParameter("author").getBytes("ISO-8859-1"),"UTF-8");
    String publish=new String(request.getParameter("publish").getBytes("ISO-8859-1"),"UTF-8");
    String pbyear=new String(request.getParameter("pbyear").getBytes("ISO-8859-1"),"UTF-8");
    String state=new String(request.getParameter("state").getBytes("ISO-8859-1"),"UTF-8");
    String book_category=new String(request.getParameter("book_category").getBytes("ISO-8859-1"),"UTF-8");

    String updatebna = "update book set bna ='"+bna+"' where bna = '"+oldbna+"'";
    String updateau = "update book set author ='"+author+"' where bna = '"+oldbna+"'";
    String updatepb = "update book set publish ='"+publish+"' where bna = '"+oldbna+"'";
    String updatepby = "update book set pbyear ='"+pbyear+"' where bna = '"+oldbna+"'";
    String updatest = "update book set state ='"+state+"' where bna = '"+oldbna+"'";
    String updatebcg = "update book set book_category ='"+book_category+"' where bna = '"+oldbna+"'";
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
        if(oldbna.equals("要修改的图书书名")){
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请填入要修改的图书书名！');window.location.href='/updateBook.html';</script>");
        }
        rs = sql.executeQuery("select * from book where bna = '" + oldbna + "'");
        if(rs.next()){
            if(!author.equals("第一作者")){
                sql.executeUpdate(updateau);
            }
            if(!publish.equals("第一出版社")){
                sql.executeUpdate(updatepb);
            }
            if(!pbyear.equals("出版年份")){
                sql.executeUpdate(updatepby);
            }
            if(!state.equals("正常|报废")){
                sql.executeUpdate(updatest);
            }
            if(!book_category.equals("图书类别")){
                sql.executeUpdate(updatebcg);
            }
            if(!bna.equals("书名")){
                sql.executeUpdate(updatebna);
            }
            con.close();
            out.println("<script language = 'javaScript'> alert('修改成功！');window.location.href='/updateBook.html';</script>");
        }
        else{
            con.close();
            out.println("<script language = 'javaScript'> alert('修改失败！请修改当前表已存在的图书的信息！');window.location.href='/updateBook.html';</script>");
        }
    }catch(Exception e){
        out.print(e);
    }
%>
