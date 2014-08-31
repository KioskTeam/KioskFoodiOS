//
//  KSKCategoryData.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSKCategoryData : NSObject
@property (strong, nonatomic) NSString * Name;
@property (strong, nonatomic) NSString * ImageUrl;
@property (strong, nonatomic) NSMutableArray *Foods;

-(id) initWithCategoryName:(NSString *) catName andWithCategoryImageUrl:(NSString * )catImageUrl andWithFoods:(NSMutableArray*)catFoods;
@end
