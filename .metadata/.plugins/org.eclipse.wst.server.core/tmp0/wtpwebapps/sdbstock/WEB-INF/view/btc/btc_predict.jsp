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
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
$( document ).ready(function() {
	$ ('.canvas').hide();
	$ ('.finaltext').hide();
});


//비트코인그래프그리는로직
function btcsearch(){
	$.ajax({                                   
		url: "http://127.0.0.1:9001/",
		type: "GET",
		dataType: "JSON",
		contentType: "application/json; charset=UTF-8",
		success:function(data){
		    
			var ds=data.map(function(e){
				return e.ds;
			});
			
			var yhat=data.map(function(e){
				return e.yhat;
			});
		
			var Close=data.map(function(e){
				return e.Close;
			});
//			텍스트붙니느곳
			var predictprice=yhat[yhat.length -3]; //오늘자데이터
			document.getElementById("text").innerHTML = Math.floor(predictprice)+"원";
			var predictprice=yhat[yhat.length -2]; //오늘자데이터
			document.getElementById("text2").innerHTML = Math.floor(predictprice)+"원";
			var predictprice=yhat[yhat.length -1]; //오늘자데이터
			document.getElementById("text3").innerHTML = Math.floor(predictprice)+"원";
			
			var ctx = document.getElementById('canvas').getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'line',
			    data: {
			        labels: ds,
			        datasets: [{
			            label: '#지난 종가',
			            data: Close,
			            backgroundColor: 'rgba(208, 221, 243,0.4)',
			            borderColor: 'rgba(208, 221, 243)',
			            borderWidth: 2
			        },{
			            label: '# 예측가',
			            data: yhat,
			            backgroundColor: 'rgba(108, 128, 172,0.6)',
			            borderColor:'rgba(108, 128, 172)' ,
			            borderWidth: 3
			        }
			        ]
			    },
			    options: {
			        scales: {
			        	
			            y: {
			                beginAtZero: true
			            }
			        }
			    }
			});
			$ ('.canvas').show();
			$ ('.finaltext').show();
			Swal.fire({
				  icon: 'success',
				  title: '예측가 받기 성공!',
				  text: 'slack을 확인해보세요',
				  footer: '<a href=""></a>'
				})
		}
		
	})
}

//이더리움그래프그리는로직
function ethsearch(){
	$.ajax({                                   
		url: "http://127.0.0.1:9002/",
		type: "GET",
		dataType: "JSON",
		contentType: "application/json; charset=UTF-8",
		success:function(data){
		    
			var ds=data.map(function(e){
				return e.ds;
			});
			
			var yhat=data.map(function(e){
				return e.yhat;
			});
		
			var Close=data.map(function(e){
				return e.Close;
			});
			//텍스트붙니느곳
			var predictprice=yhat[yhat.length -3]; //오늘자데이터
			document.getElementById("text").innerHTML = Math.floor(predictprice)+"원";
			var predictprice=yhat[yhat.length -2]; //오늘자데이터
			document.getElementById("text2").innerHTML = Math.floor(predictprice)+"원";
			var predictprice=yhat[yhat.length -1]; //오늘자데이터
			document.getElementById("text3").innerHTML = Math.floor(predictprice)+"원";
		
			
			var ctx = document.getElementById('canvas').getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'line',
			    data: {
			        labels: ds,
			        datasets: [{
			            label: '#지난 종가',
			            data: Close,
			            backgroundColor: 'rgba(208, 221, 243,0.4)',
			            borderColor: 'rgba(208, 221, 243)',
			            borderWidth: 2
			        },{
			            label: '# 예측가',
			            data: yhat,
			            backgroundColor: 'rgba(108, 128, 172,0.6)',
			            borderColor:'rgba(108, 128, 172)' ,
			            borderWidth: 3
			        }
			        ]
			    },
			    options: {
			        scales: {
			        	
			            y: {
			                beginAtZero: true
			            }
			        }
			    }
			});
			$ ('.canvas').show();
			$ ('.finaltext').show();
			Swal.fire({
				  icon: 'success',
				  title: '예측가 받기 성공!',
				  text: 'slack을 확인해보세요',
				  footer: '<a href=""></a>'
				})
		}
		
	})
}
</script>


