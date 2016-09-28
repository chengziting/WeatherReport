//
//  SNHomeViewController.h
//  WeatherReport
//
//  Created by frank on 9/19/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNHomeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
