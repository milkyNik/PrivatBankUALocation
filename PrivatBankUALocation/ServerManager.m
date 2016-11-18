//
//  ServerManager.m
//  APITest
//
//  Created by iMac on 29.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

@interface ServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* requestSessionManager;

@end

@implementation ServerManager

+ (ServerManager*) sharedManager {
    
    static ServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* baseUrl = [NSURL URLWithString:@"https://api.privatbank.ua/p24api/"];
        
        self.requestSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        
    }
    return self;
}

#pragma mark - API:GET

//api.privatbank.ua/p24api/pboffice?json&city=&address=


- (void) getPBOfficeByCity:(NSString*) city
                 onSuccess:(void(^)(NSArray* offices)) success
                 onFailure:(void(^)(NSError* error)) failure {
  
    NSDictionary* params = @{@"city" : city};
    
    [self.requestSessionManager GET:@"pboffice?json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        
        NSArray* array = [responseObject valueForKey:@"address"];
        
        NSLog(@"%@", array);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    

 
}




  
    


@end


















