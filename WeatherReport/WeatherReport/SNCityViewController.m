//
//  SNCityViewController.m
//  WeatherReport
//
//  Created by frank on 9/27/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNCityViewController.h"
//#import "SNNodeTableViewCell.h"
#import "SNWeatherInfoTableViewCell.h"

@interface SNCityViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIViewController *parent;

-(NSDictionary *)getWeathInfoWithCode:(NSString *)code;
-(void)backTo;
@end

static const NSString *CITY_CELL_VIEW_IDENTIFIER = @"CITY_CELL_VIEW_IDENTIFIER";
static const NSString *WEATHER_API_URL = @"http://www.weather.com.cn/data/cityinfo/";



@implementation SNCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentController:(UIViewController *)parent{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.parent = parent;
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"SNWeatherInfoTableViewCell" bundle:NULL];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CITY_CELL_VIEW_IDENTIFIER];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"<%@",self.name] style:UIBarButtonItemStyleBordered target:self action:@selector(backTo)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SNNodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CITY_CELL_VIEW_IDENTIFIER forIndexPath:indexPath];
    SNWeatherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CITY_CELL_VIEW_IDENTIFIER forIndexPath:indexPath];
    
//    UIView * img = [cell viewWithTag:1];
//    [img setHidden:true];
    NSDictionary *cityDic = self.data[indexPath.row];
    NSString *cityCode ;
    NSString *name;
    NSString *code;
    if(self.parentCode.intValue <= 10104){
        cityCode = [NSString stringWithFormat:@"%@%@00",self.parentCode,cityDic[@"code"]];
        
        name = self.data[indexPath.row][@"list"][0][@"name"];
        code = self.data[indexPath.row][@"list"][0][@"code"];
    }
    else{
        cityCode = [NSString stringWithFormat:@"%@%@01",self.parentCode,cityDic[@"code"]];
        name = cityDic[@"name"];
        code = cityDic[@"code"];
    }
    
    NSDictionary *weatherinfo = [self getWeathInfoWithCode:cityCode];
    if(weatherinfo != nil){
        [cell setWeatherInfoWithName:name code:code weatherInfo:weatherinfo];
    }

    return cell;
}

-(void)backTo{
//    [self.navigationController popToRootViewControllerAnimated:true];
    
    [self.navigationController popToViewController:self.parent animated:true];
}

-(NSDictionary *)getWeathInfoWithCode:(NSString *)code{
    if(code == nil)
        return nil;
    @try {
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.html",WEATHER_API_URL,code]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3];
        //NSData *data = [NSData dataWithContentsOfURL:url];
        
        //异步请求
        
//         [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
//         completionHandler:^(NSURLResponse *response,NSData *data,NSError *connectionErr){
//         if(data){
//         
//         }
//         }];
        
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(![result isKindOfClass:[NSDictionary class]]){
            return nil;
        }
        return [result objectForKey:@"weatherinfo"];
    }
    @catch (NSException *exception) {
        NSLog(exception);
        return nil;
    }
}

@end
