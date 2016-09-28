//
//  SNHomeViewController.m
//  WeatherReport
//
//  Created by frank on 9/19/16.
//  Copyright (c) 2016 spiritnet. All rights reserved.
//

#import "SNHomeViewController.h"
#import "SNNodeTableViewCell.h"
#import "SNJsonUtils.h"
#import "SNCityViewController.h"
#import "SNCityFinder.h"

@interface SNHomeViewController ()
//@property (copy,nonatomic) NSMutableArray *datas;
@property (strong,nonatomic) SNJsonUtils *jsonUtils;

-(void)initTableViewSize;
-(NSString *)documentsPath:(NSString *)fileName;

-(void)getLocalCity;

@end

@implementation SNHomeViewController

const static CGFloat TOP_TO_VIEW = 20;
const static NSString *HOME_VIEW_CELL_IDENTIFIER = @"Home_View_Cell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableViewSize];
    
    self.tableView.dataSource   = self;
    self.tableView.delegate     = self;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citylist" ofType:@"txt"];
//    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    self.datas = [[NSMutableArray alloc] init];
//    self.datas = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.jsonUtils = [[SNJsonUtils alloc] init];
    
    UINib *cellNib = [UINib nibWithNibName:@"SNNodeTableViewCell" bundle:NULL];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:HOME_VIEW_CELL_IDENTIFIER];
    
    self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    self.tableView.rowHeight = 25;
    
    self.navigationItem.title = @"Provinces";
    
    NSString * localCity = [[SNCityFinder getInstance] getLocalCity];
}

-(void)initTableViewSize{
    CGRect rect = [self.view frame];
    self.tableView.frame = CGRectMake(0, TOP_TO_VIEW, rect.size.width, rect.size.height - TOP_TO_VIEW);
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [self.datas count];
    return [self.jsonUtils getProvinces].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SNNodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOME_VIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    
    NSDictionary *dic = [self.jsonUtils getProvinces][indexPath.row];
    cell.name   = dic[@"name"];
    cell.code       = dic[@"code"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SNNodeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"name=%@,code=%@",cell.name,cell.code);
    SNCityViewController *cityController = [[SNCityViewController alloc] initWithNibName:@"SNCityViewController" bundle:nil parentController:self];
    cityController.parentCode = cell.code;
    cityController.data       = [self.jsonUtils getProvinces][indexPath.row][@"list"];
    cityController.name       = cell.name;
    [self.navigationController pushViewController:cityController animated:true];
}

-(void)getLocalCity{
    
}

@end
