//
//  SandBoxFileManager.h
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/9/2.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SandBoxFileManager : NSObject

//创建文件
+ (BOOL )createFile:(NSString *)fileName dir:(NSString *)dirName;

//写文件
+ (void )writeFileContent:(NSString *)content file:(NSString *)fileName dir:(NSString *)dirName;

//读文件
+ (NSString *)readFile:(NSString *)fileName dir:(NSString *)dirName;

//删除文件
+ (void)deleteFile:(NSString *)fileName dir:(NSString *)dirName;

#pragma mark -
+ (void)createPressureTestFile;

+ (void)writePressureTestFIle:(NSString *)content;

+ (NSString *)readPressureTestFile;

+ (void)deletePressureTestFile;

#pragma mark - store
//冷启动记录
+ (void)coldBootRecord;

+ (void)killMyself;

+ (void)recordTotalBeaconNumber;

+ (void)beaconConnectSuccessNumber;

@end

NS_ASSUME_NONNULL_END
