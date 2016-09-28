//
//  SNWeatherInfoTableViewCell.m
//  WeatherReport
//
//  Created by frank on 9/28/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNWeatherInfoTableViewCell.h"

@interface SNWeatherInfoTableViewCell ()
@property (copy,nonatomic) NSString         *name;
@property (copy,nonatomic) NSString         *code;
@end

static const NSString *WEATHER_ICON_URL = @"http://www.weather.com.cn/m2/i/weatherpic/29x20/";

@implementation SNWeatherInfoTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setWeatherInfoWithName:(NSString *)name code:(NSString *)code weatherInfo:(NSDictionary *)weatherInfo{
    self.name = [name copy];
    self.code = [code copy];
    CGRect rect = self.frame;
    NSLog(@"x=%f,y=%f,width=%f,height=%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
//    UILabel *labelCityName = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 100, rect.size.height-10)];
//    [labelCityName setText:[NSString stringWithFormat:@" %@  %@  %@ ",name,weatherInfo[@"weather"],weatherInfo[@"temp2"]]];
//    [labelCityName setTextColor:[UIColor blackColor]];
//    [self.window addSubview:labelCityName];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEATHER_ICON_URL,weatherInfo[@"img2"]]];
//    NSData * imgData = [NSData dataWithContentsOfURL:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* imgData, NSError* connectionError){
        UIImage *img = [UIImage imageWithData:imgData];
        UIImageView *imgView = [self viewWithTag:2];
        [imgView setImage:img];
    }];
    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    imgView.frame = CGRectMake(
//                               labelCityName.frame.origin.x + labelCityName.frame.size.width + 10, 3,
//                               rect.size.width - (labelCityName.frame.size.width + 13), rect.size.height - 10);
//    [self.window addSubview:imgView];
    
    UILabel *labelInfo = [self viewWithTag:1];
    [labelInfo setText:[NSString stringWithFormat:@" %@  %@  %@ ",name,weatherInfo[@"weather"],weatherInfo[@"temp2"]]];
}



@end
