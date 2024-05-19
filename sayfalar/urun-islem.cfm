<cfquery NAME="urun" datasource="cfemredumanDSN">   
    SELECT * FROM urun ORDER BY id DESC
</cfquery>
<cfparam name="url.islem" default="">
<cfif url.islem eq "">
<div class="card border-0 p-5 my-5">
    <div class="card-header pb-5 bg-transparent border-0 d-flex align-items-center justify-content-between gap-3">
        <h4 class="mb-0">Ürün Listesi</h4>
        <a href="indexadmin.cfm?sayfa=urun-islem&islem=ekle">
            <button type="button" id="btn" class="btn btn-danger btn-lg rounded-pill">
            <i class="fa-solid fa-plus"></i></button>
        </a>
    <style>
        #btn{
            font-size: 13px;
            padding: 0px 20px;
            line-height: 38px;
            height: 40px;
            text-align: center; 
        }
    </style>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-borderless">
                <thead>
                    <tr>
                        <th class="text-center" width="">Resim</th>
                        <th class="text-center" width="">Ürün Kodu</th>
                        <th class="text-center" width="">Ürün Adı</th>
                        <th class="text-center" width="">Ürün Fiyat</th>
                        <th class="text-center" width="">Teknosa</th>
                        <th class="text-center" width="">Vatan Bilgisayar</th>
                        <th class="text-center" width="">Hepsiburada</th>
                        <th class="text-center" width="">N11</th>
                        <th class="text-center" width="">Trendyol</th>
                        <th class="text-center" width="15%">İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="urun">
                        <tr>
                            <td class="text-center" style="vertical-align: middle;">
                                <div class="employee d-flex gap-2 flex-wrap">
                                    <div class="profilepicture flex-shrink-0 d-none d-xl-block">
                                        <img src="<cfoutput>#urun.resim#</cfoutput>"alt="" width="50">
                                    </div>
                                </div>
                            </td>
                            <cfquery NAME="urun_fiyatlar" datasource="cfemredumanDSN">
                             
                                SELECT u.id, u.urun_adi, u.resim, u.urun_fiyat, u.urun_kodu, vatan.vatan_urun_ismi, vatan.vatan_fiyat, teknosa.teknosa_urun_ismi, teknosa.teknosa_fiyat, hepsiburada.hepsiburada_urun_ismi, hepsiburada.hepsiburada_fiyat, n11.n11_urun_ismi, n11.n11_fiyat, trendyol.trendyol_urun_ismi, trendyol.trendyol_fiyat
                                FROM (
                                    SELECT urun_ismi as vatan_urun_ismi, firma, seri_model_numarasi, MIN(fiyat) as vatan_fiyat
                                    FROM urun_fiyatlari 
                                    WHERE firma = 'Vatan' AND seri_model_numarasi = '<cfoutput>#urun.urun_kodu#</cfoutput>'
                                    GROUP BY urun_ismi, firma, seri_model_numarasi
                                ) vatan
                                LEFT JOIN (
                                    SELECT  urun_ismi as teknosa_urun_ismi, MIN(fiyat) as teknosa_fiyat, seri_model_numarasi
                                    FROM urun_fiyatlari 
                                    WHERE firma = 'Teknosa' AND seri_model_numarasi = '<cfoutput>#urun.urun_kodu#</cfoutput>'
                                    GROUP BY urun_ismi, seri_model_numarasi
                                ) teknosa ON vatan.seri_model_numarasi = teknosa.seri_model_numarasi
                                LEFT JOIN (
                                    SELECT urun_ismi as trendyol_urun_ismi, MIN(fiyat) as trendyol_fiyat, seri_model_numarasi
                                    FROM urun_fiyatlari 
                                    WHERE firma = 'Trendyol' AND seri_model_numarasi = '<cfoutput>#urun.urun_kodu#</cfoutput>'
                                    GROUP BY urun_ismi, seri_model_numarasi
                                ) trendyol ON vatan.seri_model_numarasi = trendyol.seri_model_numarasi
                                LEFT JOIN (
                                    SELECT urun_ismi as n11_urun_ismi, MIN(fiyat) as n11_fiyat, seri_model_numarasi
                                    FROM urun_fiyatlari 
                                    WHERE firma = 'N11' AND seri_model_numarasi = '<cfoutput>#urun.urun_kodu#</cfoutput>'
                                    GROUP BY urun_ismi, seri_model_numarasi
                                ) n11 ON vatan.seri_model_numarasi = n11.seri_model_numarasi
                                LEFT JOIN (
                                    SELECT  urun_ismi as hepsiburada_urun_ismi, MIN(fiyat) as hepsiburada_fiyat, seri_model_numarasi
                                    FROM urun_fiyatlari 
                                    WHERE firma = 'Hepsiburada' AND seri_model_numarasi = '<cfoutput>#urun.urun_kodu#</cfoutput>'
                                    GROUP BY urun_ismi, seri_model_numarasi
                                ) hepsiburada ON vatan.seri_model_numarasi = hepsiburada.seri_model_numarasi
                                INNER JOIN urun u ON vatan.seri_model_numarasi = u.urun_kodu 
                                ORDER BY vatan.vatan_fiyat ASC;
                            </cfquery>
                            <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun.urun_kodu#</cfoutput></td>
                            <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun.urun_adi#</cfoutput></td>
                            <td class="text-center" style="vertical-align: middle;"> <span class="badge bg-success fw-bold"><cfoutput>#urun.urun_fiyat#</cfoutput> TL</span></td>
                            <cfif urun_fiyatlar.teknosa_fiyat neq "">
                                <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun_fiyatlar.teknosa_urun_ismi#</cfoutput> <br> <span class="badge bg-warning fw-bold"><cfoutput>#urun_fiyatlar.teknosa_fiyat#</cfoutput></span></td>
                                <cfelse>
                                <td class="text-center text-danger" style="vertical-align: middle;"><cfoutput>Fiyat Bulunamadı</cfoutput></td>
                            </cfif>
                            <cfif urun_fiyatlar.vatan_fiyat neq "">
                                <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun_fiyatlar.vatan_urun_ismi#</cfoutput> <br> <span class="badge bg-warning fw-bold"><cfoutput>#urun_fiyatlar.vatan_fiyat#</cfoutput></span></td>
                                <cfelse>
                                <td class="text-center text-danger" style="vertical-align: middle;"><cfoutput>Fiyat Bulunamadı</cfoutput></td>
                            </cfif>
                            <cfif urun_fiyatlar.hepsiburada_fiyat neq "">
                                <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun_fiyatlar.hepsiburada_urun_ismi#</cfoutput> <br> <span class="badge bg-warning fw-bold"><cfoutput>#urun_fiyatlar.hepsiburada_fiyat#</cfoutput></span></td>
                                <cfelse>
                                <td class="text-center text-danger" style="vertical-align: middle;"><cfoutput>Fiyat Bulunamadı</cfoutput></td>
                            </cfif>
                            <cfif urun_fiyatlar.n11_fiyat neq "">
                                <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun_fiyatlar.n11_urun_ismi#</cfoutput> <br> <span class="badge bg-warning fw-bold"><cfoutput>#urun_fiyatlar.n11_fiyat#</cfoutput></span></td>
                                <cfelse>
                                <td class="text-center text-danger" style="vertical-align: middle;"><cfoutput>Fiyat Bulunamadı</cfoutput></td>
                            </cfif>
                            <cfif urun_fiyatlar.trendyol_fiyat neq "">
                                <td class="text-center" style="vertical-align: middle;"><cfoutput>#urun_fiyatlar.trendyol_urun_ismi#</cfoutput> <br> <span class="badge bg-warning fw-bold"><cfoutput>#urun_fiyatlar.trendyol_fiyat#</cfoutput></span></td>
                                <cfelse>
                                <td class="text-center text-danger" style="vertical-align: middle;"><cfoutput>Fiyat Bulunamadı</cfoutput></td>
                            </cfif>
                            <td class="text-center" style="vertical-align: middle;" class="tooltip-demo text-center">
                                <a href="?sayfa=urun-islem&islem=duzenle&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-warning" id="btn" data-toggle="tooltip" data-placement="top" title="Düzenle"><i class="fa fa-edit"></i></a>
                                <a href="?sayfa=urun-islem&islem=sil&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-danger" id="btn" onclick="return confirm('Bilgileri silmek istediğinize emin misiniz?');" data-toggle="tooltip" data-placement="top" title="Sil"><i class="fa fa-times"></i></a>
                                <a href="?sayfa=urun-islem&islem=arama&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-secondary" id="btn" data-toggle="modal" data-target="#exampleModal" data-placement="top" title="Arama"><i class="fa-brands fa-searchengin"></i></a>
                            </td>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
        </div>
    </div>
