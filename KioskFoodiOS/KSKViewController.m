//
//  KSKViewController.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/27/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKViewController.h"
#import <pop/POP.h>


@interface KSKViewController ()
@property (assign, readwrite) BOOL isRuuning;
@end

@implementation KSKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _isRuuning = NO;
}

- (IBAction)tapped:(id)sender {
    
    // Toggle isRunning property
    _isRuuning = !_isRuuning;
    
    //Disabling tap gesture recognizer for preventing continuous taps!
    [_tapRec setEnabled:NO];
    
    [_kioskFoodLabel.layer pop_removeAllAnimations];
    
    POPSpringAnimation  *kioskAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    
    if(_isRuuning){
        kioskAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(55, 56)];
    }
    else{
        kioskAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 36)];
    }
    
    kioskAnimation.springBounciness = 10.0;
    kioskAnimation.springSpeed = 1.0;
    
    // Animation Completion Callback
    kioskAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"Animation has completed.");
        // Enabling tap gesture recognizer
        [_tapRec setEnabled:YES];
    };
    
    // Applying animation to our Label
    [_kioskFoodLabel.layer pop_addAnimation:kioskAnimation forKey:@"pop"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
