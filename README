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

https://gist.github.com/3123639

## Author

jordi domenech
jordi@iamyellow.net
http://iamyellow.net
@iamyellow2

## Feedback and Support

jordi@iamyellow.net

## License

Copyright 2012 jordi domenech <jordi@iamyellow.net>
Apache License, Version 2.0