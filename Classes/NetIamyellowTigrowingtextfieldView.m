//
//   Copyright 2012 jordi domenech <jordi@iamyellow.net>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

#import "NetIamyellowTigrowingtextfieldView.h"
#import "TiHost.h"
#import "TiViewProxy.h"

@implementation NetIamyellowTigrowingtextfieldView

-(void)dealloc
{
    RELEASE_TO_NIL(textView);
    RELEASE_TO_NIL(entryImageView);
    RELEASE_TO_NIL(text);
    [super dealloc];
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (bounds.size.width == 0 || bounds.size.height == 0) {
    	textView.internalTextView.editable = NO;
        return;
    }
    if (textView == nil) {
        userHeight = bounds.size.height;
        topCorrectionPadding = [TiUtils floatValue:[[self proxy] valueForKey:@"topCorrectionPadding"] def:0.0f];
        
        // init
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(0, topCorrectionPadding,
                                                                       frame.size.width, frame.size.height)];
        textView.text = text ? text : @"";

		

        // become first responder
        if ([TiUtils boolValue:[[self proxy] valueForKey:@"showKeyboardImmediately"] def:NO]) {
            [textView becomeFirstResponder];
        }
        
        // lines
        NSInteger minNumberOfLines = [TiUtils intValue:[[self proxy] valueForKey:@"minNumberOfLines"] def:1];
        NSInteger maxNumberOfLines = [TiUtils intValue:[[self proxy] valueForKey:@"maxNumberOfLines"] def:3];
        textView.minNumberOfLines = minNumberOfLines;
        textView.maxNumberOfLines = maxNumberOfLines;
        
        // sides padding
        CGFloat sidesPadding = [TiUtils floatValue:[[self proxy] valueForKey:@"sidesPadding"] def:0.0f];
        textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);

        // return key type
        NSInteger wew = [TiUtils intValue:[[self proxy] valueForKey:@"wew"] def:0]>0 ? UIReturnKeySend : UIReturnKeyDefault;
        textView.returnKeyType = wew;
        
        // appearance
        NSInteger appearance = [TiUtils intValue:[[self proxy] valueForKey:@"appearance"] def:UIKeyboardAppearanceDefault];
        textView.internalTextView.keyboardAppearance = appearance;
        
        // font
        UIFont* font = [[TiUtils fontValue:[[self proxy] valueForKey:@"font"] def:[WebFont defaultFont]] font];
        textView.font = font;
        
        // autocorrect
        BOOL autocorrect = [TiUtils boolValue:[[self proxy] valueForKey:@"autocorrect"] def:NO];
        textView.internalTextView.autocorrectionType = autocorrect ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;

        // scrollsToTop
        BOOL scrollsToTop = [TiUtils boolValue:[[self proxy] valueForKey:@"scrollsToTop"] def:YES];
        textView.internalTextView.scrollsToTop = scrollsToTop;
        

        
        // colors
        id pBackgroundColor = [[self proxy] valueForKey:@"backgroundColor"];
        if (pBackgroundColor) {
            //textView.backgroundColor = [[TiUtils colorValue:pBackgroundColor] _color];
            self.backgroundColor = [[TiUtils colorValue:pBackgroundColor] _color];
        }
        else {
            textView.backgroundColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor whiteColor];
        }
        id pTextColor = [[self proxy] valueForKey:@"color"];
        if (pTextColor) {
            textView.textColor = [[TiUtils colorValue:pTextColor] _color];
        }
        
        // text alignment
        id pTextAlignment = [[self proxy] valueForKey:@"textAlign"];
        if (pTextAlignment) {
            textView.textAlignment = [TiUtils textAlignmentValue:pTextAlignment];
        }
        
        textView.delegate = self;
        
        // add the text view
        [self addSubview: textView];


		TiProxy* proxy = [self proxy];
	    if ([proxy _hasListeners:@"loaded"]) {
	        [proxy fireEvent:@"loaded" withObject:nil];
	    }

		

        // entry background image
        id pEntryImage = [[self proxy] valueForKey:@"backgroundImage"];
        if (pEntryImage) {
            NSInteger backgroundLeftCap = [TiUtils intValue:[[self proxy] valueForKey:@"backgroundLeftCap"] def:0],
            backgroundTopCap = [TiUtils intValue:[[self proxy] valueForKey:@"backgroundTopCap"] def:0];
            
            entryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                           self.frame.size.width,
                                                                           self.frame.size.height)];
            NSString* imgName = [[TiHost resourcePath]
                                 stringByAppendingPathComponent:pEntryImage];
            [entryImageView setImage:[[UIImage imageWithContentsOfFile:imgName] stretchableImageWithLeftCapWidth:backgroundLeftCap topCapHeight:backgroundTopCap]];
            [self addSubview: entryImageView];
        }
    }
    else {
        if (lastWidth != frame.size.width) {
            // width has changed (e.g. orientation change)
            CGRect textViewFrame = textView.frame;
            textViewFrame.size.width = frame.size.width;
            textView.frame = textViewFrame;
        }

        CGRect entryImageViewFrame = entryImageView.frame;
        entryImageViewFrame.size = frame.size;
        entryImageView.frame = entryImageViewFrame;
    }
    
    lastWidth = frame.size.width;
    // isEditable
    textView.internalTextView.editable = YES;
}