</div>
<cfelseif url.islem eq "ekle">
    <div class="card border-0 p-5 my-5">
        <div class="card-header pb-5 bg-transparent border-0 d-flex align-items-center justify-content-between gap-3">
            <h4 class="mb-0">Ürün Ekle</h4>
        </div>
        <div class="card-body p-0 my-2">
            <div class="table-responsive">
                <div class="card border-0">
                        <div class="card-body pt-3">
                            <form class="" method="POST" action="indexadmin.cfm?sayfa=urun-islem&islem=eklendi" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="form-label">İçerik Görseli</label>
                                            <input type="file" class="form-control" name="resim" required="">
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Adı</label>
                                            <input type="text" class="form-control" name="urun_adi" required="">
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Kodu</label>
                                            <input type="text" class="form-control" name="urun_kodu" required="">
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Fiyatı</label>
                                            <input type="text" class="form-control" name="urun_fiyat" required="">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Ekle</button>
                                </div>
                            </form>
                        </div>
                    </div>
            </div>
        </div>
    </div>
<cfelseif url.islem eq "eklendi">
    <cfquery NAME="urun" datasource="cfemredumanDSN">
        SELECT * FROM urun
    </cfquery>
    <cfparam name="form.urun_adi" default="">
    <cfparam name="form.urun_kodu" default="">
    <cfparam name="form.urun_fiyat" default="">

    <cfset uploadedImagePath = "">

    <!-- Eğer resim yüklendi ise -->
    <cfif structKeyExists(form, "resim") and form.resim neq "">
        <!-- Resim yükleme işlemini gerçekleştir -->
        <cffile action="upload" filefield="resim" destination="#expandPath('./yukleme/urun/')#" nameconflict="makeunique">
        <!-- Yüklü resmin yolu -->
        <cfset uploadedImagePath = "yukleme/urun/#cffile.serverFile#">
    </cfif>

    <cfquery datasource="cfemredumanDSN" name="insertQuery">
        INSERT INTO urun (urun_adi, urun_kodu, urun_fiyat, resim)
        VALUES (
            <cfqueryparam value="#form.urun_adi#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.urun_kodu#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.urun_fiyat#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#uploadedImagePath#" cfsqltype="CF_SQL_VARCHAR">
        )
    </cfquery>
