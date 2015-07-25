//
//  ViewController.m
//  Clock
//
//  Created by tt on 15/7/12.
//  Copyright (c) 2015年 boyu. All rights reserved.
//

#import "ViewController.h"

#define perSecondA 6
#define perMinuteA 6
#define perHourA   30
#define angle2radian(x) ((x) / 180.0 * M_PI)


@interface ViewController ()
{
    CALayer *_second;
    CALayer *_minute;
    CALayer *_hour;
}

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1:添加秒针
    [self addSecondLayer];
    
    //2：添加分针
    [self addMinuteLayer];
    
    //3:添加时针
    [self addHourLayer];
    
    [self addCenterHub];
    //4：先显示时间1遍
    [self displayTheClock];
    
    //5：再每秒显示1遍
    [NSTimer scheduledTimerWithTimeInterval:1.00f target:self selector:@selector(displayTheClock) userInfo:nil repeats:YES];
}

-(void)addSecondLayer
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    //1:创建秒针
    CALayer *second = [CALayer layer];
    
    //2:设置锚点
    second.anchorPoint = CGPointMake(0.5, 1);
                       
    //3:位置设置
    second.position = CGPointMake(0.5*imageW, 0.5*imageH);
                       
    //4:设置尺寸
    second.bounds = CGRectMake(0, 0, 1, imageH * 0.50 - 20);
                       
    //5:设置颜色
    second.backgroundColor = [UIColor redColor].CGColor;
                       
    //6:添加到图层上
    [_clockView.layer addSublayer:second];
    
    _second = second;
                    
}

-(void)addMinuteLayer
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    CALayer *minute = [CALayer layer];
    
    minute.anchorPoint = CGPointMake(0.5, 1);
    
    minute.position = CGPointMake(0.5 * imageW, 0.5 * imageH);
    
    minute.bounds = CGRectMake(0, 0, 3, 0.5*imageH - 30);
    
    minute.backgroundColor = [UIColor greenColor].CGColor;
    
    [_clockView.layer addSublayer:minute];
    
    _minute = minute;
    
}

-(void)addHourLayer
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    CALayer *hour = [CALayer layer];
    
    hour.anchorPoint = CGPointMake(0.5, 1);
    
    hour.position = CGPointMake(0.5 * imageW, 0.5 *imageH);
    
    hour.bounds = CGRectMake(0, 0, 6, 0.5 *imageH - 50);
    
    hour.backgroundColor = [UIColor blackColor].CGColor;
    
    hour.cornerRadius = 10;
    
    
    [_clockView.layer addSublayer:hour];
    
    _hour = hour;
    
}

-(void)addCenterHub
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;

    CALayer *center = [CALayer layer];
    
    center.anchorPoint =CGPointMake(0.5, 0.5);
    center.position = CGPointMake(0.5 *imageW, 0.5 *imageH);
    center.bounds = CGRectMake(0, 0, 10, 10);
    center.backgroundColor = [UIColor cyanColor].CGColor;
    center.cornerRadius = 5.0f;
    
    [_clockView.layer addSublayer:center];
}

-(void)displayTheClock
{
    
    //获取日历对象(当前日期日历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取日期组件
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour fromDate:[NSDate date]];
    
    //获取秒数
    CGFloat sec = components.second;
    
    //获取分钟
    CGFloat min = components.minute;
    min += sec / 60;
    
    //获取小时
    CGFloat hour = components.hour;
    hour += min / 60;
    
    //计算秒针旋转多少
    CGFloat secondA = sec * perSecondA;
    //计算分针选装多少
    CGFloat minuteA = min * perMinuteA;
    //计算出时针旋转多少
    CGFloat hourA = hour * perHourA;
    
    
    //旋转秒针
    _second.transform = CATransform3DMakeRotation(angle2radian(secondA), 0, 0, 1);
    
    //旋转分针
    _minute.transform = CATransform3DMakeRotation(angle2radian(minuteA), 0, 0, 1);
    
    //旋转时针
    _hour.transform = CATransform3DMakeRotation(angle2radian(hourA), 0, 0, 1);
}


@end
