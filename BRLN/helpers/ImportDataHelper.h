//
//  ImportDataHelper.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/7/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImportDataHelper : NSObject

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;
- (void)importData;

@end