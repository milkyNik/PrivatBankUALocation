//
//  UIView+MKAnnotationView.m
//  MappTest
//
//  Created by iMac on 20.09.16.
//  Copyright © 2016 MilNik. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>


@implementation UIView (MKAnnotationView)

- (MKAnnotationView*) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
}

@end
