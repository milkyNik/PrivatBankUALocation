//
//  DetailViewController.h
//  PrivatBankUALocation
//
//  Created by iMac on 03.12.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBOffice;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PBOffice* currentOffice;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
