//
//  DMLCarpoolDetailViewController.m
//  Diamond Lane
//
//  Created by Lorenzo Gentile on 2015-09-19.
//  Copyright © 2015 CS Boys. All rights reserved.
//

#import "DMLCarpoolDetailViewController.h"

#import "DMLPassengerTableViewCell.h"
#import "DMLOpenTableViewCell.h"
#import "DMLCodeTableViewCell.h"

#define PASSENGER_CELL @"DMLPassengerTableViewCell"
#define OPEN_CELL @"DMLOpenTableViewCell"
#define CODE_CELL @"DMLCodeTableViewCell"

@interface DMLCarpoolDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSArray *passengers;
@property (strong, nonatomic) NSArray *infoCellIds;

@end

@implementation DMLCarpoolDetailViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sectionTitles = @[@"Members", @"Info"];
        self.passengers = @[@"Bob", @"Joe", @"Moe", @"Rob", @"Tom", @"Bill"];
        self.infoCellIds = @[OPEN_CELL, CODE_CELL];
        
        // self.title = carpool.title;
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.estimatedRowHeight = 44.0;
        [self.view addSubview:self.tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:PASSENGER_CELL bundle:nil] forCellReuseIdentifier:PASSENGER_CELL];
        [self.tableView registerNib:[UINib nibWithNibName:OPEN_CELL bundle:nil] forCellReuseIdentifier:OPEN_CELL];
        [self.tableView registerNib:[UINib nibWithNibName:CODE_CELL bundle:nil] forCellReuseIdentifier:CODE_CELL];
        
    }
    return self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.passengers.count;
            break;
            
        case 1:
            return self.infoCellIds.count;
            break;
            
        default:
            return 0;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionTitles[section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:PASSENGER_CELL forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[DMLPassengerTableViewCell class]]) {
            
            DMLPassengerTableViewCell *passengerCell = (DMLPassengerTableViewCell *)cell;
            passengerCell.nameLabel.text = self.passengers[indexPath.row];
            
        }
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:self.infoCellIds[indexPath.row] forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[DMLCodeTableViewCell class]]) {
            
            DMLCodeTableViewCell *codeCell = (DMLCodeTableViewCell *)cell;
            codeCell.carpoolCodeLabel.text = @"P3N15";
            
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if ([cell isKindOfClass:[DMLCodeTableViewCell class]]) {
        
        DMLCodeTableViewCell *codeCell = (DMLCodeTableViewCell *)cell;
        codeCell.infoLabel.text = @"Copied!";
        [UIPasteboard generalPasteboard].string = codeCell.carpoolCodeLabel.text;
        
    }
    
}

@end