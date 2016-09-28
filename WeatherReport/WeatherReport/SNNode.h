//
//  SNNode.h
//  WeatherReport
//
//  Created by frank on 9/26/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNode : NSObject
@property (copy,nonatomic) NSString             *name;
@property (copy,nonatomic) NSString             *code;
@property (nonatomic)      NSInteger            *level;

@property (copy,nonatomic) NSMutableArray       *children;


-(id) initWithName:(NSString *)name :(NSString *)code :(NSInteger *)level;
-(void) addChild:(SNNode *) child;
@end
