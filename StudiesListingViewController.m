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

@implementation StudiesListingViewController {
  NSFetchedResultsController *fetchedResultsController;
}
@synthesize echoListingTableView = _echoListingTableView;

- (NSFetchedResultsController *)fetchedResultsController
{
  if (fetchedResultsController == nil) {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CardiacContext"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"surname" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    [fetchRequest setFetchBatchSize:20];
    fetchedResultsController = [[NSFetchedResultsController alloc]
                                initWithFetchRequest:fetchRequest
                                managedObjectContext:self.managedObjectContext
                                sectionNameKeyPath:@"surname"
                                cacheName:@"CardiacContexts"];
    fetchedResultsController.delegate = self;
  }
  return fetchedResultsController;
}

- (void)performFetch {
  NSError *error;
  if (![self.fetchedResultsController performFetch:&error]) {
    FATAL_CORE_DATA_ERROR(error);
    return;
  }
}

#pragma mark - Actions
- (void)settingsClicked {
    NSLog(@"Settings clicked...");
}

- (IBAction)createNewEchoInstance:(id)sender {
    [self performSegueWithIdentifier:@"createNewEcho" sender:nil];
}

- (void)editExistingEchoInstance:(id)sender {
  NSLog(@"Inside Edit method, SenderL (%@)", sender);
  EchoDetailViewController *controller = [[EchoDetailViewController alloc] init];
  controller.managedObjectContext = self.managedObjectContext;
  controller.cardiacContext = sender;
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"createNewEcho"]) {
    NSLog(@"inside segue");
    EchoDetailViewController *controller = segue.destinationViewController;
    
    controller.managedObjectContext = self.managedObjectContext;
    controller.cardiacContext = nil;
    controller.navigationItem.title = @"Create New Echo";
    
    // Set the cancel button programmatically so I can erase the insert Core Data Entity
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@" Cancel"
                                                                     style:UIBarButtonSystemItemAction
                                                                    target:controller
                                                                    action:@selector(cancelCreate:)];
    UIImage *backButton = [[UIImage imageNamed:@"backButton.png"]
                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 7)];
    [cancelButton setBackgroundImage:backButton
                            forState:UIControlStateNormal
                          barMetrics:UIBarMetricsDefault];
    controller.navigationItem.leftBarButtonItem = cancelButton;
  } 
}

#pragma mark - View Scaffoldinga
- (void)updateLabels {
  self.totalNumberLabel.text = [NSString stringWithFormat:@"%d", [[self.fetchedResultsController fetchedObjects] count]];
}

- (void)viewWillAppear:(BOOL)animated {
  UIImage *settingsImage = [UIImage imageNamed:@"settingsIcon.png"];
  UIButton *settingsView = [[UIButton alloc]
                            initWithFrame:CGRectMake(0, 0, settingsImage.size.width, settingsImage.size.height)];
  [settingsView setContentMode:UIViewContentModeCenter];
  [settingsView addTarget:self action:@selector(createNewEchoInstance:) forControlEvents:UIControlEventTouchUpInside];
  [settingsView setBackgroundImage:settingsImage forState:UIControlStateNormal];
  UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsView];
  [self.navigationItem setRightBarButtonItem:settingsButton];
  [self updateLabels];
}

- (void)cleanEchoZombies {
  // This looks for the default echo instance which was orphaned after creation but before
  //  saving as a real object or cancelling with the back button.
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"CardiacContext"
                                            inManagedObjectContext:self.managedObjectContext];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mrn IN %@", @[@"-1"]];
  [fetchRequest setPredicate:predicate];
  [fetchRequest setEntity:entity];
  NSError *error;
  NSArray *zombies = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                              error:&error];
  if ([zombies count] > 0) {
    NSLog(@"Ack! Zombies! (%@)", zombies);
    for (CardiacContext *context in zombies) {
      NSLog(@"Deleting Zombie (%@)", context);
      [self.managedObjectContext deleteObject:context];
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self cleanEchoZombies];
  [self performFetch];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.echoListingTableView deselectRowAtIndexPath:[self.echoListingTableView indexPathForSelectedRow]
                                           animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  CardiacContext *context = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = context.surname;
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setTimeStyle:NSDateFormatterFullStyle];
  [formatter setDateStyle:NSDateFormatterShortStyle];
  cell.detailTextLabel.text = [formatter stringFromDate:context.date];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    CardiacContext *context = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:context];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      FATAL_CORE_DATA_ERROR(error);
      return;
    }
    [self updateLabels];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.cardiacContextToEdit = [self.fetchedResultsController objectAtIndexPath:indexPath];
  [self editExistingEchoInstance:self.cardiacContextToEdit];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  NSLog(@"*** controllerWillChangeContent");
  [self.echoListingTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
  switch (type) {
    case NSFetchedResultsChangeInsert:
      NSLog(@"*** controllerDidChangeObject - NSFetchedResultsChangeInsert");
      [self.echoListingTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      NSLog(@"*** controllerDidChangeObject - NSFetchedResultsChangeDelete");
      [self.echoListingTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      NSLog(@"*** controllerDidChangeObject - NSFetchedResultsChangeUpdate");
      [self configureCell:[self.echoListingTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      NSLog(@"*** controllerDidChangeObject - NSFetchedResultsChangeMove");
      [self.echoListingTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.echoListingTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
  switch (type) {
    case NSFetchedResultsChangeInsert:
      NSLog(@"*** controllerDidChangeSection - NSFetchedResultsChangeInsert");
      [self.echoListingTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      NSLog(@"*** controllerDidChangeSection - NSFetchedResultsChangeDelete");
      [self.echoListingTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  NSLog(@"*** controllerDidChangeContent");
  [self.echoListingTableView endUpdates];
}

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc {
  fetchedResultsController.delegate = nil;
}

@end

