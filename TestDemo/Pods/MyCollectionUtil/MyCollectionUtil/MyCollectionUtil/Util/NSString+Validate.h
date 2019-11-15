//
//  NSString+Validate.h
//  OrderCar-Driver
//
//  Created by 伯明利 on 16/12/16.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)
/**
 非空且不能全为空格
 */
+ (BOOL)validateUnNull:(NSString *)string;

/**
 非空且不能全为空格，且必须由汉字组成
 */
+ (BOOL)validateChinese:(NSString *)string;

/**
 数字及小数点
 */
+ (BOOL)validatePositiveInteger:(NSString *)string;

/**
 邮箱
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 手机号码验证
 */
+ (int) validateMobile:(NSString *)mobile;

 /**
  车牌号验证
  */
+ (BOOL) validateCarNo:(NSString *)carNo;

 /**
  车型
  */
+ (BOOL) validateCarType:(NSString *)CarType;

 /**
  用户名
  */
+ (BOOL) validateUserName:(NSString *)name;


/**
 密码校验。返回1，正确；2，为空；3，格式错误

 @param passWord 密码
 @return 返回结果。1，正确；2，为空；3，格式错误
 */
+ (int) validatePassword:(NSString *)passWord;

 /**
  昵称
  */
+ (BOOL) validateNickname:(NSString *)nickname;

 /**
  身份证号
  */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 输入金额是否符合规范

 @param money 输入金额
 @return 结果
 */
+ (BOOL)validateMoney:(NSString *)money;
+(BOOL)validateNumber:(NSString *)number;

/**
 去掉HTML里的标签元素

 @return 纯文本
 */
- (NSString *)replaceHTML;
+(CGFloat)calculateTitleWidth:(NSString *)str withMaxHeight:(CGFloat)height andFont:(UIFont*)font;
+(CGFloat)calculateTitleHeight:(NSString *)str withMaxWidth:(CGFloat)width andFont:(UIFont *)font;
+(NSAttributedString *)addColorString:(NSString *)str font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;
+ (NSString *) md5:(NSString *) input;
- (NSInteger)needLinesWithWidth:(CGFloat)width withFont:(UIFont *)font andString:(NSString *)str;
- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label;
+(BOOL)validateWithNumAndChar:(NSString *)numAndChar;
+ (NSString *)chineseWithInteger:(NSInteger)integer;
+(NSString *)transformToPinyin:(NSString *)name;
+ (NSString *)getPinyinWithString:(NSString *)string;

@end