<div class="row">
 <div class="col-12 grid-margin stretch-card">
  <div class="card">
   <div class="card-body">
    <div class="alert alert-success">Bilgiler Eklendi!<br>Bilgiler başarıyla eklendi. Lütfen bekleyin yönlendiriliyorsunuz.</div>
    <meta http-equiv="refresh" content="2; URL=indexadmin.cfm?sayfa=urun-islem">
  </div>
 </div>
</div>
</div>
<cfelseif url.islem eq "duzenle">
    <cfparam name="url.id" default="">
    <cfset id = Int(url.id)>
    <cfquery name="updateQuery" datasource="cfemredumanDSN">
        SELECT * FROM urun WHERE id = <cfqueryparam value="#id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    <div class="card border-0 p-5 my-5">
        <div class="card-header pb-5 bg-transparent border-0 d-flex align-items-center justify-content-between gap-3">
            <h4 class="mb-0">Ürün Düzenle</h4>
        </div>
        <div class="card-body p-0 my-2">
            <div class="table-responsive">
                <div class="card border-0">
                        <div class="card-body pt-3">
                            <form method="POST" action="indexadmin.cfm?sayfa=urun-islem&islem=duzenlendi" enctype="multipart/form-data" id="islem_guncelle">
                                <div class="row">
                                    <cfif len(trim(updateQuery.resim))> <!--- Eğer resim alanı boş değilse --->
                                        <div class="row">
                                            <div class="form-group col-sm-6">
                                                <img width="100%" src="<cfoutput>#updateQuery.resim#</cfoutput>">
                                                <br><br>
                                                <a class="btn btn-danger" href="indexadmin.cfm?sayfa=urun-islem&islem=resimsil&id=<cfoutput>#updateQuery.id#</cfoutput>" onclick="return confirm('Resmi silmek istediğinize emin misiniz?');">Resmi Sil</a>
                                            </div>
                                        </div>
                                    <cfelse> <!--- Eğer resim alanı boş ise --->
                                        <div class="form-group col-md-6">
                                            <label>İçerik Görseli</label>
                                            <input name="resim" type="file" class="file-upload-default">
                                            <div class="input-group col-xs-12">
                                                <input type="text" class="form-control file-upload-info" disabled placeholder="Seçilen Resim Buraya Gelir" required>
                                                <span class="input-group-append">
                                                    <button class="file-upload-browse btn btn-gradient-primary" type="button">Resim Seç</button>
                                                </span>
                                            </div>
                                        </div>
                                    </cfif>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Adı</label>
                                            <input type="text" class="form-control" name="urun_adi" required="" value="<cfoutput>#updateQuery.urun_adi#</cfoutput>">
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Kodu</label>
                                            <input type="text" class="form-control" name="urun_kodu" required="" value="<cfoutput>#updateQuery.urun_kodu#</cfoutput>">
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Ürün Fiyatı</label>
                                            <input type="text" class="form-control" name="urun_fiyat" required="" value="<cfoutput>#updateQuery.urun_fiyat#</cfoutput>">
                                        </div>
                                    </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="id" value="<cfoutput>#updateQuery.id#</cfoutput>">
                                    <button type="submit" class="btn btn-primary">Düzenle</button>
                                </div>
                            </form>
                        </div>
                    </div>
            </div>
        </div>
    </div> 
