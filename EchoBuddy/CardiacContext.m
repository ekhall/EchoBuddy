//
//  CardiacContext.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/29/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "CardiacContext.h"


@implementation CardiacContext

@dynamic date;
@dynamic firstname;
@dynamic middlename;
@dynamic mrn;
@dynamic outsideStudy;
@dynamic surname;
@dynamic atrium;
@dynamic ventricle;

- (void)populateNewEchoInstance {
  self.date = [NSDate date];
  self.firstname = @"John";
  self.surname = @"Smith";
  self.mrn = @"012345";
  self.outsideStudy = 0;
  self.middlename = @"Parker";
}

@end
