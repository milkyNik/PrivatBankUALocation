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
@property (strong, nonatomic) NSArray <PBInfrastructure*> * atms;


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

- (void) getATMsWithServer {
    
    [[ServerManager sharedManager] getPBATMByCity:@"Харьков"
                                        onSuccess:^(NSArray *atms) {
                                            
                                            self.atms = atms;
                                            
                                        } onFailure:nil];
    
}


- (void) getTSOsWithServer {
    
    
    
}

#pragma mark - Actions

- (IBAction)actionEditTypeInfrastructure:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self getOfficesWithServer];
            break;
        case 1:
            [self getATMsWithServer];
            break;
        case 2:
            [self getTSOsWithServer];
            break;
        default:
            break;
    }
    
}

#pragma mark - MKMapViewDelegate



@end
