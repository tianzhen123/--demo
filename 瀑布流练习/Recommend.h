//
//  Recommend.h
//  团队1.0
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recommend : NSObject

@property (nonatomic,strong)NSString *now; // 发布时间

@property (nonatomic,strong)NSString * headline_img; // 图片URL

@property (nonatomic,strong)NSString * title; // 标题

@property (nonatomic,strong)NSString * source_name; // 来源

@property (nonatomic,strong)NSString * link;

@property (nonatomic,strong)NSString * link_v2; // 详情网址

@property (nonatomic,strong)NSString * summary;  // 简介

@property (nonatomic,strong)NSString * author; // 作者

@property (nonatomic,strong)NSString * category; // 类型

@end
