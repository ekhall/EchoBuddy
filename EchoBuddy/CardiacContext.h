//
//  CardiacContext.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/29/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CardiacContext : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * middlename;
@property (nonatomic, retain) NSString * mrn;
@property (nonatomic, retain) NSNumber * outsideStudy;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSSet *atrium;
@property (nonatomic, retain) NSSet *ventricle;
@end

@interface CardiacContext (CoreDataGeneratedAccessors)

- (void)populateNewEchoInstance;

- (void)addAtriumObject:(NSManagedObject *)value;
- (void)removeAtriumObject:(NSManagedObject *)value;
- (void)addAtrium:(NSSet *)values;
- (void)removeAtrium:(NSSet *)values;

- (void)addVentricleObject:(NSManagedObject *)value;
- (void)removeVentricleObject:(NSManagedObject *)value;
- (void)addVentricle:(NSSet *)values;
- (void)removeVentricle:(NSSet *)values;

@end
