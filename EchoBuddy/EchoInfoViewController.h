//
//  EchoInfoViewController.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 1/5/13.
//  Copyright (c) 2013 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardiacContext.h"

@interface EchoInfoViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CardiacContext *cardiacContext;

@property (weak, nonatomic) IBOutlet UITextField *surnameField;
@property (weak, nonatomic) IBOutlet UITextField *firstnameField;
@property (weak, nonatomic) IBOutlet UITextField *middlenameField;


@end