<style type="text/css">
wrapper {
    margin: 0px auto;
    
    width: 100%;
}

.col {
  display:inline-block;
  width: 22%;
  margin: 1%;
  text-align:center;
  border: 1px solid #eee;
  padding: 20px;
}

#h1 {
  font-size: 40px;
  color:#fff;
  display:block;
  border-radius: 50%;
  width: 90px;
  height:90px;
  padding: 20px;
  margin:0 auto;
}

h4 {
  margin:10px 0;
}

.bitcoin h1 {
  background: #f7931a;
}

.litecoin h1 {
  background: #bebebe;
}

.ethereum h1 {
  background: #454a75;
}

.ripple h1 {
  background: #102b3e;
  font-size:26px;
  text-align:center;
  line-height: 50px;
}

#price, #bprice, #eprice, #rprice{
  font-size: 20px;
}

.chan {
  margin: 20px 0 0 0;
  padding: 10px;
  background: #eee;
  font-size: 12px;
}

#chan {
  display: inline-block;
}
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body{
  
  font-family: 'Open Sans', sans-serif;
}

.search {
  width: 100%;
  position: relative;
  display: flex;
}

.searchTerm {
  width: 50%;
  border: 3px solid #3a444e;
  border-right: none;
  padding: 5px;
  height: 70px;
  border-radius: 5px 0 0 5px;
  outline: none;
  color: #3a444e;
   text-align: center;
   margin-left: 270px;
   font-size:x-large;
}

.searchTerm:focus{
  color: #3a444e;
  text-align: center;
}

.searchButton {
  width: 40px;
  height: 70px;
  border: 1px solid #3a444e;
  background: #3a444e;
  text-align: center;
  color: #fff;
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
				<h1 class="mt-4">BTC/ETH</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">가상화폐예측</li>
				</ol>

				<div class="row">
					<div class="col-xl-24">

						<div class="card-header">
							<i class="fas fa-chart-area me-1"></i> 지난 6개월간의 데이터를 분석하여 3일간의  가상화폐를 예측해드립니다.
						</div>
						
						<div class="card-body" id="div1" style="height: 1000px"><br>
                           
                         <div class="wrapper">
                             <div class="col bitcoin" onclick="btcsearch();" style="margin-left:50px;width:40%;height:80%; transition: 0.4s ease-out;background-color: white;border-radius: 10px;cursor: pointer;" >
                                    <h1 id="h1">Ƀ</h1>
                           <h4>Bitcoin</h4>  예측하기<span id="bprice"></span><div class="chan">3일치  예측가<span id="bchange"></span></div>
                             </div>

<div class="col ethereum" onclick="ethsearch();" style="margin-left:50px;width:40%;height:80%;transition: 0.4s ease-out;background-color: white;border-radius: 10px;cursor: pointer;">
  <h1 id="h1">Ξ</h1>
  <h4>Ethereum</h4>
  예측하기<span id="eprice"></span>
  <div class="chan">3일치  예측가<span id="echange"></span></div>
</div>
                           <div class="canvas" style="width: 100%; background-color: #f6f7fa;margin:0 auto;">
                           <canvas id="canvas"></canvas>
                           </div>
                           
                           
                             <div class="finaltext" style="background-color:#f6f7fa"><span style="font-size: 20px;margin-left: 100px;"><i class="fas fa-pen"></i> 1일뒤 예측가:</span><span id="text" style="background-color:#feffab;font-size: 30px;margin-left:20px;font-weight:bold; "></span>
                               <span style="font-size: 20px;margin-left: 10px;"><i class="fas fa-pen-alt"></i> 2일뒤 예측가:</span>  <span id="text2" style="background-color:#feffab;font-size: 30px;margin-left:20px;font-weight:bold;"></span>
                               <span style="font-size: 20px;margin-left: 10px;"><i class="fas fa-pen-fancy"></i> 3일뒤 예측가:</span>  <span id="text3" style="background-color:#feffab;font-size: 30px;margin-left:20px;font-weight:bold;"></span></div>

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