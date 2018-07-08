//
//  AKLineView.m
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKLineView.h"
#import "AKLabelUtil.h"
@implementation AKLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIBezierPath *)bezierPath{
    CGPoint startPoint = [self translateAKPointToCGPoint:self.startPoint];
    CGPoint endPoint = [self translateAKPointToCGPoint:self.endPoint];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    return path;
}

- (CALayer *)AKLayer{
    CAShapeLayer *layer = (CAShapeLayer *)[super AKLayer];
    layer.path = self.bezierPath.CGPath;
    return layer;
}

- (BOOL)isPonitAtLine:(CGPoint)point{
    CGPoint startPoint = [self translateAKPointToCGPoint:self.startPoint];
    CGPoint endPoint = [self translateAKPointToCGPoint:self.endPoint];
    
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
//    // Closest distance from point to line
//    float distance = (float) fabs(((endPoint.x - startPoint.x) * (point.y - startPoint.y)) - ((startPoint.x - point.x) * (startPoint.y - endPoint.y)));
//    distance /= hypot(endPoint.x - startPoint.x, startPoint.y - endPoint.y);
//    return distance <= self.lineWidth/2+5 ? YES : NO;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Line From (%.2lf%.2lf) To (%.2lf,%.2lf)",self.startPoint.x,self.startPoint.y,self.endPoint.x,self.endPoint.y];
}
@end
