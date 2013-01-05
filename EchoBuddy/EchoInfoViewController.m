//
//  EchoInfoViewController.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/5/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import "EchoInfoViewController.h"

@interface EchoInfoViewController ()

@end

@implementation EchoInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)saveInfo {
  
}

- (void)updateLabels {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterShortStyle];
  [formatter setTimeStyle:NSDateFormatterShortStyle];
 
  NSString *fullName  = [NSString stringWithFormat:@"%@, %@ %@.",
                         self.cardiacContext.surname,
                         self.cardiacContext.firstname,
                         [self.cardiacContext.middlename substringToIndex:1]];
  self.navigationItem.title = fullName;
  self.surnameField.text    = self.cardiacContext.surname;
  self.firstnameField.text  = self.cardiacContext.firstname;
  self.middlenameField.text = self.cardiacContext.middlename;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateLabels];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
