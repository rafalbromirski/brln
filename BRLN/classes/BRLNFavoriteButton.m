//
//  BRLNFavoriteButton.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/18/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "BRLNFavoriteButton.h"

@implementation BRLNFavoriteButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self setImage:[UIImage imageNamed:@"favorite-button"] forState:UIControlStateNormal];
        // [self setImage:[UIImage imageNamed:@"favorite-button"] forState:UIControlStateNormal | UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"favorite-button-selected"] forState:UIControlStateSelected];
        // [self setImage:[UIImage imageNamed:@"favorite-button-selected"] forState:UIControlStateSelected | UIControlStateHighlighted];
        
        [self setAdjustsImageWhenHighlighted:NO];
        [self addTarget:self action:@selector(toggleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)toggleClick:(id)selector
{
    BOOL selected = [self isSelected];
    [self setSelected:(selected ? NO : YES)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
