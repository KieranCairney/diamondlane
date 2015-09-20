//
//  DMLOnboardingNameViewController.m
//  Diamond Lane
//
//  Created by Aaron Wojnowski on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLOnboardingNameViewController.h"
#import "DMLOnboardingEnablerViewController.h"

#import "DMLUser.h"

@interface DMLOnboardingNameViewController () <UITextFieldDelegate>

@property (nonatomic, readonly, strong) UITextField *nameField;
@property (nonatomic, readonly, strong) UILabel *namePromptLabel;

@end

@implementation DMLOnboardingNameViewController

@synthesize nameField=_nameField;
-(UITextField *)nameField {
    
    if (!_nameField) {
        
        _nameField = [[UITextField alloc] init];
        [_nameField setBorderStyle:UITextBorderStyleNone];
        [_nameField setDelegate:self];
        [_nameField setReturnKeyType:UIReturnKeyGo];
        [_nameField setTextColor:[UIColor dml_grayColor]];
        [_nameField setTextAlignment:NSTextAlignmentCenter];
        [_nameField setPlaceholder:@"nickname"];
        [_nameField setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightLight]];
        [[self view] addSubview:_nameField];
        
    }
    return _nameField;
    
}

@synthesize namePromptLabel=_namePromptLabel;
-(UILabel *)namePromptLabel {
    
    if (!_namePromptLabel) {
        
        _namePromptLabel = [[UILabel alloc] init];
        [_namePromptLabel setTextAlignment:NSTextAlignmentCenter];
        [_namePromptLabel setTextColor:[UIColor dml_grayColor]];
        [_namePromptLabel setBackgroundColor:[UIColor clearColor]];
        [_namePromptLabel setFont:[UIFont systemFontOfSize:32.0 weight:UIFontWeightThin]];
        [_namePromptLabel setNumberOfLines:0];
        [_namePromptLabel setText:@"Before you throw your car in a pool, we need your name."];
        [[self view] addSubview:_namePromptLabel];
        
    }
    return _namePromptLabel;
    
}

-(void)dealloc {
    
    ;
    
}

-(instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ;
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // setup view heirarchy
    
    [self namePromptLabel];
    [self nameField];
    
    // begin
    
    [[self nameField] becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat const padding = 32.0;
    
    [[self nameField] setFrame:CGRectMake(0, (CGRectGetHeight([[self view] bounds]) - 64) / 2.0, CGRectGetWidth([[self view] bounds]), 64)];
    [[self namePromptLabel] setFrame:CGRectMake(padding, padding, CGRectGetWidth([[self view] bounds]) - padding * 2, CGRectGetMinY([[self nameField] frame]) - padding * 2.0)];
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}

#pragma mark - Actions

-(void)createUser:(id)sender {
    
    NSString *name = [[self nameField] text];
    if ([name length] != 0) {
        
        [DMLUser createUserWithName:name completionBlock:^{
            
            DMLOnboardingEnablerViewController *enablerViewController = [[DMLOnboardingEnablerViewController alloc] initWithNibName:@"DMLOnboardingEnablerViewController" bundle:nil];
            [[self navigationController] pushViewController:enablerViewController animated:YES];
            
        } failedBlock:^(NSError *error) {
            
            UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ;
            }];
            
            [errorAlert addAction:defaultAction];
            [self presentViewController:errorAlert animated:YES completion:nil];
            
        }];
        
    }
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self createUser:textField];
    return NO;
    
}

@end
