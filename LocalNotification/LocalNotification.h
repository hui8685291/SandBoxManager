//
//  LocalNotification.h
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/8/11.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalNotification : NSObject
+ (LocalNotification *)shareMG;
- (void)showNotification:(NSString *)body;
@end

NS_ASSUME_NONNULL_END
