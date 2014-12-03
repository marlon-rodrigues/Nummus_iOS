//
//  PieChartViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PieChartViewController.h"

@implementation PieChartViewController

@synthesize graphValue1 = _graphValue1;
@synthesize graphValue2 = _graphValue2;
@synthesize graphValue3 = _graphValue3;
@synthesize graphValue4 = _graphValue4;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Use to hold the values that calculates how much of the graph each value will take
    float sum = _graphValue1 + _graphValue2 + _graphValue3 + _graphValue4;
    float mult = (360/sum);

    
    //Points to determine where the angles starts and ends
    float startDeg = 0;
    float endDeg = 0;
    
    //In accordance with the size of the view that holds the graph (300x300)
    int graphCenterX = 150;
    int graphCenterY = 160;
    int radius = 80;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.0);
    CGContextSetLineWidth(ctx, 2.0);
    
    startDeg = 0;
    endDeg= _graphValue1 * mult;
    if (startDeg != endDeg)
    {
        CGContextSetRGBFillColor(ctx, 0.5709, 0.7744, 0.3871, 1.0);
        CGContextMoveToPoint(ctx, graphCenterX, graphCenterY);
        CGContextAddArc(ctx, graphCenterX, graphCenterY, radius, (startDeg)*M_PI/180.0, (endDeg)*M_PI/180.0, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
    
    startDeg = endDeg;
    endDeg = endDeg + (_graphValue2 * mult);
    if (startDeg != endDeg)
    {
        CGContextSetRGBFillColor(ctx, 0.8963, 0.0519, 0.1903, 1.0);
        CGContextMoveToPoint(ctx, graphCenterX, graphCenterY);
        CGContextAddArc(ctx, graphCenterX, graphCenterY, radius, (startDeg)*M_PI/180.0, (endDeg)*M_PI/180.0, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
    
    startDeg = endDeg;
    endDeg = endDeg + (_graphValue3 * mult);
    if (startDeg != endDeg)
    {
        CGContextSetRGBFillColor(ctx, 0.8639, 0.4783, 0.0, 1.0);
        CGContextMoveToPoint(ctx, graphCenterX, graphCenterY);
        CGContextAddArc(ctx, graphCenterX, graphCenterY, radius, (startDeg)*M_PI/180.0, (endDeg)*M_PI/180.0, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
    
    startDeg = endDeg;
    endDeg = endDeg + (_graphValue4 * mult);
    if (startDeg != endDeg)
    {
        CGContextSetRGBFillColor(ctx, 0.1567, 0.3548, 1.0, 1.0);
        CGContextMoveToPoint(ctx, graphCenterX, graphCenterY);
        CGContextAddArc(ctx, graphCenterX, graphCenterY, radius, (startDeg)*M_PI/180.0, (endDeg)*M_PI/180.0, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
}

- (void) setValuesForGraph:(float)value1 setGraphValue2:(float)value2 setGraphValue3:(float)value3 setGraphValue4:(float)value4
{
    _graphValue1 = value1;
    _graphValue2 = value2;
    _graphValue3 = value3;
    _graphValue4 = value4;
}


@end
