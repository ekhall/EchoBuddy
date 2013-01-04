//
//  EBTableViewCell.h
//  EchoBuddy
//
//  Created by E. Kevin Hall on 12/29/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBTableViewCell : UITableViewCell

// INFO CELL
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mrnLabel;
@property (weak, nonatomic) IBOutlet UILabel *dobLabel;

// ATRIUM CELL
@property (weak, nonatomic) IBOutlet UILabel *atrium;


@end
