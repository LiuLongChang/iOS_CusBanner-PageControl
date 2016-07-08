//
//  CustomPageControl.h
//  CFFCProject
//
//  Created by langyue on 16/7/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface CustomPageControl : UIView



@property(nonatomic,retain)NSMutableArray * dataArray;


+(instancetype)makePageControl_Numbers:(int)num ConstrateMaker:(void(^)(MASConstraintMaker*))block ToView:(UIView*)superView;
-(void)currentPage:(int)index;


@end
