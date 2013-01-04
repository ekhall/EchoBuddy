//
//  SeptalDefect.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/4/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Septum;

@interface SeptalDefect : NSManagedObject

@property (nonatomic, retain) NSString * properType;
@property (nonatomic, retain) NSString * shunting;
@property (nonatomic, retain) NSDecimalNumber * sizeA;
@property (nonatomic, retain) NSDecimalNumber * sizeB;
@property (nonatomic, retain) NSDecimalNumber * sizeC;
@property (nonatomic, retain) NSString * viewA;
@property (nonatomic, retain) NSString * viewB;
@property (nonatomic, retain) NSString * viewC;
@property (nonatomic, retain) Septum *septum;

@end
