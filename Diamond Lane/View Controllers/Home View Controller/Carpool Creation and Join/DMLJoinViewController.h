//
//  DMLJoinViewController.h
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMLCreateCarpoolViewController.h"

@interface DMLJoinViewController : UIViewController

@property (nonatomic, weak) id <DMLCreateCarpoolViewControllerDelegate> delegate;

@end
