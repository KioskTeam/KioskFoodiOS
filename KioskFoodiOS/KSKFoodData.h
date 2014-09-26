//
//  KSKFoodData.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSKFoodData : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger price;
@property (strong, nonatomic) NSString *food_description;
@property  (strong, nonatomic) NSMutableArray *imageUrls;
@property (strong, nonatomic) NSString *thumbnailImageUrl;

-(id)initWithName:(NSString *) foodName andWithPrice:(NSInteger )foodPrice andWithThumbnailImage:(NSString *)foodThumbnailImage andWithPhotos:(NSMutableArray *) images;
@end
