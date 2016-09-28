//
//  SNAppDelegate.h
//  WeatherReport
//
//  Created by frank on 9/19/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNHomeViewController.h"

@interface SNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)  SNHomeViewController *homeviewController;
@end
