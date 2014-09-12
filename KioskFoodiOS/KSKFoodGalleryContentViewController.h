//
//  KSKFoodGalleryContentViewController.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/12/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSKKioskCommunicator.h"

@interface KSKFoodGalleryContentViewController : UIViewController

@property NSUInteger pageIndex;
@property NSString* imageURL;

@property (strong, nonatomic) KSKKioskCommunicator * kCommunicator;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
