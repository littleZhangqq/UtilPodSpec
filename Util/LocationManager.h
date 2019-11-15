//
//  LocationManager.h
//  yqjy
//
//  Created by admin on 2019/9/14.
//  Copyright © 2019 易起. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "YLUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

@property(nonatomic, strong) CLLocationManager *manager;
@property(nonatomic, copy) void(^sucBlock)(NSString *city,CLLocation *result);
@property(nonatomic, copy) void(^failBlock)(NSString *error);
@property(nonatomic, unsafe_unretained) BOOL alreadyLocation;

-(CLAuthorizationStatus)currentStatus;

-(void)requestAuthor;
-(void)startLocation;

@end

NS_ASSUME_NONNULL_END
