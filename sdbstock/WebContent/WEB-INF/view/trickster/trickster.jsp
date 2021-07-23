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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
$( document ).ready(function() {
	$ ('.text').hide();
	$ ('.text2').hide();
});  
	// More API functions here:
	// https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

	// the link to your model provided by Teachable Machine export panel
	const URL = "/my_model/";

	let model, webcam, labelContainer, maxPredictions;

	// Load the image model and setup the webcam
	async function init() {
		  const modelURL = URL + "model.json";
		   const metadataURL = URL + "metadata.json";

		// load the model and metadata
		// Refer to tmImage.loadFromFiles() in the API to support files from a file picker
		// or files from your local hard drive
		// Note: the pose library adds "tmImage" object to your window (window.tmImage)
		model = await
		tmImage.load(modelURL, metadataURL);
		maxPredictions = model.getTotalClasses();

		labelContainer = document.getElementById("label-container");
		for (let i = 0; i < maxPredictions; i++) { // and class labels
			labelContainer.appendChild(document.createElement("div"));
		}
	}

	

	// run the webcam image through the image model
	async function predict() {
		// predict can take in an image, video or canvas html element
		var image= document.getElementById("face-image")
		const prediction = await model.predict(image,false);
		for (let i = 0; i < maxPredictions; i++) {
			const classPrediction = prediction[i].className + ": "+ prediction[i].probability.toFixed(2);
			console.log(prediction[0].probability.toFixed(2));
			console.log(prediction[1].probability.toFixed(2));
			if(prediction[0].probability.toFixed(2)>0.60){

				$('.text').show();
			}
			if(prediction[1].probability.toFixed(2)>0.80){
				$('.text2').show();
			}
			
		
		}
		
	}
</script>
<script type="text/javascript">

	function readURL(input) {
		if (input.files && input.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('.image-upload-wrap').hide();
				
				$('.file-upload-image').attr('src', e.target.result);
				$('.file-upload-content').show();

				$('.image-title').html(input.files[0].name);
			};

			reader.readAsDataURL(input.files[0]);
			init().then(function(){
				console.log("hello");
				predict();
			});

		} else {
			removeUpload();
		}
	}

	function removeUpload() {
		$('.file-upload-input').replaceWith($('.file-upload-input').clone());
		$('.file-upload-content').hide();
		$('.image-upload-wrap').show();
		$ ('.text').hide();
		$ ('.text2').hide();

	}
	$('.image-upload-wrap').bind('dragover', function() {
		$('.image-upload-wrap').addClass('image-dropping');
	});
	$('.image-upload-wrap').bind('dragleave', function() {
		$('.image-upload-wrap').removeClass('image-dropping');
	});
</script>
<style type="text/css">
body {
	font-family: sans-serif;
	background-color: #eeeeee;
}

.file-upload {
    padding: 12% 3%;
    height:50%;
    margin: 0 auto;
    border-radius: 10px;
    border: solid 1.5px #f6f7fa;
    background-color: #f6f7fa;
}

.file-upload-btn {
	width: 100%;
	margin: 0;
	color: #fff;
	background: #1FB264;
	border: none;
	padding: 10px;
	border-radius: 4px;
	border-bottom: 4px solid #15824B;
	transition: all .2s ease;
	outline: none;
	text-transform: uppercase;
	font-weight: 700;
}

.file-upload-btn:hover {
	background: #1AA059;
	color: #ffffff;
	transition: all .2s ease;
	cursor: pointer;
}

.file-upload-btn:active {
	border: 0;
	transition: all .2s ease;
}

.file-upload-content {
	display: none;
	text-align: center;
}

.file-upload-input {
  position: absolute;
  margin: 0;
  padding: 0;
  width: 70%;
  height: 50%;
  outline: none;
  opacity: 0;
  cursor: pointer;
}

.image-upload-wrap {
    width: 60%;
    height:100%;
    margin: 0 auto;
    position: relative;
    object-fit: contain;
    border-radius: 12px;
    border: dashed 1.5px #35465d;
    background-color: #ffffff;
}

.image-dropping, .image-upload-wrap:hover {
	background-color: #567b9b ;
	border: 4px dashed #ffffff;
}

.image-title-wrap {
	padding: 0 15px 15px 15px;
	color: #222;
}

.drag-text {
	text-align: center;
}

.drag-text h3 {
	font-weight: 100;
	text-transform: uppercase;
	color: grey;
	padding: 60px 0;
}

.file-upload-image {
	max-height: 500px;
	max-width: 500px;
	margin: auto;
	padding: 5px;
}

.remove-image {
	width: 200px;
	margin: 0;
	color: #fff;
	background: #cd4535;
	border: none;
	padding: 10px;
	border-radius: 4px;
	border-bottom: 4px solid #b02818;
	transition: all .2s ease;
	outline: none;
	text-transform: uppercase;
	font-weight: 700;
}

.remove-image:hover {
	background: #c13b2a;
	color: #ffffff;
	transition: all .2s ease;
	cursor: pointer;
}

.remove-image:active {
	border: 0;
	transition: all .2s ease;
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
				<h2 class="mt-4">전문가 판별</h2>
				

				<div class="row">
					<div class="col-xl-24">
						<div class="card mb-4">
						
							<div class="card-body" style="height: 100%; width: 100%">
								
								<div>
								
								<h3 style="text-align: center;color: grey">사진을 업로드 하여 믿을수 있는 사람인지 확인해보세요!</h3></div>
							
								<script class="jsbin"
									src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
								<div class="file-upload" style="height: 80%;">
									
									<div class="image-upload-wrap">
										<input class="file-upload-input" type='file'
											onchange="readURL(this);" accept="image/*" />
										<div class="drag-text" style="color: black">
											<h3>Drag and drop a file or select add Image</h3>
										</div>
									</div>
									<div class="file-upload-content">
										<img class="file-upload-image" id="face-image" src="#" alt="your image" />
									
										<div class="image-title-wrap">
										<div id="label-container"></div>
										<p>
										
									
										<p>
											<button type="button" onclick="removeUpload()"
		                                                          class="remove-image">
												Remove <span class="image-title">Uploaded Image</span>
											</button>
										</div>
										<div class="text" ><h2>자산투자를 믿고 맡길수있는 <span style="color:#265b90;font-family: sans-serif;font-weight: 10px;font-size:70px;">"전문가"</span>입니다</h2> </div>
									<div class="text2" ><h2>자산투자를 믿고 맡길수 없는 <span style="color:#265b90;font-family: sans-serif;font-weight: 10px;font-size:70px;">"비전문가"</span>입니다</h2> </div>
									</div>
								</div>
								<div id="webcam-container"></div>
								







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
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
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