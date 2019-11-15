//
//  Event.m
//
//  Created by zhangqq on 2018/3/7.
//  Copyright © 2018年 张强. All rights reserved.
//

#import "Event.h"

@interface Event()

@property(nonatomic, strong) NSMutableDictionary *eventTargetDic;
@property(nonatomic, strong) NSMutableArray *eventArray;
@property(nonatomic, unsafe_unretained) BOOL isDispatching;

@end

@implementation Event

- (instancetype)init{
    self = [super init];
    if (self) {
        _eventTargetDic = [NSMutableDictionary dictionary];
        _eventArray = [NSMutableArray array];
        _isDispatching = NO;
    }
    return self;
}

+(instancetype)getInstance{
    static Event *event = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        event = [[self alloc] init];
    });
    return event;
}

-(void)getTargetEvent:(NSString *)evt{
    
}

-(void)handleEvent:(NSString *)event data:(__weak id)data{
//    if (_isDispatching) {
//        return;
//    }
//    if ([event isEqualToString:EVENT_REMOVE_LAST_EVENT]) {
//        NSArray *array = (NSArray *)data;
//        for (NSString *event in array) {
//            NSMutableArray *eventarr = _eventTargetDic[event];
//            if (eventarr.count > 0) {
//                [eventarr removeLastObject];
//                continue;
//            }
//        }
//    }else{
        _isDispatching = YES;
        NSMutableArray *array = _eventTargetDic[event];
        if (array.count > 0) {
            EventCallback cb = [array lastObject];
            if (!cb(event,data)) {
                [_eventTargetDic removeObjectForKey:event];
            }else{
            }
        }
//    }
//    _isDispatching = NO;
}

-(void)addEvent:(NSString *)event priority:(EventDispatchPriority)priority cb:(EventCallback)cb{
    NSMutableArray *array = _eventTargetDic[event];
    if (!array) {
        array = [NSMutableArray array];
    }
    if (cb) {
        [array addObject:cb];
    }
    _eventTargetDic[event] = array;
}
@end
