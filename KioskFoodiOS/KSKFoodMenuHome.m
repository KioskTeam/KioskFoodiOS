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
#import "KSKPersianAnimator.h"

static NSString *kCell=@"cell";
static int  selectedRow =-1;
KSKKioskCommunicator* kCommunicator;

#define PARALLAX_ENABLED 1

@interface KSKFoodMenuHome ()

@property (assign, nonatomic) NSInteger numberOfCells;
@property(strong, nonatomic) KSKRestaurantData* data ;

@end

@implementation KSKFoodMenuHome

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    kCommunicator = [[KSKKioskCommunicator alloc] init];

    [kCommunicator fetchData:^(KSKRestaurantData *restaurantData)  {
        // Data received!
        
        _data = restaurantData;
        
        if (_data) {
            _numberOfCells = [_data.categoreis count];
        }
        
        [_collectionView reloadData];
    } forceUpdate:NO];
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"B Traffic" size:18], NSFontAttributeName, nil]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MPSkewedCell* cell = (MPSkewedCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];

    NSInteger index = indexPath.row;
    
    KSKCategoryData* cellCategoryData = [_data.categoreis objectAtIndex:index];
    cell.text = cellCategoryData.Name;
   
    // Placeholder Image
    //cell.image = [UIImage imageNamed:@"foodBasket"];
    // Try to get Category image via KSKKioskCommunicator Class 
    [kCommunicator getImage:cellCategoryData.ImageUrl callBackFunc:^(UIImage *reuqestedImage) {
        cell.image = reuqestedImage;
    }];
    
    
    cell.textLabel.font = [UIFont fontWithName:@"B Traffic" size:22.f];
    cell.text= [NSString stringWithFormat:@"%@%@", @"  ", cell.text];
    cell.textLabel.textAlignment = NSTextAlignmentRight;

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    selectedRow = (int)index;
    
    [self performSegueWithIdentifier: @"browseCategorySegue" sender: self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {
    if([segue.identifier isEqualToString:@"browseCategorySegue"]) {
        KSKCategoryTableViewController *controller = (KSKCategoryTableViewController *) segue.destinationViewController;
        KSKCategoryData* catData = [_data.categoreis objectAtIndex:selectedRow];
        
        controller.categoryData = catData;
        controller.kCommunicator = kCommunicator;
        
    }
    
}

- (IBAction)reloadData:(id)sender {
    _numberOfCells = 0;
    
    if(kCommunicator == NULL) {
        kCommunicator = [[KSKKioskCommunicator alloc] init];
    }
    
    [kCommunicator fetchData:^(KSKRestaurantData *restaurantData)  {
        _data = restaurantData;
        
        if (_data) {
            _numberOfCells = [_data.categoreis count];
        }
        
        [_collectionView reloadData];
    } forceUpdate:YES];
    
}



@end
