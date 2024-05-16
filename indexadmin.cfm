
<!--- <cfapplication name="myApp" sessionmanagement="true">
<cfif not structKeyExists(session, "isLoggedIn") or not session.isLoggedIn>
    <!--- Kullanıcı girişi yapılmamış, giriş sayfasına yönlendir --->  
    <cflocation url="login.cfm" addtoken="false">
<cfelse>  --->
<!DOCTYPE html>
<html lang="tr">
    <head>
        <!-- Meta Tags -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
        <meta name="description" content="Urun Paneli">
        <meta name="author" content="">

        <!--- <!-- Favicon and touch Icons -->
        <link href="assets/img/favicon.png" rel="shortcut icon" type="image/png">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
        <link href="assets/img/apple-touch-icon-72x72.png" rel="apple-touch-icon" sizes="72x72">
        <link href="assets/img/apple-touch-icon-114x114.png" rel="apple-touch-icon" sizes="114x114">
        <link href="assets/img/apple-touch-icon-144x144.png" rel="apple-touch-icon" sizes="144x144"> --->

        <!-- Page Title -->
        <title>Urun Paneli</title>
        
        <!-- Styles Include -->
        <link rel="stylesheet" href="assets/css/main.css" id="stylesheet">
        
    </head>
    <body class="bg-light">
        <!-- Default Nav -->
        <header class="header kleon-default-nav">				
            <div class="d-none d-xl-block">
                <div class="header-inner d-flex align-items-center justify-content-around justify-content-xl-between flex-wrap flex-xl-nowrap gap-3 gap-xl-5">

                    <div class="header-right-part d-flex align-items-center flex-shrink-0">
                        <ul class="nav-elements d-flex align-items-center list-unstyled m-0 p-0">
                            <div class="card-footer p-3">
                                <a href="index.cfm" class="btn btn-outline-gray bg-transparent w-100 py-1 rounded-1 text-dark fs-14 fw-medium"><i class="bi bi-box-arrow-right"></i> Güvenli Çıkış</a>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="small-header d-flex align-items-center justify-content-between d-xl-none">
                <div class="logo">
                    <a href="indexadmin.html" class="d-flex align-items-center gap-3 flex-shrink-0">
                        <img src="assets/img/logo-icon.svg" alt="logo">
                        <div class="position-relative flex-shrink-0">
                            <img src="assets/img/logo-text.svg" alt="" class="logo-text">
                            <img src="assets/img/logo-text-white.svg" alt="" class="logo-text-white">
                        </div>
                    </a>
                </div>
                <div>
                    <button type="button" class="kleon-header-expand-toggle"><span class="fs-24"><i class="bi bi-three-dots-vertical"></i></button>
                    <button type="button" class="kleon-mobile-menu-opener"><span class="close"><i class="bi bi-arrow-left"></i></span> <span class="open"><i class="bi bi-list"></i></span></button>
                </div>
            </div>
        </header>
        <!-- Vertical Nav -->
        <div class="kleon-vertical-nav">
            <!-- Logo  -->
            <div class="logo d-flex align-items-center justify-content-between">
                <a href="indexadmin.cfm?sayfa=urunler" class="d-flex align-items-center gap-3 flex-shrink-0">
                    <h3>Urun Paneli</h3>
                </a>
            </div>

            <!--- sidebar start --->
            <div class="kleon-navmenu">
                <h6 class="hidden-header text-gray text-uppercase ls-1 ms-4 mb-4">Menuler</h6>
                <ul class="main-menu">               
                    <li class="menu-item">
                        <a href="indexadmin.cfm?sayfa=urun-islem">
                            <span class="nav-icon flex-shrink-0">
                                <i class="bi bi-calendar-day fs-18"></i>
                            </span> 
                            <span class="nav-text">Ürün İşlem</span>
                        </a>
                    </li>  
                </ul>
            </div>
            <!--- sidebar finish --->
        </div>

        <!-- Main Wrapper-->
        <main class="main-wrapper">
            <div class="container-fluid">
                <!--- content start --->
                <cfswitch expression="#url.sayfa#">
                    <cfcase value="urun-islem">
                        <cfinclude template="sayfalar/urun-islem.cfm">
                    </cfcase>
                    <cfdefaultcase>
                        <cfinclude template="sayfalar/urun-islem.cfm">
                    </cfdefaultcase>
                </cfswitch>
                
                <!--- content finish --->
            </div>
        </main>

        <!-- Core JS -->
        <script src="assets/js/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery UI Kit -->
        <script src="plugins/jquery_ui/jquery-ui.1.12.1.min.js"></script>

        <!-- ApexChart -->
        <script src="plugins/apexchart/apexcharts.min.js"></script>
        <script src="plugins/apexchart/apexchart-inits/apexcharts-analytics-2.js"></script>

        <!-- Peity  -->
        <script src="plugins/peity/jquery.peity.min.js"></script>
        <script src="plugins/peity/piety-init.js"></script>

        <!-- Select 2 -->
        <script src="plugins/select2/js/select2.min.js"></script>

        <!-- Datatables -->
        <script src="plugins/datatables/js/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/js/datatables.init.js"></script>

        <!-- Date Picker -->
        <script src="plugins/flatpickr/flatpickr.min.js"></script>

        <!-- Dropzone -->
        <script src="plugins/dropzone/dropzone.min.js"></script>
        <script src="plugins/dropzone/dropzone_custom.js"></script>

        <!-- TinyMCE -->
        <script src="plugins/tinymce/tinymce.min.js"></script>
        <script src="plugins/prism/prism.js"></script>
        <script src="plugins/jquery-repeater/jquery.repeater.js"></script>

        <!-- Sweet Alert -->
        <script src="plugins/sweetalert/sweetalert2.min.js"></script>
        <script src="plugins/sweetalert/sweetalert2-init.js"></script>
        <script src="plugins/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="plugins/nicescroll/jquery.nicescroll.min.js"></script>

        <!-- Snippets JS -->
        <script src="assets/js/snippets.js"></script>

        <!-- Theme Custom JS -->
        <script src="assets/js/theme.js"></script>

    </body>

</html>
<!--- </cfif> --->