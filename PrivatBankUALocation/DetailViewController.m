//
//  DetailViewController.m
//  PrivatBankUALocation
//
//  Created by iMac on 03.12.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "DetailViewController.h"
#import "PBOffice.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameLabel.text = self.currentOffice.name;
    self.addressLabel.text = self.currentOffice.address;
    self.indexLabel.text = self.currentOffice.index;
    self.phoneLabel.text = self.currentOffice.phone;
    self.emailLabel.text = self.currentOffice.email;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
