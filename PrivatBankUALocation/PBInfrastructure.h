//
//  PBInfrastructure.h
//  PrivatBankUALocation
//
//  Created by iMac on 18.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerObject.h"
#import <MapKit/MapKit.h>

@interface PBInfrastructure : ServerObject

@property (strong, nonatomic) NSString* type;               //Тип устройства
@property (strong, nonatomic) NSString* placeRu;            //Название места, где стоит банкомат на русском языке
@property (strong, nonatomic) NSString* fullAddressRu;      //Адрес места, где стоит банкомат на русском языке
@property (strong, nonatomic) NSString* placeUa;            //Название места, где стоит банкомат на украинском языке
@property (strong, nonatomic) NSString* fullAddressUa;      //Адрес места, где стоит банкомат на украинском языке
@property (strong, nonatomic) NSString* fullAddressEn;      //Адрес места, где стоит банкомат на английском языке
@property (strong, nonatomic) NSString* cityRU;             //Название города, где стоит банкомат на русском языке
@property (strong, nonatomic) NSString* cityUA;             //Название города, где стоит банкомат на украинском языке
@property (strong, nonatomic) NSString* cityEN;             //Название города, где стоит банкомат на английском языке
@property (strong, nonatomic) NSString* latitude;           //Координата местоположения. Широта
@property (strong, nonatomic) NSString* longitude;          //Координата местоположения. Долгота
@property (strong, nonatomic) NSDictionary* tw;             //График работы


#warning CLLocationDegrees use?
//@property (assign, nonatomic) CLLocationDegrees latitude1;           //Координата местоположения. Широта
//@property (assign, nonatomic) CLLocationDegrees longitude1;          //Координата местоположения. Долгота

@end