#pragma mark HPGrowingTextView Delegate


-(BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView
{
        // return key type
        NSInteger wew = [TiUtils intValue:[[self proxy] valueForKey:@"wew"] def:0]>0 ? UIReturnKeySend : UIReturnKeyDefault;
        textView.returnKeyType = wew;
        
        
        return YES;
}


-(void)growingTextView:(HPGrowingTextView*)growingTextView willChangeHeight:(float)height
{
    CGFloat newViewHeight = height > userHeight ? height + topCorrectionPadding : userHeight;
    if (newViewHeight == viewHeight) {
        return;
    }
    viewHeight = newViewHeight;
    
    TiViewProxy* myProxy = (TiViewProxy*)[self proxy];
    [myProxy setHeight:NUMFLOAT(viewHeight)];
    
    
}

-(void)growingTextViewDidChange:(HPGrowingTextView*)growingTextView
{
    RELEASE_TO_NIL(text);
    text = [growingTextView.text retain];
    
    TiProxy* proxy = [self proxy];
    if ([proxy _hasListeners:@"change"]) {
        NSMutableDictionary* event = [NSMutableDictionary dictionary];
        [event setObject:growingTextView.text forKey:@"value"];
        [event setObject:NUMFLOAT(viewHeight) forKey:@"height"];
        [event setObject:NUMINT(textView.internalTextView.contentSize.height / textView.internalTextView.font.lineHeight) forKey:@"lines"];
        [proxy fireEvent:@"change" withObject:event];
    }
}

-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    TiProxy* proxy = [self proxy];
    if ([proxy _hasListeners:@"focus"]) {
        [proxy fireEvent:@"focus" withObject:nil];
    }
}

-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    TiProxy* proxy = [self proxy];
    if ([proxy _hasListeners:@"blur"]) {
        [proxy fireEvent:@"blur" withObject:nil];
    }    
}

-(BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{  
  BOOL shouldChangeText = YES;  
  
  if ([TiUtils intValue:[[self proxy] valueForKey:@"wow"] def:0]==1 && [text isEqualToString:@"\n"]) {  
   	TiProxy* proxy = [self proxy];
    if ([proxy _hasListeners:@"return"]) {
        [proxy fireEvent:@"return" withObject:nil];
        /*textView.text = @"";*/
    }   
    shouldChangeText = NO;  
  }  

  return shouldChangeText;  
} 


#pragma mark public API

-(NSString*)text
{
    if (text) {
        return text;
    }
    return NULL;
}

-(void)setText:(NSString*)pText
{
    if (textView == nil) {
        text = [pText retain];
    }
    else {
        ENSURE_UI_THREAD_1_ARG(pText);
        [textView setText:pText];
    }
}

-(void)focus
{
    if (textView) {
        ENSURE_UI_THREAD_0_ARGS;
        [textView becomeFirstResponder];
    }
}

-(void)blur
{
    if (textView) {
        ENSURE_UI_THREAD_0_ARGS;
        [textView resignFirstResponder];
    }
}

@end
