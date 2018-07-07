//
//  AKArrowView.h
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"

typedef NS_ENUM(NSInteger, AKArrowStyle) {
    AKArrowStyle_Normal = 0,//箭头普通模式
    AKArrowStyle_JoinPoint//箭头连接模式（箭尾和箭头两翼内侧的连接点连接起来）
};

@interface AKArrowView : AKView

/**
 箭头绘制类型
 */
@property (nonatomic, assign) AKArrowStyle arrowStyle;

/**
 起始点坐标
 */
@property (nonatomic, assign) AKPoint startPoint;

/**
 终点坐标
 */
@property (nonatomic, assign) AKPoint endPoint;

/**
 设置连接点距离箭头两翼的距离，只当arrowStyle为ARROW_JOINTPOINT时生效注意值的约束规则：
 *                        arrowHeight/4 <=value < arrowHeight/2 ,
 *                        超过或小于则默认取arrowHeight/4.
 */
@property (nonatomic, assign) NSInteger jointPointWidth;
/**
 * 模拟把箭头用一个矩形封装起来，以确定箭头的大小
 * 与箭头垂直的方向所在的边为高，水平的方向为宽
 */
/**
 * 箭头宽度 ，最大为1920,默认60
 */
@property (nonatomic, assign) NSInteger arrowRectWidth;
/**
 * 箭头高度,最大为1080，默认60
 */
@property (nonatomic, assign) NSInteger arrowRectHeight;

- (BOOL)isPointAtArrow:(CGPoint)point;
//- (void)calculateData;
@end
