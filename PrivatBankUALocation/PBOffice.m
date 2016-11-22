//
//  PBOffice.m
//  PrivatBankUALocation
//
//  Created by iMac on 18.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "PBOffice.h"

@implementation PBOffice

- (id) initWithServerResponse:(id) response
{
    self = [super initWithServerResponse:response];
    if (self) {
        
        self.country    = [response valueForKey:@"country"];
        self.state      = [response valueForKey:@"state"];
        self.index      = [response valueForKey:@"index"];
        self.address    = [response valueForKey:@"address"];
        self.phone      = [response valueForKey:@"phone"];
        self.email      = [response valueForKey:@"email"];
        self.name       = [response valueForKey:@"name"];
        
    }
    return self;
}


@end
