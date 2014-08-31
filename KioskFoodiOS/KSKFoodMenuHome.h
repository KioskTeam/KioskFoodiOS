//
//  KSKFoodMenuHome.h
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/29/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSKFoodMenuHome : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate> {
    UICollectionView *_collectionView;
    NSInteger choosed;

}

@end
