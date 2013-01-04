//
//  Septum.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/4/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Atrium, Ventricle, SeptalDefect;

@interface Septum : NSManagedObject

@property (nonatomic, retain) NSString * alignment;
@property (nonatomic, retain) NSSet *atrium;
@property (nonatomic, retain) NSSet *septalDefect;
@property (nonatomic, retain) NSSet *ventricle;
@end

@interface Septum (CoreDataGeneratedAccessors)

- (void)addAtriumObject:(Atrium *)value;
- (void)removeAtriumObject:(Atrium *)value;
- (void)addAtrium:(NSSet *)values;
- (void)removeAtrium:(NSSet *)values;

- (void)addSeptalDefectObject:(SeptalDefect *)value;
- (void)removeSeptalDefectObject:(SeptalDefect *)value;
- (void)addSeptalDefect:(NSSet *)values;
- (void)removeSeptalDefect:(NSSet *)values;

- (void)addVentricleObject:(Ventricle *)value;
- (void)removeVentricleObject:(Ventricle *)value;
- (void)addVentricle:(NSSet *)values;
- (void)removeVentricle:(NSSet *)values;

@end
