//
//  EchoDetailViewController.m
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/27/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.


#import "EchoDetailViewController.h"

@interface EchoDetailViewController ()

@end

@implementation EchoDetailViewController 

#pragma mark - TableView Methods
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 0)
    return @"Atria";
  else if (section == 1)
    return @"Ventricles";
  else 
    return @"Great Vessels";
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.section == 0) {
    static NSString *EBCellIdentifier_Info = @"EBCellIdentifier_Info";
    EBTableViewCell *cell = (EBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:EBCellIdentifier_Info];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EBTableViewCell_Info" owner:self options:nil];
    cell = (EBTableViewCell *)[nib objectAtIndex:0];
    return cell;
  } else if (indexPath.section == 1) {
    static NSString *EBCellIdentifier_Atrium = @"EBCellIdentifier_Atrium";
    EBTableViewCell *cell = (EBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:EBCellIdentifier_Atrium];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EBTableViewCell_Atrium" owner:self options:nil];
    cell = (EBTableViewCell *)[nib objectAtIndex:0];
    return cell;
  } else if (indexPath.section == 2){
    static NSString *EBCellIdentifier_Ventricle = @"EBCellIdentifier_Ventricle";
    EBTableViewCell *cell = (EBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:EBCellIdentifier_Ventricle];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EBTableViewCell_Ventricle" owner:self options:nil];
    cell = (EBTableViewCell *)[nib objectAtIndex:0];
    return cell;
  } else {
    static NSString *EBCellIdentifier_GA = @"EBCellIdentifier_GA";
    EBTableViewCell *cell = (EBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:EBCellIdentifier_GA];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EBTableViewCell_GA" owner:self options:nil];
    cell = (EBTableViewCell *)[nib objectAtIndex:0];
    return cell;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
//  self.tableView.backgroundView = nil;
//  self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Separator.png"]];
//  self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewCellBG.png"]];
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (result.height == 480) {
      self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG.png"]];
    }
    if (result.height == 568) {
      self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBG-568h.png"]];
    }
  }
  
  if (self.cardiacContextToEdit != nil) {
    NSLog(@"Setting up new Echo Instance");
    [self.cardiacContextToEdit populateNewEchoInstance];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"MOC Error: %@", error);
      abort();
    }
    NSLog(@"Success! %@", self.cardiacContextToEdit);
  }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
