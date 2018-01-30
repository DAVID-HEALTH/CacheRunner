//
//  SDWCache.m
//  CacheRunner
//
//  Created by Shan David on 1/30/18.
//  Copyright © 2018 Shan David. All rights reserved.
//

#import "SDWCache.h"
#import <BFKit/BFKit.h>

@implementation SDWCache

-(instancetype)initWithFolderPath:(NSString*)folderPath{

    self = [super init];
    if (self) {
        self.folderPath = folderPath;
    }
    return self;
}

-(BOOL)removeCacheWithKey:(NSString*)key{
    NSString* cacheFilePath = [self getCachePath:key];
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:cacheFilePath error:nil];
    return isSuccess;
}
-(BOOL)setCacheWithKey:(NSString*)key withValue:(NSString*)value{
    
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.folderPath isDirectory:&isDirectory]) {
        //不存在则创建缓存目录
        BOOL createIsSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:self.folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!createIsSuccess){
            //创建目录失败,中断操作,返回NO
            return NO;
        }
    }
    
    NSString* cacheFilePath = [self getCachePath:key];
    BOOL isSuccess = [value writeToFile:cacheFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return isSuccess;
}
-(NSString*)getCacheWithKey:(NSString*)key{
    NSString* cacheFilePath = [self getCachePath:key];
    //判断缓存文件是否存在,存在返回缓存值,否则返回nil
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        NSString* cacheValue = [NSString stringWithContentsOfFile:cacheFilePath encoding:NSUTF8StringEncoding error:nil];
        return cacheValue;
    }
    return nil;
}

-(BOOL)removeAllCache{
    //删除缓存下的所有缓存值,多用于清空缓存
    //删除缓存目录,再重新创建该目录,除去遍历的方法
    //1.判断缓存文件夹是否存在
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.folderPath isDirectory:&isDirectory]) {
        //不存在则返回成功
        return YES;
    }
    //删除目录是否成功
    BOOL removeIsSuccess = [[NSFileManager defaultManager] removeItemAtPath:self.folderPath error:nil];
    
    return removeIsSuccess;
}
//根据缓存的主键生成cachePath的方法
-(NSString*)getCachePath:(NSString*)key{
    //对缓存的key进行编码的方法,编码的原因在于有些字符如"/"不能作为文件名,应该进行编码,保证一致性,默认进行md5编码
    NSString* cacheEncodeKey = [self encodeCacheKey:key];
    return [NSString stringWithFormat:@"%@/%@",self.folderPath,cacheEncodeKey];
}

//对缓存的key进行编码的方法,子类可以重写,一般情况下没必要,编码的原因在于有些字符如"/"不能作为文件名,应该进行编码,保证一致性,默认进行md5编码
-(NSString*)encodeCacheKey:(NSString*)key{
    return [BFCryptor MD5:key];
}

@end