<cfelseif url.islem eq "duzenlendi">
    <cfquery NAME="urun" datasource="cfemredumanDSN">
        SELECT * FROM urun
    </cfquery>
    <!--- Eğer yeni bir resim yüklendi ise --->
    <cfif structKeyExists(form, "resim") and form.resim neq "">
        <!--- Yüklenen resmi belirli bir klasöre kaydet --->
        <cffile action="upload" filefield="resim" destination="#expandPath('./yukleme/urun/')#" nameconflict="makeunique">
        <!--- Yüklü resmin yolu --->
        <cfset uploadedImagePath = "yukleme/urun/#cffile.serverFile#">
        <!--- Yüklü resmin yoluyla birlikte diğer alanları güncelle --->
        <cfquery datasource="cfemredumanDSN" name="updateQuery">
            UPDATE urun
            SET urun_adi = <cfqueryparam value="#form.urun_adi#" cfsqltype="CF_SQL_VARCHAR">,
                urun_kodu = <cfqueryparam value="#form.urun_kodu#" cfsqltype="CF_SQL_VARCHAR">,
                urun_fiyat = <cfqueryparam value="#form.urun_fiyat#" cfsqltype="CF_SQL_VARCHAR">,
                resim = <cfqueryparam value="#uploadedImagePath#" cfsqltype="CF_SQL_VARCHAR">
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
    <cfelse>
        <!--- Yeni resim yüklenmediyse, mevcut resim yolunu al --->
        <cfquery datasource="cfemredumanDSN" name="currentImageQuery">
            SELECT resim FROM urun WHERE id = <cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
        <cfset uploadedImagePath = currentImageQuery.resim>
        <!--- Diğer alanları güncelle --->
        <cfquery datasource="cfemredumanDSN" name="updateQuery">
            UPDATE urun
            SET urun_adi = <cfqueryparam value="#form.urun_adi#" cfsqltype="CF_SQL_VARCHAR">,
                urun_kodu = <cfqueryparam value="#form.urun_kodu#" cfsqltype="CF_SQL_VARCHAR">,
                urun_fiyat = <cfqueryparam value="#form.urun_fiyat#" cfsqltype="CF_SQL_VARCHAR">,
                resim = <cfqueryparam value="#uploadedImagePath#" cfsqltype="CF_SQL_VARCHAR">
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
    </cfif>
    
