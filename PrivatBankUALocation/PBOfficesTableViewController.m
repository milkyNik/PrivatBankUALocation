//
//  PBOfficesTableViewController.m
//  PrivatBankUALocation
//
//  Created by iMac on 29.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "PBOfficesTableViewController.h"
#import "DetailViewController.h"
#import "PBOffice.h"

@interface PBOfficesTableViewController ()

@property (strong, nonatomic) PBOffice* currentOffice;

@end

@implementation PBOfficesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Detail"]) //Проверяем тот ли это segue, который нам нужен
    {

        DetailViewController *detailOfficeController = (DetailViewController *)segue.destinationViewController; //Создаем ссылку на viewController который будет вызван в результате segue
        
        [detailOfficeController setCurrentOffice:self.currentOffice]; //инициализируем значение нужного viewController
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.offices count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        
    }
    
    PBOffice* office = self.offices[indexPath.row];
    
    cell.textLabel.text = office.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDisclosureIndicator;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PBOffice* office = self.offices[indexPath.row];
    
    self.currentOffice = office;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
}

@end
