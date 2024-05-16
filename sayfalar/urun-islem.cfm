<cfquery NAME="urun" datasource="cfemredumanDSN">
    SELECT * FROM urun
</cfquery>
<cfparam name="url.islem" default="">
<cfif url.islem eq "">
<div class="card border-0 p-5 my-5">
    <div class="card-header pb-5 bg-transparent border-0 d-flex align-items-center justify-content-between gap-3">
        <h4 class="mb-0">Ürün Listesi</h4>
        <a href="indexadmin.cfm?sayfa=urun-islem&islem=ekle">
            <button type="button" class="btn btn-primary btn-lg rounded-pill">
            <i class="bi bi-arrow-up-right-square-fill me-1"></i>Ürün Ekle</button>
        </a>
        
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-borderless">
                <thead>
                    <tr>
                        <th width="">Resim</th>
                        <th width="">Başlık</th>
                        <th width="">Açıklama</th>
                        <th width="">İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="urun">
                        <tr>
                            <td>
                                <div class="employee d-flex gap-2 flex-wrap">
                                    <div class="profilepicture flex-shrink-0 d-none d-xl-block">
                                        <img src="<cfoutput>#urun.resim#</cfoutput>"alt="" width="50">
                                    </div>
                                </div>
                            </td>
                            <td><cfoutput>#urun.baslik#</cfoutput></td>
                            <td><cfoutput>#urun.detay#</cfoutput></td>
                            <td style="vertical-align: middle;" class="tooltip-demo text-center">
                                <a href="?sayfa=urun-islem&islem=duzenle&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-warning" data-toggle="tooltip" data-placement="top" title="Düzenle"><i class="fa fa-edit"></i> Düzenle</a>
                                <a href="?sayfa=urun-islem&islem=sil&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-danger" onclick="return confirm('Bilgileri silmek istediğinize emin misiniz?');" data-toggle="tooltip" data-placement="top" title="Sil"><i class="fa fa-times"></i> Sil</a>
                                <a href="?sayfa=urun-islem&islem=arama&id=<cfoutput>#urun.id#</cfoutput>" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModal" data-placement="top" title="Arama"><i class="fa-brands fa-searchengin"></i> Fiyat Öğren</a>
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
                                            <label class="form-label">Başlık</label>
                                            <input type="text" class="form-control" name="baslik" required="">
                                        </div>
                                    </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Metin</label>
                                            <textarea class="form-control" name="detay" placeholder="Enter Text" id="editor1"></textarea>
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
    <cfparam name="form.baslik" default="">
    <cfparam name="form.detay" default="">

    <cfset uploadedImagePath = "">

    <!-- Eğer resim yüklendi ise -->
    <cfif structKeyExists(form, "resim") and form.resim neq "">
        <!-- Resim yükleme işlemini gerçekleştir -->
        <cffile action="upload" filefield="resim" destination="#expandPath('./yukleme/urun/')#" nameconflict="makeunique">
        <!-- Yüklü resmin yolu -->
        <cfset uploadedImagePath = "yukleme/urun/#cffile.serverFile#">
    </cfif>

    <cfquery datasource="cfemredumanDSN" name="insertQuery">
        INSERT INTO urun (baslik, detay, resim)
        VALUES (
            <cfqueryparam value="#form.baslik#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.detay#" cfsqltype="CF_SQL_LONGVARCHAR">,
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
                                            <label class="form-label">Başlık</label>
                                            <input type="text" class="form-control" name="baslik" required="" value="<cfoutput>#updateQuery.baslik#</cfoutput>">
                                        </div>
                                    </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Metin</label>
                                            <textarea class="form-control" name="detay" placeholder="Enter Text" id="editor1" value=""><cfoutput>#updateQuery.detay#</cfoutput></textarea>
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
    
    <!--- Eğer yeni bir resim yüklendi ise --->
    <cfif structKeyExists(form, "resim") and form.resim neq "">
        <!--- Yüklenen resmi belirli bir klasöre kaydet --->
        <cffile action="upload" filefield="resim" destination="#expandPath('./yukleme/urun/')#" nameconflict="makeunique">
        <!--- Yüklü resmin yolu --->
        <cfset uploadedImagePath = "yukleme/urun/#cffile.serverFile#">
        <!--- Yüklü resmin yoluyla birlikte diğer alanları güncelle --->
        <cfquery datasource="cfemredumanDSN" name="updateQuery">
            UPDATE urun
            SET baslik = <cfqueryparam value="#form.baslik#" cfsqltype="CF_SQL_VARCHAR">,
                detay = <cfqueryparam value="#form.detay#" cfsqltype="CF_SQL_LONGVARCHAR">,
                resim = <cfqueryparam value="#uploadedImagePath#" cfsqltype="CF_SQL_VARCHAR">
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
    <cfelse>
        <!--- Yeni resim yüklenmediyse, yalnızca diğer alanları güncelle --->
        <cfquery datasource="cfemredumanDSN" name="updateQuery">
            UPDATE urun
            SET baslik = <cfqueryparam value="#form.baslik#" cfsqltype="CF_SQL_VARCHAR">,
                detay = <cfqueryparam value="#form.detay#" cfsqltype="CF_SQL_LONGVARCHAR">
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
                                        <input type="text" class="form-control" name="baslik" id="productName" required="" value="<cfoutput>#updateQuery.baslik#</cfoutput>">
                                        <button type="submit" class="btn btn-primary">Fiyatları Çek</button>
                                        <p id="loading" style="display: none;">Veriler Yükleniyor lütfen bekleyin...</p>
                                        <p id="content"></p>
                                        <button type="button" id="downloadExcel" class="btn btn-success" style="display:none;">Excel'e Dönüştür</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div id="priceList">
                            <div class="table-responsive">
                                <table class="table table-bordered mt-3">
                                    <tbody id="priceTableBody">
                                        <!-- Fiyatlar burada dinamik olarak eklenecek -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
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
            const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDiq31f8drnea7fK4fN_iJeQUDVqR1Y9R4';
    
            const data = {
                contents: [
                    {
                    parts: [
                        {
                        text: "'" + productName + "' ürününün Türkiyede ki bana farklı modelleriyle beraber şuralardan ver; teknosa, vatan, hepsiburada, n11, trendyol. Veriler kesinlikle json şeklinde olsun. Fiyatı aldığın firmanın karşılığında fiyat gözüksün."
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
                final_data = final_data.replaceAll("```json", "").replaceAll("```", "").replaceAll("{", "").replaceAll("}", "").replaceAll("[", "").replaceAll("]", "");
                document.getElementById("content").innerText = final_data;
                document.getElementById("loading").style.display = "none";
                document.getElementById("downloadExcel").style.display = "inline";
            })
            .catch(error => {
            console.error('Error:', error);
            });
        });
    
        document.getElementById("downloadExcel").addEventListener("click", function() {
            var final_data = document.getElementById("content").innerText;
            var rows = final_data.split(',').map(item => item.trim().split(':').map(cell => cell.trim()));
    
            var worksheet = XLSX.utils.aoa_to_sheet(rows);
            var workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, "Fiyatlar");
    
            XLSX.writeFile(workbook, "urun_fiyatlari.xlsx");
        });
    </script>
    