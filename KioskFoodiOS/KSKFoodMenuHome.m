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


#import "KSKFoodData.h"
#import "KSKCategoryData.h"
#import "KSKCategoryTableViewController.h"
#import "KSKKioskCommunicator.h"

static NSString *kCell=@"cell";
static int  selectedRow =-1;

#define PARALLAX_ENABLED 1


@interface KSKFoodMenuHome ()

@property (assign, nonatomic) NSInteger numberOfCells;
@property(strong, nonatomic) KSKRestaurantData* data ;

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
    
    
    _numberOfCells = 0;
    KSKKioskCommunicator* kCommunicator = [[KSKKioskCommunicator alloc] init];

    _data = [kCommunicator fetchData];
    
    if (_data) {
        _numberOfCells = [_data.categoreis count];
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  _numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MPSkewedCell* cell = (MPSkewedCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];

    NSInteger index = indexPath.row;
    
    KSKCategoryData* cellCategoryData = [_data.categoreis objectAtIndex:index];
    cell.text = cellCategoryData.Name;
    cell.image = [UIImage imageNamed:@"foodBasket"];

    selectedRow = (int)index;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier: @"browseCategorySegue" sender: self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {
    if([segue.identifier isEqualToString:@"browseCategorySegue"]) {
        KSKCategoryTableViewController *controller = (KSKCategoryTableViewController *) segue.destinationViewController;
        KSKCategoryData* catData = [_data.categoreis objectAtIndex:selectedRow];
        controller.categoryData = catData;
    }
    
}


@end
