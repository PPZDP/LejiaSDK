//
//  ViewController.m
//  ThrowScreenDemo
//
//  Created by sos1a2a3a on 2017/9/28.
//  Copyright © 2017年 lijiarui. All rights reserved.
//

#import "ViewController.h"
#import <LejiaFramework/LejiaProjectManager.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [[LejiaProjectManager sharedManager] start:nil];
    _dataArray = @[@{@"ctrl":@"LScreenViewController",@"text":@"start screen"},
                   @{@"ctrl":@"LLightViewController",@"text":@"set light"},
                   @{@"ctrl":@"LRomUpgradeViewController",@"text":@"romUpgrade"},
                   ];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.section][@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ctrlStr = [_dataArray objectAtIndex:indexPath.section][@"ctrl"];
    Class ctrlClass = NSClassFromString(ctrlStr);
    UIViewController *v = (UIViewController *)[[ctrlClass alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}

@end
