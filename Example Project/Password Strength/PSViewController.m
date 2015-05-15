//
//  CPMPasswordStrengthViewController.m
//  Complete Password Manager
//
//  Created by Matthew Ellis on 13/10/2014.
//  Copyright (c) 2014 Matthew Ellis. All rights reserved.
//

#import "PSViewController.h"
#import "MEPasswordStrength.h"
#import "PSGaugeView.h"

@interface PSViewController ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scoreNumberHeight;
@property (nonatomic, strong) IBOutlet UILabel *scoreNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreTextLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *strengthGaugeHeight;
@property (nonatomic, strong) IBOutlet PSGaugeView *strengthGauge;

@property (nonatomic, strong) IBOutlet UITextField *passwordField;

@property (nonatomic, strong) MEPasswordStrength *calculateStrength;

@end

@implementation PSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calculateStrength = [[MEPasswordStrength alloc] init];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(closeKeybored)];
    [self.view addGestureRecognizer:singleFingerTap];

    if (self.view.frame.size.height < 600) {
        self.scoreNumberHeight.constant = 0;
         self.scoreTextLabel.text = @"Score: 0";
        
        if (self.view.frame.size.height < 500) {
            self.strengthGaugeHeight.constant = 140;
        }
    }
        
    self.strengthGauge.progressColor = [UIColor redColor];
    self.strengthGauge.needleColor = [UIColor lightGrayColor];
    
    [self setNeedle:0];
}

- (void)setNeedle: (CGFloat)needleValue
{
    self.strengthGauge.progress = needleValue;
}

-(void)closeKeybored {
    [self.view endEditing:YES];
}

-(IBAction)passwordFieldValueChanged:(id)sender {
    
   NSNumber *strengthValue = [self.calculateStrength strengthForPassword:self.passwordField.text];
    
    [self setNeedle:[strengthValue floatValue]];
    self.strengthGauge.progressColor = [self.calculateStrength strengthColorForPassword:self.passwordField.text];
    
    if (self.view.frame.size.height < 600) {
        self.scoreTextLabel.text = [NSString stringWithFormat:@"Score: %i" , (int)([strengthValue floatValue] * 100)];
    } else {
        self.scoreNumberLabel.text = [NSString stringWithFormat:@"%i" , (int)([strengthValue floatValue] * 100)];
    }
}

-(IBAction)infoButtonPressed:(id)sender
{
    UIAlertController *masterPasswordAlert = [UIAlertController
                                              alertControllerWithTitle:@"Password Strength Calculator"
                                              message:@"Uses a calculation that works out the number possible passwords that would need to be tried to crack the password, this is what is really important for passwords in the real world."
                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [masterPasswordAlert addAction:okAction];
    
    [self presentViewController:masterPasswordAlert animated:YES completion:nil];
}

@end
