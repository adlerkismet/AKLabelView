//
//  AKImageView.m
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/26.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKImageView.h"
@interface AKImageView()
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation AKImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIBezierPath *)bezierPath {
    
    CGPoint point = [self translateAKPointToCGPoint:self.originPoint];
    self.imageRect = CGRectMake(point.x, point.y, (CGFloat)self.imageWidth/SOURCE_WIDTH*self.presentViewSize.width, (CGFloat)self.imageHeight/SOURCE_HEIGHT*self.presentViewSize.height);
    return [UIBezierPath bezierPathWithRect:self.imageRect];
}

- (CALayer *)AKLayer{
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
    }
    CALayer* contentLayer = _imageLayer;
    contentLayer.frame = self.bezierPath.bounds;
    contentLayer.contents = (__bridge id)self.image.CGImage;
    contentLayer.contentsGravity = kCAGravityResizeAspectFill;
    return contentLayer;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Image with Rect (%d,%d,%ld,%ld)",self.originPoint.x,self.originPoint.y,(long)self.imageWidth,(long)self.imageHeight];
}


@end
