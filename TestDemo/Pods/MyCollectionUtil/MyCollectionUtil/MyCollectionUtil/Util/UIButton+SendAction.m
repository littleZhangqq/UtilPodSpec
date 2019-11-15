//
//  UIButton+SendAction.m
//  yqjy
//
//  Created by admin on 2019/9/12.
//  Copyright © 2019 易起. All rights reserved.
//

#import "UIButton+SendAction.h"

@implementation UIButton (SendAction)

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        [view endEditing:YES];
    }
}

@end
