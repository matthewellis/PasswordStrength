//
//  CPMGaugeView.h
//  Complete Password Manager
//
//  Created by Matthew Ellis on 23/12/2014.
//  Copyright (c) 2014 Matthew Ellis. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface PSGaugeView : UIView

@property (nonatomic) IBInspectable UIColor *needleColor;
@property (nonatomic) IBInspectable UIColor *progressColor;
@property (nonatomic) IBInspectable CGFloat progress;

@end
