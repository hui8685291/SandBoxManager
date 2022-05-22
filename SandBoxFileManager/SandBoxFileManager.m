//
//  SandBoxFileManager.m
//  ExDigitalKeySDK20_Example
//
//  Created by ecarx on 2021/9/2.
//  Copyright © 2021 yangqin. All rights reserved.
//

#import "SandBoxFileManager.h"
#import <GLMVVMKit/GLMVVMKit.h>
#import "DateFormatterSingleton.h"

@implementation SandBoxFileManager

//获取Documents目录
+ (NSString *)dirDoc {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

//获取Library目录
+ (void)dirLib {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@",libraryDirectory);
}

//获取Cache目录
+ (void)dirCache {
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
}

//获取Tmp目录
+ (void)dirTmp {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp: %@",tmpDirectory);
}

//创建文件夹
+ (BOOL )createDirName:(NSString *)DirName {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:DirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建目录
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹创建成功");
    } else {
        NSLog(@"文件夹创建失败");
    }
    
    return res;
 }

//创建文件
+ (BOOL)createFile:(NSString *)fileName dir:(NSString *)dirName {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dirName];
    BOOL isCreateDir = [self createDirName:dirName];
    if (isCreateDir) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
        BOOL res = [fileManager createFileAtPath:testPath contents:nil attributes:nil];
        if (res) {
            NSLog(@"文件创建成功: %@" ,testPath);
            return YES;
        } else {
            NSLog(@"文件创建失败");
        }
    }
    return NO;
}

//写文件
+ (void )writeFileContent:(NSString *)content file:(NSString *)fileName dir:(NSString *)dirName {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dirName];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:testPath]) {
        NSLog(@"文件存在");
        BOOL res = [content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (res) {
            NSLog(@"文件写入成功");
        } else {
            NSLog(@"文件写入失败");
        }
    } else {
        NSLog(@"文件不存在");
        BOOL res = [self createFile:fileName dir:dirName];
        if (res) {
            NSLog(@"文件创建成功: %@" ,testPath);
            BOOL res = [content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            if (res) {
                NSLog(@"文件写入成功");
            } else {
                NSLog(@"文件写入失败");
            }
        } else {
            NSLog(@"文件创建失败");
        }
    };
}

//读文件
+ (NSString *)readFile:(NSString *)fileName dir:(NSString *)dirName {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dirName];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
//    NSData *data = [NSData dataWithContentsOfFile:testPath];
//    NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *content=[NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件读取成功: %@",content);
    return content;
}

//文件属性
+ (void)fileAttriutesFile:(NSString *)fileName dir:(NSString *)dirName {
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:testPath error:nil];
    NSArray *keys;
    id key, value;
    keys = [fileAttributes allKeys];
    NSUInteger count = [keys count];
    for (NSInteger i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}

//删除文件
+ (void)deleteFile:(NSString *)fileName dir:(NSString *)dirName {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    BOOL res = [fileManager removeItemAtPath:testPath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    } else {
        NSLog(@"文件删除失败");
    }
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
}

#pragma mark -
+ (void)createPressureTestFile {
    [self createFile:@"test.txt" dir:@"pressureTest"];
}

+ (void)writePressureTestFIle:(NSString *)content {
    [self writeFileContent:content file:@"test.txt" dir:@"pressureTest"];
}

+ (NSString *)readPressureTestFile {
    return [self readFile:@"test.txt" dir:@"pressureTest"];
}

+ (void)deletePressureTestFile {
    [self deleteFile:@"test.txt" dir:@"pressureTest"];
}

