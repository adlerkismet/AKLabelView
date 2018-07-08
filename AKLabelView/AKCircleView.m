//
//  AKCircle.m
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKCircleView.h"

@implementation AKCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIBezierPath *)bezierPath{
    CGFloat radius = MIN((CGFloat)self.presentViewSize.width / SOURCE_WIDTH, (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT) * self.radius;
    return [UIBezierPath bezierPathWithArcCenter:[self translateAKPointToCGPoint:self.originPoint] radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
}

- (CALayer *)AKLayer{
    CAShapeLayer *layer = (CAShapeLayer *)[super AKLayer];
    layer.path = self.bezierPath.CGPath;
    return layer;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"AKPolygonView with origin:(%.2lf,%.2lf) radius:%.2lf",self.originPoint.x,self.originPoint.y,self.radius];
}
@end
