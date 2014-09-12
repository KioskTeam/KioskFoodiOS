//
//  KSKCategoryTableViewController.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSKCategoryData.h"
#import "KSKKioskCommunicator.h"

@interface KSKCategoryTableViewController : UITableViewController
@property (strong, nonatomic) KSKCategoryData* categoryData;
@property (strong, nonatomic) KSKKioskCommunicator * kCommunicator;
@end
