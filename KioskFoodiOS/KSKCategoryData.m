//
//  KSKCategoryData.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKCategoryData.h"

@implementation KSKCategoryData

-(id) initWithCategoryName:(NSString *) catName andWithCategoryImageUrl:(NSString * )catImageUrl andWithFoods:(NSMutableArray*)catFoods {
    self = [super init];
    
    if(self) {
        self.Name = catName;
        self.ImageUrl = catImageUrl;
        self.Foods = catFoods;
    }
    return self;
}
@end
