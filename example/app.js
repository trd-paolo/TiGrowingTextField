(function (tigrowingtextfield) {	
	// ****************************************************************************************************************
	// ****************************************************************************************************************
	// GUI setup
	
	var win = Ti.UI.createWindow({
		width: Ti.UI.FILL, height: Ti.UI.FILL,
		backgroundColor: '#fff612'
	}),
	toolbar = Ti.UI.createView({
		width: Ti.UI.FILL, height: Ti.UI.SIZE,
		top: 30, left: 0,
		backgroundImage: 'images/MessageEntryBackground.png',
		backgroundTopCap: 20
	}),
	// layout correction values 
	minHeight = 40,
	topCorrectionPadding = 7,
	sidesPadding = 5,
	// create view
	textField = tigrowingtextfield.createView({
		// layout, as any other view
		height: minHeight, // 0.5: once the view is inited, this is going to be the MIN height
		top: 0, left: 10, right: 10,
		// fine-tuning text adjustment (new on 0.5)
		topCorrectionPadding: topCorrectionPadding,
		sidesPadding: sidesPadding,
		// growing / shrink
		minNumberOfLines: 1, // default = 1
		maxNumberOfLines: 5, // default = 3,
		showKeyboardImmediately: true,
		// background
		backgroundImage: 'images/MessageEntryInputField.png',
		backgroundLeftCap: 15,
		backgroundTopCap: 20,
		// appearance 
		appearance: Ti.UI.KEYBOARD_APPEARANCE_ALERT,
		// text
		autocorrect: false,
		textAlign: 'left',
		font: {
			fontFamily: 'Helvetica',
			fontSize: 12
		},
		color: '#333'
	});
	
	toolbar.add(textField);
	win.add(toolbar);
	
	// ****************************************************************************************************************
	// ****************************************************************************************************************
	// events
	
	win.addEventListener('click', function () {
		textField.blur();
	});
	
	textField.addEventListener('focus', function (ev) {
		Ti.API.info('////////////////////////////////////////////////////////////');
		Ti.API.info('** focused');
	});
	
	textField.addEventListener('change', function (ev) {
		Ti.API.info('////////////////////////////////////////////////////////////');
		Ti.API.info('my value is: ' + ev.value);
		Ti.API.info('my height is: ' + ev.height);
	});
	
	textField.addEventListener('blur', function (ev) {
		Ti.API.info('////////////////////////////////////////////////////////////');
		Ti.API.info('** blurred');
	});
	
	
	// ****************************************************************************************************************
	// ****************************************************************************************************************
	// the show
	
	win.open();
})(require('net.iamyellow.tigrowingtextfield'));