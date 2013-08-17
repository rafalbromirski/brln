//
//  PlaceViewCell.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/15/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;

- (void)applyStyle;

@end
