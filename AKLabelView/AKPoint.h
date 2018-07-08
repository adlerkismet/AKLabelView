//
//  AKPoint.h
//  AKLabelViewDemo
//
//  Created by kismet adler on 2018/7/8.
//  Copyright © 2018年 kismet adler. All rights reserved.
//

#ifndef AKPoint_h
#define AKPoint_h

#include <CoreGraphics/CoreGraphics.h>
typedef struct AKPoint {
    CGFloat x;
    CGFloat y;
}AKPoint;

AKPoint AKPointMake(CGFloat x, CGFloat y);
#endif /* AKPoint_h */
