//
//  CardiacContext.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/29/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "CardiacContext.h"


@implementation CardiacContext

@synthesize managedObjectContext;

@dynamic date;
@dynamic dob;
@dynamic firstname;
@dynamic middlename;
@dynamic mrn;
@dynamic outsideStudy;
@dynamic surname;
@dynamic atrium;
@dynamic ventricle;

- (void)awakeFromInsert {
  self.date = [NSDate date];
  self.dob = [NSDate dateWithTimeIntervalSince1970:100];
  self.firstname = @"John";
  self.surname = @"Smith";
  self.mrn = @"012345";
  self.outsideStudy = [NSNumber numberWithBool:YES];
  self.middlename = @"Parker";
}

@end
