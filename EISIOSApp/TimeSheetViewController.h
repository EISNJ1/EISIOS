//
//  TimeSheetViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "createTimeSheetViewController.h"
#import "Webservices.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "statusTimeSheetViewController.h"

@interface TimeSheetViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal>
{

    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIPopoverController *popController;

    IBOutlet UITableView *timeSheetTbl;
    NSMutableArray *loans;
    
    
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1;
    
    LoginAppDelegate *appDel;
    
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*Usertypestr,*orgIdstr;

    
    NSString *Timesheetstr;
    
    NSString *TimeSheetLineIdstr,*Descrptonstr,*HrsSpentstr,*IsTaskComplstr,*Reasonstr,*EstHrsToCmplitedstr,*SubmitionDatestr,*submissionDateStr1;
    
    NSMutableString *TaskFalseString;
    NSMutableArray *DescrptonArray,*TimeSheetLineIdArray,*SubmitionDateArray,*HrsSpentArray,*EstHrsToCmplitedArray,*IsTaskComplArray,*ReasonArray;
    NSArray *TimesheetSplitArray,*TimesheetdataArray;
    
    NSString *selectedLineId,*selectedReason;
    
    UIAlertView *logoutalertView;
    UIAlertView *disApproveAlert;
    UIAlertView *alertView1;

}

@end