#pragma mark - store
//冷启动记录
+ (void)coldBootRecord {
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    NSString *recordStr =  [NSString stringWithFormat:@"冷启动 1 次，applicationState：%ld", (long)state];
    if ([NSUserDefaults boolForKey:@"coldBootRecord"]) {
       NSNumber *totalNum = [NSUserDefaults readObjectWithKeyByEncoder:@"coldBootRecord"];
        NSInteger total = totalNum.integerValue;
        total += 1;
        recordStr = [NSString stringWithFormat:@"冷启动：%ld 次，applicationState：%ld",(long)total, (long)state];
        [NSUserDefaults writeObjectByEncoder:@(total) forKey:@"coldBootRecord"];
    } else {
        [NSUserDefaults writeObjectByEncoder:@(1) forKey:@"coldBootRecord"];
    }
    
    [self cacheRecord:recordStr];
    dispatch_semaphore_signal(sema);
}

+ (void)killMyself {
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    NSString *recordStr =  [NSString stringWithFormat:@"模拟被杀死 1 次，applicationState：%ld", (long)state];
    if ([NSUserDefaults boolForKey:@"killMyself"]) {
       NSNumber *totalNum = [NSUserDefaults readObjectWithKeyByEncoder:@"killMyself"];
        NSInteger total = totalNum.integerValue;
        total += 1;
        recordStr = [NSString stringWithFormat:@"模拟被杀死：%ld 次，applicationState：%ld",(long)total, (long)state];
        [NSUserDefaults writeObjectByEncoder:@(total) forKey:@"killMyself"];
    } else {
        [NSUserDefaults writeObjectByEncoder:@(1) forKey:@"killMyself"];
    }
    
    [self cacheRecord:recordStr];
    dispatch_semaphore_signal(sema);
}

+ (void)recordTotalBeaconNumber {
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    NSString *recordStr =  [NSString stringWithFormat:@"获取ibeacon广播感应记录满足条件进行连接的次数 1 次，applicationState：%ld", (long)state];
    if ([NSUserDefaults boolForKey:@"recordTotalBeaconNumber"]) {
       NSNumber *totalNum = [NSUserDefaults readObjectWithKeyByEncoder:@"recordTotalBeaconNumber"];
        NSInteger total = totalNum.integerValue;
        total += 1;
        recordStr = [NSString stringWithFormat:@"获取ibeacon广播感应记录满足条件进行连接的次数：%ld 次，applicationState：%ld",(long)total, (long)state];
        [NSUserDefaults writeObjectByEncoder:@(total) forKey:@"recordTotalBeaconNumber"];
    } else {
        [NSUserDefaults writeObjectByEncoder:@(1) forKey:@"recordTotalBeaconNumber"];
    }
    [self cacheRecord:recordStr];
    dispatch_semaphore_signal(sema);
}

+ (void)beaconConnectSuccessNumber {
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    NSString *recordStr =  [NSString stringWithFormat:@"捕获ibeacon广播感应记录进行连接成功的次数 1 次，applicationState：%ld",(long)state];
    if ([NSUserDefaults boolForKey:@"beaconConnectSuccessNumber"]) {
       NSNumber *totalNum = [NSUserDefaults readObjectWithKeyByEncoder:@"beaconConnectSuccessNumber"];
        NSInteger total = totalNum.integerValue;
        total += 1;
        recordStr = [NSString stringWithFormat:@"捕获ibeacon广播感应记录进行连接成功的次数：%ld 次，applicationState：%ld",(long)total, (long)state];
        [NSUserDefaults writeObjectByEncoder:@(total) forKey:@"beaconConnectSuccessNumber"];
    } else {
        [NSUserDefaults writeObjectByEncoder:@(1) forKey:@"beaconConnectSuccessNumber"];
    }
    [self cacheRecord:recordStr];
    dispatch_semaphore_signal(sema);
}

+ (void)cacheRecord:(NSString *)record {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [SandBoxFileManager readPressureTestFile];
        [SandBoxFileManager writePressureTestFIle:[NSString stringWithFormat:@"%@\n%@  ---- %@", str, [self getDateString], record]];
    });
}

+ (NSString *)getDateString{
    NSDateFormatter *formatter = [[DateFormatterSingleton sharedDateFormatter] receiveDateFormat:@"MM-dd HH:mm:ss.SSS"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
