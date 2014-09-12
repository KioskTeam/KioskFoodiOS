//
//  KSKCategoryCell.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/12/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSKCategoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageTumbnail;
@property (strong, nonatomic) IBOutlet UILabel *txtTitle;
@property (strong, nonatomic) IBOutlet UILabel *txtDescription;

@end
