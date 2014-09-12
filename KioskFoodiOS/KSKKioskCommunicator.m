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
static  NSString *const ASSET_FOLDER = @"assets";
static  NSString *const LOCAL_DATA_DIRECTORY = @"data";
static  NSString *const LOCAL_DATA_FILE_NAME = @"data.json";

NSString* DocumentDirectory;
NSString* AssetsDirectory;
NSString* DataDirectory;

@implementation KSKKioskCommunicator

-(id) init{
    self = [super init];
    
    if(self) {
        _imagesDic = [[NSMutableDictionary alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        DocumentDirectory = [paths objectAtIndex:0];
        AssetsDirectory = [NSString stringWithFormat:@"%@/%@/", [paths objectAtIndex:0], ASSET_FOLDER];
        DataDirectory = [NSString stringWithFormat:@"%@/%@/", [paths objectAtIndex:0], LOCAL_DATA_DIRECTORY];
        
        
        //Directory Check
        [[NSFileManager defaultManager] createDirectoryAtPath:AssetsDirectory withIntermediateDirectories:YES  attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:DataDirectory withIntermediateDirectories:YES  attributes:nil error:nil];
        
        // getting all locally stored images
        NSError *error;
        NSArray *storedImages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:AssetsDirectory error:&error];
        if(!error) {
            for (int i = 0, n = (int)[storedImages count]; i < n ; i++) {
                if(![[storedImages objectAtIndex:i] isEqual:@".DS_Store"])
                {
                    NSString * fullImagePath =[NSString stringWithFormat:@"%@/%@", AssetsDirectory, [storedImages objectAtIndex:i]];
                    
                    UIImage* rIamge = [UIImage imageWithContentsOfFile:fullImagePath];
                    
                    [_imagesDic setObject:rIamge forKey:[storedImages objectAtIndex:i]];
                }
            }
        }
    }
    
    return self;
}

-(void) fetchData:(void (^)(KSKRestaurantData *))callBack forceUpdate:(BOOL)force{
    // Check if local Copy of file is already exists
    NSString* localJSONFullPath =[NSString stringWithFormat:@"%@%@", DataDirectory, LOCAL_DATA_FILE_NAME];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localJSONFullPath];

    if(fileExists && !force) {
        
        NSData * fdata = [NSData dataWithContentsOfFile:localJSONFullPath];
        [self parseJsonData:fdata callBackFunc:callBack];
        
        
    } else {
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:REMOTE_API_URL]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [self parseJsonData:data callBackFunc:callBack];
            
            [data writeToFile:localJSONFullPath atomically:YES];
            
        }];
    }
}

-(void) parseJsonData:(NSData *)jsonFile callBackFunc:(void (^)(KSKRestaurantData *))callBack   {
    
    KSKRestaurantData* restaurant = [[KSKRestaurantData alloc] init];
    
    NSError * parseError;
    NSDictionary *parsedData = [NSJSONSerialization  JSONObjectWithData:jsonFile options:kNilOptions  error:&parseError];
    
    
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
                
                newFood.imageUrls = photos;
                
                [foodsInCategory addObject:newFood];
            }
            
            newCategory.Foods = foodsInCategory;
            [restaurantCategoies addObject:newCategory];
            
        }
        restaurant.categoreis = restaurantCategoies;
    }
    
    callBack(restaurant);
}


-(void) getImage:(NSString*) imageUrl callBackFunc:(void (^) (UIImage* reuqestedImage)) callBack {
    
    NSArray *parts = [imageUrl componentsSeparatedByString:@"/"];
    UIImage* requestedImage = _imagesDic[[parts objectAtIndex:(int)[parts count]-1]];
    
    if(requestedImage) {
        //Already in image pool
        callBack(requestedImage);
    } else {
        // Image not existed!
    
        NSString * urlToGet = [NSString stringWithFormat:@"%@%@", REMOTE_IMAGE_POOL_DIRECTORY, imageUrl];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,  0ul);
        dispatch_async(queue, ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlToGet]];
            UIImage *image = [UIImage imageWithData:data];
            
            // Save image
            // for now i assume all images are in JPG format
            
            NSString *pathForSave = [NSString stringWithFormat:@"%@%@", DocumentDirectory, imageUrl];
            [UIImageJPEGRepresentation(image, 1.0) writeToFile:pathForSave atomically:YES];
            [_imagesDic setObject:image forKey:[parts objectAtIndex:(int)[parts count]-1]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(image);
            });
        });
    }
    
}

@end
