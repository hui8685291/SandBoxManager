//
//  DateFormatterSingleton.h
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/7/30.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateFormatterSingleton : NSObject

+ (instancetype)sharedDateFormatter;

- (NSDateFormatter *)receiveDateFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
