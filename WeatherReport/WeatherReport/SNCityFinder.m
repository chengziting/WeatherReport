//
//  SNCityFinder.m
//  WeatherReport
//
//  Created by frank on 9/28/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNCityFinder.h"

static id _instance;

static CLLocationManager *locationManager;
static float defaultLatitude =31.221517;
static float defaultLongitude = 121.544379;

@interface SNCityFinder ()

@end

@implementation SNCityFinder

+(instancetype)getInstance{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^(){
        NSLog(@"create the singleton instance");
        _instance = [[self alloc] init];
        
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDistanceFilter:CLLocationDistanceMax];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];
        
    });
    return _instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(){
        _instance = [super allocWithZone:zone];
    
    });
    return _instance;
}


-(NSString *)getLocalCity{
    CLLocationCoordinate2D coordinate2d = locationManager.location.coordinate;
    NSLog([NSString stringWithFormat:@"latitude=%f,longitude=%f",coordinate2d.latitude,coordinate2d.longitude]);
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=csv",
                           coordinate2d.latitude==0?defaultLatitude:coordinate2d.latitude, coordinate2d.longitude==0?defaultLongitude:coordinate2d.longitude];
    NSError* error;
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSLog([NSString stringWithFormat:@"location is %@",locationString]);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:defaultLatitude longitude:defaultLongitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks[0];
        NSDictionary *addressDictionary = [placemark addressDictionary];
        NSString *city ;
        NSString *country;

        city = addressDictionary[@"City"];
        country = addressDictionary[@"Country"];
        NSLog(@"Country is %@,City is %@",country,city);
    }];
    
    
    return locationString;
}

@end
