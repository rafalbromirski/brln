//
//  PlaceViewCell.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/15/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "PlaceViewCell.h"

@implementation PlaceViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self applyStyle];
}

- (void)applyStyle
{
    [[self placeNameLabel] setFont:[UIFont fontWithName:@"Lato-Bold" size:self.placeNameLabel.font.pointSize]];
    [[self placeNameLabel] setTextColor:[UIColor colorWithRed:57.0/255.0 green:65.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [self setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-disclosure"]]];    
}

@end
