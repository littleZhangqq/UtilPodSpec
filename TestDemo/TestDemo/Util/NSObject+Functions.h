//
//  NSObject+Functions.h
//  TestDemo
//
//  Created by admin on 2019/11/15.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DateFormatterDefualt @"yyyy-MM-dd HH:mm:ss"
#define DateFormatterMonthToMinutes @"MM-dd HH:mm"
#define DateFormatterHourToSeconds @"HH:mm:ss"
#define DateFormatterYearToDay @"yyyy-MM-dd"

#define DateStringFromDate(date,formatter)   [NSDate dateStringFromDate:date dateFormatter:formatter]

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GradiatLoadImage)<CAAnimationDelegate>

-(void)gradientLoadWithImage:(UIImage *)image;

@end

@interface NSDate (Utility)
+(NSString *)nextDateStringSinceNowWithHMS:(NSString *)HMSStr;//根据给定时间获取下一个距离现在最近的日期
+(NSString *)dateString;//当前时间字符串
+(NSString *)dateStringWithDateFormatter:(NSString *)dateFormat;//当前时间字符串
+(NSString *)dateStringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime;
+(NSInteger)timeSwitchIntervalWith:(NSString *)formatTime;
+(NSDate *)dateFromDateString:(NSString *)dateString;
+(NSDate *)dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormat;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)timeWithYearMonthString:(NSString *)timeString;
+ (NSString *)timeWithTimeIntervalToMinuteAndSecondString:(NSString *)timeString;
+ (NSString *)timeWithMonsYearString:(NSString *)timeString;
+ (NSString *)timeWithMonthDayString:(NSString *)timeString;
+ (NSString *)timeWithMonth_DayString:(NSString *)timeString;
+(NSInteger)timeSwitchWithYearMonthDay:(NSString *)formatTime;
+(NSString *)timeSwitchNoLineTimestamp:(NSString *)formatTime;
+ (NSString *)timeForUploadFormat:(NSString *)timeString;
+(NSString *)lastMonth;
+(NSString *)thisYear;
+(NSString *)thisMonth;
+(NSString *)thisWeekMonday;
+(NSString *)yesterday;
+(NSString *)today;
@end

@interface UIView (HQExtension)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

@end

@interface UIImage (HQImage)


/**
 *  根据颜色生成一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (instancetype)originalImageNamed:(NSString *)imageName;

@end

@interface UIColor (HQColor)

+ (UIColor *) colorWithHexString: (NSString *)color;

@end

@interface UIButton (SendAction)

@end


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

+(CGFloat)calculateTitleWidth:(NSString *)str withMaxHeight:(CGFloat)height andFont:(UIFont*)font;
+(CGFloat)calculateTitleHeight:(NSString *)str withMaxWidth:(CGFloat)width andFont:(UIFont *)font;
+(NSAttributedString *)addColorString:(NSString *)str font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;
+ (NSString *) md5:(NSString *) input;


@end


@interface NSObject (Functions)

@end

NS_ASSUME_NONNULL_END
