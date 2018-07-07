//
//  AKView.m
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"


@interface AKView()
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CALayer *AKLayer;
@end

@implementation AKView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupValue];
    }
    return self;
}

- (void)setupValue {
    _lineWidth = 1.0f;
    _strokeColor = [UIColor blackColor];
    _fillColor = [UIColor clearColor];
    _strokeStart = 0;
    _strokeEnd = 1;
    _miterLimit = 10.f;
    _lineDashPhase = 0;
    _opacity = 1;
    _fillRuleType = FillRuleTypeNonZero;
    _lineJoinType = LineJoinTypeMiter;
    _lineCapType = LineCapTypeButt;
    _coordinateType = CoordinateTypeLeftTop;
}

- (void)drawRect:(CGRect)rect {
    if (!UIGraphicsGetCurrentContext()) {
        return;
    }
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)drawInContext:(CGContextRef)ctx{
    
}

- (void)drawSelfInContext:(CGContextRef)ctx{
    
}

- (CGPathRef)CGPath{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    return pathRef;
}

- (void)centerDrawingInContext:(CGContextRef)ctx drawingExtent:(CGRect)drawingExtent scaleToFit:(BOOL)scaleToFit {
    float xScale = self.bounds.size.width / drawingExtent.size.width;
    float yScale = self.bounds.size.height / drawingExtent.size.height;
    float doScale = scaleToFit ? MIN(xScale, yScale) : 1.0;
    float xExtra = self.bounds.size.width - drawingExtent.size.width;
    float yExtra = self.bounds.size.height - drawingExtent.size.height;
    CGContextTranslateCTM(ctx, xExtra/2, yExtra/2);
    CGContextScaleCTM(ctx, doScale, doScale);
}

- (void)savingGStateInContext:(CGContextRef)ctx block:(void(^)(void))block{
    CGContextSaveGState(ctx);
    if (!block) {
        CGContextRestoreGState(ctx);
        return;
    }
    
    block();
    CGContextRestoreGState(ctx);
}
#pragma mark - Property
- (CALayer *)AKLayer{
    if (!_AKLayer) {
        _AKLayer = [CAShapeLayer layer];
    }
    CAShapeLayer *layer = (CAShapeLayer *)_AKLayer;
    layer.path = self.bezierPath.CGPath;
    layer.fillColor = self.fillColor.CGColor;
    layer.strokeColor = self.strokeColor.CGColor;
    layer.lineWidth = self.lineWidth;
    layer.strokeEnd = self.strokeEnd;
    layer.miterLimit = self.miterLimit;
    layer.lineDashPattern = self.lineDashPattern;
    layer.lineDashPhase = self.lineDashPhase;
    layer.strokeStart = self.strokeStart;
    layer.fillRule = [self convertStringWithFillRuleType:self.fillRuleType];
    layer.lineJoin = [self convertStringWithLineJoinType:self.lineJoinType];
    layer.lineCap = [self convertStringWithLineCapType:self.lineCapType];
    layer.opacity = self.opacity;
    layer.contentsGravity = kCAGravityResizeAspect;
    return layer;
}

- (CGPoint)translateAKPointToCGPoint:(AKPoint)point{
    CGPoint relativePoint;
    if (self.presentViewSize.width==0 || self.presentViewSize.height==0) {
        self.presentViewSize = [UIScreen mainScreen].bounds.size;
    }
    if (self.coordinateType == CoordinateTypeLeftTop) {
        relativePoint.x = (CGFloat)self.presentViewSize.width / SOURCE_WIDTH * point.x;
        relativePoint.y = (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT * point.y;
    }else{
        relativePoint.x = (CGFloat)self.presentViewSize.width / SOURCE_WIDTH * point.x;
        relativePoint.y = (CGFloat)self.presentViewSize.height / SOURCE_HEIGHT * (SOURCE_HEIGHT - point.y);
    }
    
    return relativePoint;
}

- (NSString *)convertStringWithFillRuleType:(FillRuleType)type{
    NSString *tempStr = @"";
    switch (type) {
        case FillRuleTypeNonZero:
            tempStr = kCAFillRuleNonZero;
            break;
            
        case FillRuleTypeEvenOdd:
            tempStr = kCAFillRuleEvenOdd;
            break;
    }
    return tempStr;
}

- (NSString *)convertStringWithLineJoinType:(LineJoinType)type{
    NSString *tempStr = @"";
    switch (type) {
        case LineJoinTypeMiter:
            tempStr = kCALineJoinMiter;
            break;

        case LineJoinTypeRound:
            tempStr = kCALineJoinRound;
            break;
        case LineJoinTypeBevel:
            tempStr = kCALineJoinBevel;
            break;
    }
    return tempStr;
}

- (NSString *)convertStringWithLineCapType:(LineCapType)type{
    NSString *tempStr = @"";
    switch (type) {
        case LineCapTypeButt:
            tempStr = kCALineCapButt;
            break;

        case LineCapTypeRound:
            tempStr = kCALineCapRound;
            break;
        case LineCapTypeSquare:
            tempStr = kCALineCapSquare;
            break;
    }
    return tempStr;
}

@end

