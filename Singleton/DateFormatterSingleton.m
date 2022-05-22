//
//  DateFormatterSingleton.m
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/7/30.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import "DateFormatterSingleton.h"

@interface DateFormatterSingleton ()  {
    NSDateFormatter *_dateFormatter;
}
@end

@implementation DateFormatterSingleton

static DateFormatterSingleton *_sharedSingleton = nil;
+ (instancetype)sharedDateFormatter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          // 要使用self来调用
          if (_sharedSingleton == nil) {
            _sharedSingleton = [[DateFormatterSingleton alloc] init];
          }
    });
    return _sharedSingleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterFullStyle];
    }
    return self;
}

- (NSDateFormatter *)receiveDateFormat:(NSString *)dateFormat{
    [_dateFormatter setDateFormat:dateFormat];
    return _dateFormatter;
}

@end
