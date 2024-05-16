
    <cfcomponent>
        <cfif IsDefined("form.kullaniciadi") and IsDefined("form.sifre")>
            <cfquery name="checkAdminLogin" datasource="cfemredumanDSN">
                SELECT *
                FROM adminGiris
                WHERE kullaniciadi = <cfqueryparam value="#form.kullaniciadi#" cfsqltype="cf_sql_varchar">
                AND sifre = <cfqueryparam value="#form.sifre#" cfsqltype="cf_sql_varchar">
            </cfquery>
    
            <cfif checkAdminLogin.RecordCount>
                <!--- Kullanıcı doğru bilgilerle giriş yaptıysa --->
                <cflocation url="indexadmin.cfm?sayfa=urunler" addtoken="false">
            <cfelse>
                <!--- Kullanıcı adı veya şifre yanlışsa --->
                <cfset errorMessage = "Kullanıcı adı veya şifre yanlış">
                <cfoutput>
                    <script>
                        alert("#errorMessage#");
                        window.history.back();
                    </script>
                </cfoutput>
            </cfif>
        </cfif>
    </cfcomponent>

