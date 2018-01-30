//
//  SDWCache.h
//  CacheRunner
//
//  Created by Shan David on 1/30/18.
//  Copyright © 2018 Shan David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDWCache : NSObject

//folderPath:用来存储cache的目录地址,
//注意:不能带后面的/,这个要注意
@property(strong,nonatomic)NSString* folderPath;

//通过folderPath来初始化缓存的实例
//注意:不能带后面的/,这个要注意
-(instancetype)initWithFolderPath:(NSString*)folderPath;
//通过缓存键删除缓存的方法,返回删除是否成功
-(BOOL)removeCacheWithKey:(NSString*)key;
//通过键来设置缓存的方法
-(BOOL)setCacheWithKey:(NSString*)key withValue:(NSString*)value;
//根据key来获取缓存的方法
-(NSString*)getCacheWithKey:(NSString*)key;
//删除目录下所有缓存的方法
-(BOOL)removeAllCache;

@end
