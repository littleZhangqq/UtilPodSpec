//
//  NSObject+Functions.m
//  TestDemo
//
//  Created by admin on 2019/11/15.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#import "NSObject+Functions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@implementation UIImageView (GradiatLoadImage)

-(void)gradientLoadWithImage:(UIImage *)image{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    animation.type = kCATransitionFade;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"transition"];
    self.image = image;
    [self setNeedsLayout];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.layer removeAnimationForKey:@"transition"];
}

@end

@implementation NSDate (Utility)
+(NSString *)nextDateStringSinceNowWithHMS:(NSString *)HMSStr//根据给定时间获取下一个距离现在最近的日期
{
    
    NSDate *todayDate = [NSDate dateTodayWithHMS:HMSStr];
    NSDate *nowDate = [NSDate date];
    NSString *dateString = [NSDate dateStringFromDate:todayDate];
    if (![todayDate isLaterDate:nowDate]) {
        NSDate *nextDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:todayDate];
        dateString = [NSDate dateStringFromDate:nextDate];
    }
    return dateString;
}



+(NSString *)dateStringTodayWithHMS:(NSString *)HMSStr
{
    NSString *dateString = [NSDate dateStringWithDateFormatter:DateFormatterYearToDay];
    dateString = [NSString stringWithFormat:@"%@ %@",dateString,HMSStr];
    return dateString;
}

+(NSString *)dateString
{
    NSString *dateString = [NSDate dateStringWithDateFormatter:DateFormatterDefualt];
    return dateString;
}
+(NSString *)dateStringWithDateFormatter:(NSString *)dateFormat
{
    NSDate *date = [NSDate date];
    
    NSString *dateString = [NSDate dateStringFromDate:date dateFormatter:dateFormat];
    return dateString;
}

+(NSString *)dateStringFromDate:(NSDate *)date
{
    NSString *dateString = [NSDate dateStringFromDate:date dateFormatter:DateFormatterDefualt];
    return dateString;
}
+(NSString *)dateStringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSDate *)dateTodayWithHMS:(NSString *)HMSStr
{
    NSString *todayDayString = [NSDate dateStringTodayWithHMS:HMSStr];
    NSDate *date = [NSDate dateFromDateString:todayDayString dateFormatter:DateFormatterDefualt];
    return date;
}
+(NSDate *)dateFromDateString:(NSString *)dateString
{
  return   [self dateFromDateString:dateString dateFormatter:DateFormatterDefualt];
}
+(NSDate *)dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormat
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

-(BOOL)isLaterDate:(NSDate *)anotherDate
{
    NSDate *laterDate = [self laterDate:anotherDate];
    if (laterDate==self) {
        return YES;
        
    }
    else
    {
        return NO;
    }
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+(NSInteger)timeSwitchIntervalWith:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (formatTime.length > 10) {
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    }else{
        [formatter setDateFormat:@"YYYY-MM-dd"];
    }
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+(NSString *)timeSwitchNoLineTimestamp:(NSString *)formatTime{
      // 格式化时间
      NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
      formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
      [formatter setDateStyle:NSDateFormatterMediumStyle];
      [formatter setTimeStyle:NSDateFormatterShortStyle];
      [formatter setDateFormat:@"yyyyMMdd"];
      
      // 毫秒值转化为秒
      NSDate* date = [NSDate dateWithTimeIntervalSince1970:[formatTime doubleValue]];
      NSString* dateString = [formatter stringFromDate:date];
      return dateString;
}



+ (NSString *)timeForUploadFormat:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddhhmmsss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonsYearString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonthDayString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMdd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonth_DayString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalToMinuteAndSecondString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"hh:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSInteger)timeSwitchWithYearMonthDay:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+(NSString *)today{
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",time(NULL)*1000]];
}

+(NSString *)yesterday{
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",(time(NULL)-24*3600)*1000]];
}

+(NSString *)thisWeekMonday{
    // 计算当前时间
    time_t timeinterval = time(NULL);
    // 计算当前时间对应个各个信息的结构体（结构体内包含了所需的各种信息）
    struct tm *info = localtime(&timeinterval);
    NSInteger monday = 0;
    //因为咱们计算周的开始一般是周一到周末，如果==0  说明是周末，应该从今天往前推七天。
    if (info->tm_wday == 0) {
        monday = timeinterval - 7*24*3600;
    }else{
        monday = timeinterval - (info->tm_wday-1)*24*3600;
    }
    
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",monday*1000]];
}

