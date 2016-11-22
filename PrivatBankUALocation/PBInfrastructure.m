//
//  PBInfrastructure.m
//  PrivatBankUALocation
//
//  Created by iMac on 18.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "PBInfrastructure.h"


@implementation PBInfrastructure



- (id) initWithServerResponse:(id) response
{
    //self = [super initWithServerResponse:response];
    self = [super init];
    if (self) {
        
        self.type           = [response valueForKey:@"type"];
        self.placeRu        = [response valueForKey:@"placeRu"];
        self.fullAddressRu  = [response valueForKey:@"fullAddressRu"];
        self.placeUa        = [response valueForKey:@"placeUa"];
        self.fullAddressUa  = [response valueForKey:@"fullAddressUa"];
        self.fullAddressEn  = [response valueForKey:@"fullAddressEn"];
        self.cityRU         = [response valueForKey:@"cityRU"];
        self.cityUA         = [response valueForKey:@"cityUA"];
        self.cityEN         = [response valueForKey:@"cityEN"];
        self.latitude       = [response valueForKey:@"latitude"];
        self.longitude      = [response valueForKey:@"longitude"];
        self.tw             = [response valueForKey:@"tw"];

    }
    return self;
}

@end
