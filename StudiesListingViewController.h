//
//  NavViewController.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/23/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EchoDetailViewController.h"
#import "CardiacContext.h"

@interface StudiesListingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CardiacContext *cardiacContextToEdit;
@property (weak, nonatomic) IBOutlet UITableView *echoListingTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;

@end
