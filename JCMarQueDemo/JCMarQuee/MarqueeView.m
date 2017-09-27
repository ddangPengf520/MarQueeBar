//
//  MarqueeView.m
//  JCMarQueDemo
//
//  Created by 风外杏林香 on 2017/9/27.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "MarqueeView.h"


#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface MarqueeView ()
{
    NSTimer     *_timer;
}
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation MarqueeView
+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title
{
    MarqueeView * marqueeBar = [[MarqueeView alloc] initWithFrame:frame];
    marqueeBar.title = title;
    return marqueeBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.firstLabel];
        [self addSubview:self.secondLabel];
        
        [self.labelArray addObject:_firstLabel];
        [self.labelArray addObject:_secondLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    NSString *raceStr = [NSString stringWithFormat:@"%@    ",title];
    _firstLabel.text = raceStr;
    _secondLabel.text = raceStr;
    self.firstLabel.frame = CGRectMake(0, 0, [self getStringWidth:raceStr], self.frame.size.height);
    self.secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    _secondLabel.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startAnimation];
    }
}

- (void)updateTitle:(NSString *)title
{
    self.title = title;
}

- (BOOL)isNeedRaceAnimate{
    return !(_firstLabel.bounds.size.width <= self.bounds.size.width);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_firstLabel && _secondLabel) {
        _firstLabel.frame = CGRectMake(50, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
        _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    }
    _secondLabel.hidden = ![self isNeedRaceAnimate];
}



- (void)startAnimation
{
    //1.0 / 120 控制文字速度
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 120 target:self selector:@selector(raceLabelFrameChanged:) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)raceLabelFrameChanged:(NSTimer *)timer
{
    UILabel *firstLabel = [self.labelArray firstObject];
    UILabel *secondLabel = [self.labelArray lastObject];
    CGRect frameOne = firstLabel.frame;
    CGRect frameTwo = secondLabel.frame;
    CGFloat firstX = firstLabel.frame.origin.x;
    CGFloat secondX = secondLabel.frame.origin.x;
    firstX -= 0.5;
    secondX -= 0.5;
    if (ABS(firstX) >= firstLabel.bounds.size.width) {
        firstX = secondX + firstLabel.bounds.size.width;
        [self.labelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
    frameOne.origin.x = firstX;
    frameTwo.origin.x = secondX;
    firstLabel.frame = frameOne;
    secondLabel.frame = frameTwo;
}

- (void)resume
{
    [self resumeAndStart:NO];
}

- (void)resumeAndStart
{
    [self resumeAndStart:YES];
}

- (void)resumeAndStart:(BOOL)start
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _firstLabel.frame = CGRectMake(50, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
    _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    if (start) {
        [self startAnimation];
    }
}



#pragma mark - Properties
- (UILabel *)firstLabel
{
    if (_firstLabel == nil) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.font = [UIFont systemFontOfSize:14];
        _firstLabel.textColor = RGB(102, 102, 102, 1);
        _firstLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel
{
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.font = [UIFont systemFontOfSize:14];
        _secondLabel.textColor = RGB(102, 102, 102, 1);
        _secondLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _secondLabel;
}

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        self.labelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _labelArray;
}


- (CGFloat)getStringWidth:(NSString *)string
{
    if (string) {
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                           context:nil];
        return rect.size.width;
    }
    return 0.f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
