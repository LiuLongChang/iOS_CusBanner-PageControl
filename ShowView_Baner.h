//
//  ShowView_Baner.h
//  CFFCProject
//
//  Created by langyue on 16/7/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"
#import "Masonry.h"


typedef void (^BannerActionBlock)(int index);



@interface ShowView_Baner : UIView<UIScrollViewDelegate>


@property(nonatomic,retain)UIScrollView * scrollView;


@property(nonatomic,retain)NSMutableArray * dataArrayImg;
@property(nonatomic,assign)int nowMiddleIndex;
@property(nonatomic,retain)UIImageView * leftImgView,* middleImgView,* rightImgView;




@property(nonatomic,copy)BannerActionBlock bannerActionBlock;
@property(nonatomic,retain)CustomPageControl * pageControl;




+(instancetype)makeShowViewBanner_ImgArray:(NSArray*)imageArr ToView:(UIView*)superView ConstraintMake:(void(^)(MASConstraintMaker *make))block;





@end
