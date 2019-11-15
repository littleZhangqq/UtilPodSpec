//
//  StringComponent.m
//  XDYCar
//
//  Created by zhangqiang on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import "StringComponent.h"

@implementation StringOffset


@end

@interface StringComponent ()

@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) UIColor *color;
@property(nonatomic, strong) NSArray *range;
@property(nonatomic, unsafe_unretained) CGFloat blurRadius;
@property(nonatomic, strong) UIImage *attachImage;
@property(nonatomic, strong) UIColor *shadowColor;
@property(nonatomic, unsafe_unretained) NSTextAlignment alignment;
@property(nonatomic, unsafe_unretained) CGFloat  seperateNum;
@property(nonatomic, unsafe_unretained) CGFloat lineSpace;
@property(nonatomic, unsafe_unretained) StringOffset  *shadowOffSet;
@end

@implementation StringComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
    }else{
        @throw [[NSException alloc] initWithName:@"请把该类初始化后使用" reason:@"" userInfo:nil];
    }
    return self;
}

-(NSMutableAttributedString *)attribuString{
    
    if (!_attribuString) {
        NSMutableDictionary *defaultDic = [NSMutableDictionary dictionary];
        defaultDic[NSForegroundColorAttributeName] = self.color;
        defaultDic[NSFontAttributeName] = self.font;
        
        if (self.shadowOffSet && self.shadowColor) {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowColor = self.shadowColor;
            shadow.shadowOffset = CGSizeMake(self.shadowOffSet.x, self.shadowOffSet.y);
            shadow.shadowBlurRadius = self.blurRadius;
            defaultDic[NSShadowAttributeName] = shadow;
        }
        
        NSTextAttachment *attchment = nil;
        if (self.attachImage) {
            attchment = [[NSTextAttachment alloc] init];
            attchment.image = self.attachImage;
            attchment.bounds = CGRectMake(0, -2, 13, 13);
        }
        
        if (self.alignment || self.lineSpace) {
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.alignment = self.alignment;
            style.lineSpacing = self.lineSpace;
            defaultDic[NSParagraphStyleAttributeName] = style;
        }
        
        if (self.seperateNum > 0) {
            defaultDic[NSKernAttributeName] = @(self.seperateNum);
        }
    
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        if (self.range.count > 1) {
            NSRange range = NSMakeRange([self.range[0] integerValue], [self.range[1] integerValue]);
            attr = [[NSMutableAttributedString alloc] initWithString:self.text];
            [attr addAttributes:defaultDic range:range];
        }else{
            if (defaultDic.allValues.count > 0) {
                attr = [[NSMutableAttributedString alloc] initWithString:self.text attributes:defaultDic];
            }else if(self.text.length > 0){
                attr = [[NSMutableAttributedString alloc] initWithString:self.text];
            }else{
                attr = [[NSMutableAttributedString alloc] init];
            }
        }

        if (attchment != nil) {
            [attr appendAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attchment]];
        }
        _attribuString = attr;
    }
    return _attribuString;
}

-(StringComponentChain)COMFont{
    return ^(id font){
        self.font = font;
        return self;
    };
}

-(StringComponentChain)COMText{
    return ^(id text){
        self.text = text;
        return self;
    };
}

-(StringComponentChain)COMColor{
    return ^(id color){
        self.color = color;
        return self;
    };
}

- (StringComponentChain)COMRange{
    return ^(id range){
        self.range = [NSArray arrayWithArray:range];
        return self;
    };
}

-(StringComponentChain)COMShadowColor{
    return ^(id color){
        self.color = color;
        return self;
    };
}

-(StringComponentChain)COMShadowOffSet{
    return ^(id offset){
        self.shadowOffSet = offset;
        return self;
    };
}

-(StringComponentChain)COMBlurRadius{
    return ^(id blurRadius){
        self.blurRadius = [blurRadius floatValue];
        return self;
    };
}

-(StringComponentChain)COMAttachImage{
    return ^(id image){
        self.attachImage = image;
        return self;
    };
}

-(StringComponentChain)COMSeperateSpace{
    return ^(id seperate){
        self.seperateNum = [seperate floatValue];
        return self;
    };
}

-(StringComponentChain)COMTextAlignment{
    return ^(id alignment){
        self.alignment = [alignment integerValue];
        return self;
    };
}

-(StringComponentChain)COMLineSpace{
    return ^(id lineNum){
        self.lineSpace = [lineNum floatValue];
        return self;
    };
}

-(StringComponent *)appendingStringWithString:(StringComponent *)com{
    StringComponent *newcom = [StringComponent new];
    [self.attribuString appendAttributedString:com.attribuString];
    newcom.attribuString = self.attribuString;
    return newcom;
}
@end
