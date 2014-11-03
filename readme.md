# TiGrowingTextField Appceleartor Titanium iOS Module

## Description

This simple module let's you create a text field which grows or shinks depending on the the content the user types, like iMessage, WhatsApp, etc.

TiGrowingTextField uses a third party library created by HansPinckaers:
https://github.com/HansPinckaers/GrowingTextView/

And it's open sourced:
https://github.com/iamyellow/TiGrowingTextField

## Using the module

Require the module and call and create the view:

```js
var textField = require('net.iamyellow.tigrowingtextfield').createView({
	// layout stuff -it works as any other view-
	height: 40, // 40 is the minimum height, the view height won't be < 40
	left: 10, right: 10,
	// layout correction (new since v0.5)
	topCorrectionPadding: 7,
	sidesPadding: 5,
	// growing / shrink
	minNumberOfLines: 1, // default = 1
	maxNumberOfLines: 10, // default = 3,
	showKeyboardImmediately: true,
	// background stuff
	backgroundImage: 'images/MessageEntryInputField.png',
	backgroundLeftCap: 12,
	backgroundTopCap: 20,
	value: 'hellow',
	// appearance 
	appearance: Ti.UI.KEYBOARD_APPEARANCE_ALERT,
	// text stuff, works as Ti.UI.TextField
	autocorrect: false, // disables / enables autocorrection
	textAlign: 'left',
	font: {
		fontFamily: 'Georgia',
		fontSize: 12
	},
	color: '#333333'
});
```

I guess properties names are self explanatory, except **showKeyboardImmediately**... well, sometimes I need the keyboard appears immediately as window is opened. Setting this to true makes it possible.

### Methods

#### focus ()

The field gains the focus.

#### blur ()

The field loses the focus.

### Events

#### focus

When it gains the focus.

#### blur

When it loses the focus.

#### change

When the content changes. The event has properties:

* **value** the content itself, the text field value.

* **height** the current height.

## Example

```js
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
```

## Thanks to

Danny Pham for the funds for keep up to date this module.

## Author

jordi domenech  
jordi@iamyellow.net  
http://iamyellow.net  
@0xfff612

## License

Copyright 2013 jordi domenech <jordi@iamyellow.net>  
Apache License, Version 2.0