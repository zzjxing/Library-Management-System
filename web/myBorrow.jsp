<%@ page language="java" import="java.sql.*" contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>我的借阅</title>


    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- Custom Theme files -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />



    <script type="text/javascript">
        $(function() {
            /* For zebra striping */
            $("table tr:nth-child(odd)").addClass("odd-row");
            /* For cell text alignment */
            $("table td:first-child, table th:first-child").addClass("first");
            /* For removing the last border */
            $("table td:last-child, table th:last-child").addClass("last");
        });
    </script>
    <style type="text/css">

        html, body, div, span, object, iframe,
        h1, h2, h3, h4, h5, h6, p, blockquote, pre,
        abbr, address, cite, code,
        del, dfn, em, img, ins, kbd, q, samp,
        small, strong, sub, sup, var,
        b, i,
        dl, dt, dd, ol, ul, li,
        fieldset, form, label, legend,
        table, caption, tbody, tfoot, thead, tr, th, td {
            margin:0;
            padding:0;
            border:0;
            outline:0;
            font-size:100%;
            vertical-align:baseline;
            background:transparent;
        }

        body {
            margin:0;
            padding:0;
            font:12px/15px "Helvetica Neue",Arial, Helvetica, sans-serif;
            color: #555;
            /*background:#f5f5f5 url(bg.jpg);*/
        }

        a {color:#666;}

        #content {width:65%; max-width:690px; margin:6% auto 0;}

        /*
        Pretty Table Styling
        CSS Tricks also has a nice writeup: http://css-tricks.com/feature-table-design/
        */

        table {
            overflow:hidden;
            border:1px solid #d3d3d3;
            background:#fefefe;
            width:70%;
            margin:5% auto 0;
            -moz-border-radius:5px; /* FF1+ */
            -webkit-border-radius:5px; /* Saf3-4 */
            border-radius:5px;
            -moz-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
            -webkit-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
        }

        th, td {padding:18px 28px 18px; text-align:center; }

        th {padding-top:22px; text-shadow: 1px 1px 1px #fff; background:#e8eaeb;}

        td {border-top:1px solid #e0e0e0; border-right:1px solid #e0e0e0;}

        tr.odd-row td {background:#f6f6f6;}

        td.first, th.first {text-align:left}

        td.last {border-right:none;}


        tr:first-child th.first {
            -moz-border-radius-topleft:5px;
            -webkit-border-top-left-radius:5px; /* Saf3-4 */
        }

        tr:first-child th.last {
            -moz-border-radius-topright:5px;
            -webkit-border-top-right-radius:5px; /* Saf3-4 */
        }

        tr:last-child td.first {
            -moz-border-radius-bottomleft:5px;
            -webkit-border-bottom-left-radius:5px; /* Saf3-4 */
        }

        tr:last-child td.last {
            -moz-border-radius-bottomright:5px;
            -webkit-border-bottom-right-radius:5px; /* Saf3-4 */
        }

    </style>
</head>
<body>



<div class="content">


    <table cellspacing="0">
        <tr><th><a href="/reader_index.html" > <i style="font-size:3em"> Back </i>  </a></th></tr>
        <td style="font-size:2em">我的借阅</td>
    </table>
    <table cellspacing="0">

        <tr><th>书名</th><th>借阅日期</th><th>归还日期</th></tr>
        <%
            String id=new String(request.getParameter("id").getBytes("ISO-8859-1"),"UTF-8");
            try{  Class.forName("com.mysql.jdbc.Driver");
            }
            catch(Exception e){}
            Connection con;
            Statement sql;
            ResultSet rs;
            try{
                String uri="jdbc:mysql://127.0.0.1/图书馆管理系统db?"+"user=root&password=&characterEncoding=UTF-8";
                con=DriverManager.getConnection(uri);
                sql=con.createStatement();
                rs=sql.executeQuery("select * from borrow where id='"+id+"'");

                while(rs.next()){
        %>
        <tr>
            <td>
                <%
                    out.print(rs.getString(2));
                %>
            </td>
            <td>
                <%
                    out.print(rs.getString(3));
                %>
            </td>
            <td>
                <%
                    String b=rs.getString(4);
                    if(b==null){
                        out.print("尚未归还");
                }
                   else
                       out.print(rs.getString(4));
                %>
            </td>
        </tr>
        <%
                }
                con.close();


            }
            catch(SQLException e){
                out.print(e);
            }
        %>
    </table>

</div>

</div>







</body>
</html>