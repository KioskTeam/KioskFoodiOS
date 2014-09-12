//
//  KSKFoodViewController.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/6/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKFoodViewController.h"

@implementation KSKFoodViewController


-(id) init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    if(_foodData) {
        _foodNameLabel.text = _foodData.name;
        
        
        NSString* imageURL = [_foodData.imageUrls objectAtIndex:0];
        
        if(imageURL != nil){
            [_kCommunicator getImage:imageURL callBackFunc:^(UIImage *reuqestedImage) {
                
                _foodImage.image = reuqestedImage;
            }];
        }
    }
}

@end
