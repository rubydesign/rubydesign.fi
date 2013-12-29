function bs_init(){

    /* Richtext editor */
    $('.select-richtext').click(function(){
        $('.label-richtext-type[for=' + $(this).attr('id') + ']').trigger('click');
    });
    $('.label-richtext-type').live("click", function(){
        elt = $('#' + $(this).attr('for'));
        newSet = elt.val();
        idspleditor = elt.attr('data-spleditor');
        ideditor = elt.attr('data-editor');
        $('#' + idspleditor).markItUpRemove();
        if(!$('#' + idspleditor).hasClass('markItUpEditor')){
            switch(newSet) {
                case 'bbcode':
                    $('#' + idspleditor).markItUp(myBbcodeSettings);
                    break;
                case 'wiki':
                    $('#' + idspleditor).markItUp(myWikiSettings);
                    break;
                case 'textile':
                    $('#' + idspleditor).markItUp(myTextileSettings);
                    break;
                case 'markdown':
                    $('#' + idspleditor).markItUp(myMarkdownSettings);
                    break;
                case 'html':
                    $('#' + idspleditor).markItUp(myHtmlSettings);
                    break;
            }
        }
        $('#' + ideditor).removeClass("bbcode html markdown textile wiki").addClass(newSet);
        return true;
    });

    // Tagit
    $('.bs-tagit').each(function( index ) {
        var tagitelt = this;
        $(tagitelt).tagit({
            tagSource : function( request, response ) {

                var par = $(tagitelt).attr("data-param");
                var url = $(tagitelt).attr("data-url");
                var result = $(tagitelt).attr("data-result");
                var data_to_send = {
                    "skip_save_search": true
                };
                data_to_send[par] = request.term;
                $.ajax({
                    url: url,
                    type: "POST",
                    data: data_to_send,
                    dataType: "json",
                    success: function( data ) {
                        response( $.map( data, function( item ) {
                            return { label: String(item[result]), value: item.id };
                        }));
                    }
                });
            },
            triggerKeys:['enter', 'comma', 'tab'],
            select : true,
            allowNewTags : false
        });
    });

    // Processing
    $('#checkall').click(function(){
        $('.cbbatch').attr('checked', ($(this).attr('checked') != undefined));
    });

    // Filter columns
    $('#filter-columns').on('click', function(){
        var return_json = [];
        $.each($('input[name^="field"]:checked'), function(index, value) {
            return_json.push($(value).val());
        });
        var url = $(this).attr('data-url');
        $.ajax({
            url: url,
            data: { 'fields' : return_json },
            success: function(data) {
                $('table.table th[class^="col"], table.table td[class^="col"]').css('display', 'none');
                $.each(return_json, function(index, value) {
                    $('table.table th.col-' + value + ', table.table td.col-' + value).css('display', 'table-cell');
                });
                $('div[class^="col"]').css('display', 'none');
                $.each(return_json, function(index, value) {
                    $('div.col-' + value).css('display', 'inline');
                });
                $('#modal-columns').modal('hide');
            }
        });
        return false;
    });
    $('#cancel-filter-columns').on('click', function(){
        $('#modal-columns').modal('hide');
        return false;
    });

    // Barcode
    $('.barcode').each(function(index){
        $(this).barcode($(this).attr('data-barcode'), $(this).attr('data-type-barcode'));
    });

    // Chardinjs (overlay instructions)
    $(".bs-chardinjs").on("click", function(){
        var selector = $(this).attr("data-selector");
        $(selector).chardinJs('toggle');
        return false;
    });

    // Add Error Form style with bootstrap
    $("div.control-group>div.field_with_errors").parent().addClass("error");
    $("#error_explanation").addClass("text-error");

    // Mass inserting set focus
    elt = $('form.mass-inserting div[style*="inline"][class*="col"] .input-small').first();
    if($('form.mass-inserting').hasClass('setfocus')){
        $(elt).focus();
    }

    // Menu dropdown
    try{
        $('.dropdown-toggle').dropdown();
        $('.dropdown-menu').find('form').click(function (e) {
            e.stopPropagation();
        });
    }catch (e){
    }

}