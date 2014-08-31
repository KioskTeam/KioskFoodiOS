//
//  KSKKioskCommunicatorDelegate.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KSKKioskCommunicatorDelegate <NSObject>
-(void) receivedFoodsJSON:(NSData* ) json;
-(void) fetchingFoodsFailedWithError:(NSError*) error;
@end
