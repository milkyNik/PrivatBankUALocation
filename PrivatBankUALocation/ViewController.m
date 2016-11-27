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
@property (strong, nonatomic) NSString* sityName;

//@property (strong, nonatomic) NSArray <PBOffice*> * offices;
//@property (strong, nonatomic) NSArray <PBInfrastructure*> * atms;
//@property (strong, nonatomic) NSArray <PBInfrastructure*> * tsos;

@property (strong, nonatomic) NSArray * offices;
@property (strong, nonatomic) NSArray * atms;
@property (strong, nonatomic) NSArray * tsos;

@property (strong, nonatomic) CLGeocoder* geoCoder;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.userLocation = self.mapView.userLocation;

    [self viewMapRect];
    
    self.geoCoder = [[CLGeocoder alloc] init];
    
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

- (void) viewMapRect {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    //CLLocationCoordinate2D location = self.userLocation.coordinate; // берет координаты текущего пользователя
    
    // Для тестирования берем постоянные координаты города Харькова.
    
    CLLocation* userLocation = [[CLLocation alloc] initWithLatitude:49.99722 longitude:36.23333];
    CLLocationCoordinate2D location = userLocation.coordinate;
    
    MKMapPoint center = MKMapPointForCoordinate(location);
    
    static double delta = 70000;
    
    MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
    
    zoomRect = MKMapRectUnion(zoomRect, rect);
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];

    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];

}

- (void) getOfficesWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];

    [[ServerManager sharedManager] getPBOfficeByCity:@"Харьков"
                                           onSuccess:^(NSArray *offices) {
                                               
                                               weakSelf.offices = offices;
                                               
                                           } onFailure:nil];
}

- (void) getATMsWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [[ServerManager sharedManager] getPBATMByCity:@"Харьков"
                                        onSuccess:^(NSArray *atms) {
                                            
                                            weakSelf.atms = atms;
                                            [weakSelf addAnnotations:weakSelf.atms
                                                               InMap:weakSelf.mapView];
                                            
                                        } onFailure:nil];
}


- (void) getTSOsWithServer {
    
    __weak ViewController* weakSelf = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [[ServerManager sharedManager] getPBTSOByCity:@"Харьков"
                                        onSuccess:^(NSArray *tsos) {
                                            
                                            weakSelf.tsos = tsos;
                                            [weakSelf addAnnotations:weakSelf.tsos
                                                               InMap:weakSelf.mapView];

                                        } onFailure:nil];
}

- (void) addAnnotations:(NSArray*) array InMap:(MKMapView*) map {
    
    [map addAnnotations:array];
    
    
    
    
    /*
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in map.annotations) {
        
        PBInfrastructure* pin = annotation;
        
        CLLocationCoordinate2D location = pin.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 20000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];
     */
    
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
}



#pragma mark - Actions

- (void) actionDescription:(UIButton*) sender {
    
    NSLog(@"actionDescription");
    
    /*
    MNStudent* annotation = [sender superAnnotationView].annotation;
    
    
    DetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailController.modalPresentationStyle = UIModalPresentationPopover;
    
    
    
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark* placemark = [placemarks firstObject];
        
        [self presentViewController:detailController animated:YES completion:nil];
        
        detailController.firstName.text = annotation.firstName;
        detailController.lastName.text = annotation.lastName;
        detailController.lastName.text = annotation.lastName;
        detailController.gender.text = annotation.gender? @"Women":@"Man";
        detailController.dateOfBirth.text = [annotation getDateOfBirth];
        detailController.address.text = [NSString stringWithFormat:@"%@", placemark.addressDictionary];
    }];
    
    UIPopoverPresentationController *popController = [detailController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = sender;
     
     */
    
    
}

#pragma mark - Geocoding

//city on the user's position

- (void) getSityOnTheUserLocation:(MKUserLocation*) userLocation {
    
    
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    
    [self.geoCoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                            
                            NSString* message = nil;
                            
                            if (error) {
                                
                                message = [error localizedDescription];
                                
                            } else {
                                
                                CLPlacemark* placemark = [placemarks firstObject];
                                
                                //message = [placemark.addressDictionary description];
                                //message = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
                                
                                message = [NSString stringWithFormat:@"%@", placemark.addressDictionary];
                            }
                            
                            
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Location"
                                                                                           message:message
                                                                                    preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                                               style:UIAlertActionStyleCancel
                                                                             handler:nil];
                            
                            [alert addAction:actionOk];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                            
                            
                        }];
    
}

@end
