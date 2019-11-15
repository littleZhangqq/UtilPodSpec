//
//  NSString+Validate.m
//  OrderCar-Driver
//
//  Created by 伯明利 on 16/12/16.
//  Copyright © 2016年 lovcreate. All rights reserved.
//

#import "NSString+Validate.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

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
