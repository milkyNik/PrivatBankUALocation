//
//  ViewController.m
//  PrivatBankUALocation
//
//  Created by iMac on 17.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "ServerManager.h"

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation* userLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ServerManager sharedManager] getPBOfficeByCity:@"Харьков"
                                           onSuccess:^(NSArray *users) {
                                               
                                           } onFailure:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionEditTypeInfrastructure:(UISegmentedControl *)sender {
    
}

#pragma mark - MKMapViewDelegate



@end
