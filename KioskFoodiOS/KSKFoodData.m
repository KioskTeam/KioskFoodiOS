//
//  KSKFoodData.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKFoodData.h"

@implementation KSKFoodData


-(id)initWithName:(NSString *) foodName andWithPrice:(NSInteger)foodPrice andWithThumbnailImage:(NSString *)foodThumbnailImage andWithPhotos:(NSMutableArray *) foodImages {
   
    self = [super init];
    
    if(self) {
        self.name = foodName;
        self.price = foodPrice;
        self.thumbnailImageUrl = foodThumbnailImage;
        self.imageUrls = foodImages;
    }
    
    return  self;
}
@end
