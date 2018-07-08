//
//  AKRectangleView.m
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKRectangleView.h"
#import "AKLabelUtil.h"
#import <UIKit/UIKit.h>

@interface AKRectangleView()
@property (nonatomic, assign) CGRect rect;
@end

@implementation AKRectangleView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIBezierPath *)bezierPath {
    self.rect = [self convertRectFromTwoPoint];
    return [UIBezierPath bezierPathWithRect:self.rect];
}

- (CALayer *)AKLayer{
    CAShapeLayer *layer = (CAShapeLayer *)[super AKLayer];
    layer.path = self.bezierPath.CGPath;
    return layer;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Rect from (%.2lf,%.2lf) to (%.2lf,%.2lf)",self.startPoint.x,self.startPoint.y,self.endPoint.x,self.endPoint.y];
}

- (CGRect)convertRectFromTwoPoint{
    CGPoint startPoint = [self translateAKPointToCGPoint:self.startPoint];
    CGPoint endPoint = [self translateAKPointToCGPoint:self.endPoint];
    //应满足startPoint.x < endPoint.y, startPoint.y < endPoint.y
    if (startPoint.x > endPoint.x) {
        AKSwapCGFloat(&startPoint.x, &endPoint.x);
    }
    if (startPoint.y > endPoint.y) {
        AKSwapCGFloat(&startPoint.y, &endPoint.y);
    }
    return CGRectMake(startPoint.x, startPoint.y, fabs(startPoint.x - endPoint.x), fabs(startPoint.y - endPoint.y));
}



@end
