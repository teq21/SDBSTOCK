<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="css/styles.css" rel="stylesheet" />
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"crossorigin="anonymous"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
$( document ).ready(function() {
	$ ('.canvas').hide();
});
function search(){
	
	var stockName= $("#stockname").val();
	$.ajax({                                   
		url: "http://127.0.0.1:8000/?pstock="+stockName,
		type: "GET",
		dataType: "JSON",
		contentType: "application/json; charset=UTF-8",
		success:function(data){
		
			var date=data.map(function(e){
				return e.date;
			});
			var close=data.map(function(e){
				return e.close;
			});
			var high=data.map(function(e){
				return e.high;
			});
			var open=data.map(function(e){
				return e.open;
			});
			var low=data.map(function(e){
				return e.low;
			});
			var volume=data.map(function(e){
				return e.volume;
			});
			
			var ctx = document.getElementById('canvas').getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'line',
			    data: {
			        labels: date,
			        datasets: [{
			            label: '# 종가',
			            data: close,
			            backgroundColor:'transparent',
			            borderColor: 'rgba(184, 207, 241,1)',
			            borderWidth: 4
			        },
			        {
			            label: '# 시가',
			            fill:false,
			            data: open,
			            backgroundColor:'transparent',
			            borderColor: 'rgba(184, 232, 241,4)',
			            borderWidth: 4
			        },
			        {
			            label: '# 저가',
			            data: low,
			            backgroundColor:'transparent',
			            borderColor: 'rgba(209, 193, 253,1)',
			            borderWidth: 4
			        },
			        {
			            label: '# 고가',
			            data: high,
			            backgroundColor:'transparent',
			            borderColor: 'rgba(253, 193, 193,1)',
			            borderWidth: 4
			        },
			        {
			            label: '# 거래량',
			            data: volume,
			            backgroundColor:'transparent',
			            borderColor: 'rgba(217, 217, 217,1)',
			            borderWidth: 4
			        },
			        ]
			    },
			    options: {
			    	elements:{
			    		line:{
			    			tension:0
			    		}
			    	},
			        scales: {
			        	
			        },
			    }
			});
			$ ('.canvas').show();
			$ ('.search').hide();
			Swal.fire({
				  icon: 'success',
				  title: '주가정보받기 성공!',
				  text: 'slack을 확인해보세요',
				  footer: '<a href=""></a>'
				})
		}
	})
}

</script>


<style type="text/css">

@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body{
  
  font-family: 'Open Sans', sans-serif;
}

.search {
  width: 100%;
  position: relative;
  display: flex;
  height: 400px;
  padding-top: 180px;
}

.searchTerm {
  width: 45%;
  border: 3px solid #fff;
  border-right: none;
  padding: 5px;
  height: 50px;
  border-radius: 5px 0 0 5px;
  outline: none;
  color: #3a444e;
   text-align: center;
   font-size:large;
   margin-left: 258px;
}

.searchTerm:focus{
  color: #3a444e;
  text-align: center;
}

.searchButton {
  width: 70px;
  height: 50px;
  border: 1px solid #fff;
  background:#fff;
  text-align: center;
  color: #282828;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
  font-size: 20px;
}
/*Resize the wrap to see the search bar change!*/

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
				<h1 class="mt-4">주식</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">주가정보받기</li>
				</ol>

				<div class="row">
					<div class="col-xl-24">

						
						<div class="card-body" id="div1" style="height: 1000px">
							
                           <div class="search" style="background-image:url('/img/search.png');background-size : cover;">
                           <input type="text" class="searchTerm"  id="stockname" placeholder="어떤주식을  찾으시나요?">
                              <button type="submit" name="searc" onclick="search()" class="searchButton"><i class="fa fa-search"></i></button>
                           </div><br><br><br>
                           
                           
                           <div class="canvas" style="width: 90%; background-color: #f6f7fa;margin:0 auto;">
                           <canvas id="canvas"></canvas>
                           </div>
                           <br><br><br>
                           <div></div>

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
			</footer>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<scriptsrc="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>