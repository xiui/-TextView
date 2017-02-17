//
//  ZYTextView.m
//  限制字数的 TextView
//
//  Created by ZY on 2017/2/15.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYTextView.h"

/*** 最小高度为字号大小时,会展示不全,所以需要多加一个高度(此高度没有发现规律,所以只写了个20,自己根据自己设置的字号,可以进行修改,使其更好看) ***/
static CGFloat _moreHeight = 20;

/*** 最小高度,不能小于字号加上_moreHeight ***/
#define MIN_HEIGHT (self.font.pointSize+_moreHeight)

@interface ZYTextView ()
/*** 第一次修改 TextView 里的值 ***/
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation ZYTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _isFirst = NO;
        _minHeight = 0;
        _maxHeight = 0;
        _maxNumOfText = 0;
    }
    return self;
}


/**
 设置最小高度,不能小于 MIN_HEIGHT

 @param minHeight 最小高度
 */
- (void)setMinHeight:(CGFloat)minHeight {
    
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    _minHeight = (minHeight > MIN_HEIGHT) ? minHeight : MIN_HEIGHT;
    [self setNewFrame];
}


/**
 设置字体,调整最小高度不能小于 MIN_HEIGHT

 @param font 字体
 */
- (void)setFont:(UIFont *)font {
    super.font = font;
    _minHeight = (_minHeight > MIN_HEIGHT) ? _minHeight : MIN_HEIGHT;
    [self setNewFrame];
}


/**
 重新设置 frame, 使其高度不能小于 MIN_HEIGHT
 */
- (void)setNewFrame {
    CGRect frame = self.frame;
    frame.size.height = _minHeight;
    self.frame = frame;
    self.contentSize = frame.size;
}


/**
 设置最大高度,使其不能小于 MIN_HEIGHT

 @param maxHeight 最大高度
 */
- (void)setMaxHeight:(CGFloat)maxHeight {
    _maxHeight = (maxHeight > MIN_HEIGHT) ? maxHeight : MIN_HEIGHT;
}


/**
 每次改变都要调用,调整高度
 */
- (void)didChange {
    
    if (!_isFirst) {
        _isFirst = YES;
        if (_minHeight == 0) {
            _minHeight = (self.frame.size.height > MIN_HEIGHT) ? self.frame.size.height : MIN_HEIGHT;
        } else {
            CGRect frame = self.frame;
            frame.size.height = _minHeight;
            self.frame = frame;
        }
    }
    
    if (_maxHeight == 0) {
        if (self.frame.size.height != self.contentSize.height) {
            
            CGRect frame = self.frame;
            frame.size.height = (_minHeight > self.contentSize.height) ? _minHeight : self.contentSize.height;
            self.frame = frame;
        }
    } else {
        if (_maxHeight < _minHeight) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"最大高度<最小高度\n请重新设置代码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
            [alert show];
        } else if (_maxHeight > _minHeight) {
            
            if (self.frame.size.height != self.contentSize.height) {
                
                CGFloat height = (_minHeight > self.contentSize.height) ? _minHeight : self.contentSize.height;
                height = (_maxHeight < height) ? _maxHeight : height;
                
                CGRect frame = self.frame;
                frame.size.height = height;
                self.frame = frame;
            }
        }
    }

    if (_maxNumOfText > 0) {
        
        BOOL isHaveSelectedChinese = [self markedTextRange];
        
        if (self.text.length > _maxNumOfText && !isHaveSelectedChinese) {
            self.text = [self.text substringToIndex:_maxNumOfText];
            [self resignFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"最多可输入%ld字", _maxNumOfText] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
            [alert show];
        }
    }
}


/**
 调整contentOffset,防止跳动
 */
- (void)layoutSubviews {
    if (_maxHeight == 0 || self.frame.size.height < _maxHeight) {
        self.contentOffset = CGPointZero;
    }
}

@end
