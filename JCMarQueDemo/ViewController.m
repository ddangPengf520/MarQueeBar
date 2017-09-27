//
//  ViewController.m
//  JCMarQueDemo
//
//  Created by 风外杏林香 on 2017/9/27.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"888");
    
    
    
    MarqueeView *marqueeBar = [MarqueeView marqueeBarWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 49) title:@"你在南方的艳阳里大雪纷飞，我在北方的寒夜里四季如春"];
    [self.view addSubview:marqueeBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
