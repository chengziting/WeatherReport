//
//  SNJsonUtils.m
//  WeatherReport
//
//  Created by frank on 9/26/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNJsonUtils.h"

@interface SNJsonUtils ()
+(NSString *) getJsonString;
@end

static NSMutableArray *provinceArray ;

@implementation SNJsonUtils

+(void)initialize{
    NSData *jsonData = [[self getJsonString] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
    if([result isKindOfClass:[NSDictionary class]]){
        provinceArray = [result objectForKey:@"Provinces"];
//        provinceArray = [provinceArray sortedArrayUsingSelector:@selector(compare:)];
    }
}

+(NSString *)getJsonString{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"json"];
    return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
}


-(NSArray *)getProvinces{
    if(provinceArray == nil)
        return nil;
    
    return [provinceArray copy];
}

-(NSArray *)getCitysWithProvinceCode:(NSString *)provinceCode{
    if(provinceArray == nil)
        return nil;
    NSArray *arr;
    for(NSDictionary *dic in provinceArray){
        if([provinceCode isEqualToString:[dic objectForKey:@"code"]]){
            arr = [dic objectForKey:@"list"];
            break;
        }
    }
    return arr;
}

-(NSArray *)getAreasWithProvinceCode:(NSString *)provinceCode :(NSString *)cityCode{
    if(provinceArray == nil)
        return nil;
    NSArray *arr;
    NSArray *citys;
    for(NSDictionary *province in provinceArray){
        if([provinceCode isEqualToString:province[@"code"]]){
            citys = [province objectForKey:@"list"];
            break;
        }
    }
    
    if(citys != nil){
        for(NSDictionary * city in citys){
            if([cityCode isEqualToString:city[@"code"]]){
                arr = [city objectForKey:@"list"];
                break;
            }
        }
    }
    return arr;
}

@end
