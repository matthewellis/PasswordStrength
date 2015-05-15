//
//  MEPasswordStrength.h
//  Pods
//
//  Created by Matthew Ellis on 14/05/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MEPasswordStrength : NSObject

-(NSNumber *)strengthForPassword:(NSString *)password;
-(UIColor *)strengthColorForPassword:(NSString *)password;

@end
