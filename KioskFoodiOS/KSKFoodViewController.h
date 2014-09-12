//
//  KSKFoodViewController.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/6/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSKFoodData.h"
#import "KSKKioskCommunicator.h"
#import "KSKFoodGalleryContentViewController.h"

@interface KSKFoodViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) KSKFoodData* foodData;


@property (strong, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *foodImage;
@property (strong, nonatomic) KSKKioskCommunicator * kCommunicator;

@property (strong, nonatomic) IBOutlet UIView *galleryContainer;

@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@end
