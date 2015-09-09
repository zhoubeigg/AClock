//
//  ViewController.m
//  AClock
//
//  Created by macAir on 15/9/9.
//  Copyright (c) 2015年 ZhouBei. All rights reserved.
//

#import "ViewController.h"

// 秒针每秒转6度
#define perSecondA 6

// 分针每分转6度
#define perMinuteA 6

// 时针每小时转30度
#define perHourA 30

// 时针每分钟转0.5度
#define perMinuteHourA 0.5

#define angle2rediao(x) ((x) / 180.0 * M_PI)

@interface ViewController ()
{
    CALayer *_second;
    CALayer *_minute;
    CALayer *_hour;
}
@property (nonatomic, strong) UIImageView *clockDialView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.创建表盘
    [self creatClockDialView];
    
    // 2.添加秒针
    [self addSecond];
    
    // 3.添加分针
    [self addMinute];
    
    // 4.添加时针
    [self addHour];
    
    // 创建定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [self update];
}

- (void)addHour
{
    // 1.添加时针
    CALayer *hour = [CALayer layer];
    
    // 2.设置锚点
    hour.anchorPoint = CGPointMake(0.5, 0.9);
    
    // 3.设置位置
    hour.position = CGPointMake(self.clockDialView.bounds.size.width * 0.5, self.clockDialView.bounds.size.height * 0.5);
    
    // 4.设置尺寸
    hour.bounds = CGRectMake(0, 0, 3, self.clockDialView.bounds.size.height * 0.2);
    
    // 5.设置时针黑色
    hour.backgroundColor = [UIColor blackColor].CGColor;
    
    // 添加到表盘的图层上
    [self.clockDialView.layer addSublayer:hour];
    
    _hour = hour;
}

- (void)addMinute
{
    // 1.添加秒针
    CALayer *minute = [CALayer layer];
    
    // 2.设置锚点
    minute.anchorPoint = CGPointMake(0.5, 0.9);
    
    // 3.设置位置
    minute.position = CGPointMake(self.clockDialView.bounds.size.width * 0.5, self.clockDialView.bounds.size.height * 0.5);
    
    // 4.设置尺寸
    minute.bounds = CGRectMake(0, 0, 2, self.clockDialView.bounds.size.height * 0.3);
    
    // 5.设置分针蓝色
    minute.backgroundColor = [UIColor blueColor].CGColor;
    
    // 添加到表盘的图层上
    [self.clockDialView.layer addSublayer:minute];
    
    _minute = minute;
    
}


- (void)addSecond
{
    // 1.添加秒针
    CALayer *second = [CALayer layer];
    
    // 2.设置锚点
    second.anchorPoint = CGPointMake(0.5, 0.9);
    
    // 3.设置位置
    second.position = CGPointMake(self.clockDialView.bounds.size.width * 0.5, self.clockDialView.bounds.size.height * 0.5);
    
    // 4.设置尺寸
    second.bounds = CGRectMake(0, 0, 1, self.clockDialView.bounds.size.height * 0.4);
    
    // 5.设置秒针红色
    second.backgroundColor = [UIColor redColor].CGColor;
    
    // 添加到表盘的图层上
    [self.clockDialView.layer addSublayer:second];
    
    _second = second;

}

- (void)update
{
    // 获取日历组件
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取日期组件
    NSDateComponents *compoents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    // 获取秒数
    CGFloat sec = compoents.second;
    
    // 获取分钟数
    CGFloat minute = compoents.minute;
    
    // 获取小时数
    CGFloat hour = compoents.hour > 12 ? compoents.hour - 12 : compoents.hour;
    
    // 获取秒针旋转度数
    CGFloat secondA = sec * perSecondA;
    
    // 获取分针旋转度数
    CGFloat minuteA = minute * perMinuteA;
    
    // 获取时针旋转度数
    CGFloat hourA = hour * perHourA;
    hourA += minute * perMinuteHourA;
    
    // 旋转秒针
    _second.transform = CATransform3DMakeRotation(angle2rediao(secondA), 0, 0, 1);
    
    // 旋转分针
    _minute.transform = CATransform3DMakeRotation(angle2rediao(minuteA), 0, 0, 1);
    
    // 旋转时针
    _hour.transform = CATransform3DMakeRotation(angle2rediao(hourA), 0, 0, 1);

}

- (void)creatClockDialView
{
    CGFloat screenW = self.view.frame.size.width;
    CGFloat screenH = self.view.frame.size.height;
    
    UIImageView *clockDialView = [[UIImageView alloc] init];
    
    CGFloat clockDialViewW = 200;
    CGFloat clockDialViewH = 200;
    CGFloat clockDialViewX = (screenW - clockDialViewW)/2.0;
    CGFloat clockDialViewY = (screenH - clockDialViewH)/2.0;
    
    clockDialView.frame = CGRectMake(clockDialViewX, clockDialViewY, clockDialViewW, clockDialViewH);
    clockDialView.image = [UIImage imageNamed:@"钟表"];
    
    self.clockDialView = clockDialView;
    [self.view addSubview:clockDialView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
