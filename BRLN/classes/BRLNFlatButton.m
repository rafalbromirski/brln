//
//  BRLNFlatButton.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/19/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "BRLNFlatButton.h"

@implementation BRLNFlatButton

@synthesize text = _text;

@synthesize textColor = _textColor;
@synthesize textHighlightedColor = _textHighlightedColor;
@synthesize textDisabledColor = _textDisabledColor;

@synthesize borderColor = _borderColor;
@synthesize borderHighlightedColor = _borderHighlightedColor;
@synthesize borderDisabledColor = _borderDisabledColor;

@synthesize backgroundColor = _backgroundColor;
@synthesize backgroundHighlightedColor = _backgroundHighlightedColor;
@synthesize backgroundDisabledColor = _backgroundDisabledColor;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self applyStyle];
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGSize size = self.bounds.size;
    CGRect buttonRectangle = CGRectMake(0, 0, size.width, size.height);
    
    UIColor *buttonTitleColor = nil;
    UIFont *buttonFont = [UIFont fontWithName:@"Lato-Light" size:12.0];
    NSString *buttonTitle = [self text];
    CGSize buttonTitleSize = [buttonTitle sizeWithFont:buttonFont constrainedToSize:buttonRectangle.size];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.highlighted == YES)
    {                
        CGContextSetFillColorWithColor(ctx, [[self backgroundHighlightedColor] CGColor]);
        CGContextFillRect(ctx, buttonRectangle);
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[self borderHighlightedColor] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
        
        buttonTitleColor = [self textHighlightedColor];
    }
    else if (self.enabled == NO)
    {        
        CGContextSetFillColorWithColor(ctx, [[self backgroundDisabledColor] CGColor]);
        CGContextFillRect(ctx, buttonRectangle);
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[self borderDisabledColor] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
        
        buttonTitleColor = [self textDisabledColor];
    }
    else
    {
        CGContextSetFillColorWithColor(ctx, [[self backgroundColor] CGColor]);
        CGContextFillRect(ctx, buttonRectangle);
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[self borderColor] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
        
        buttonTitleColor = [self textColor];
    }
    
    NSLog(@"color: %@", buttonTitleColor);
    
    CGContextSetFillColorWithColor(ctx, [buttonTitleColor CGColor]);
    [buttonTitle drawInRect:CGRectMake( (buttonRectangle.size.width / 2) - (buttonTitleSize.width / 2) , (buttonRectangle.size.height / 2) - (buttonTitleSize.height / 2), buttonTitleSize.width, buttonTitleSize.height) withFont:buttonFont lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];

    // helpers:
    //    NSString *buttonTitle = @"test";
    //    [buttonTitle drawInRect:buttonRectangle withFont:[UIFont fontWithName:@"Lato-Light" size:12.0]];
    //    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //    CGContextFillRect(context, buttonRectangle);
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"highlighted"];
}

- (void)applyStyle
{
    self.backgroundColor = [UIColor _whiteColor];
    self.backgroundHighlightedColor = [UIColor colorWithRed:200.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1.0];
    self.backgroundDisabledColor = [self backgroundColor];
    
    self.textColor = [UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0];
    self.textHighlightedColor = [self backgroundColor];
    self.textDisabledColor = [[self textColor] colorWithAlphaComponent:0.4];
    
    self.borderColor = [self backgroundHighlightedColor];
    self.borderHighlightedColor = [self borderColor];
    self.borderDisabledColor = [[self borderColor] colorWithAlphaComponent:0.4];
}

@end
