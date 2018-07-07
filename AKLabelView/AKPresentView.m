 //
//  AKPresentView.m
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKPresentView.h"
#import "AKLineView.h"
#import "AKArrowView.h"
#import "AKView.h"
static const CGFloat AlphaVisibleThreshold = 0.1f;
@interface AKPresentView()
@property (nonatomic, assign) NSTimeInterval firstTouchTimeInterval;
@property (nonatomic, assign) NSTimeInterval longPressTimeInterval;
@property (nonatomic, assign) NSTimeInterval doubleTapTimeInterval;
@property (nonatomic, assign) CGPoint firstTouchPoint;
@end

@interface UIView (ColorAtPixel)
- (UIColor *)colorAtPixel:(CGPoint)point;
@end

@implementation AKPresentView

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

- (void)setupValue{
    _longPressTimeInterval = .5f;
    _doubleTapTimeInterval = 0.25f;
    self.backgroundColor = [UIColor clearColor];
    self.layer.needsDisplayOnBoundsChange = YES;
    self.layer.masksToBounds = YES;
//    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//    self.layer.backgroundColor = [UIColor clearColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)redraw {
    [self.layer setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
    //清除上一次绘制的layer
    NSArray *tempArray = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer *layer in tempArray) {
        if ([layer.name hasPrefix:@"AKLayer"]) {
            [layer removeFromSuperlayer];
        }
    }
    //重新绘制
    [self.drawViewArray enumerateObjectsUsingBlock:^(AKView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.presentViewSize = self.bounds.size;
        view.AKLayer.name = [NSString stringWithFormat:@"AKLayer%ld",idx];
        [self.layer addSublayer:view.AKLayer];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]];
    if (touch.tapCount == 1) {
        self.firstTouchTimeInterval = touch.timestamp;
        self.firstTouchPoint = point;
        [self performSelector:@selector(longPressAt:) withObject:[NSValue valueWithCGPoint:point] afterDelay:self.longPressTimeInterval];
        return;
    }
    
    if (touch.tapCount == 2) {
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAt:) object:[NSValue valueWithCGPoint:self.firstTouchPoint]];
        [self doubleTapAt:point];
        return;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]];
    if (touch.tapCount == 1) {
        if (self.longPressTimeInterval > (touch.timestamp - self.firstTouchTimeInterval)) {
            [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(longPressAt:) object:[NSValue valueWithCGPoint:point]];
            [self performSelector:@selector(singleTapAt:) withObject:[NSValue valueWithCGPoint:point] afterDelay:self.doubleTapTimeInterval];
        }
        return;
    }
    
    if (touch.tapCount > 1) {
        return;
    }
}

#pragma mark - Hit testing

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point
{
    // Correct point to take into account that the image does not have to be the same size
    // as the button. See https://github.com/ole/OBShapedButton/issues/1
//    CGSize iSize = image.size;
//    CGSize bSize = self.bounds.size;
//    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
//    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor = [self colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)])
    {
        // available from iOS 5.0
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }
    else
    {
        // for iOS < 5.0
        // In iOS 6.1 this code is not working in release mode, it works only in debug
        // CGColorGetAlpha always return 0.
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= AlphaVisibleThreshold;
}


// UIView uses this method in hitTest:withEvent: to determine which subview should receive a touch event.
// If pointInside:withEvent: returns YES, then the subview’s hierarchy is traversed; otherwise, its branch
// of the view hierarchy is ignored.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // Return NO if even super returns NO (i.e., if point lies outside our bounds)
//    BOOL superResult = [super pointInside:point withEvent:event];
//    if (!superResult) {
//        return superResult;
//    }
    
    // Don't check again if we just queried the same point
    // (because pointInside:withEvent: gets often called multiple times)
//    if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
//        return self.previousTouchHitTestResponse;
//    } else {
//        self.previousTouchPoint = point;
//    }
    
    BOOL response = NO;
    
//    if (self.image == nil) {
//        response = YES;
//    }
    
//    else {
    if ([self isAlphaVisibleAtPoint:point]) {
        response = YES;
    }
    if ([self viewOfPointAt:point]) {
        response = YES;
    }
        //        else {
        //            response = [self isAlphaVisibleAtPoint:point forImage:NULL];
        //        }
//    }
    
//    self.previousTouchHitTestResponse = response;
    
//    if (response) {
//        self.selectedBlock(self);
//    }
    return response;
}


#pragma mark - Method
- (void)singleTapAt:(NSValue *)point{
    AKView *view = [self viewOfPointAt:[point CGPointValue]];
    if (!view) {
        return;
    }
    
    if (view.singleTapBlock) {
        view.singleTapBlock();
    }
    
}

- (void)doubleTapAt:(CGPoint)point{
    AKView *view = [self viewOfPointAt:point];
    if (!view) {
        return;
    }
    
    if (view.doubleTapBlock) {
        view.doubleTapBlock();
    }
}

- (void)longPressAt:(NSValue*)point{
    AKView *view = [self viewOfPointAt:[point CGPointValue]];
    if (!view) {
        return;
    }
    
    if (view.longPressBlock) {
        view.longPressBlock();
    }
}

- (AKView *)viewOfPointAt:(CGPoint)point{
    __block AKView *akView = [[AKView alloc] init];
    [self.drawViewArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(AKView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        //判断view是否是AKLineView，使用点到直线的距离去判断
        if ([view isKindOfClass:[AKLineView class]]) {
            AKLineView *lineView = (AKLineView *)view;
            if ([lineView isPonitAtLine:point]) {
                NSLog(@"you touch : %@",[lineView description]);
                akView = lineView;
                *stop = YES;
                return;
            }
        }
        
        if ([view isKindOfClass:[AKArrowView class]]) {
            AKArrowView *arrowView = (AKArrowView *)view;
            if (arrowView.arrowStyle == AKArrowStyle_Normal) {
                if ([arrowView isPointAtArrow:point]) {
                    NSLog(@"you touch : %@",[arrowView description]);
                    akView = arrowView;
                    *stop = YES;
                    return;
                }
            }
        }
        //其他的图像使用点是否在图像的曲线里面去判断
        if(CGPathContainsPoint(view.bezierPath.CGPath, NULL, point, YES)){
            NSLog(@"you touch : %@",[view description]);
            akView = view;
            *stop = YES;
            return;
        }
        
        akView = nil;
    }];
    if (!self.drawViewArray.count) {
        akView = nil;
    }
    return akView;
}
@end



@implementation UIView (ColorAtPixel)
- (UIColor *)colorAtPixel:(CGPoint)point{
    UIImage *image = [self translateViewToImage];
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)translateViewToImage{
    CGSize s = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end




