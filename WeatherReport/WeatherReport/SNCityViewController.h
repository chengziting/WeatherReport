//
//  SNCityViewController.h
//  WeatherReport
//
//  Created by frank on 9/27/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNCityViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (copy,nonatomic) NSString *parentCode;

@property (copy,nonatomic) NSArray  *data;
@property (copy,nonatomic) NSString *name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentController:(UIViewController *)parent;
@end
