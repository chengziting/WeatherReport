//
//  SNJsonUtils.h
//  WeatherReport
//
//  Created by frank on 9/26/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNNode.h"

@interface SNJsonUtils : NSObject

-(NSArray *) getProvinces;
-(NSArray *) getCitysWithProvinceCode :(NSString *)provinceCode;
-(NSArray *) getAreasWithProvinceCode :(NSString *)provinceCode :(NSString *)cityCode;

@end
