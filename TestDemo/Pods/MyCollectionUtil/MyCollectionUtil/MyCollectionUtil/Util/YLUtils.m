//
//  YLUtils.m
//  yilongyueche
//
//  Created by zhangqq on 2018/4/25.
//  Copyright © 2018年 张凯. All rights reserved.
//

#import "YLUtils.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation YLUtils

+(void)save:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)getValueFromKey:(NSString *)key{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return value;
}

+(void)removeValueForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIViewController *)topViewController{
    UIViewController *resultVC;
    UIViewController *ctl = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([ctl isKindOfClass:[UINavigationController class]]) {
        resultVC = [(UINavigationController *)ctl topViewController];
    } else if ([ctl isKindOfClass:[UITabBarController class]]) {
        resultVC = [(UITabBarController *)ctl selectedViewController];
    } else {
        resultVC = ctl;
    }
    
    while (resultVC.presentedViewController) {
        resultVC = resultVC.presentedViewController;
    }
    return resultVC;
}

+ (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+(void)showAlertWithOneButton:(NSString *)title message:(NSString *)msg buttonTitle:(NSString *)btn leftBlock:(void(^)())leftBlock{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:btn style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftBlock();
    }];
    
    [alertCtl addAction:leftAction];;
    
    [[YLUtils topViewController] presentViewController:alertCtl animated:YES completion:nil];
}

+(UIAlertController *)showAlertWithTwoButton:(NSString *)title message:(NSString *)msg leftbuttonTitle:(NSString *)leftbtn leftBlock:(void(^)())leftBlock rightButtonTitle:(NSString *)rightButton rightBlock:(void(^)())rightBlock{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftbtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftBlock();
    }];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        rightBlock();
    }];
    
    [alertCtl addAction:leftAction];
    [alertCtl addAction:rightAction];
    
    [[YLUtils topViewController] presentViewController:alertCtl animated:YES completion:nil];
    return alertCtl;
}

+ (NSString*)getPreferredLanguage{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    [self save:preferredLang forKey:@"language"];
    return preferredLang;
}

+(void)showActionSheetViewWithTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)action1 andAction:(void(^)(UIAlertAction *action))actionBlock cancelAction:(NSString *)cancelTitle otherAction:(NSArray<NSString *> *)titleArr andOtherActionBlock:(NSArray <void(^)(UIAlertAction *action) > *)blockArray{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    if (action1) {
        UIAlertAction *first = [UIAlertAction actionWithTitle:action1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(action);
        }];
        [alertCtl addAction:first];
    }
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    if (titleArr.count > 0) {
        for (NSInteger i = 0; i<titleArr.count; i++) {
            [alertCtl addAction:[UIAlertAction actionWithTitle:titleArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (blockArray.count == 1) {
                    blockArray[0](action);
                }else{
                    blockArray[i](action);
                }
            }]];
        }
    }
//    [[YLUtils topViewController].view bringSubviewToFront:alertCtl.view];
    [[YLUtils topViewController] presentViewController:alertCtl animated:YES completion:nil];
}



+ (NSString *)iphoneType{//
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}


@end
