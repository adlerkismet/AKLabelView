//
//  AKTextView.m
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKTextView.h"
@interface AKTextView()
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, strong) CATextLayer *textLayer;
@end
@implementation AKTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIBezierPath *)bezierPath{
    CGPoint point = [self translateAKPointToCGPoint:self.originPoint];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text?:@"" attributes:@{NSFontAttributeName:self.font?:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:self.textColor?:[UIColor blackColor]}];
    CGSize size = [self.attributedString size];
    return [UIBezierPath bezierPathWithRect:CGRectMake(point.x, point.y, size.width, size.height)];
}

- (CALayer *)AKLayer{
    if (!_textLayer) {
        _textLayer = [[CATextLayer alloc] init];
    }
    
    self.attributedString = [[NSAttributedString alloc] initWithString:self.text?:@"" attributes:@{NSFontAttributeName:self.font?:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:self.textColor?:[UIColor blackColor]}];
    _textLayer.string = self.attributedString;
    _textLayer.frame = self.bezierPath.bounds;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    return _textLayer;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"TextView with text:%@ originPoint:(%d,%d)",self.text,self.originPoint.x,self.originPoint.y];
}

@end
