//
//  createRequirementViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 03/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "requirementObjectViewController.h"
#import "NSString+HTML.h"


@interface createRequirementViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    IBOutlet UITextField *projectTfd,*contactTfd,*coreProcessTfd,*processTfd,*subProcessTfd,*activityTfd,*reqTypeTfd,*criticalityTfd,*systemTfd,*requiremnetNameTxtFld;
    IBOutlet UITextView *reqDesTxtView,*reqHistoryTxtView;
    UIWebView *reqhistorywebview;
    IBOutlet UIButton *saveBtn,*updateBtn;
    IBOutlet UIView *createReqView;
    IBOutlet UILabel *headingLabel;
    UIPickerView *questionpkr;
    UIAlertView *logoutalertView;
    
    
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5,*xmlParser6,*xmlParser7,*xmlParser8,*xmlParser9,*xmlParser10;
    
    
    
    //1
    NSString *projectliststring,*projectidstr,*projectnamestr;
    NSArray *Projectlistdataarray,*projectlistsplitarray;
    NSMutableArray *PROJECT_IDArray,*PROJECT_NAMEArray;
    
    //2
    NSString *resourceListString,*resourceIdString,*resourceNameString;
    NSArray *resouceListDataAry,*resourceListSplitary;
    NSMutableArray *resourceIdAry,*resourceNameAry;
    
    //3
    NSString *coreProcessListString,*coreProcessIdString,*coreProcessCodeString,*coreProcessNameString,*coreProcessDesString ;
    NSArray *coreProcessDataAry,*coreProcessSplitary;
    NSMutableArray *coreProcessIdAry,*coreProcessCodeAry,*coreProcessNameAry,*coreProcessDescAry;
    
    
    //4
    NSString *processListString,*processIdString,*processCodeString,*processNameString,*processDesString ;
    NSArray *processDataAry,*processSplitary;
    NSMutableArray *processIdAry,*processCodeAry,*processNameAry,*processDescAry;

    //5
    NSString *subProcessListString,*subProcessIdString,*subProcessCodeString,*subProcessNameString,*subProcessDesString ;
    NSArray *subProcessDataAry,*subProcessSplitary;
    NSMutableArray *subProcessIdAry,*subProcessCodeAry,*subProcessNameAry,*subProcessDescAry;
    
    //6
    NSString *activityListString,*activityIdString,*activityNameString,*activityDesString ;
    NSArray *activityDataAry,*activitySplitary;
    NSMutableArray *activityIdAry,*activityNameAry,*activityDescAry;

    

    //7
    NSString *typeListString,*reqTypeIdStr,*reqTpeStr;
    NSArray *typeDataAry,*typeSplitary;
    NSMutableArray *reqTypeIdAry,*reqTpeAry;
    
    //8
    NSString *criticialityListString1,*criticialitySystemIdStr1,*criticialitySystemStr1;
    NSArray *criticalityDataAry1,*criticalitySplitary1;
    NSMutableArray *criticialitySystemIdAry1,*citicialitySystemAry1;
    
    //9
    
    NSString *criticialityListString2,*criticialitySystemIdStr2,*criticialitySystemStr2;
    NSArray *criticalityDataAry2,*criticalitySplitary2;
    NSMutableArray *criticialitySystemIdAry2,*citicialitySystemAry2;
    
    
    NSString *pkrProjectIDStr,*pkrResourceIDStr,*pkrCoreProcessIDStr,*pkrprocessIDStr,*pkrSubProcessIDStr,*pkrActivityIDStr,*pkrReqTypeIDStr,*pkrCriticiality1IDStr,*pkrCriticiality2IDStr,*asisReqIdStr,*asisReqIdStr1;
    
    NSString *saveString;
    NSString *historyStr;
    NSArray *saveAry;
    
}
@property(nonatomic,strong)NSString *assignedIdStr,*projectTblStr,*contactTblStr,*coreProcessTblStr,*processTblStr,*subProcessTblStr,*activityTblStr,*reqDesTblStr,*reqHistoryTblStr,*reqTypeTblStr,*criticialityTblStr,*systemTblStr,*requiremnetNamestr;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(IBAction)projectBtnClk:(id)sender;
-(IBAction)contactBtnClk:(id)sender;
-(IBAction)coreProcessBtnClk:(id)sender;
-(IBAction)processBtnClk:(id)sender;
-(IBAction)subProcessBtnClk:(id)sender;
-(IBAction)activityBtnClk:(id)sender;
-(IBAction)reqTypeBtnClk:(id)sender;
-(IBAction)criticialityBtnClk:(id)sender;
-(IBAction)systemBtnClk:(id)sender;

-(IBAction)saveBtn:(id)sender;
-(IBAction)upDateBtnClk:(id)sender;
-(IBAction)ObjectBtnClk:(id)sender;
-(IBAction)homeBtnClk:(id)sender;




@end
