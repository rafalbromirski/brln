//
//  BRLNFlatButton.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/19/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRLNFlatButton : UIButton

@property (nonatomic, copy) NSString *text;

@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *textHighlightedColor;
@property (nonatomic, retain) UIColor *textDisabledColor;

@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *borderHighlightedColor;
@property (nonatomic, retain) UIColor *borderDisabledColor;

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *backgroundHighlightedColor;
@property (nonatomic, retain) UIColor *backgroundDisabledColor;

- (void)applyStyle;

@end
