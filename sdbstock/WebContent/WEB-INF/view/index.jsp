<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
        <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">
        $( document ).ready(function() {
        	  $( ".tradingview-widget-container iframe" ).clone().appendTo( ".tradingview-widget-container" );
        	});
        </script>
<style type="text/css">
       .content {
  padding: 10px 20px;
}
.content p {
  font-family: sans-serif;
}

/******/

.ticker-container {
  width: 100%;
  overflow: hidden;
}

.ticker-canvas {
  width: calc((200px * 15) + 2px);
  /* 
  200px = minimum width of ticker item before widget script starts removing ticker codes
  15 = number of ticker codes
  2px = accounts for 1px external border
  */
  -webkit-animation-iteration-count: infinite;
  animation-iteration-count: infinite;
  -webkit-animation-timing-function: linear;
  animation-timing-function: linear;
  -webkit-animation-name: ticker-canvas;
  animation-name: ticker-canvas;
  -webkit-animation-duration: 20s;
  animation-duration: 20s;
}
.ticker-canvas:hover {
  animation-play-state: paused
}

@-webkit-keyframes ticker-canvas {
  0% {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
    visibility: visible;
  }
  100% {
    -webkit-transform: translate3d(-100%, 0, 0);
    transform: translate3d(-100%, 0, 0);
  }
}

@keyframes ticker-canvas {
  0% {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
    visibility: visible;
  }
  100% {
    -webkit-transform: translate3d(-100%, 0, 0);
    transform: translate3d(-100%, 0, 0);
  }
}
.tradingview-widget-container {
  position: relative;
}
.tradingview-widget-container iframe {
    position: absolute;
    top: 0;
}
.tradingview-widget-container iframe:nth-of-type(2) {
  left: 100%;
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
                <!-- TradingView Widget BEGIN -->
<div class="ticker-container">
<div class="ticker-canvas">
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-tickers.js">
  {
  "symbols": [
    {
      "title": "S&P 500",
      "proName": "INDEX:SPX"
    },
    {
      "title": "Nasdaq 100",
      "proName": "INDEX:IUXX"
    },
    {
      "title": "EUR/USD",
      "proName": "FX_IDC:EURUSD"
    },
    {
      "title": "BTC/USD",
      "proName": "BITFINEX:BTCUSD"
    },
    {
      "title": "ETH/USD",
      "proName": "BITFINEX:ETHUSD"
    },
    {
      "description": "Apple",
      "proName": "NASDAQ:AAPL"
    },
    {
      "description": "Berkshire",
      "proName": "NYSE:BRK.A"
    },
    {
      "description": "Microsoft",
      "proName": "NASDAQ:MSFT"
    },
    {
      "description": "Google",
      "proName": "NASDAQ:GOOG"
    },
    {
      "description": "Tesla",
      "proName": "NASDAQ:TSLA"
    },
    {
      "description": "Amazon",
      "proName": "NASDAQ:AMZN"
    },
    {
      "description": "AUD/USD",
      "proName": "OANDA:AUDUSD"
    },
    {
      "description": "Sony",
      "proName": "NYSE:SNE"
    },
    {
      "description": "BHP",
      "proName": "BHP"
    },
    {
      "description": "Telstra",
      "proName": "TLS"
    }
  ],
  "locale": "en"
}
  </script>
</div>
</div>
</div>
<!-- TradingView Widget END -->
<div class="content">
                    <div class="container-fluid px-4">
                       
                        
                        <div class="row">
                            <div class="col-xl-24">
                                <div class="card mb-4">
                                   
                                    <div class="card-body" style="height: 500px;width: 100%;background-image:url('/img/index.png');background-size : cover;"></div>
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
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>