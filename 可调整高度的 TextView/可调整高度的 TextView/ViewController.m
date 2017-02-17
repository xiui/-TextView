//
//  ViewController.m
//  可调整高度的 TextView
//
//  Created by ZY on 2017/2/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ViewController.h"
#import "ZYTextView.h"
@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, assign) CGFloat theRow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ZYTextView *textV = [[ZYTextView alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    textV.maxHeight = 100;
    textV.layer.borderColor = [UIColor grayColor].CGColor;
    textV.layer.borderWidth = 1;
    textV.layer.cornerRadius = 5;
    textV.delegate = self;
    [self.view addSubview:textV];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView isKindOfClass:[ZYTextView class]]) {
        [((ZYTextView *)textView) didChange];
    }
    
    
}

@end
