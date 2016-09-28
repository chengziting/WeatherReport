//
//  SNHomeTableViewCell.m
//  WeatherReport
//
//  Created by frank on 9/20/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNNodeTableViewCell.h"
@interface SNNodeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *labelProvince;

@end

@implementation SNNodeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString *)pro{
    if(![pro isEqualToString:_name]){
        _name = [pro copy];
        self.labelProvince.text = _name;
    }
}


@end
