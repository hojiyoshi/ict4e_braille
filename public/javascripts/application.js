function setToForm(){
    var curfrm = document.to_form;
    if (curfrm.to_type_same.checked) {
        document.to_form.name2.disabled = "true";
        document.to_form.zip2.disabled = "true";
        document.to_form.addr2.disabled = "true";
        document.to_form.bill2.disabled = "true";

        document.to_form.name2.value ="";
        document.to_form.zip2.value ="";
        document.to_form.addr2.value ="";
        document.to_form.bill2.value ="";
    }
    else{

        document.to_form.name2.disabled = "";
        document.to_form.zip2.disabled = "";
        document.to_form.addr2.disabled = "";
        document.to_form.bill2.disabled = "";
    }
}