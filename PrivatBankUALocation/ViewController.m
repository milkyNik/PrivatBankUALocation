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
#import "SVProgressHUD.h"
#import "PBOfficesTableViewController.h"


@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation* userLocation;
@property (strong, nonatomic) NSString* cityName;

@property (strong, nonatomic) NSArray <PBOffice*> * offices;
@property (strong, nonatomic) NSArray <PBInfrastructure*> * atms;
@property (strong, nonatomic) NSArray <PBInfrastructure*> * tsos;

//@property (strong, nonatomic) NSArray * offices;
//@property (strong, nonatomic) NSArray * atms;
//@property (strong, nonatomic) NSArray * tsos;

@property (strong, nonatomic) CLGeocoder* geoCoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.showsCompass = YES;
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0.f, 32.f)];
    
    self.userLocation = self.mapView.userLocation;
    
    self.geoCoder = [[CLGeocoder alloc] init];
    
    
    UIBarButtonItem* findButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionFindPBOffices:)];
    
    self.navigationItem.leftBarButtonItem = findButtonItem;
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [SVProgressHUD showWithStatus:@"Подождите пожалуйста"];
    
    
    
}

- (void) dealloc {
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Support methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Offices"]) {
        
        PBOfficesTableViewController* officesVC = (PBOfficesTableViewController *)segue.destinationViewController;
        
        [officesVC setOffices:_offices];
    }
}

- (void) viewAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    
    [alert addAction:actionOk];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void) viewMapRectWithUserLocation {
    
    CLLocationCoordinate2D location = self.userLocation.coordinate; // берет координаты текущего пользователя

    MKMapPoint center = MKMapPointForCoordinate(location);
    
    static double delta = 50000;
    
    MKMapRect zoomRect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];

    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(0,0,0,0)
                           animated:YES];

}

#pragma mark - API Methods

- (void) getOfficesWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];

    [[ServerManager sharedManager] getPBOfficeByCity:self.cityName
                                           onSuccess:^(NSArray *offices) {
                                               
                                               [SVProgressHUD showSuccessWithStatus:@"Отделения найдены" maskType:SVProgressHUDMaskTypeGradient];
                                               
                                               weakSelf.offices = offices;
                                               weakSelf.officesButtonItem.enabled = YES;
                                               
                                           } onFailure:nil];
}

- (void) getATMsWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [SVProgressHUD showWithStatus:@"Подождите пожалуйста"];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [[ServerManager sharedManager] getPBATMByCity:self.cityName
                                        onSuccess:^(NSArray *atms) {
                                            
                                            [SVProgressHUD showSuccessWithStatus:nil];
                                            
                                            weakSelf.atms = atms;
                                            [weakSelf addAnnotations:weakSelf.atms
                                                               InMap:weakSelf.mapView];
                                            
                                        } onFailure:nil];
}


- (void) getTSOsWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [SVProgressHUD showWithStatus:@"Подождите пожалуйста"];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [[ServerManager sharedManager] getPBTSOByCity:self.cityName
                                        onSuccess:^(NSArray *tsos) {
                                            
                                            [SVProgressHUD showSuccessWithStatus:nil];
                                            
                                            weakSelf.tsos = tsos;
                                            [weakSelf addAnnotations:weakSelf.tsos
                                                               InMap:weakSelf.mapView];

                                        } onFailure:nil];
}

- (void) addAnnotations:(NSArray*) array InMap:(MKMapView*) map {
    
    [map addAnnotations:array];

}


#pragma mark - Actions

- (void) actionDescription:(UIButton*) sender {
    
    NSLog(@"actionDescription");
    
}

- (void) actionFindPBOffices:(UIBarButtonItem*) sender {
    
    if (self.cityName) {
        [self getOfficesWithServer];
    } else {
        [self viewAlertWithTitle:@"Ошибка" andMessage:@"Вероятно, Вы находитесь не в населенном пункте"];
    }
    
    
}

- (IBAction)actionEditTypeInfrastructure:(UISegmentedControl *)sender {
        
    if (self.cityName) {
        
        switch (sender.selectedSegmentIndex) {
            case 0:
                [self getATMsWithServer];
                break;
            case 1:
                [self getTSOsWithServer];
                break;
            default:
                break;
        }
        
    } else {
        
        [self viewAlertWithTitle:@"Ошибка" andMessage:@"Вероятно, Вы находитесь не в населенном пункте"];
        
    }
}

- (IBAction)actionViewOffices:(UIBarButtonItem *)sender {
    
    NSLog(@"OK!");
    
    //[self performSegueWithIdentifier:@"Offices" sender:nil];
    
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    [self getCityOnTheUserLocation:userLocation];
    
    [self viewMapRectWithUserLocation];
    
}
/*
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        pin.pinTintColor = [UIColor greenColor];
        pin.animatesDrop = YES;
        pin.enabled = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        //UIImage *image = [UIImage imageNamed:@"pin.png"];
        
#warning Image not working
        
        //[pin setImage:[UIImage imageNamed:@"pin.png"]];
        

        UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [descriptionButton addTarget:self
                              action:@selector(actionDescription:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = descriptionButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}*/

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
#warning Не работает canShowCallout!!!! И нужно что-то сделать с картинкой для метки.
    
    static NSString* identifier = @"Annotation";
    
    MKAnnotationView* pin = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.canShowCallout = YES;
        
        MKPinAnnotationView* standartPin = [[MKPinAnnotationView alloc] init];
        
        standartPin.pinTintColor = [UIColor greenColor];
        
        pin.image = standartPin.image;
        
        //pin.image = [UIImage imageNamed:@"pin.png"];
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [infoButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = infoButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

#pragma mark - Geocoding

//city on the user's position

- (void) getCityOnTheUserLocation:(MKUserLocation*) userLocation {
    
    CLLocation* location = userLocation.location;
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    [self.geoCoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                            
                            [SVProgressHUD dismiss];
                            
                            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                            
                            if (error) {
                                
                                [self viewAlertWithTitle:@"Ошибка!"
                                              andMessage:[error localizedDescription]];
                                
                            } else {
                                
                                CLPlacemark* placemark = [placemarks firstObject];
                                
                                NSLog(@"%@", placemark.country);
                                
                                // Находится ли устройство в Украине. Так как за её пределами искать объекты Приват Банка не имеет ни малейшего смысла.
                                
                                if ([placemark.country isEqualToString:@"Украина"]) {
                                    
                                    self.cityName = placemark.locality;
                                    NSLog(@"%@", self.cityName);
                                    
                                } else {
                                    
                                    [self viewAlertWithTitle:@"Местоположение"
                                                  andMessage:@"Вы находитесь за пределами Украины. Возможна некорректная работа приложения."];
                                    
                                }
                            }
                        }];
}


@end
