//
//  MXLogView.m
//  
//
//  Created by UIBear.com on 13-12-29.
//  Copyright (c) 2013年 UIBear.com. All rights reserved.
//

#import "MXLogView.h"

@interface MXLogView()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat xOffSet;
@property (nonatomic, assign) CGFloat yOffSet;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

@implementation MXLogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = frame.size.width;
        self.height = frame.size.height;
        [self setFrame:CGRectMake(43, 75, _width, _height)];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitle:@"x" forState:UIControlStateNormal];
        [btn setContentMode:UIViewContentModeCenter];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setSelected:YES];
        [self addSubview:btn];
        
        UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width-45, 0, 45, 30)];
        [cleanBtn setBackgroundColor:[UIColor grayColor]];
        [cleanBtn setTitle:@"clean" forState:UIControlStateNormal];
        [cleanBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cleanBtn setContentMode:UIViewContentModeCenter];
        [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cleanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cleanBtn];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 30)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.text = @"辅助日志输出器";
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        [self addSubview:lbl];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 30,
                                                              _width,
                                                              _height-30)];
        [_textView setText:@"Output :"];
        [_textView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        [_textView setTextColor:[UIColor blackColor]];
        [_textView setEditable:NO];
        [self addSubview:_textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControl:) name:@"MXLogView" object:nil];
        
        [self setAlpha:0];
        
    }
    return self;
}


#pragma mark - btn Action
- (void)btnAction:(UIButton*)sender{
    
    sender.selected =! sender.selected;
    
    if (sender.selected) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _width, _height);
        _textView.hidden = NO;
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _width, 30);
        _textView.hidden = YES;
    }
}


- (void)cleanAction{
    [_textView setText:@"Output :"];
}
#pragma mark - notification
- (void)viewControl:(NSNotification*)notification{
    [UIView animateWithDuration:0.5 animations:^(void){
        if ([[notification object]isEqualToString:@"showLogView"]) {
            [self setAlpha:1];
        }else if ([[notification object]isEqualToString:@"hideLogView"]){
            [self setAlpha:0];
        }else{
            _textView.text = [_textView.text stringByAppendingFormat:@"\n\n%@",[notification object]];
        }
    }];
}

#pragma mark - view touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    _xOffSet=touchPoint.x- [touch view].frame.origin.x;
    _yOffSet=touchPoint.y- [touch view].frame.origin.y;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    [touch view].frame = CGRectMake(touchPoint.x-_xOffSet,
                                    touchPoint.y-_yOffSet,
                                    [touch view].frame.size.width,
                                    [touch view].frame.size.height);
}

@end
