//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  LTBaiduNetDiskiPhonePod.m
//  LTBaiduNetDiskiPhonePod
//
//  Created by 裕福 on 2018/8/20.
//  Copyright (c) 2018年 裕福. All rights reserved.
//

#import "LTBaiduNetDiskiPhonePod.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>

CHDeclareClass(BDUser)

CHOptimizedClassMethod0(self, BOOL, BDUser, isSVIP){
    return YES;
}
CHOptimizedClassMethod0(self, BOOL, BDUser, svipExpireTime){
    return [[NSDate dateWithTimeIntervalSinceNow:1 * 365 * 24 * 60 * 60] timeIntervalSince1970];
}

CHDeclareClass(BDPanCloudFileListViewController)

CHOptimizedMethod1(self, void, BDPanCloudFileListViewController, viewWillAppear, BOOL, arg1){
    CHSuper1(BDPanCloudFileListViewController, viewWillAppear, arg1);
    
    NSString *userId = ((id (*)(id, SEL))objc_msgSend)(objc_getClass("BDUser"),@selector(userId));
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *originDic = [ud objectForKey:userId];
    NSLog(@"%@ == %@",userId,originDic);
    
    NSTimeInterval expireTime = [[NSDate dateWithTimeIntervalSinceNow:1 * 365 * 24 * 60 * 60] timeIntervalSince1970];
    NSString *expireTimeStr = [NSString stringWithFormat:@"%f",expireTime];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:originDic];
    [dic setValue:@YES forKey:@"isSVipUser"];
    [dic setValue:expireTimeStr forKey:@"SVipExpireTime"];
    [ud setObject:dic forKey:userId];
}

CHDeclareClass(DownTransListViewController)

CHOptimizedMethod1(self, void, DownTransListViewController, viewWillAppear, BOOL, arg1){
    CHSuper1(DownTransListViewController, viewWillAppear, arg1);
    NSString *userId = ((id (*)(id, SEL))objc_msgSend)(objc_getClass("BDUser"),@selector(userId));
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *originDic = [ud objectForKey:userId];
    NSLog(@"%@ == %@",userId,originDic);
    
    NSTimeInterval expireTime = [[NSDate dateWithTimeIntervalSinceNow:1 * 365 * 24 * 60 * 60] timeIntervalSince1970];
    NSString *expireTimeStr = [NSString stringWithFormat:@"%f",expireTime];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:originDic];
    [dic setValue:@YES forKey:@"isSVipUser"];
    [dic setValue:expireTimeStr forKey:@"SVipExpireTime"];
    [ud setObject:dic forKey:userId];
}


CHConstructor{
    CHLoadLateClass(BDUser);
    CHLoadLateClass(BDPanCloudFileListViewController);
    CHLoadLateClass(DownTransListViewController);
    CHClassHook0(BDUser, isSVIP);
    CHClassHook0(BDUser, svipExpireTime);
    
    CHHook1(BDPanCloudFileListViewController, viewWillAppear);
    CHHook1(DownTransListViewController, viewWillAppear);
}
