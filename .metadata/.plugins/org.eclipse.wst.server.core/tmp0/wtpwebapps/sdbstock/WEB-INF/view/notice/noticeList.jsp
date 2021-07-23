<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.NoticeDTO"%>
<%@page import="poly.util.Pagination_other"%>
<%@page import="static poly.util.CmmUtil.nvl"%>
<%@page import="java.util.List"%>
<%@ include file="../session.jsp"%>
<%
	List<NoticeDTO> rList = (List<NoticeDTO>)request.getAttribute("rList");
	String pageName = "noticeList";
	Pagination_other pg = (Pagination_other) request.getAttribute("pg");
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Dashboard - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>


<style type="text/css">
body {
	font-family: sans-serif;
	background-color: #eeeeee;
}
table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 15px;
        }
</style>

</head>
<body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="/index.do">SDB STOCK</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="/user/LoginForm.do">로그인</a></li>
                        <li><a class="dropdown-item" href="/user/UserRegForm.do">회원가입</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="/user/Logout.do">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="/index.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                home
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                                                                                              주식
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/stockindex.do">주식정보 받기</a>
                                    <a class="nav-link" href="/stockpredict.do">주가예측</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                               BTC/ETH
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/ethchart.do">가상화폐정보 받기</a>
                                    <a class="nav-link" href="/btcpredict.do">가상화폐예측</a>
                                </nav>
                            </div>
                            
                            <div class="sb-sidenav-menu-heading">ETC</div>
                            <a class="nav-link" href="/trickster.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                               전문가판별
                            </a>
                            <a class="nav-link" href="/notice/noticeList.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                커뮤니티
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
		<div id="layoutSidenav_content">
			<main>
                 <div class="container-fluid px-4">
                        <h1 class="mt-4">커뮤니티</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">게시물</li>
                            
                        </ol>
                       
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                주가에대한 자신의생각을 나눠보세요
                            </div>
                            <div class="card-body">
                                  <div class="container" data-ng-app="myApp" data-ng-controller="myCtrl">
   
    <table>
      <tr>
        <th>순번</th>
        <th>제목</th>
        <th>등록자</th>
        <th>등록일</th>
      </tr>
      
      <%
         for (NoticeDTO sDTO : rList) {
      %>
      <div class="table-row item" role="button" onclick="location.href='/notice/noticeDetail.do?no=<%=sDTO.getPost_no()%>'">
      <tr data-ng-repeat="customer in people | filter: table">
        <td role="button" onclick="location.href='/notice/noticeDetail.do?no=<%=sDTO.getPost_no()%>'"><%=sDTO.getPost_no()%></td>
        <td><%=sDTO.getPost_title()%></td>
        <td><%=sDTO.getReg_id()%></td>
         <td><%=sDTO.getReg_dt()%></td>
      </tr>
      
                           <%} %>
   
    </table><br>
     <div style="margin: 0 auto;"><i class="fas fa-check-square"></i><input type="button" onclick="location.href='/notice/noticeForm.do'" value="등록" style="color:grey ">
     </div>
                            </div>
                        </div>
                    </div>
                     </div>
			</main>
			<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; Your Website 2021</div>
					<div>
						<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
							&amp; Conditions</a>
					</div>
					</div>
				</div>
			</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>