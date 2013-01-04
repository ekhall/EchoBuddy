//
//  Atrium.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/4/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardiacContext, Septum;

@interface Atrium : NSManagedObject

@property (nonatomic, retain) NSNumber * onLeftSide;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) CardiacContext *cardiacContext;
@property (nonatomic, retain) Septum *septum;

@end
