function setToForm(){
    var curfrm = document.to_form;
    if (curfrm.data_type_same.checked) {
        document.to_form.name2.disabled = "true";
        document.to_form.zip2.disabled = "true";
        document.to_form.addr2.disabled = "true";
        document.to_form.bill2.disabled = "true";
    }
    else{

        document.to_form.name2.disabled = "";
        document.to_form.zip2.disabled = "";
        document.to_form.addr2.disabled = "";
        document.to_form.bill2.disabled = "";
    }
}