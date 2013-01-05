//
//  EchoDetailViewController.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/27/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.


#import "EchoDetailViewController.h"

@interface EchoDetailViewController ()


@end

@implementation EchoDetailViewController {
  NSArray *CellKeys;
  NSArray *SectionKeys;
  CardiacContext *cardiacContext;
}
@synthesize cardiacContext;

#pragma mark - Edit Methods
- (void)editEchoInfo:(CardiacContext *)context {
  UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  EchoInfoViewController *controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"EchoInfoView"];
  controller.managedObjectContext = self.managedObjectContext;
  controller.cardiacContext = self.cardiacContext;
  NSLog(@"VC: (%@)", controller);
  //[self presentViewController:controller animated:YES completion:nil];
  [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - TableView Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([indexPath section] == 0) {
    NSLog(@"1");
    [self editEchoInfo:self.cardiacContext];
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [SectionKeys objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (EBTableViewCell *)setupCell:(EBTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section == 0) {
    cell.fullnameLabel.text = [NSString stringWithFormat:@"%@, %@ %@", self.cardiacContext.surname,
                          self.cardiacContext.firstname,
                          self.cardiacContext.middlename];
    cell.mrnLabel.text = self.cardiacContext.mrn;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    cell.dobLabel.text = [formatter stringFromDate:self.cardiacContext.dob];
    
  }
  
  return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  NSString *cellID = [NSString stringWithFormat:@"EBTableViewCell_%@", (NSString *)[CellKeys objectAtIndex:indexPath.section]];
  EBTableViewCell *cell = (EBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil];
  cell = (EBTableViewCell *)[nib objectAtIndex:0];
  
  return [self setupCell:cell forIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [SectionKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//  NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
//  if (sectionTitle == nil) {
//    return nil;
//  }
//  
//  // Create label with section title
//  UILabel *label = [[UILabel alloc] init] ;
//  label.frame = CGRectMake(20, 6, 300, 30);
//  label.backgroundColor = [UIColor clearColor];
//
//  label.textColor = YELLOW_TEXT_COLOR;
//  label.font = APP_FONT_16;
//  label.text = sectionTitle;
//  
//  int SectionHeaderHeight = 20;
//  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, SectionHeaderHeight)];
//  [view addSubview:label];
//  
//  return view;
//}

#pragma mark - Scaffolding
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      CellKeys = CALL_KEYS;
      SectionKeys = SECTION_KEYS;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    CellKeys = CALL_KEYS;
    SectionKeys = SECTION_KEYS;
  }
  return self;
}

- (void)cancelCreate:(id)sender {
  if (self.cardiacContext != nil) {
    [self.managedObjectContext deleteObject:self.cardiacContext];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
  } else {
    NSLog(@"Cardiac context was nil (%@)", self.cardiacContext);
  }
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)createNewEchoInstance {
  CardiacContext *newContext = [NSEntityDescription insertNewObjectForEntityForName:@"CardiacContext"
                                                      inManagedObjectContext:self.managedObjectContext];
  Atrium *leftAtrium = [NSEntityDescription insertNewObjectForEntityForName:@"Atrium"
                                                     inManagedObjectContext:self.managedObjectContext];
  Atrium *rightAtrium = [NSEntityDescription insertNewObjectForEntityForName:@"Atrium"
                                                      inManagedObjectContext:self.managedObjectContext];
  rightAtrium.onLeftSide = [NSNumber numberWithBool:NO];
  NSSet *atria = [NSSet setWithObjects:leftAtrium, rightAtrium, nil];
  [newContext addAtrium:atria];
  
  NSError *error;
  if (![self.managedObjectContext save:&error]) {
    NSLog(@"MOC Error: %@", error);
    abort();
  }
  self.cardiacContext = newContext;
}

- (void)populateDummies {
  NSArray *surnames = @[@"Wilson", @"Talbut", @"Rumbles", @"Jovis", @"Dumpy"];
  for (int i = 0; i < 5; i++) {
    CardiacContext *newContext = [NSEntityDescription insertNewObjectForEntityForName:@"CardiacContext"
                                                        inManagedObjectContext:self.managedObjectContext];
    newContext.surname = [surnames objectAtIndex:i];
    newContext.mrn = [NSString stringWithFormat:@"%d", i];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

  //[self populateDummies];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (result.height == 480) {
      self.parentViewController.view.backgroundColor =
        [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG.png"]];
    }
    if (result.height == 568) {
      self.parentViewController.view.backgroundColor =
        [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG-568h.png"]];
    }
  }
  
  if (self.cardiacContext == nil) {
    [self createNewEchoInstance];
  } else {
    // Load data into table cells;
    NSLog(@"Would load data into cells here");
  }
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
