//
//  KSKCategoryTableViewController.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKCategoryTableViewController.h"
#import "KSKFoodData.h"
#import "KSKFoodViewController.h"
#import "KSKCategoryCell.h"
#import "KSKPersianAnimator.h"
#import "KSKImagePreview.h"
#import "KSKDismissingAnimator.h"

@interface KSKCategoryTableViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation KSKCategoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBackButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_categoryData.Foods count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CatCellTableIdentifier = @"categoryCellProtoID";
    
    KSKCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CatCellTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[KSKCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CatCellTableIdentifier];
        cell.backgroundColor = [UIColor redColor];
    }
    
    KSKFoodData* fdata = [_categoryData.Foods objectAtIndex:indexPath.row];
    [cell txtTitle].text = fdata.name;
    [cell txtDescription].text = @"Food Description";
    [_kCommunicator getImage:fdata.thumbnailImageUrl callBackFunc:^(UIImage *reuqestedImage) {
        [cell imageTumbnail].image = reuqestedImage;
    }];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPreview:)];
    singleTap.numberOfTapsRequired = 1;
    [cell imageTumbnail].userInteractionEnabled = YES;
    [[cell imageTumbnail] addGestureRecognizer:singleTap];

    
    
    
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {
  
    if([segue.identifier isEqualToString:@"browseFoodSegue"]) {
        KSKFoodViewController *controller = (KSKFoodViewController *) segue.destinationViewController;
    
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        int selectedRow = (int)index.row;
        
        
        KSKFoodData* selectedFoodData = [_categoryData.Foods objectAtIndex:selectedRow];
        controller.navigationItem.title = selectedFoodData.name;
        controller.foodData = selectedFoodData;
        controller.kCommunicator = _kCommunicator;
    }
}

-(void) showPreview:(id)sender {
    
    KSKImagePreview *modalViewController = [KSKImagePreview new];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    
    UIImageView *theImageView = (UIImageView *)[sender view];
    modalViewController.theImage = theImageView.image;
    
    [self.navigationController presentViewController:modalViewController animated:YES completion:NULL];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [KSKPersianAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [KSKDismissingAnimator new];
}

@end