+(NSString *)thisMonth{
    time_t timeinterval = time(NULL);
    struct tm *info = localtime(&timeinterval);
    NSInteger monday = timeinterval - (info->tm_mday-1)*24*3600;
    
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",monday*1000]];
}

+(NSString *)lastMonth{
    time_t timeinterval = time(NULL);
    struct tm *info = localtime(&timeinterval);
    NSInteger month = info->tm_mon;
    //上月月初时间戳
    NSInteger lastMonFirstDay = 0;
    //本月月初时间戳
    NSInteger lastMonthInterval = (timeinterval - info->tm_mday*24*3600);
    if (month == 1 || month == 3  || month == 5 || month == 7 || month == 8 || month == 10 || month== 12) {
        lastMonFirstDay = (lastMonthInterval - 30 * 24*3600);
    }else{
        lastMonFirstDay = (lastMonthInterval - 29 * 24*3600);
    }
    NSString *monFirst = [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",lastMonFirstDay*1000]];
    NSString *monLast = [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",lastMonthInterval*1000]];
    return monFirst;
}

+(NSString *)thisYear{
    time_t timeInterval = time(NULL);
    struct tm *stm = localtime(&timeInterval);
    NSInteger days = timeInterval - stm->tm_yday*24*3600;
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",days*1000]];
}

@end

@implementation UIView (HQExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end


@implementation UIImage (HQImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    //渲染上下文
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (instancetype)originalImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end


@implementation UIColor (HQColor)

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end

@implementation UIButton (SendAction)

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        [view endEditing:YES];
    }
}

@end

@implementation NSString (Validate)

+ (NSString *) md5:(NSString *) input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

//非空且不能全为空格
+ (BOOL)validateUnNull:(NSString *)string {
    if (string == nil) {
        return NO;
    } else {
        NSString *str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    }
}

//非空且不能全为空格，且必须由汉字组成
+ (BOOL)validateChinese:(NSString *)string {
    if ([NSString validateUnNull:string]) {
        NSString *chineseRegex = @"^[\u4e00-\u9fa5]{0,}$";
        NSPredicate *chinesePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
        return [chinesePredicate evaluateWithObject:string];
    } else {
        return NO;
    }
}

//数字及小数点
+ (BOOL)validatePositiveInteger:(NSString *)string {
    NSString *positiveIntegerRegex = @"^[0-9]+([.]{0}|[.]{0,}[0-9]+)$";
    NSPredicate *positiveIntegerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",positiveIntegerRegex];
    return [positiveIntegerPredicate evaluateWithObject:string];
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (int)validateMobile:(NSString *)mobile
{
    //非空
    if ([NSString validateUnNull:mobile] == NO) {
        return 2;
    } else {
        //手机号以13， 15，18开头，八个 \d 数字字符
        NSString *phoneRegex = @"^((16[0-9])|(13[0-9])|(15[^4,\\D])|(14[579])|(17[0-9])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        if ([phoneTest evaluateWithObject:mobile]) {
            return 1;
        } else {
            return 3;
        }
    }
    
    
}


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL)validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (int)validatePassword:(NSString *)passWord
{
    //@"^.{6,16}+$";//匹配除换行符以外的任意字符，长度在6到16之间
    //@"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,20}$";//支持数字、字母、符号8-20位,必须包含其中至少两种
    //非空
    if ([NSString validateUnNull:passWord] == NO) {
        return 2;
    } else {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}$";//支持数字、字母、符号8-20位,必须包含其中至少两种
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
        if ([passWordPredicate evaluateWithObject:passWord]) {
            return 1;
        } else {
            return 3;
        }
    }
}


