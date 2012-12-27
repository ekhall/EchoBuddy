//
//  NavViewController.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/23/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EchoDetailViewController.h"

@interface StudiesListingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *echoListingTableView;

@end
