function bs_init(){


    // Barcode
    $('.barcode').each(function(index){
        $(this).barcode($(this).attr('data-barcode'), $(this).attr('data-type-barcode'));
    });

    // Add Error Form style with bootstrap
    $("div.control-group>div.field_with_errors").parent().addClass("error");
    $("#error_explanation").addClass("text-error");


}