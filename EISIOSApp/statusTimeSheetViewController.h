//
//  statusTimeSheetViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "TimeSheetViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"


@interface statusTimeSheetViewController : UIViewController
{
    IBOutlet UISearchBar *statusSearch;
    IBOutlet UITableView *statusResultsTbl;
    IBOutlet UIView *searchBackGroundView;
    Webservices *Servicecall;
    NSXMLParser *xmlParser;
    
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*UserType;
    
    
    NSString *Timesheetstr;
    NSMutableString *TaskFalseString;
    NSMutableArray *DescrptonArray,*TimeSheetLineIdArray,*SubmitionDateArray,*HrsSpentArray,*EstHrsToCmplitedArray,*IsTaskComplArray,*ReasonArray,*approvalAry;
    NSArray *TimesheetSplitArray,*TimesheetdataArray;
    
    NSString *Descrptonstr,*TimeSheetLineIdstr,*SubmitionDatestr,*HrsSpentstr,*EstHrsToCmplitedstr,*Reasonstr,*IsTaskComplstr,*approvalStr,*daetsStr1;
    
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIPopoverController *popController;

    //search bar
    UIPickerView  *questionpkr;
    
    NSMutableArray *tableAry,*searchAry,*tempAry;
    BOOL search;

    
    NSMutableArray *pickerAry,*pickerAry1;
    
}
-(IBAction)btnClk:(id)sender;
-(IBAction)pkrDoneClk:(id)sender;


@end
