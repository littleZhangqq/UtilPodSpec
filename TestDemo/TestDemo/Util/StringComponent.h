//
//  XDYStringComponent.h
//  XDYCar
//
//  Created by zhangqiang on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringOffset : NSObject

@property(nonatomic, unsafe_unretained) CGFloat x;
@property(nonatomic, unsafe_unretained) CGFloat y;

@end

@interface StringComponent : NSObject

typedef StringComponent *(^StringComponentChain)(id);

@property(nonatomic, strong) NSMutableAttributedString *attribuString;

-(StringComponentChain)COMFont;
-(StringComponentChain)COMText;
-(StringComponentChain)COMColor;

-(StringComponentChain)COMTextAlignment;
-(StringComponentChain)COMSeperateSpace;// 字间距
-(StringComponentChain)COMLineSpace;// 行间距

-(StringComponentChain)COMRange;

//shadow
-(StringComponentChain)COMShadowColor;
-(StringComponentChain)COMShadowOffSet;
-(StringComponentChain)COMBlurRadius;

//icon
-(StringComponentChain)COMAttachImage;

-(StringComponent *)appendingStringWithString:(StringComponent *)com;

@end
