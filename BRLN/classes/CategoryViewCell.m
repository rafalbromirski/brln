//
//  CategoryViewCell.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/15/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "CategoryViewCell.h"
#import "BRLNBadge.h"

@implementation CategoryViewCell

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
    [[self categoryNameLabel] setFont:[UIFont fontWithName:@"Lato-Bold" size:self.categoryNameLabel.font.pointSize]];
    [[self categoryNameLabel] setTextColor:[UIColor colorWithRed:57.0/255.0 green:65.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [[self categoryDescriptionLabel] setFont:[UIFont fontWithName:@"Lato-Bold" size:self.categoryDescriptionLabel.font.pointSize]];
    [[self categoryDescriptionLabel] setTextColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0]];
    
    [[self categoryBadge] setHorizontalAlignment:LKBadgeViewHorizontalAlignmentRight];
    [[self categoryBadge] setFont:[UIFont fontWithName:@"Lato-Bold" size:10.0]];
    [[self categoryBadge] setBadgeColor:[UIColor colorWithRed:158.0/255.0 green:177.0/255.0 blue:191.0/255.0 alpha:1.0]];

    [self setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-disclosure"]]];
}

@end
