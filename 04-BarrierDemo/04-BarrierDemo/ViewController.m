//
//  ViewController.m
//  04-BarrierDemo
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)login{
    [NSThread sleepForTimeInterval:1];
    NSLog(@"=====%s",__func__);
}



-(void)BarrierLoad
{
   //1.创建一个并发队列,屏障必须使用dispatch_queue_create 创建的并发队列,才可以生效
    dispatch_queue_t queue=dispatch_queue_create("com.qingyun.www", DISPATCH_QUEUE_CONCURRENT);
   //2.派发任务
    __weak ViewController *vc=self;
    dispatch_async(queue, ^{
        //2.1.登录
        [vc  login];
      //2.2同步配置信息
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"=====3");
        });
       //2.3同步好友信息
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:4];
            NSLog(@"=====4");
        });
        //2.4.显示主页面,需要设置屏障
        dispatch_barrier_async(queue, ^{
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"=====2");
        });
        
        //2.5.获取好友聊天列表
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"=====1");
        });
    
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self BarrierLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
