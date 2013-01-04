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

#pragma mark - TableView Methods
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
    NSLog(@"Removing %@ from store.", self.cardiacContext);
    [self.managedObjectContext deleteObject:self.cardiacContext];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
    NSLog(@"Success!");
  } else {
    NSLog(@"Cardiac context was nil (%@)", self.cardiacContext);
  }
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (result.height == 480) {
      self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG.png"]];
    }
    if (result.height == 568) {
      self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG-568h.png"]];
    }
  }
  
  if (self.cardiacContext == nil) {
    NSLog(@"Setting up new Echo Instance");
    self.cardiacContext = [NSEntityDescription insertNewObjectForEntityForName:@"CardiacContext"
                                                                   inManagedObjectContext:self.managedObjectContext];
    self.cardiacContext.managedObjectContext = self.managedObjectContext;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
    NSLog(@"Success! %@", self.cardiacContext);
  } else {
    // Load data into table cells;
    NSLog(@"Would load data into cells here");
  }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
