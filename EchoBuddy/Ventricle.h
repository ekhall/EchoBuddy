//
//  Ventricle.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/4/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardiacContext, Septum;

@interface Ventricle : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * efa2c;
@property (nonatomic, retain) NSDecimalNumber * efa4c;
@property (nonatomic, retain) NSDecimalNumber * fs;
@property (nonatomic, retain) NSString * looping;
@property (nonatomic, retain) NSNumber * onLeftSide;
@property (nonatomic, retain) CardiacContext *cardiacContext;
@property (nonatomic, retain) Septum *septum;

@end
