//
//  resolutionIssueViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 28/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "createIssueViewController.h"

@interface resolutionIssueViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal>
{
    IBOutlet UIView *resolutionBackView;
    IBOutlet UITextField *escalatedToTfd,*releaseImpactTfd,*drnbTfd,*rejectReasonTfd,*resolutionTypeTfd,*dateResolvedTfd,*dateClosedTfd,*resolutionDescriptionTfd;
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIDatePicker *datePkr;
    UIPickerView *questionpkr;
    
    
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4;

    //1
    NSString *taskDetailsstr1,*resourceIdStr,*resourceNameStr;
    NSArray *taskdataarray1,*tasksplitArray1;
    NSMutableArray *resourceIdArray,*resourceNameArray;

    //2
    NSString *taskDetailsstr2,*statusIdStr,*StatusNameStr;
    NSArray *taskdataarray2,*tasksplitArray2;
    NSMutableArray *statusIdArray,*StatusNameArray;
    
    //3
    NSString *taskDetailsstr3,*rejectstatusIdStr,*rejectStatusNameStr;
    NSArray *taskdataarray3,*tasksplitArray3;
    NSMutableArray *rejectstatusIdAry,*rejectStatusNameAry;
    
    //4
    NSString *taskDetailsstr4,*resolutionTypeStatusIdStr,*resolutionTypeStatusNameStr;
    NSArray *taskdataarray4,*tasksplitArray4;
    NSMutableArray *resolutionTypeStatusIdAry,*resolutionTypeStatusNameAry;
    
    //
    NSString *selectEscalateIdStr,*selectReleaseImpactIdStr,*selectRejectIdStr,*selectResolutionIdStr;
    

}
@property(nonatomic,strong)NSString *projectIDStr,*issueIdStr,*escalatedToTblStr,*releaseImpactTblStr,*dateResolutionNeededByTblStr,*rejectReasonTblStr,*resolutionTypeTblStr,*dateResolvedTblStr,*dateClosedTblStr,*resolutionDtlsTblStr;


-(IBAction)escalatedToBtnClk:(id)sender;
-(IBAction)releaseImapctBtnClk:(id)sender;
-(IBAction)drnbBtnClk:(id)sender;
-(IBAction)rejectReasonBtnClk:(id)sender;
-(IBAction)resolutionTypeBtnClk:(id)sender;
-(IBAction)dataResolvedBtnClk:(id)sender;
-(IBAction)dateClosedBtnClk:(id)sender;


-(IBAction)resolutionUpdateBtnClk:(id)sender;
-(IBAction)resolutionHomeBtnClk:(id)sender;

@end
