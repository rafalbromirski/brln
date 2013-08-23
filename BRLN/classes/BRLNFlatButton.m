//
//  BRLNFlatButton.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/19/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "BRLNFlatButton.h"

@implementation BRLNFlatButton

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
    
    if (self.highlighted == YES)
    {        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:200.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1.0] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
        
        CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:200.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1.0] CGColor]);
        CGContextFillRect(ctx, buttonRectangle);
    }
    else if (self.enabled == NO)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:200.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:0.4] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:200.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1.0] CGColor]);
        CGContextAddRect(ctx, buttonRectangle);
        CGContextStrokePath(ctx);
    }

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
    [self setTitleColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor _whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:0.4] forState:UIControlStateDisabled];

    [[self titleLabel] setFont:[UIFont fontWithName:@"Lato-Light" size:12.0]];
}

@end
