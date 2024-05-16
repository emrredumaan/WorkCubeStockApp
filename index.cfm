<cfinclude template="loginCheck.cfc">
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <!-- Meta Tags -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
        <meta name="description" content="Urun Paneli">
        <meta name="author" content="">

        <!-- Favicon and touch Icons -->
        <!--- <link href="assets/img/favicon.png" rel="shortcut icon" type="image/png">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
        <link href="assets/img/apple-touch-icon-72x72.png" rel="apple-touch-icon" sizes="72x72">
        <link href="assets/img/apple-touch-icon-114x114.png" rel="apple-touch-icon" sizes="114x114">
        <link href="assets/img/apple-touch-icon-144x144.png" rel="apple-touch-icon" sizes="144x144"> --->

        <!-- Page Title -->
        <title>Urun Paneli</title>
        
        <!-- Styles Include -->
        <link rel="stylesheet" href="assets/css/main.css" id="stylesheet">
        
    </head>


    <body class="bg-primary">
        
        <!-- Login Form -->
        <div class="row align-items-center justify-content-center vh-100">
            <div class="col-xxl-4 col-xl-5 col-lg-5 col-md-6">
                <div class="card rounded-2 border-0 p-5 m-0">
                    <div class="card-header border-0 p-0 text-center">
                        <h3>Hoş Geldiniz!</h3>
                        <p class="fs-14 text-dark my-4">Lütfen Giriş Yapınız</p>
                    </div>
                    <div class="card-body p-0">
                        <form class="form-horizontal" method="post">
                            <div class="form-group">
                                <input type="text" class="form-control" name="kullaniciadi" value="" placeholder="E-Posta Adresi" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="sifre" value="" placeholder="Parola" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 text-uppercase text-white rounded-2 lh-34 ff-heading fw-bold shadow">Giriş</button>                            
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!--CK Editor-->
        <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
        <script>
            ClassicEditor
                    .create( document.querySelector( '#editor1' ) )
                    .then( editor => {
                            console.log( editor );
                    } )
                    .catch( error => {
                            console.error( error );
                    } );
        </script>
        

        <!-- Core JS -->
        <script src="assets/js/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery UI Kit -->
        <script src="plugins/jquery_ui/jquery-ui.1.12.1.min.js"></script>
        
        <!-- ApexChart -->
        
        
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

        <!-- Snippets JS -->
        <script src="assets/js/snippets.js"></script>

        <!-- Theme Custom JS -->
        <script src="assets/js/theme.js"></script>
        
    </body>
</html>

