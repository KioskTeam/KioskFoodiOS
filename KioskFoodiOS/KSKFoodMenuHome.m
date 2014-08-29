//
//  KSKFoodMenuHome.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/29/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKFoodMenuHome.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"


static NSString *kCell=@"cell";


#define PARALLAX_ENABLED 1


@interface KSKFoodMenuHome ()

@end

@implementation KSKFoodMenuHome

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
#ifndef PARALLAX_ENABLED
    // you can use that if you don't need parallax
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(self.view.width, 230);
    layout.minimumLineSpacing=-layout.itemSize.height/3; // must be always the itemSize/3
    //use the layout you want as soon as you recalculate the proper spacing if you made different sizes
#else
    
    MPSkewedParallaxLayout *layout=[[MPSkewedParallaxLayout alloc] init];
    
    
#endif
    
    
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCell];
    [self.view addSubview:_collectionView];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MPSkewedCell* cell = (MPSkewedCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    
    //cell.image=[UIImage imageNamed:[NSString stringWithFormat:@"%li",(long) (choosed>=0 ? choosed : indexPath.item%5+1)]];
    
    cell.image = [UIImage imageNamed:@"foodBasket"];
    
    NSString *text;
    
    NSInteger index = indexPath.row;
    
    switch (index) {
        case 0:
            text=@"Burgers\n aaa";
            break;
        case 1:
            text=@"Sandwiches\n bbb";
            break;
        case 2:
            text=@"Appetizers\n ccc";
            break;
        case 3:
            text=@"Desserts\n ddd";
            break;
        case 4:
            text=@"Coffee & Tea\n eee";
            break;
        case 5:
            text=@"Drinks\n fff";
            break;
        case 6:
            text=@"Gallery\n ggg";
            break;
            
        default:
            break;
            
    }
    
    cell.text=text;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"item %li",(long)indexPath.item);
    
//    NSInteger bk=choosed;
//    
//    if(choosed==-1)
//        choosed=indexPath.item;
//    else choosed=-1;
//    
//    NSMutableArray *arr=[[NSMutableArray alloc] init];
//    
//    for (NSInteger i=0; i<30; i++) {
//        if (i!=choosed && i!=bk) {
//            [arr addObject:[NSIndexPath indexPathForItem:i inSection:0]];
//        }
//    }
//    
//    [collectionView performBatchUpdates:^{
//        if (choosed==-1) {
//            [collectionView insertItemsAtIndexPaths:arr];
//        }else [collectionView deleteItemsAtIndexPaths:arr];
//    } completion:^(BOOL finished) {
//        
//    }];
//    
    
}

@end
