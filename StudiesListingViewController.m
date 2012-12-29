//
//  NavViewController.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/23/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "StudiesListingViewController.h"

@interface StudiesListingViewController ()

@end

@implementation StudiesListingViewController
@synthesize echoListingTableView = _echoListingTableView;

#pragma mark - Actions
- (void)settingsClicked {
    NSLog(@"Settings clicked...");
}

- (IBAction)createNewEchoInstance:(id)sender {
    [self performSegueWithIdentifier:@"createNewEcho" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"createNewEcho"]) {
    NSLog(@"inside segue");
    EchoDetailViewController *controller = segue.destinationViewController;
    
    controller.managedObjectContext = self.managedObjectContext;
    CardiacContext *cardiacContext = [NSEntityDescription insertNewObjectForEntityForName:@"CardiacContext"
                                                                   inManagedObjectContext:self.managedObjectContext];
    controller.cardiacContextToEdit = cardiacContext;
    controller.navigationItem.title = @"Create New Echo";
  }
}

#pragma mark - View Scaffolding
- (void)viewWillAppear:(BOOL)animated {
    UIImage *settingsImage = [UIImage imageNamed:@"settingsIcon.png"];
    UIButton *settingsView = [[UIButton alloc]
                              initWithFrame:CGRectMake(0, 0, settingsImage.size.width, settingsImage.size.height)];
    [settingsView setContentMode:UIViewContentModeCenter];
    [settingsView addTarget:self action:@selector(createNewEchoInstance:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView setBackgroundImage:settingsImage forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsView];
    [self.navigationItem setRightBarButtonItem:settingsButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"text";
    return cell;
}

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

@end
