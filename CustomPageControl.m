//
//  CustomPageControl.m
//  CFFCProject
//
//  Created by langyue on 16/7/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

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
        self.dataArray = [NSMutableArray array];
    }
    return self;
}



+(instancetype)makePageControl_Numbers:(int)num ConstrateMaker:(void(^)(MASConstraintMaker*))block ToView:(UIView*)superView{


    CustomPageControl * page = [[CustomPageControl alloc] init];
    [superView addSubview:page];
    [page mas_makeConstraints:block];


    UIImageView * imgView = [UIFactory makeImageView_Image:[UIImage imageNamed:@"transluteSmall"] ToView:page];
    imgView.userInteractionEnabled = true;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(page);
        make.height.mas_equalTo(30);
    }];


    [page layoutIfNeeded];
    [page layoutSubviews];
    [imgView layoutIfNeeded];
    [imgView layoutSubviews];


    CGFloat spaceVer = 5/3*2;
    CGFloat width = 10/3*2;

    for (int i=0; i<num; i++) {

        UIButton * btn = [UIFactory makeButton_ToView:imgView];
        [page.dataArray addObject:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"newRadius"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"newRadiusSel"] forState:UIControlStateSelected];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo( (CGRectGetWidth(page.bounds) - spaceVer*num - (num-1)*spaceVer)/2 + i*(width+spaceVer));
            make.centerY.equalTo(page);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(width);

        }];
        if (i == 0) {
            btn.selected = YES;
        }

    }

    return page;

}






-(void)currentPage:(int)index{


    for (UIButton * btn in self.dataArray) {
        btn.selected = NO;
    }
    UIButton * btn = self.dataArray[index];
    btn.selected = YES;


}









@end
