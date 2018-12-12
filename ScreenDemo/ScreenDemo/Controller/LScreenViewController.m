//
//  LScreenViewController.m
//  LeJiaScreenProject
//
//  Created by sos1a2a3a on 2018/11/12.
//  Copyright © 2018 lijiarui. All rights reserved.
//

#import "LScreenViewController.h"
#import <LejiaFramework/LejiaProjectManager.h>

@interface CustomLab : UILabel

@end


@implementation CustomLab


-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end



@interface LScreenViewController ()<LejiaProjectManagerDelegate>
@property(nonatomic,strong)NSTimer *times;
@property(nonatomic,strong)CustomLab *showView;

@end

@implementation LScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    UIButton *startBt = [[UIButton alloc]initWithFrame:CGRectMake(20, 64+30, 100, 50)];
    startBt.backgroundColor = [UIColor redColor];
    startBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [startBt setTitle:@"开始投屏" forState:UIControlStateNormal];
    [startBt addTarget:self action:@selector(startScreen:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startBt];
    UIButton *closeBt = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(startBt.frame)+20, 100, 50)];
    closeBt.backgroundColor = [UIColor blueColor];
    closeBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [closeBt setTitle:@"关闭投屏" forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(closeScreen:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:closeBt];
    
    
    
    CustomLab *showView = [[CustomLab alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(closeBt.frame)+20, 480, 240)];
    self.showView = showView;
    showView.textAlignment = NSTextAlignmentCenter;
    showView.text = [NSString stringWithFormat:@"%@",[NSDate new]];
    showView.font = [UIFont systemFontOfSize:18];
    showView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:showView];
    
    
    _times = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refeshData) userInfo:nil repeats:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)refeshData
{
    
    
    self.showView.text = [NSString stringWithFormat:@"%@",[NSDate new]];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_times) {
        [_times invalidate];
        _times = nil;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden=YES;
}

- (void)startScreen:(UIButton *)bt
{
    [LejiaProjectManager sharedManager].delegate = self;
    // customView: width:480 height:240
    [[LejiaProjectManager sharedManager] start:self.showView];
}

-(void)closeScreen:(UIButton *)bt
{
    NSLog(@"手动断开连接");
    [[LejiaProjectManager sharedManager] stop];
}

- (void)onDisconnected:(NSError *)error
{
    NSLog(@"连接失败！自动重连中！%@",error);
}
-(void)onConnected
{
    NSLog(@"连接成功！");
}

- (void)dealloc
{
     [[LejiaProjectManager sharedManager] releaseCustomView];
     NSLog(@"%s",__func__);
}

@end
