//
//  ZYTextView.h
//  限制字数的 TextView
//
//  Created by ZY on 2017/2/15.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTextView : UITextView

/*** TextView 的最大高度（如果设置，小于‘字体号加_moreHeight’时会自动修改为‘字体号加_moreHeight’） ***/
@property (nonatomic, assign) CGFloat maxHeight;
/*** TextView 的最小高度（如果设置，小于‘字体号加_moreHeight’时会自动修改为‘字体号加_moreHeight’） ***/
@property (nonatomic, assign) CGFloat minHeight;
/*** 最多输入的字数 ***/
@property (nonatomic, assign) NSInteger maxNumOfText;

/*** 每次修改时调用，用于修改 TextView 的大小， ***/
/*** 请在此方法- (void)textViewDidChange:(UITextView *)textView 中调用 ***/
- (void)didChange;
@end
