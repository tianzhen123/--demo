//
//  RecommendCollectionViewCell.h
//  Wendao
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 Jyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recommend.h"
@interface RecommendCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)UIImageView *MyImage;
@property (nonatomic,strong)UILabel * myTitle;

@property (nonatomic,strong)Recommend * commend;

@end
