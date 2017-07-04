//
//  dashboardListViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 22/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "barChartViewController.h"
#import "programByOwnerReportsViewController.h"
#import "TaskOverViewViewController.h"
#import "LineChartViewController.h"
#import "OverViewViewController.h"

@interface dashboardListViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UITableView *dashBoardListTbl;
    IBOutlet UIView *searchBackView;
    UIBarButtonItem *homeBtn,*logOutBtn;
    UIAlertView *logoutalertView;
    UIPickerView *questionpkr;
    IBOutlet UITextField *searchTfd;
    
    NSArray *dashBoardListAry;
    NSArray *pickerArray;
    
    TaskOverViewViewController *taskOVerView;
    LineChartViewController *lineChart;
    OverViewViewController *overView;
    
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
   
    
}
-(IBAction)searchBtnClk:(id)sender;

-(IBAction)searchSelectionBtnClk:(id)sender;


@end