<div class="row">
 <div class="col-12 grid-margin stretch-card">
  <div class="card">
   <div class="card-body">
    <div class="alert alert-success">Bilgiler Eklendi!<br>Bilgiler başarıyla eklendi. Lütfen bekleyin yönlendiriliyorsunuz.</div>
    <meta http-equiv="refresh" content="2; URL=indexadmin.cfm?sayfa=urun-islem">
  </div>
 </div>
</div>
</div>

<cfelseif url.islem eq "resimsil">
     <!--- İlgili urun yazısının resmini sil --->
    <cfquery datasource="cfemredumanDSN">
        UPDATE urun
        SET resim = ''
        WHERE id = <cfqueryparam value="#url.id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    
<div class="row">
    <div class="col-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div class="alert alert-success">Bilgiler Eklendi!<br>Bilgiler başarıyla eklendi. Lütfen bekleyin yönlendiriliyorsunuz.</div>
                <meta http-equiv="refresh" content="2; URL=?sayfa=urun-islem&islem=duzenle&id=<cfoutput>#urun.id#</cfoutput>">
                </div>
            </div>
        </div>
    </div>
</div>    

<cfelseif url.islem eq "sil">
<cfparam name="url.id" default="">

<cfquery datasource="cfemredumanDSN" name="deleteQuery">
    DELETE FROM urun
    WHERE id = <cfqueryparam value="#url.id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
    <div class="row">
        <div class="col-12 grid-margin stretch-card">
         <div class="card">
          <div class="card-body">
           <div class="alert alert-success">Bilgiler Eklendi!<br>Bilgiler başarıyla eklendi. Lütfen bekleyin yönlendiriliyorsunuz.</div>
           <meta http-equiv="refresh" content="2; URL=indexadmin.cfm?sayfa=urun-islem">
         </div>
        </div>
       </div>
       </div>
    </div>
