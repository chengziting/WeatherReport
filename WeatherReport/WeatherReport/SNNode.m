//
//  SNNode.m
//  WeatherReport
//
//  Created by frank on 9/26/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNNode.h"

@interface SNNode ()

@end

@implementation SNNode

-(id)initWithName:(NSString *)name :(NSString *)code :(NSInteger *)level{
    self = [super init];
    _name = [name copy];
    _code = [code copy];
    _level = level;
    self.children = [[NSMutableArray alloc] init];
    return self;
}

-(void)addChild:(SNNode *)child{
    if(child != nil){
        if(![self.children containsObject:child]){
            [self.children addObject:child];
        }
    }
}

@end
