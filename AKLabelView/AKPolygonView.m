//
//  AKPolygonView.m
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKPolygonView.h"
@interface AKPolygonView()
@property (nonatomic, copy) NSArray<NSValue *> *cgPoints;
@end
@implementation AKPolygonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIBezierPath *)bezierPath{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSValue *pointValue in self.points) {
        [mutableArray addObject:[NSValue valueWithCGPoint:[self translateAKPointToCGPoint:[pointValue AKPointValue]]]];
    }
    self.cgPoints = [mutableArray copy];
    if (self.cgPoints.count < 3) {
        return nil;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[self.cgPoints.firstObject CGPointValue]];
    for (NSInteger i = 1; i < self.cgPoints.count; i ++) {
        [path addLineToPoint:[self.cgPoints[i] CGPointValue]];
    }
    [path closePath];
    return path;
}

- (CALayer *)AKLayer{
    CAShapeLayer *layer = (CAShapeLayer *)[super AKLayer];
    layer.path = self.bezierPath.CGPath;
    return layer;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"AKPolygonView with path :%@",self.bezierPath];
}

@end

@implementation NSValue(AKPoint)
+ (NSValue *)valueWithAKPoint:(AKPoint)point{
    NSValue *pointValue = [NSValue value:&point withObjCType:@encode(struct AKPoint)];
    return pointValue;
}

- (AKPoint)AKPointValue{
    AKPoint point;
    [self getValue:&point];
    return point;
}
@end
