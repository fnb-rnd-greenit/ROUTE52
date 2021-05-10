/*
 * SimpleModal Basic Modal Dialog
 * http://simplemodal.com
 *
 * Copyright (c) 2013 Eric Martin - http://ericmmartin.com
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 */

jQuery(function ($) {
	// Load dialog on page load
	//$('#basic-modal-content').modal();

	// Load dialog on click
	$('#basic-modal .basic').click(function (e) {
		$('#basic-modal-content').modal();

		return false;
	});
	// Load dialog on click
	$('.btnBox .motion').click(function (e) {
		$('#basic-modal-content2').modal();

		return false;
	});

	$('#basic-modal-content2').hide();

});

function onLoadCancelModal() {
	$('#basic-modal-content').modal('show');
}

function onLoadReservationModal() {
	$.modal.close();
	$('#basic-modal-content2').modal('show');
	$('#simplemodal-container').css({top:'40%', left:'40%'});
	$('#simplemodal-container').width('500px');
	$('#simplemodal-container').height('300px');
}