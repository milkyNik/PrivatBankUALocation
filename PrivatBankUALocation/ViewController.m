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
#import "PBInfrastructure.h"
#import "PBOffice.h"

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation* userLocation;
@property (strong, nonatomic) NSArray <PBOffice*> * offices;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Support methods

- (void) getOfficesWithServer {
    
    [[ServerManager sharedManager] getPBOfficeByCity:@"Харьков"
                                           onSuccess:^(NSArray *offices) {
                                               
                                               self.offices = offices;
                                               
                                           } onFailure:nil];
    
}

#pragma mark - Actions

- (IBAction)actionEditTypeInfrastructure:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self getOfficesWithServer];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - MKMapViewDelegate



@end
