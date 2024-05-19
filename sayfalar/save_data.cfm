
<cfparam name="form.data" default="">
<cfset jsonData = DeserializeJSON(form.data)>

<!--- Veritabanına ekleme işlemi --->
<cftry>
    <cfloop array="#jsonData#" index="item">
        
        <cfif not structKeyExists(item, "fiyat")>
            <cfset item.fiyat = 0>
        </cfif>

        <cfif not structKeyExists(item, "renk")>
            <cfset item.renk = ''>
        </cfif>

        <cfif not structKeyExists(item, "kapasite")>
            <cfset item.kapasite = ''> 
        </cfif>

        <!--- Veritabanı işlemi --->
        <cfquery name="insertData" datasource="cfemredumanDSN">
            INSERT INTO urun_fiyatlari (urun_ismi, fiyat, firma, seri_model_numarasi)
            VALUES (
                <cfqueryparam value="#item.urun_adi# #item.kapasite# #item.renk#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#item.fiyat#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#item.magaza_adi#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#item.seri_model_numarasi#" cfsqltype="CF_SQL_VARCHAR">
            );
        </cfquery>
    </cfloop>

    <!--- Başarılı işlem mesajı --->
    <cfoutput>Veri başarıyla eklendi.</cfoutput>

    <!--- Hata durumunu kontrol etme --->
    <cfcatch>
        <!--- Hata mesajını gösterme --->
        <cfoutput>Hata: #cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>
