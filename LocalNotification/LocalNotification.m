//
//  LocalNotification.m
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/8/11.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import "LocalNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface LocalNotification ()<UNUserNotificationCenterDelegate>

@end

@implementation LocalNotification
static LocalNotification * shareManager = nil;

+ (LocalNotification *)shareMG {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

    shareManager = [[LocalNotification alloc]init];

    });

   return shareManager;

}

- (instancetype)init{
    if (self = [super init]) {
        if (@available(iOS 10.0, *)) {
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    return ;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                
            }];
            
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;

        }else{
            if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
                UIMutableUserNotificationCategory *category = [UIMutableUserNotificationCategory new];
                category.identifier = @"";
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
            }
        }
        
    }
    return  self;
}

- (void)showNotification:(NSString *)body{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"主题";
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    
    UNNotificationRequest  *request = [UNNotificationRequest requestWithIdentifier:[NSUUID UUID].UUIDString content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error _%@",(error.localizedDescription));
            }
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:notification.request.content.body preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    [[self getCurrentVC]  presentViewController:alertController animated:YES completion:nil];

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    completionHandler();
}

//获取当前controller
- (UIViewController *)getCurrentVC {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].delegate.window rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    
    return resultVC;
}


#pragma mark - private method

- (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end
