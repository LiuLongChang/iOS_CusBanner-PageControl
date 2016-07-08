//
//  ShowView_Baner.m
//  CFFCProject
//
//  Created by langyue on 16/7/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ShowView_Baner.h"



@interface ShowView_Baner()
{

}

@end


@implementation ShowView_Baner

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        UIScrollView * scroll = [UIFactory makeScrollView_ToView:self];
        self.scrollView = scroll;
        scroll.delegate = self;
        [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

    }
    return self;
}


+(instancetype)makeShowViewBanner_ImgArray:(NSArray*)imageArr ToView:(UIView*)superView ConstraintMake:(void(^)(MASConstraintMaker *make))block{

    ShowView_Baner * banner = [[ShowView_Baner alloc] initWithFrame:CGRectZero];
    [superView addSubview:banner];
    [banner mas_makeConstraints:block];

    [banner.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(banner);
    }];
    [banner layoutIfNeeded];
    [banner layoutSubviews];
    banner.scrollView.pagingEnabled = YES;
    banner.scrollView.scrollEnabled = YES;
    banner.scrollView.showsVerticalScrollIndicator = NO;
    banner.scrollView.showsHorizontalScrollIndicator = NO;



    banner.pageControl = [CustomPageControl makePageControl_Numbers:imageArr.count ConstrateMaker:^(MASConstraintMaker *make) {

        make.left.right.bottom.equalTo(banner);
        make.height.mas_equalTo(25);


    } ToView:banner];




    CGFloat bannerWidth = CGRectGetWidth(banner.bounds);
    banner.dataArrayImg = (NSMutableArray*)imageArr;
    banner.scrollView.contentOffset = CGPointMake(bannerWidth, 0);


    banner.leftImgView = [UIFactory makeImageView_ToView:banner.scrollView];
    banner.middleImgView = [UIFactory makeImageView_ToView:banner.scrollView];
    banner.rightImgView = [UIFactory makeImageView_ToView:banner.scrollView];
    banner.leftImgView.userInteractionEnabled = YES;
    banner.middleImgView.userInteractionEnabled = YES;
    banner.rightImgView.userInteractionEnabled = YES;


    [banner.middleImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:banner action:@selector(bannerClickAction:)]];


    [banner.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(bannerWidth);
        make.height.equalTo(banner);

    }];

    [banner.middleImgView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(banner.leftImgView.mas_right);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(bannerWidth);
        make.height.equalTo(banner);

    }];

    
    [banner.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(banner.middleImgView.mas_right);
        make.top.top.mas_equalTo(0);
        make.width.mas_equalTo(bannerWidth);
        make.height.equalTo(banner);

    }];

    banner.scrollView.contentSize = CGSizeMake(bannerWidth * 3, 0);


    [banner.scrollView layoutIfNeeded];
    [banner.scrollView layoutSubviews];



    if (imageArr != nil && imageArr.count != 0) {

        [banner.middleImgView setImage:imageArr[0]];
        banner.nowMiddleIndex = 0;

/*
 *  初始化图片
 *
 */

//        当有3个或者以上
        if (imageArr.count >= 3) {
            [banner.leftImgView setImage:imageArr.lastObject];
            [banner.rightImgView setImage:imageArr[1]];
        }
//  当有两个时
        if (imageArr.count == 2) {
            [banner.leftImgView setImage:imageArr[1]];
            [banner.rightImgView setImage:imageArr[1]];
        }
//        当有一个时
        if (imageArr.count == 1) {
            banner.scrollView.contentSize = CGSizeMake(bannerWidth, CGRectGetHeight(banner.bounds));
            banner.scrollView.contentOffset = CGPointMake(0, 0);
        }


    }

    return banner;
}



#pragma mark Banner图的点击事件

-(void)bannerClickAction:(UIGestureRecognizer *)tap{

    if (self.bannerActionBlock != nil) {
        self.bannerActionBlock(self.nowMiddleIndex);
    }
}



#pragma mark ScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{



//当进行正向滑动
    if (scrollView.contentOffset.x == scrollView.bounds.size.width*2) {
        //摆放图片

        if (self.dataArrayImg.count >= 3) {

            self.nowMiddleIndex += 1;

            if (self.nowMiddleIndex == self.dataArrayImg.count-1) {


                [self.leftImgView setImage:self.dataArrayImg[self.nowMiddleIndex-1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[0]];

            }else if(self.nowMiddleIndex == self.dataArrayImg.count){

                self.nowMiddleIndex = 0;
                [self.leftImgView setImage:self.dataArrayImg.lastObject];
                [self.middleImgView setImage:self.dataArrayImg[0]];
                [self.rightImgView setImage:self.dataArrayImg[1]];

            }else{

                [self.leftImgView setImage:self.dataArrayImg[self.nowMiddleIndex-1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[self.nowMiddleIndex+1]];

            }

        }


        if (self.dataArrayImg.count == 2) {

            if (self.nowMiddleIndex == 0) {
                self.nowMiddleIndex = 1;
                [self.leftImgView setImage:self.dataArrayImg[0]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[0]];


            }else if (self.nowMiddleIndex == 1){
                self.nowMiddleIndex = 0;
                [self.leftImgView setImage:self.dataArrayImg[1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[1]];
            }

        }

        [self.pageControl currentPage:self.nowMiddleIndex];
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0)];


    }

//当进行反向滑动
    if (scrollView.contentOffset.x == 0) {
        //摆放图片
        if (self.dataArrayImg.count >= 3) {

            self.nowMiddleIndex -= 1;


            
            if (self.nowMiddleIndex == -1) {

                self.nowMiddleIndex = self.dataArrayImg.count - 1;
                [self.leftImgView setImage:self.dataArrayImg[self.nowMiddleIndex-1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[0]];

            }else if(self.nowMiddleIndex == 0){


                [self.leftImgView setImage:self.dataArrayImg.lastObject];
                [self.middleImgView setImage:self.dataArrayImg[0]];
                [self.rightImgView setImage:self.dataArrayImg[1]];

                
            }else{


                NSLog(@"++++++++++::::: %d",self.nowMiddleIndex);

                [self.leftImgView setImage:self.dataArrayImg[self.nowMiddleIndex-1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[self.nowMiddleIndex+1]];
            }
        }


        if (self.dataArrayImg.count == 2) {

            if (self.nowMiddleIndex == 0) {
                self.nowMiddleIndex = 1;
                [self.leftImgView setImage:self.dataArrayImg[0]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[0]];
            }else if (self.nowMiddleIndex == 1){
                self.nowMiddleIndex = 0;
                [self.leftImgView setImage:self.dataArrayImg[1]];
                [self.middleImgView setImage:self.dataArrayImg[self.nowMiddleIndex]];
                [self.rightImgView setImage:self.dataArrayImg[1]];
            }

        }

        [self.pageControl currentPage:self.nowMiddleIndex];
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0)];

    }


//正滑、反滑 都立即变成展示中间ImageView图片



}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{




}





@end
