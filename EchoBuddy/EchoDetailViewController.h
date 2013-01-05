//
//  EchoDetailViewController.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/27/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBTableViewCell.h"
#import "CardiacContext.h"
#import "Atrium.h"
#import "EchoInfoViewController.h"

@interface EchoDetailViewController : UITableViewController

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)CardiacContext *cardiacContext;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)cancelCreate;

@end
