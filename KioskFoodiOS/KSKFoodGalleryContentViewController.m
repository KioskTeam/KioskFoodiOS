//
//  KSKFoodGalleryContentViewController.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/12/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKFoodGalleryContentViewController.h"

@implementation KSKFoodGalleryContentViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    if(_kCommunicator != nil) {
        if(self.imageURL != nil){
            [_kCommunicator getImage:self.imageURL callBackFunc:^(UIImage *reuqestedImage) {
                self.backgroundImageView.image = reuqestedImage;
            }];
        }
        
    }
}

@end
