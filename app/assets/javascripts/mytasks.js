jQuery(document).ready(function($) {
	$('.edit_task input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
});