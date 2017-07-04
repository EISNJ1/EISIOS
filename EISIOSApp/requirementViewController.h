//
//  requirementViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 01/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "createRequirementViewController.h"

@interface requirementViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIPopoverController *popController;
    UIAlertView *logoutalertView;
    
    IBOutlet UISearchBar *req1SearchBar,*req2SearchBar;
    IBOutlet UIButton *reqSearchBtn2,*reqSearchBtn3;
    NSArray *searchBar2PkrAry;
    
    
    
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1;
    
    NSString *reqStr;
    NSString *reqTypeStr,*contactStr,*criticialityStr,*activityStr,*systemStr;
    NSString *assignReqIdStr,*isTaskGeneratedStr,*coreProcessStr,*processStr,*subProcessStr,*reqDescriptionStr,*reqHistoryStr,*projectIdStr,*projectName,*reqlistProjectNameStr,*requirementNameStr,*reqhstrStr;
    NSMutableString *reqFalseString;
    NSMutableArray *reqTypeArray,*contactAry,*criticialityAry,*activityAry,*systemAry;
    NSMutableArray *assignReqIdAry,*isTaskGeneratedAry,*coreProcessAry,*processAry,*subProcessAry,*reqDescriptionAry,*reqHistoryAry,*projectIDArray,*projectNameArray,*requirementNameArray;
    NSArray *reqSplitAry,*reqDataAry;
    
    NSMutableString *soapResults;
    NSMutableDictionary *songDict;
    NSMutableArray *songsArray,*noAry;
    
    
    IBOutlet UITableView *reqListTbl;
    UIPickerView *questionpkr;
    
    //1
    NSString *projectliststring,*projectidstr,*projectnamestr;
    NSArray *Projectlistdataarray,*projectlistsplitarray;
    NSMutableArray *PROJECT_IDArray,*PROJECT_NAMEArray;
    
    NSString *pkrProjectIDStr;
    
    
    
    //searchBar
    NSMutableArray *pickerAry,*pickerAry1,*picker2,*picker3,*picker4,*pickerarray11;
    NSMutableArray *newpickerAry,*newpickerAry1,*newpickerAry2,*newpickerAry3,*newpickerAry4;
    NSMutableArray *tableAry,*searchAry,*tempAry,*tempArray1,*searchArray1,*projectSearchArray,*TempArray1;
    
    NSMutableArray *searchReqtypeArray,*searchCriticalityArray,*searchActivityArray,*searchSystemArray,*searchContactArray,*searchassignedIDArray,*searchProjectIDArray,*searchCoreprocessArray,*searchProcessArray,*searchSubprocessArray,*searchreqdescriptionArray,*searchReqHistoryArray,*searchRequiremnetNameArray;
    
    NSMutableArray *search1ReqtypeArray,*search1CriticalityArray,*search1ActivityArray,*search1SystemArray,*search1ContactArray,*search1assignedIDArray,*search1ProjectIDArray,*search1CoreprocessArray,*search1ProcessArray,*search1SubprocessArray,*search1reqdescriptionArray,*search1ReqHistoryArray,*search1RequiremnetNameArray;
    BOOL search;
    
}
-(IBAction)reqSearchBtnClk:(id)sender;
-(IBAction)reqSearchBtnClk2:(id)sender;
-(IBAction)reqSearchBtnClk3:(id)sender;


@end
