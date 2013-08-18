//
//  CategoryViewCell.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/15/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRLNBadge;

@interface CategoryViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryDescriptionLabel;
@property (weak, nonatomic) IBOutlet BRLNBadge *categoryBadge;

- (void)applyStyle;

@end
