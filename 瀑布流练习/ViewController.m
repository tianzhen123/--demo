//
//  ViewController.m
//  瀑布流练习
//
//  Created by mac on 16/1/4.
//  Copyright © 2016年 丁志杰 --- 银泰. All rights reserved.
//
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#import "ViewController.h"
#import "AoiroSoraLayout.h"
#import "Recommend.h"
#import "RecommendCollectionViewCell.h"
#import "UIImage+MultiFormat.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>


@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UIImage * image;
@property (nonatomic,assign)NSInteger itemHeight;
@property (nonatomic,strong)NSMutableArray * heightArray;
@property (nonatomic,strong)NSMutableArray * modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_collectionView];
    [self p_json];
    
    self.dataArray = [NSMutableArray array];
    self.heightArray = [NSMutableArray array];
    self.modelArray  = [NSMutableArray array];
}


#pragma mark -- json解析
- (void)p_json
{
    NSString * str = [NSString stringWithFormat:@"http://apis.guokr.com/handpick/article.json?limit=20&ad=1&category=all&retrieve_type=by_since"];
    
    NSURL * url = [NSURL URLWithString:str];
    // 创建请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    // 发送请求
   NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       


            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary * d in [dict objectForKey:@"result"]) {
                Recommend * m = [[Recommend alloc]init];
                [m setValuesForKeysWithDictionary:d];
                
                [self.modelArray addObject:m];
                
                
                // 获取图片
                UIImage * image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.headline_img]]];
                
                // 加到图片数组
                [self.dataArray addObject:image];
            
                // 获取图片的高度并按比例压缩
                NSInteger itemHeight = image.size.height * (((self.view.frame.size.width - 20) / 2 / image.size.width));
                
                
                NSNumber * number = [NSNumber numberWithInteger:itemHeight];
                
                [self.heightArray addObject:number];
               

            }
       
            dispatch_async(dispatch_get_main_queue(), ^{
            
            [_collectionView reloadData];
            
        });
        
      
    }];
    [dataTask resume]; // 开始请求

}

#pragma mark -- collectionView 布局
- (void)p_collectionView
{
    
    AoiroSoraLayout * layout = [[AoiroSoraLayout alloc]init];
    layout.interSpace = 5; // 每个item 的间隔
    layout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.colNum = 2; // 列数;
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
     [_collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

#pragma mark -- 返回每个item的高度
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    
    UIImage * image = self.dataArray[indexPath.row];
    return image.size.height * ((([UIScreen mainScreen].bounds.size.width-20)/2.0) / image.size.width);
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
       cell.MyImage.image = self.dataArray[indexPath.row];
    
       cell.commend = self.modelArray[indexPath.row];
  
       return cell;
}

#pragma mark -- 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第 %ld 个cell",(long)indexPath.row);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
