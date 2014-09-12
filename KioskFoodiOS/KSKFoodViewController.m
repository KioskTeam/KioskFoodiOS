//
//  KSKFoodViewController.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/6/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKFoodViewController.h"

@implementation KSKFoodViewController


-(id) init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    if(_foodData) {
        //        _foodNameLabel.text = _foodData.name;
        //
       
        self.pageImages = _foodData.imageUrls;
        self.foodNameLabel.text = _foodData.name;
        
        
        // Create page view controller
        self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FoodGalleryPageViewController"];
        self.pageViewController.dataSource = self;
        
        KSKFoodGalleryContentViewController *startingViewController = [self viewControllerAtIndex:0];
        if(startingViewController != nil) {
            NSArray *viewControllers = @[startingViewController];
            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            
            // Change the size of page view controller
            self.pageViewController.view.frame = CGRectMake(0, 0, self.galleryContainer.frame.size.width, self.galleryContainer.frame.size.height);
            
            [self addChildViewController:_pageViewController];
            [self.galleryContainer addSubview:_pageViewController.view];
            [self.pageViewController didMoveToParentViewController:self];
            
        }
        
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((KSKFoodGalleryContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((KSKFoodGalleryContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (KSKFoodGalleryContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    KSKFoodGalleryContentViewController *pageContent = [self.storyboard instantiateViewControllerWithIdentifier:@"KSKFoodGalleryContentViewController"];
    pageContent.imageURL = self.pageImages[index];
    pageContent.kCommunicator = self.kCommunicator;
    pageContent.pageIndex = index;
    
    return pageContent;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
