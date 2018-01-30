//
//  DHCacheNetWork.m
//  CacheRunner
//
//  Created by Shan David on 1/31/18.
//  Copyright © 2018 Shan David. All rights reserved.
//

#import "DHCacheNetWork.h"
#import <BFKit/BFKit.h>

@implementation DHCacheNetWork

-(instancetype)init{
    self = [super init];
    if (self) {
        //存储到network文件夹
        self.folderPath = [NSFileManager getCacheDirectoryForFile:@"Network"];
    }
    return self;
}

@end
