//
//  ServerObject.h
//  APITest
//
//  Created by iMac on 06.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DICTIONARY_KEYS 0

#if DICTIONARY_KEYS
static NSString* ServerObjectPBInfrastructureTWMondayKey;
static NSString* ServerObjectPBInfrastructureTWTuesdayKey;
static NSString* ServerObjectPBInfrastructureTWWednesdayKey;
static NSString* ServerObjectPBInfrastructureTWThursdayKey;
static NSString* ServerObjectPBInfrastructureTWFridayKey;
static NSString* ServerObjectPBInfrastructureTWSaturdayKey;
static NSString* ServerObjectPBInfrastructureTWSundayKey;
static NSString* ServerObjectPBInfrastructureTWHolidayKey;
#endif

@interface ServerObject : NSObject

@property (strong, nonatomic) NSString* city;       //Город в котором находиться объект (отделение банка, банкомат, терминал самообслуживания)

- (id) initWithServerResponse:(id) response;



@end
