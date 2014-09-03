//
//  KSKKioskCommunicator.m
//  KioskFoodiOS
//
//  Created by Mohmmad Reza Taesiri on 8/31/14.
//  Copyright (c) 2014 Kiosk Team. All rights reserved.
//

#import "KSKKioskCommunicator.h"

#import "KSKRestaurantData.h"
#import "KSKCategoryData.h"
#import "KSKFoodData.h"

static  NSString *const TAG_RESTAURANT_NAME = @"Name";
static  NSString *const TAG_RESTAURANT_ADDRESS = @"Address";
static  NSString *const TAG_CATEGORIES = @"Categories";
static  NSString *const TAG_NAME = @"Name";
static  NSString *const TAG_IMAGE = @"Image";
static  NSString *const TAG_FOODS = @"Foods";
static  NSString *const TAG_PRICE = @"Price";
static  NSString *const TAG_THUMBNAIL = @"Thumbnail";
static  NSString *const TAG_PICTURES = @"Pictures";

@implementation KSKKioskCommunicator


-(void) fetchData:(void (^)(KSKRestaurantData *))callBack {
    
    
    //TODO : Check if the json file is already exists on Phone, if not download it from server and store it on the Phone!
 
    //Loading Local JSON file From bundle (for TESTING)
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sampleData" ofType:@"json"];
    //NSData * fdata = [NSData dataWithContentsOfFile:filePath];
    // return restaurant;
    
    KSKRestaurantData* restaurant = [[KSKRestaurantData alloc] init];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://secure-scrubland-8071.herokuapp.com/api/latest"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSError * parseError;
        NSDictionary *parsedData = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions  error:&parseError];
       
        
        if(parseError){
            // Something is not right!
            
        }
        else {
            
            restaurant.Name = parsedData[TAG_RESTAURANT_NAME];
            restaurant.Address = parsedData[TAG_RESTAURANT_ADDRESS];
            
            NSArray *jsonCategories = parsedData[TAG_CATEGORIES];
            NSMutableArray* restaurantCategoies = [[NSMutableArray alloc] init];
            
            for ( NSDictionary *jsonCat in jsonCategories )
            {
                
                KSKCategoryData * newCategory = [[KSKCategoryData alloc] init];
                newCategory.Name = jsonCat[TAG_NAME];
                newCategory.ImageUrl = jsonCat[TAG_IMAGE];
                
                NSMutableArray* foodsInCategory = [[NSMutableArray alloc] init];
                
                for(NSDictionary* jsonFood in jsonCat[TAG_FOODS]) {
                    
                    KSKFoodData* newFood = [[KSKFoodData alloc] init];
                    newFood.name = jsonFood[TAG_NAME];
                    newFood.thumbnailImageUrl = jsonFood[TAG_THUMBNAIL];
                    newFood.price = (NSInteger) jsonFood[TAG_PRICE];
                    
                    NSMutableArray* photos = [[NSMutableArray alloc] init];
                    
                    for (int i =0, n = (int)[jsonFood[TAG_PICTURES] count]; i < n; i++) {
                        
                        [photos addObject:  [jsonFood[TAG_PICTURES] objectAtIndex:i]];
                    }
                    
                    [foodsInCategory addObject:newFood];
                }
                
                newCategory.Foods = foodsInCategory;
                [restaurantCategoies addObject:newCategory];
                
            }
            restaurant.categoreis = restaurantCategoies;
        }
        
        callBack(restaurant);
    }];
    
}

@end
