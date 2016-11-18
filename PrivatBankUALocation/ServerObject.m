//
//  ServerObject.m
//  APITest
//
//  Created by iMac on 06.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerObject.h"


#if DICTIONARY_KEYS
static NSString* ServerObjectPBInfrastructureTWMondayKey       = @"mon";
static NSString* ServerObjectPBInfrastructureTWTuesdayKey      = @"tue";
static NSString* ServerObjectPBInfrastructureTWWednesdayKey    = @"wed";
static NSString* ServerObjectPBInfrastructureTWThursdayKey     = @"thu";
static NSString* ServerObjectPBInfrastructureTWFridayKey       = @"fri";
static NSString* ServerObjectPBInfrastructureTWSaturdayKey     = @"sat";
static NSString* ServerObjectPBInfrastructureTWSundayKey       = @"sun";
static NSString* ServerObjectPBInfrastructureTWHolidayKey      = @"hol";
#endif


@implementation ServerObject

- (id) initWithServerResponse:(id) response
{
    self = [super init];
    if (self) {
        
        self.city = [response valueForKey:@"city"];
        
    }
    return self;
}

@end
