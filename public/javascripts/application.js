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
            
        default:
            $('#frequency').hide();
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


function assignColumnName(){
	$('.edit_widget').each(function() {
		var currentId = $(this).attr('id');
		var column = $(this).parent().attr('column');
		if (currentId.indexOf(column) == -1) {
			$(this).attr('id', currentId + column);
		}
	});
	
}
