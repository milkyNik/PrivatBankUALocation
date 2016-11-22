//
//  ServerManager.h
//  APITest
//
//  Created by iMac on 29.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerManager : NSObject


+ (ServerManager*) sharedManager;

- (void) getPBOfficeByCity:(NSString*) city
                 onSuccess:(void(^)(NSArray* offices)) success
                 onFailure:(void(^)(NSError* error)) failure;

- (void) getPBATMByCity:(NSString*) city
              onSuccess:(void(^)(NSArray* atms)) success
              onFailure:(void(^)(NSError* error)) failure;

- (void) getPBTSOByCity:(NSString*) city
              onSuccess:(void(^)(NSArray* tsos)) success
              onFailure:(void(^)(NSError* error)) failure;

@end