<cfelseif url.islem eq "arama">
    <cfparam name="url.id" default="">
    <cfset id = Int(url.id)>
    <cfquery name="updateQuery" datasource="cfemredumanDSN">
        SELECT * FROM urun WHERE id = <cfqueryparam value="#id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    <div class="card border-0 p-5 my-5">
        <div class="card-header pb-5 bg-transparent border-0 d-flex align-items-center justify-content-between gap-3">
            <h2 class="mb-0">Ürün Fiyat Bilgisi Öğren</h2>
        </div>
        <div class="card-body p-0 my-2">
            <div class="table-responsive">
                <div class="card border-0">
                    <div class="card-body pt-3">
                        <form id="productForm">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <h3 class="">Ürün İsmi</h3>
                                        <input type="text" class="form-control" name="baslik" id="productName" required="" value="<cfoutput>#updateQuery.urun_kodu#</cfoutput>">
                                        <button type="submit" class="btn btn-primary">Fiyatları Çek</button>
                                        <p id="loading" style="display: none;">Veriler Yükleniyor lütfen bekleyin...</p>
                                        <p id="content"></p>
                                        <button type="button" id="downloadExcel" class="btn btn-success" style="display:none;">Excel'e Dönüştür</button>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <!--- <cfquery NAME="urun_fiyatlari" datasource="cfemredumanDSN">
                            SELECT * FROM urun_fiyatlari  WHERE id = <cfqueryparam value="#id#" cfsqltype="CF_SQL_INTEGER">
                        </cfquery>
                        <div id="priceList">
                            <div class="table-responsive">
                                <table class="table table-striped mt-3">
                                        <thead>
                                          <tr>
                                            <th scope="col">Ürün</th>
                                            <th scope="col">Firma</th>
                                            <th scope="col">Fiyat</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                            <cfloop query="urun_fiyatlari">
                                          <tr>
                                            <th><cfoutput>#urun_fiyatlari.urun_ismi#</cfoutput></th>
                                            <td><cfoutput>#urun_fiyatlari.firma#</cfoutput></td>
                                            <td><cfoutput>#urun_fiyatlari.fiyat#</cfoutput></td>
                                          </tr>
                                        </cfloop>
                                        </tbody>
                                </table>
                            </div>
                        </div> --->
                    </div>
                </div>
            </div>
        </div>
    </div>
    </cfif>
    
    <!-- jQuery kütüphanesi -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-pwCvru4E4HJ4JZDEalgqzPhBh0p6RQi3CN9x5w+8d7g=" crossorigin="anonymous"></script>
    
    <!-- Bootstrap kütüphanesi -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+gv0+9v+58b9ay2HNY5/KCWhl+LQ9b4v/R5NpGqiKfuo/6b7lXo5l2I++U" crossorigin="anonymous"></script>
    
    <!-- SheetJS kütüphanesi -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    
    <script>
        document.getElementById("productForm").addEventListener("submit", function(event) {
            event.preventDefault();
    
            var productName = document.getElementById("productName").value;
            var urun_adi = "";
            var urun_kodu = "";
            <cfif url.islem eq "arama">
                 urun_adi = "<cfoutput>#updateQuery.urun_adi#</cfoutput>" ;
                 urun_kodu = "<cfoutput>#updateQuery.urun_kodu#</cfoutput>" ;
            </cfif>
            const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDiq31f8drnea7fK4fN_iJeQUDVqR1Y9R4';
            
            const data = {
                contents: [
                    {
                    parts: [
                        {
                        text: "Türkiyedeki '" + urun_adi + productName + "' isimli ürünün bana farklı kapasiteleriyle beraber şu mağazalardan ver; teknosa, vatan, hepsiburada, n11, trendyol. Veriler kesinlikle veri formatı: [{\"urun_adi\"   : \"\",\"magaza_adi\" : \"\",\"kapasite\"  : \"\",\"renk\"  : \"\",\"fiyat\"  : \"\" ,\"\",\"seri_model_numarasi\"  : \""+urun_kodu+"\"},] şeklinde belirtilen json veri formatında listelensin. Fiyatı aldığın firmanın karşılığında fiyat gözüksün."
                        
                        }
                    ]
                    }
                ]
            };
    
            document.getElementById("loading").style.display = "block";
            fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(data => {
            var final_data = data.candidates[0].content.parts[0].text;
            final_data = final_data.replaceAll("```json", "").replaceAll("```", "");
            document.getElementById("content").innerText = final_data;
            document.getElementById("loading").style.display = "none";
            document.getElementById("downloadExcel").style.display = "inline";

    // Veriyi veritabanına kaydet
    saveDataToDatabase(final_data);
})

            .catch(error => {
            console.error('Error:', error);
            });
        });

        function saveDataToDatabase(final_data) {
        fetch('sayfalar/save_data.cfm', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'data=' + encodeURIComponent(final_data)
        })
        .then(response => response.text())
        .then(responseText => {
            console.log(responseText);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
    
        document.getElementById("downloadExcel").addEventListener("click", function() {
            var final_data = document.getElementById("content").innerText;
            var rows = final_data.split(',').map(item => item.trim().split(':').map(cell => cell.trim()));
    
            var worksheet = XLSX.utils.aoa_to_sheet(rows);
            var workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, "Fiyatlar");
    
            XLSX.writeFile(workbook, "urun_fiyatlari.xlsx");
        });
    </script>
    
