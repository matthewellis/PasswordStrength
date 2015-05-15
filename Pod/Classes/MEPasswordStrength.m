//
//  MEPasswordStrength.m
//  Pods
//
//  Created by Matthew Ellis on 14/05/2015.
//
//

#import "MEPasswordStrength.h"

@implementation MEPasswordStrength

-(NSNumber *)strengthForPassword:(NSString *)password {
    
    NSInteger charsetSize = 0;
    NSCharacterSet *lowercaseSet = [NSCharacterSet lowercaseLetterCharacterSet];
    if ([password rangeOfCharacterFromSet:lowercaseSet].location != NSNotFound) {
        charsetSize += 26;
    }
    
    NSCharacterSet *uppercaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
    if ([password rangeOfCharacterFromSet:uppercaseSet].location != NSNotFound) {
        charsetSize += 26;
    }
    
    NSCharacterSet *numberSet = [NSCharacterSet alphanumericCharacterSet];
    if ([password rangeOfCharacterFromSet:numberSet].location != NSNotFound) {
        charsetSize += 10;
    }
    
    NSCharacterSet *punctuationlSet = [NSCharacterSet punctuationCharacterSet];
    if ([password rangeOfCharacterFromSet:punctuationlSet].location != NSNotFound) {
        charsetSize += 20;
    }
    
    NSCharacterSet *symbolSet = [NSCharacterSet symbolCharacterSet];
    if ([password rangeOfCharacterFromSet:symbolSet].location != NSNotFound) {
        charsetSize += 30;
    }
    
    NSNumber *strength = [NSNumber numberWithFloat:(charsetSize * [password length])*0.001];
    
    if ([strength floatValue] > 1) {
        strength = [NSNumber numberWithFloat:1];
    }
    
    return strength;
}

-(UIColor *)strengthColorForPassword:(NSString *)password {
    
    UIColor *strengthColor;
    NSNumber *strength = [self strengthForPassword:password];
    
    if([strength floatValue] > 0 && [strength floatValue] <= .3){
        strengthColor = [UIColor redColor];
    }
    else if([strength floatValue] > .3 && [strength floatValue] <= .5){
        strengthColor = [UIColor orangeColor];
    }
    else if([strength floatValue] > .5 && [strength floatValue]<= .7){
        strengthColor = [UIColor yellowColor];
    }
    else if([strength floatValue] > .7){
        strengthColor = [UIColor greenColor];
    }
    else {//should never do this..
        strengthColor = [UIColor whiteColor];
    }
    return strengthColor;
}


@end
