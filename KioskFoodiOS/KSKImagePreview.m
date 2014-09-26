//
//  KSKImagePreview.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 9/15/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKImagePreview.h"

@implementation KSKImagePreview


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor grayColor];
    [self addImageView];
    [self addDismissButton];
}

#pragma mark - Private Instance methods

-(void) addImageView {
    
    UIImageView *imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 280)];
    imagePreview.backgroundColor = [UIColor grayColor];
    
    imagePreview.contentMode = UIViewContentModeScaleAspectFill;
    imagePreview.image = self.theImage;
    imagePreview.layer.cornerRadius = 8.f;
    imagePreview.layer.masksToBounds = YES;
    
    [self.view addSubview:imagePreview];
}

- (void)addDismissButton {
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dismissButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
