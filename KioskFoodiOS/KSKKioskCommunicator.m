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

@implementation KSKKioskCommunicator


-(KSKRestaurantData *) fetchData {
    
    KSKRestaurantData* restaurant = [[KSKRestaurantData alloc] init];
    
    
    //TODO : Check if the json file is already exists on Phone, if not download it from server and store it on the Phone!
    //    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"URL TO JSON FILE"]];
    //    NSError* error;
    //    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    
    //Loading Local JSON file From bundle (for TESTING)
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sampleData" ofType:@"json"];
    NSData * fdata = [NSData dataWithContentsOfFile:filePath];
 
    NSError* parsingError ;
    NSDictionary *parsedData = [NSJSONSerialization  JSONObjectWithData:fdata options:kNilOptions  error:&parsingError];
    
    
    if(parsingError){
        // Something is not right!
        
    }
    else {
        
        restaurant.Name = parsedData[@"restaurantName"];
        restaurant.Address = parsedData[@"restaurantAddress"];
        
        NSArray *jsonCategories = parsedData[@"categories"];
        NSMutableArray* restaurantCategoies = [[NSMutableArray alloc] init];
        
        for ( NSDictionary *jsonCat in jsonCategories )
        {
            
            KSKCategoryData * newCategory = [[KSKCategoryData alloc] init];
            newCategory.Name = jsonCat[@"name"];
            newCategory.ImageUrl = jsonCat[@"imageUrl"];
            
            NSMutableArray* foodsInCategory = [[NSMutableArray alloc] init];
            
            for(NSDictionary* jsonFood in jsonCat[@"foods"]) {
                
                KSKFoodData* newFood = [[KSKFoodData alloc] init];
                newFood.name = jsonFood[@"foodName"];
                newFood.thumbnailImageUrl = jsonFood[@"thumbnailImageUrl"];
                newFood.price = (NSInteger) jsonFood[@"foodPrice"];
                
                NSMutableArray* photos = [[NSMutableArray alloc] init];
                
                for (int i =0, n = (int)[jsonFood[@"photos"] count]; i < n; i++) {
                    
                    [photos addObject:  [jsonFood[@"photos"] objectAtIndex:i]];
                }
                
                [foodsInCategory addObject:newFood];
            }
            
            newCategory.Foods = foodsInCategory;
            [restaurantCategoies addObject:newCategory];
           
        }
        
        restaurant.categoreis = restaurantCategoies;
    }

    return restaurant;
}

@end
