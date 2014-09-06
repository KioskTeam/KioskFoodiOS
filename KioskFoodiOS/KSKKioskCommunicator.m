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
static  NSString *const REMOTE_IMAGE_POOL_DIRECTORY =@"http://secure-scrubland-8071.herokuapp.com";
static  NSString *const REMOTE_API_URL = @"http://secure-scrubland-8071.herokuapp.com/api/latest";
@implementation KSKKioskCommunicator


-(void) fetchData:(void (^)(KSKRestaurantData *))callBack {
    
    
    //TODO : Check if the json file is already exists on Phone, if not download it from server and store it on the Phone!
 
    //Loading Local JSON file From bundle (for TESTING)
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sampleData" ofType:@"json"];
    //NSData * fdata = [NSData dataWithContentsOfFile:filePath];
    // return restaurant;
    
    KSKRestaurantData* restaurant = [[KSKRestaurantData alloc] init];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:REMOTE_API_URL]];
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
                    //newFood.price = (NSInteger) jsonFood[TAG_PRICE];
                    
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


-(void) getImage:(NSString*) imageUrl callBackFunc:(void (^) (UIImage* reuqestedImage)) callBack {
    NSString * urlToGet = [NSString stringWithFormat:@"%@%@", REMOTE_IMAGE_POOL_DIRECTORY, imageUrl];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,  0ul);
    dispatch_async(queue, ^{
        
        // Check if image is already exists!
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [NSString stringWithFormat:@"%@%@", [paths objectAtIndex:0], imageUrl];
        NSLog(@"%@", filePath);
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        UIImage *image;
        if(fileExists) {
            NSData* imageData = [NSData dataWithContentsOfFile:filePath];
            
            image = [UIImage imageWithData:imageData];
            
            NSLog(@"File Already Exists!");
        } else {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlToGet]];
            image = [UIImage imageWithData:data];
            // Save image
            // for now i assume all images are in JPG format
            
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@%@", [paths objectAtIndex:0], @"assets"]
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
            
            [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(image);
        });
    });
    
}

@end
