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


@interface KSKCategoryTableViewController ()
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CatCellTableIdentifier = @"categoryCellProtoID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CatCellTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CatCellTableIdentifier];
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    KSKFoodData* fdata = [_categoryData.Foods objectAtIndex:indexPath.row];
    cell.textLabel.text = fdata.name;
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
    }
}
@end
