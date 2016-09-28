//
//  SNCityFinder.h
//  WeatherReport
//
//  Created by frank on 9/28/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SNCityFinder : NSObject <CLLocationManagerDelegate>
//singleton
+(instancetype) getInstance;

-(NSString *) getLocalCity;
@end
