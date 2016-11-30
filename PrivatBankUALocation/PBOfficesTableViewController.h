//
//  PBOfficesTableViewController.h
//  PrivatBankUALocation
//
//  Created by iMac on 29.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBOffice;

@interface PBOfficesTableViewController : UITableViewController

@property (strong, nonatomic) NSArray <PBOffice*> * offices;

@end
