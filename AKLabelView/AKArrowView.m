//
//  AKArrowView.m
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//



#import "AKArrowView.h"
#import "AKLabelUtil.h"


@interface AKArrowView()
@property (nonatomic, assign) CGPoint startCGPoint;
@property (nonatomic, assign) CGPoint endCGPoint;
@property (nonatomic, assign) CGFloat arrowLength;
@property (nonatomic, assign) CGFloat arrowRectHeightF;
@property (nonatomic, assign) CGFloat arrowRectWidthF;
@property (nonatomic, assign) CGFloat jointPointWidthF;
@property (nonatomic, assign) CGPoint arrowLeftPoint;
@property (nonatomic, assign) CGPoint arrowRightPoint;
@property (nonatomic, assign) CGPoint arrowLeftJoinPoint;
@property (nonatomic, assign) CGPoint arrowRightJoinPoint;

/**
 箭头与箭头两翼连线的交点
 */
@property (nonatomic, assign) CGPoint arrowNodePoint;
@end
@implementation AKArrowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValue];
    }
    return self;
}

- (void)initValue{
    _arrowRectWidth = 60;
    _arrowRectHeight = 60;
}



- (UIBezierPath *)bezierPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self calculateData];
    if (self.arrowStyle == AKArrowStyle_Normal) {
        [path moveToPoint:self.startCGPoint];
        [path addLineToPoint:self.endCGPoint];
        [path addLineToPoint:self.arrowLeftPoint];
        [path moveToPoint:self.endCGPoint];
        [path addLineToPoint:self.arrowRightPoint];
    } else {
        [path moveToPoint:self.startCGPoint];
        [path addLineToPoint:self.arrowLeftJoinPoint];
        [path addLineToPoint:self.arrowLeftPoint];
        [path addLineToPoint:self.endCGPoint];
        [path addLineToPoint:self.arrowRightPoint];
        [path addLineToPoint:self.arrowRightJoinPoint];
        [path closePath];
    }
    return path;
}

- (CALayer *)AKLayer{
    CAShapeLayer *layer = (CAShapeLayer *)[super AKLayer];
    self.lineJoinType = LineJoinTypeRound;
    layer.path = self.bezierPath.CGPath;
    return layer;
}

//- (NSString *)description{
//    return [NSString stringWithFormat:@"AKPolygonView with origin:(%d,%d) radius:%ld",self.originPoint.x,self.originPoint.y,self.radius];
//}
#pragma mark - Method
- (void)calculateData{
    [self calculateLengthOfArrow];
    [self calculateArrowNodePoint];
    [self calculateCoordinate];
}

/**
 计算从箭尾到箭头的长度
 */
