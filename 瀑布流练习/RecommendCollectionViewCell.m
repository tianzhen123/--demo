//
//  RecommendCollectionViewCell.m
//  Wendao
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 Jyp. All rights reserved.
//

#import "RecommendCollectionViewCell.h"
#import "UIImage+MultiFormat.h"
#import "UIImageView+WebCache.h"
@implementation RecommendCollectionViewCell

- (void)setCommend:(Recommend *)commend
{
    self.myTitle.text = commend.title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _MyImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_MyImage];
        
        _myTitle = [[UILabel alloc]init];
        [self.contentView addSubview:_myTitle];
        _myTitle.numberOfLines = 0;
        
    }
    return self;
}




-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _MyImage.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
    
    //_myTitle.frame = CGRectMake(0, CGRectGetMaxY(_MyImage.frame), layoutAttributes.frame.size.width, 100);
    
}








//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//    
//    self.MyImage.image = nil;
//    
//    self.MyImage.frame = self.contentView.bounds;
//}
//


@end
