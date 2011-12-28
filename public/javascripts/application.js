// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showPeriodAndFrequency(value){

    switch (value) {
        case 'Daily':
            $('#period').html('day');
            $('#frequency').show();
						$('#end_date').show();
            break;
        case 'Weekly':
            $('#period').html('week');
            $('#frequency').show();
						$('#end_date').show();
            break;
        case 'Monthly':
            $('#period').html('month');
            $('#frequency').show();
						$('#end_date').show();
            break;
        case 'Yearly':
            $('#period').html('year');
            $('#frequency').show();
						$('#end_date').show();
            break;
        case 'Monday':
            $('#period_other').html('Monday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Tuesday':
            $('#period_other').html('Tuesday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Wednesday':
            $('#period_other').html('Wednesday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Thursday':
            $('#period_other').html('Thursday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Friday':
            $('#period_other').html('Friday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Saturday':
            $('#period_other').html('Saturday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
        case 'Sunday':
            $('#period_other').html('Sunday in the month');
            $('#position').show();
						$('#end_date').show();
            break;
            
        default:
            $('#frequency').hide();
						$('#position').hide();
						$('#end_date').hide();
						
    }
        
}

function checkForExternalLink(value){	
	if (value == '') {
		$('#external_link_field').show();
	}
	else {
		$('#external_link_field').hide();
	}     
}

function checkForLinkType(value){
	if (value == 'internal_link') {
		$('#internal_link_field').show();
		$('#external_link_field').hide();
	}
	else {
		$('#external_link_field').show();
		$('#internal_link_field').hide();
	}
}

$(function($) {
	var status = $('#nav_item_link_type_internal_link').attr("checked");
	if (status == true) {
			$('#external_link_field').hide();
	}
	else {
			$('#internal_link_field').hide();
	}
})

function assignColumnName(){
	$('.edit_widget').each(function() {
		var currentId = $(this).attr('id');
		var column = $(this).parent().attr('column');
		if (currentId.indexOf(column) == -1) {
			$(this).attr('id', currentId + column);
		}
	});
	
}

function modifyLightboxLinks(){
	$('a.fancybox').each(function() {
		var currentLink = $(this).attr('href');
		var lightboxLink = currentLink + (currentLink.indexOf('?') != -1 ? '&lightbox=true' : '?lightbox=true')
		$(this).attr('href', lightboxLink);
	});
}

$(function($) { 
	
	$('.admin_dropdown_hidden').hide();
	
	$('.admin_parish_nav_item').mouseenter(function() {
		var dropdownId = $(this).attr("id");
	  $('#admin_dropdown_hidden_' + dropdownId).show();
	});

	$('.admin_parish_nav_item').mouseleave(function() {
		var dropdownId = $(this).attr("id");
	  $('#admin_dropdown_hidden_' + dropdownId).hide();
	});
	
	modifyLightboxLinks();
	
	$("#forms_edit_content").on("change", "select", function(event){
		var valuesId = '#' + $(this).attr('id').replace('field_type', 'values')
		var value = $(this).val();
		if (value == 'select' || value == 'check_boxes' || value == 'radio_buttons') {
			$(valuesId).parent().show();
		}
		else {
			$(valuesId).parent().hide();
		}
	});
	
		
})