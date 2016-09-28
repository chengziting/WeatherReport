//
//  SNWeatherInfoTableViewCell.h
//  WeatherReport
//
//  Created by frank on 9/28/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNWeatherInfoTableViewCell : UITableViewCell

-(void) setWeatherInfoWithName:(NSString *) name code:(NSString *)code weatherInfo:(NSDictionary *)weatherInfo;

@end