- (void)calculateLengthOfArrow{
    self.startCGPoint = [self translateAKPointToCGPoint:self.startPoint];
    self.endCGPoint = [self translateAKPointToCGPoint:self.endPoint];
    self.arrowRectWidthF = MIN((CGFloat)self.presentViewSize.width / SOURCE_WIDTH, (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT) * self.arrowRectWidth;
    self.arrowRectHeightF = MIN((CGFloat)self.presentViewSize.width / SOURCE_WIDTH, (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT) * self.arrowRectHeight;
    self.jointPointWidthF = MIN((CGFloat)self.presentViewSize.width / SOURCE_WIDTH, (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT) * self.jointPointWidth;
    if (self.jointPointWidthF < (self.arrowRectHeightF/4) || self.jointPointWidthF > (self.arrowRectHeightF/2)) {
        self.jointPointWidthF = self.arrowRectHeightF/4;
    }
    CGFloat doubleSum = powf((self.startCGPoint.x - self.endCGPoint.x), 2) + powf((self.startCGPoint.y - self.endCGPoint.y), 2);
    self.arrowLength = fabsf(sqrtf(doubleSum));
}

- (void)calculateArrowNodePoint{
    CGFloat t = self.arrowRectHeightF / self.arrowLength;
    CGPoint arrowNode;
    arrowNode.x = (t * self.startCGPoint.x) + (1 - t) * self.endCGPoint.x;
    arrowNode.y = (t * self.startCGPoint.y) + (1 - t) * self.endCGPoint.y;
    self.arrowNodePoint = arrowNode;
}

- (void)calculateCoordinate{
    CGFloat arrowLineA,arrowLineB,arrowLineC;
    AKTranslateTwoPointsToLinearEquation(self.startCGPoint, self.endCGPoint, &arrowLineA, &arrowLineB, &arrowLineC);
    NSLog(@"arrowLine(%f,%f,%f)",arrowLineA,arrowLineB,arrowLineC);
    [self calculateArrowNodePoint];
    
    CGFloat nodeLineA,nodeLineB,nodeLineC;
    AKTranslatePointAndNormalToLinearEquation(self.arrowNodePoint, -arrowLineA/arrowLineB, &nodeLineA, &nodeLineB, &nodeLineC);
    NSLog(@"nodeLine(%f,%f,%f)",nodeLineA,nodeLineB,nodeLineC);
    
    CGFloat arrowLeftLineA,arrowLeftLineB,arrowLeftLineC;
    AKTranslateArcAndLineToLinearEquation(arrowLineA, arrowLineB, arrowLineC, self.arrowRectHeightF, self.arrowRectWidthF, true, self.endCGPoint, &arrowLeftLineA, &arrowLeftLineB, &arrowLeftLineC);
    NSLog(@"arrowLeftLine(%f,%f,%f)",arrowLeftLineA,arrowLeftLineB,arrowLeftLineC);
    
    CGFloat arrowRightLineA,arrowRightLineB,arrowRightLineC;
    AKTranslateArcAndLineToLinearEquation(arrowLineA, arrowLineB, arrowLineC, self.arrowRectHeightF, self.arrowRectWidthF, false, self.endCGPoint, &arrowRightLineA, &arrowRightLineB, &arrowRightLineC);
    NSLog(@"arrowRightLine(%f,%f,%f)",arrowRightLineA,arrowRightLineB,arrowRightLineC);
    
    CGPoint leftPoint,rightPoint;
    AKCalculateLinearEquationInTwoUnknows(nodeLineA, nodeLineB, nodeLineC, arrowLeftLineA, arrowLeftLineB, arrowLeftLineC, &(leftPoint.x), &(leftPoint.y));
    self.arrowLeftPoint = leftPoint;
    AKCalculateLinearEquationInTwoUnknows(nodeLineA, nodeLineB, nodeLineC, arrowRightLineA, arrowRightLineB, arrowRightLineC, &(rightPoint.x), &(rightPoint.y));
    self.arrowRightPoint = rightPoint;
    NSLog(@"arrowLeftPoint:(%f,%f),arrowRightPoint:(%f,%f)",self.arrowLeftPoint.x,self.arrowLeftPoint.y,self.arrowRightPoint.x,self.arrowRightPoint.y);
    
    /**
     * 计算连接点坐标
     * 根据数学公式：x = t * x1 + (1-t)*x2;
     * y = t *y1+(1-t)*y2;
     * 详见：https://zhidao.baidu.com/question/135331342722976325.html?qbl=relate_question_0
     * t可由占比求得；
     */
    if (self.arrowStyle == AKArrowStyle_JoinPoint) {
        CGFloat t1,t2;
        t1 = (self.arrowRectHeightF - self.jointPointWidthF) / self.arrowRectHeightF;
        _arrowLeftJoinPoint.x = t1 * self.arrowLeftPoint.x + (1 - t1) * self.arrowRightPoint.x;
        _arrowLeftJoinPoint.y = t1 * self.arrowLeftPoint.y + (1 - t1) * self.arrowRightPoint.y;
        t2 = 1 - t1;
        _arrowRightJoinPoint.x = t2 * self.arrowLeftPoint.x + (1 - t2) * self.arrowRightPoint.x;
        _arrowRightJoinPoint.y = t2 * self.arrowLeftPoint.y + (1 - t2) * self.arrowRightPoint.y;
    }
}

- (BOOL)isPonitAtLine:(CGPoint)point startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    //直线1为两点连线的直线
    CGFloat a1,b1,c1,a2,b2,c2;
    AKTranslateTwoPointsToLinearEquation(startPoint, endPoint, &a1, &b1, &c1);
    //直线2为过点p与直线1垂直的直线
    AKTranslatePointAndNormalToLinearEquation(point, -a1/b1, &a2, &b2, &c2);
    //计算直线1、2的交点
    CGFloat nodeX,nodeY;
    AKCalculateLinearEquationInTwoUnknows(a1, b1, c1, a2, b2, c2, &nodeX, &nodeY);
    //判断交点是否在线段上
    if (!AKIsPointOnSegment(startPoint, endPoint, CGPointMake(nodeX, nodeY))) {
        return NO;
    }
    float distance = (float) fabs(((endPoint.x - startPoint.x) * (point.y - startPoint.y)) - ((startPoint.x - point.x) * (startPoint.y - endPoint.y)));
    distance /= hypot(endPoint.x - startPoint.x, startPoint.y - endPoint.y);
    return distance <= self.lineWidth/2+5 ? YES : NO;
}

- (BOOL)isPointAtArrow:(CGPoint)point{
    BOOL isTouch = [self isPonitAtLine:point startPoint:self.startCGPoint endPoint:self.endCGPoint] || [self isPonitAtLine:point startPoint:self.endCGPoint endPoint:self.arrowLeftPoint] || [self isPonitAtLine:point startPoint:self.endCGPoint endPoint:self.arrowRightPoint];
    return isTouch;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Arrow From (%d,%d) To (%d,%d)",self.startPoint.x,self.startPoint.y,self.endPoint.x,self.endPoint.y];
}


@end
