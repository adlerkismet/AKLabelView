//
//  AKView.h
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import <UIKit/UIKit.h>
static const NSInteger SOURCE_WIDTH = 1920;
static const NSInteger SOURCE_HEIGHT = 1080;

typedef struct AKPoint {
    CGFloat x;
    CGFloat y;
}AKPoint;

typedef NS_ENUM(NSInteger,FillRuleType) {
    FillRuleTypeNonZero = 0,
    FillRuleTypeEvenOdd
};

typedef NS_ENUM(NSInteger,LineJoinType) {
    LineJoinTypeMiter = 0,
    LineJoinTypeRound,
    LineJoinTypeBevel
};

typedef NS_ENUM(NSInteger,LineCapType) {
    LineCapTypeButt = 0,
    LineCapTypeRound,
    LineCapTypeSquare
};

/**
 标签所在坐标系

 - CoordinateTypeLeftTop: 原点为左上角的坐标系（手机的屏幕坐标系）
 - CoordinateTypeLeftBottom: 原点为左下角坐标系（数学坐标系）
 */
typedef NS_ENUM(NSInteger,CoordinateType) {
    CoordinateTypeLeftTop = 0,
    CoordinateTypeLeftBottom
};

NS_ASSUME_NONNULL_BEGIN
@interface AKView : UIView

/**
 边框的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 边框的颜色
 */
@property (nonatomic, strong, nullable) UIColor *strokeColor;

/**
 填充颜色
 */
@property (nonatomic, strong, nullable) UIColor *fillColor;

/**
 虚线数组，定义了虚线中实线部分和间隔部分分别的长度，数组下标偶数为实线长度，奇数为间隔长度。
 */
@property (nonatomic, strong, nullable) NSArray<NSNumber *> *lineDashPattern;

/**
 标签的贝塞尔曲线
 */
@property (nonatomic, strong, readonly) UIBezierPath *bezierPath;

/**
 标签的CAShapeLayer
 */
@property (nonatomic, strong, readonly) CALayer *AKLayer;

///**
// 图标image
// */
//@property (nonatomic, strong) UIImage *image;

/**
 边框的起始点，取值[0,1],默认值为0
 */
@property (nonatomic, assign) CGFloat strokeStart;

/**
 边框的终点，取值[0,1],默认值为1
 */
@property (nonatomic, assign) CGFloat strokeEnd;

/**
 两直线之间的外夹角及内夹角之间的距离，仅当LineJoinType为LineJoinTypeMiter的时候有效。
 */
@property (nonatomic, assign) CGFloat miterLimit;

/**
 虚线的起始位置
 */
@property (nonatomic, assign) CGFloat lineDashPhase;

/**
 标签的透明度
 */
@property (nonatomic, assign) CGFloat opacity;

/**
 内部区域的填充样式
 */
@property (nonatomic, assign) FillRuleType fillRuleType;

/**
 线的交点的样式
 */
@property (nonatomic, assign) LineJoinType lineJoinType;

/**
 线的端点的样式
 */
@property (nonatomic, assign) LineCapType lineCapType;

/**
 标签源头所处坐标系类型
 */
@property (nonatomic, assign) CoordinateType coordinateType;

/**
 标签容器的尺寸
 */
@property (nonatomic, assign) CGSize presentViewSize;

/**
 单击标签的block
 */
@property (nonatomic, copy) void(^singleTapBlock)(void);

/**
 双击标签的block
 */
@property (nonatomic, copy) void(^doubleTapBlock)(void);

/**
 长按标签的block
 */
@property (nonatomic, copy) void(^longPressBlock)(void);

/**
 获取标签的贝塞尔曲线

 @return 标签的贝塞尔曲线
 */
- (UIBezierPath *)bezierPath;

/**
 获取标签的layer

 @return 标签的layer
 */
- (CALayer *)AKLayer;


/**
 将AKPoint类型源头的坐标点转成CGPoint类型的容器坐标点

 @param point AKPoint类型源头的坐标点
 @return CGPoint类型的容器坐标点
 */
- (CGPoint)translateAKPointToCGPoint:(AKPoint)point;
@end
NS_ASSUME_NONNULL_END
