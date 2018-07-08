//
//  AKPoint.c
//  AKLabelViewDemo
//
//  Created by kismet adler on 2018/7/8.
//  Copyright © 2018年 kismet adler. All rights reserved.
//

#include "AKPoint.h"
AKPoint AKPointMake(CGFloat x, CGFloat y) {
    AKPoint p;p.x = x;p.y = y;return p;
}
