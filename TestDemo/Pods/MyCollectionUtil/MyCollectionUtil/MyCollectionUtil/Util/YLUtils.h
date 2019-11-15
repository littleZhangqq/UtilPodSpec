//
//  YLUtils.h
//  yilongyueche
//
//  Created by zhangqq on 2018/4/25.
//  Copyright © 2018年 张凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


inline static void removeSubviewsFrom(UIView *view){
    do {
        UIView *sub = view.subviews.lastObject;
        [sub removeFromSuperview];
    } while (view.subviews.count);
}

@interface YLUtils : NSObject

+(void)save:(id)value forKey:(NSString *)key;
+(id)getValueFromKey:(NSString *)key;
+(void)removeValueForKey:(NSString *)key;
+(UIViewController *)topViewController;
+ (UIViewController*)currentViewController;
+(void)showAlertWithOneButton:(NSString *)title message:(NSString *)msg buttonTitle:(NSString *)btn leftBlock:(void(^)(void))leftBlock;
+(UIAlertController *)showAlertWithTwoButton:(NSString *)title message:(NSString *)msg leftbuttonTitle:(NSString *)leftbtn leftBlock:(void(^)(void))leftBlock rightButtonTitle:(NSString *)rightButton rightBlock:(void(^)(void))rightBlock;
+ (NSString*)getPreferredLanguage;
+(void)showActionSheetViewWithTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)action1 andAction:(void(^)(UIAlertAction *action))actionBlock cancelAction:(NSString *)cancelTitle otherAction:(NSArray<NSString *> *)titleArr andOtherActionBlock:(NSArray <void(^)(UIAlertAction *action) > *)blockArray;

+ (NSString *)iphoneType;


@end

NS_ASSUME_NONNULL_END

