//
//  KSKKioskCommunicator.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSKRestaurantData.h"

@protocol KSKKioskCommunicatorDelegate;

@interface KSKKioskCommunicator : NSObject

@property (strong, nonatomic) NSMutableDictionary* imagesDic;

-(id) init;

-(void) fetchData:(void (^)(KSKRestaurantData* data)) callBack;
-(void) getImage:(NSString*) imageUrl callBackFunc:(void (^) (UIImage* reuqestedImage)) callBack;

@end
