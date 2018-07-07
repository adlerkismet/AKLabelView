//
//  AKLabelUtil.h
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/29.
//  Copyright © 2018年 kismet. All rights reserved.
//

#ifndef AKLabelUtil_h
#define AKLabelUtil_h

#include <stdio.h>
#include <CoreGraphics/CGBase.h>
#include <CoreGraphics/CoreGraphics.h>

/**
 计算两条直线方程（AX+BY=C）的交点
 
 @param a1 直线1的a值
 @param b1 直线1的b值
 @param c1 直线1的c值
 @param a2 直线1的a值
 @param b2 直线1的b值
 @param c2 直线1的c值
 @param x 交点的x坐标
 @param y 交点的y坐标
 @return 成功返回0
 */
int AKCalculateLinearEquationInTwoUnknows(CGFloat a1, CGFloat b1, CGFloat c1, CGFloat a2, CGFloat b2, CGFloat c2, CGFloat *x, CGFloat *y);

/**
 通过两点式求出形如（AX+BY=C）的直线方程
 
 @param p1 点1
 @param p2 点2
 @param a 所求出直线方程的a值
 @param b 所求出直线方程的b值
 @param c 所求出直线方程的c值
 @return 成功返回0
 */
int AKTranslateTwoPointsToLinearEquation(CGPoint p1, CGPoint p2, CGFloat *a, CGFloat *b, CGFloat *c);

/**
 通过某条直线方程及偏移角求出所需要的直线方程
 
 @param a0 偏移前的直线方程a值
 @param b0 偏移前的直线方程b值
 @param c0 偏移前的直线方程c值
 @param arrowRectHeightF 箭头头部的高度，可与宽度算出偏移角的大小
 @param arrowRectWidthF 箭头头部的宽度
 @param isLeftArc 是否往逆时针偏移
 @param p 偏移前后两条直线的交点
 @param a 偏移后的直线方程a值
 @param b 偏移后的直线方程b值
 @param c 偏移后的直线方程c值
 @return 成功返回0
 */
int AKTranslateArcAndLineToLinearEquation(CGFloat a0, CGFloat b0, CGFloat c0, CGFloat arrowRectHeightF, CGFloat arrowRectWidthF, bool isLeftArc, CGPoint p, CGFloat *a, CGFloat *b, CGFloat *c);

/**
 求过某点斜率为k的直线方程的垂直直线方程
 
 @param p 某点
 @param k 斜率
 @param a 所求直线的a值
 @param b 所求直线的b值
 @param c 所求直线的c值
 @return 成功返回0
 */
int AKTranslatePointAndNormalToLinearEquation(CGPoint p, CGFloat k, CGFloat *a, CGFloat *b, CGFloat *c);

/**
 求过某点斜率为k的直线方程
 
 @param p 某点
 @param k 斜率
 @param a 所求直线的a值
 @param b 所求直线的b值
 @param c 所求直线的c值
 @return 成功返回0
 */
int AKTranslatePointAndSlopeToLinearEquation(CGPoint p, CGFloat k, CGFloat *a, CGFloat *b, CGFloat *c);

/**
 判断点q是否在p1,p2的线段内
 算法参照https://blog.csdn.net/liangzhaoyang1/article/details/51088475
 @param p1 点1
 @param p2 点2
 @param q 点q
 @return 在线上返回true，不在返回false
 */
bool AKIsPointOnSegment(CGPoint p1, CGPoint p2, CGPoint q);

/**
 交换两个CGFloat值
 
 @param a 待交换值a
 @param b 待交换值b
 @return 成功返回0
 */
int AKSwapCGFloat(CGFloat *a, CGFloat *b);

#endif /* AKLabelUtil_h */
