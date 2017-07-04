//
//  createTimeSheetViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statusTimeSheetViewController.h"
#import "Webservices.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "TimeSheetViewController.h"

@interface createTimeSheetViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,NSXMLParserDelegate,WebserviceownProtocal>
{
    IBOutlet UIView *createTimeShhetView;
    IBOutlet UITextField *projectTfd,*taskTfd,*hoursSpendTfd,*dateTfd,*estdHrsTfd,*taskCompletedTfd,*reasonsTfd;
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    IBOutlet UIButton *projectPkrBtn,*taskPkrBtn,*datePkrBtn,*taskCompletedPkrBtn,*saveBtn;
    UIPopoverController *popController;

    NSArray *pickerAry;
    NSArray *taskCompletedAry;
    UIPickerView *questionpkr;
    UIDatePicker *datePkr;
    
    
    Webservices *Servicecall;
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*saveTimeSheetXmlParser;
    
    
    NSString *projectliststring,*projectidstr,*projectnamestr;
    NSMutableArray *PROJECT_IDArray,*PROJECT_NAMEArray;
    NSArray *Projectlistdataarray,*projectlistsplitarray;
    
    NSString *Timesheetstring,*TimeTASK_NAMEStr,*TimesheetTaskIdstr;
    NSMutableArray *TimeTASK_IDArray,*TaskStartDateArray,*TaskEnddateArray;
    NSMutableArray *TimeTASK_NAMEArray;
    NSArray *TimeSplitarray,*Timetaskdataarray;
    
    NSString *pkrSelectionProjectId,*pkrSelectionTaskId,*startDateStr,*endDateStr,*startDateStr1,*endDateStr1;
    
    
}
-(IBAction)projectPkrBtnClk:(id)sender;
-(IBAction)taskPkrBtnClk:(id)sender;
-(IBAction)datePkrBtnClk:(id)sender;
-(IBAction)taskCompletedPkrBtnClk:(id)sender;
-(IBAction)saveBtnClk:(id)sender;

@end