//昵称
+ (BOOL)validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (NSString *)replaceHTML {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    return [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

/**
 输入金额是否符合规范
 
 @param money 输入金额
 @return 结果
 */
+ (BOOL)validateMoney:(NSString *)money {
    //
    NSString *regex = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:money];
}

+(BOOL)validateNumber:(NSString*)number{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
/*
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 if ([string isEqualToString:@""]) {//退格、删除
 return YES;
 } else {
 NSString *newStr = [NSString stringWithFormat:@"%@%@",textField.text, string];
 BOOL validate = [NSString validateMoney:newStr];
 if (validate == YES) {
 return YES;
 } else {
 if ([string isEqualToString:@"."] && [textField.text containsString:@"."] == NO) {
 if (textField.text == nil || [textField.text isEqualToString:@""]) {
 textField.text = @"0";
 }
 return YES;
 } else {
 return NO;
 }
 }
 }
 }
 */


+(CGFloat)calculateTitleHeight:(NSString *)str withMaxWidth:(CGFloat)width andFont:(UIFont *)font{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGSize size1 = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return size1.height;
}

+(CGFloat)calculateTitleWidth:(NSString *)str withMaxHeight:(CGFloat)height andFont:(UIFont*)font{
    CGSize size = CGSizeMake(MAXFLOAT,height);
    CGSize size1 = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil].size;
    return size1.width;
}

+(NSAttributedString *)addColorString:(NSString *)str font:(UIFont *)font color:(UIColor *)color range:(NSRange)range{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    [attr addAttribute:NSFontAttributeName value:font range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attr;
}

/**
 显示当前文字需要几行
 @param width 给定一个宽度
 @return 返回行数
 */
- (NSInteger)needLinesWithWidth:(CGFloat)width withFont:(UIFont *)font andString:(NSString *)str{
    //创建一个labe
    UILabel * label = [[UILabel alloc]init];
    //font和当前label保持一致
    label.font = font;
    NSString * text = str;
    NSInteger sum = 0;
    //总行数受换行符影响，所以这里计算总行数，需要用换行符分隔这段文字，然后计算每段文字的行数，相加即是总行数。
    NSArray * splitText = [text componentsSeparatedByString:@"\n"];
    for (NSString * sText in splitText) {
        label.text = sText;
        //获取这段文字一行需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        //size.width/所需要的width 向上取整就是这段文字占的行数
        NSInteger lines = ceilf(textSize.width/width);
        //当是0的时候，说明这是换行，需要按一行算。
        lines = lines == 0?1:lines;
        sum += lines;
    }
    return sum;
}

- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
    
}

/**
 判断字符串是否同时包含字母和数字
 
 @param numAndChar 字符串
 @return 结果
 */
+(BOOL)validateWithNumAndChar:(NSString *)numAndChar{
    //去掉所有的空格
    numAndChar = [numAndChar stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //筛选数字条件
    NSRegularExpression *NumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger NumMatchCount = [NumRegularExpression numberOfMatchesInString:numAndChar options:NSMatchingReportProgress range:NSMakeRange(0, numAndChar.length)];
    
    if(NumMatchCount == numAndChar.length){
        //纯数字
        return NO;
    }
    
    //筛选字母条件
    NSRegularExpression *LetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger LetterMatchCount = [LetterRegularExpression numberOfMatchesInString:numAndChar options:NSMatchingReportProgress range:NSMakeRange(0, numAndChar.length)];
    
    if(LetterMatchCount == numAndChar.length){
        //纯字母
        return NO;
    }
    
    if(NumMatchCount + LetterMatchCount == numAndChar.length){
        //包含字母和数字
        return YES;
    }else{
        //包含字母和数字之外的其他字符
        return NO;
    }
}
/*
 kCFNumberFormatterRoundCeiling = 0,//四舍五入,直接输出3
 kCFNumberFormatterRoundFloor = 1,//保留小数输出2.8
 kCFNumberFormatterRoundDown = 2,//加上了人民币标志,原值输出￥2.8
 kCFNumberFormatterRoundUp = 3,//本身数值乘以100后用百分号表示,输出280%
 kCFNumberFormatterRoundHalfEven = 4,//输出2.799999999E0
 kCFNumberFormatterRoundHalfDown = 5,//原值的中文表示,输出二点七九九九。。。。
 kCFNumberFormatterRoundHalfUp = 6//原值中文表示,输出第三

 */
//CFNumberFormatterRoundingMode:
+ (NSString *)chineseWithInteger:(NSInteger)integer{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)integer]];
    return string;
}

+(NSString *)transformToPinyin:(NSString *)name{
    NSMutableString * mutableString = [NSMutableString stringWithString:name];
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return mutableString.lowercaseString;
}

+ (NSString *)getPinyinWithString:(NSString *)string{
    NSString * pinyin;
    if ([string length]) {
        NSMutableString * ms = [[NSMutableString alloc] initWithString:string];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform( (__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
        pinyin = ms;
    }
    return pinyin;
}

@end



@implementation NSObject (Functions)

@end
