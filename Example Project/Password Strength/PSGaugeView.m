//
//  CPMGaugeView.m
//  Complete Password Manager
//
//  Created by Matthew Ellis on 23/12/2014.
//  Copyright (c) 2014 Matthew Ellis. All rights reserved.
//

#import "PSGaugeView.h"

@interface PSGaugeView()

@property(nonatomic) CGFloat needleRadius;
@property(nonatomic) CGFloat currentRadian;
@property(nonatomic) CGFloat bgRadius;

@end

@implementation PSGaugeView

static const CGFloat CUTOFF = 0.5;

#pragma mark drawing

- (void)drawRect:(CGRect)rect
{
    [self drawBg];
    [self drawNeedle];
}

- (void) drawBg
{
    CGFloat starttime = M_PI + CUTOFF;
    CGFloat endtime = 2 * M_PI - CUTOFF;
    CGFloat innerRadius = self.bgRadius - (self.bgRadius * 0.3);
    
    UIBezierPath *bgPath = [UIBezierPath bezierPath];
    
    [bgPath addArcWithCenter:[self center] radius:innerRadius startAngle:starttime endAngle:endtime clockwise:YES];
    [bgPath addArcWithCenter:[self center] radius:self.bgRadius startAngle:endtime endAngle:starttime clockwise:NO];
    
    [[UIColor whiteColor] set];
    [bgPath fill];
    
    if ((3 * M_PI_2) + self.currentRadian > starttime) {
        UIBezierPath *trackPath = [UIBezierPath bezierPath];

        [trackPath addArcWithCenter:[self center] radius:innerRadius startAngle:starttime endAngle:(3 * M_PI_2) + self.currentRadian clockwise:YES];
        [trackPath addArcWithCenter:[self center] radius:self.bgRadius startAngle:(3 * M_PI_2) + self.currentRadian endAngle:starttime clockwise:NO];

        [[self progressColor] set];
        [trackPath fill];
    }
}

- (void) drawNeedle
{
    CGFloat distance = [self bgRadius] + ([self bgRadius] * 0.1);
    CGFloat starttime = 0;
    CGFloat endtime = M_PI;
    CGFloat topSpace = (distance * 0.1)/6;
    
    CGPoint center = [self center];
    
    CGPoint topPoint = CGPointMake([self center].x, [self center].y - distance);
    CGPoint topPoint1 = CGPointMake([self center].x - topSpace, [self center].y - distance + (distance * 0.1));
    CGPoint topPoint2 = CGPointMake([self center].x + topSpace, [self center].y - distance + (distance * 0.1));
    
    CGPoint finishPoint = CGPointMake([self center].x + self.needleRadius, [self center].y);
    
    UIBezierPath *needlePath = [UIBezierPath bezierPath]; //empty path
    [needlePath moveToPoint:center];
    CGPoint next;
    next.x = center.x + self.needleRadius * cos(starttime);
    next.y = center.y + self.needleRadius * sin(starttime);
    [needlePath addLineToPoint:next]; //go one end of arc
    [needlePath addArcWithCenter:center radius:self.needleRadius startAngle:starttime endAngle:endtime clockwise:YES]; //add the arc
    
    [needlePath addLineToPoint:topPoint1];
    
    [needlePath addQuadCurveToPoint:topPoint2 controlPoint:topPoint];
    
    [needlePath addLineToPoint:finishPoint];
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(-1 * (self.bounds.origin.x + [self center].x), -1 * (self.bounds.origin.y + [self center].y));
    [needlePath applyTransform:translate];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(self.currentRadian);
    [needlePath applyTransform:rotate];
    
    translate = CGAffineTransformMakeTranslation((self.bounds.origin.x + [self center].x), (self.bounds.origin.y + [self center].y));
    [needlePath applyTransform:translate];
    
    [[self needleColor] set];
    [needlePath fill];
}

# pragma mark current level

- (void) setProgress:(CGFloat)progress
{
    if (progress >= 0 && progress <= 1) {
        CGFloat range = M_PI - (CUTOFF * 2);
        self.currentRadian = range*progress - (range/2);
        
        [self setNeedsDisplay];
    }
}

#pragma mark custom getter/setter

- (CGPoint)center
{
    return CGPointMake([self centerX], [self centerY]);
}

- (CGFloat)centerY
{
    return self.bounds.size.height - (self.bounds.size.height * 0.2);
}

- (CGFloat)centerX
{
    return self.bounds.size.width/2;
}

- (UIColor *) needleColor
{
    if (!_needleColor) {
        _needleColor = [UIColor lightGrayColor];
    }
    
    return _needleColor;
}

- (UIColor *) progressColor
{
    if (!_progressColor) {
        _progressColor = [UIColor clearColor];
    }
    
    return _progressColor;
}

- (CGFloat) needleRadius
{
    if (!_needleRadius) {
        _needleRadius = self.bounds.size.height * 0.08;
    }
    
    return _needleRadius;
}

- (CGFloat) bgRadius
{
    if (!_bgRadius) {
        _bgRadius = [self centerX] - ([self centerX] * 0.1);
    }
    
    return _bgRadius;
}

@end
