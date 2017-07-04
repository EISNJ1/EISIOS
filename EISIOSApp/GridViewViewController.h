//
//  GridViewViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingListViewController.h"
#import "TimeSheetViewController.h"
#import "issueViewController.h"
#import "TaskListViewController.h"
#import "requirementViewController.h"
#import "projectExpencesViewController.h"
#import "dashboardListViewController.h"

@interface GridViewViewController : UIViewController

{
    IBOutlet UITableView *GridTableV;
    MeetingListViewController *MeetingLV;
    TaskListViewController *TaskListV;
    UIAlertView *LogoutAlert;
    NSArray *colorsArray;
}
@property(nonatomic,strong)NSString *UserNamestr;
@end
