//
//  MarqueeView.h
//  JCMarQueDemo
//
//  Created by 风外杏林香 on 2017/9/27.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeView : UIView
@property (nonatomic, strong) NSString  * title;
+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString *)title;
- (void)updateTitle:(NSString *)title;
- (void)resume;
@end
