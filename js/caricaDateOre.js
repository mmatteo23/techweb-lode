var mesi = ["gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno", "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre"];
var settimana = ["domenica", "lunedì", "martedì", "mercoledì", "giovedì", "venerdì", "sabato"];

/*function caricaDateOre(){
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();
    var htmlCode = "";
    var n = numeroDiGiorni(mm, yyyy);
    for(var i = 1; i <= n; i++){
        if(i==parseInt(dd))
            htmlCode += "<option value='" + i + "' selected>" + String(i).padStart(2, '0') + "</option>";
        else
            htmlCode += "<option value='" + i + "'>" + String(i).padStart(2, '0') + "</option>";
    }
    document.getElementById("giornoSessione").innerHTML = htmlCode;

    htmlCode = "";
    for(var i = 0; i < 12; i++){
        if(i+1==parseInt(mm))
            htmlCode += "<option value='" + (i + 1) + "' selected>" + mesi[i] + "</option>";
        else
            htmlCode += "<option value='" + (i + 1) + "'>" + mesi[i] + "</option>";
    }
    document.getElementById("meseSessione").innerHTML = htmlCode;

    var h = today.getHours();
    if(h>=10 && h<=22){
        document.getElementById("oraInizio").selectedIndex = h-10;
        document.getElementById("oraFine").selectedIndex = h-10;
        document.getElementById("minutoFine").selectedIndex = 2;
    }

    var dotw = today.getDay();
    document.getElementById("giornoSettimana").innerHTML = settimana[dotw];
}*/

function meseCambiato(){
    var e = document.getElementById("meseSessione");
    var mm = e.options[e.selectedIndex].value;
    mm = String(mm).padStart(2, '0');
    var n = numeroDiGiorni(mm, new Date().getFullYear());
    var htmlCode = "<option value='1' selected >01</option>";
    for(var i = 2; i <= n; i++){
        htmlCode += "<option value='" + i + "'>" + String(i).padStart(2, '0') + "</option>";
    }
    document.getElementById("giornoSessione").innerHTML = htmlCode;
    giornoCambiato();
}

function giornoCambiato(){
    var today = new Date();
    document.getElementById("prenota").disabled = false;
    var date = new Date(today.getFullYear(), document.getElementById("meseSessione").value - 1, document.getElementById("giornoSessione").value);
    console.log(date);console.log(today);
    if(today.setHours(0,0,0,0) > date){   //il giorno è passato
        document.getElementById("selezioneOrari").innerHTML = "<p>Non è possibile prenotare sessioni per giorni passati</p>";
        document.getElementById("prenota").disabled = true;
        return;
    }
    var dotw = date.getDay();
    document.getElementById("giornoSettimana").innerHTML = settimana[dotw];
    var dalle = 10, alle = 22;
    var contenuto = "";
    if(dotw == 6){    //è sabato
        dalle = 11;
        alle = 16;
    }
    else if(dotw == 0){      //è domenica
        document.getElementById("selezioneOrari").innerHTML = "<p>Non è possibile prenotare sessioni di domenica</p>";
        document.getElementById("prenota").disabled = true;
        return;
    }
    var contenuto = "<div class='inline-selectbox'><label class='width-fill-available' for='oraInizio minutoInizio'>Ora d'inizio della sessione:</label><div class='inline-selectbox'><select id='oraInizio' name='oraInizio'>";
    contenuto += "<option value='" + dalle + "' selected>" + String(dalle) + "</option>";
    for(i=dalle + 1; i<=alle; i++){
        contenuto += "<option value='" + i + "'>" + String(i) + "</option>";
    }
    contenuto += "</select><select id='minutoInizio' name='minutoInizio'><option value='0' selected>00</option><option value='15'>15</option><option value='30'>30</option><option value='45'>45</option></select>";
    contenuto += "</div></div><div class='inline-selectbox'><label class='width-fill-available' for='oraFine minutoFine'>Ora di fine della sessione:</label><div class='inline-selectbox'><select id='oraFine' name='oraFine'>";
    contenuto += "<option value='" + dalle + "' selected>" + String(dalle) + "</option>";
    for(i=dalle + 1; i<=alle; i++){
        contenuto += "<option value='" + i + "'>" + String(i) + "</option>";
    }
    contenuto += "</select><select id='minutoFine' name='minutoFine'><option value='0'>00</option><option value='15'>15</option><option value='30' selected>30</option><option value='45'>45</option></select>";
    //contenuto += "</div></div><input type='submit' value='prenota' name='prenota'>";

    document.getElementById("selezioneOrari").innerHTML = contenuto;

}

function numeroDiGiorni(mm, yyyy){
    var n = 31;
    console.log("il mese che mi hai dato è " + mm);
    if(mm == "11" || mm == "04" || mm == "06" || mm == "09")
        n = 30;
    else if(mm == "02"){
        n = 28;
        if(yyyy%4==0)
            n = 29;
    }
    return n;
}