//
//  KSKRestaurantData.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSKRestaurantData : NSObject
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSMutableArray *categoreis;
@end
