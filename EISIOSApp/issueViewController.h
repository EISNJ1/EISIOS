//
//  issueViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 18/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "createIssueViewController.h"
#import "Webservices.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "resolutionIssueViewController.h"
#import "createIssueViewController.h"


@interface issueViewController : UIViewController<UISearchBarDelegate>
{
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    IBOutlet UITableView *issueDetailsTbl;
    IBOutlet UISearchBar *statusSearch;
    IBOutlet UIImageView *imageView;

    
    
    Webservices *Servicecall;
    LoginAppDelegate *appDel;
    createIssueViewController *createISSSUE;
    //resolutionIssueViewController *resolutionIssueView;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    UIImagePickerController *camImagePickerController,*GalleryImage;
    UIImage *ImageforUpload;

    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2;
    
    UIView *selectionView;
    NSMutableString *fileName;
    NSString*fileType,*fileBytes,*byteLenth,*TaskHistorystr,*datestr,*imagedatestr,*imagedatastr;


    
    UILabel *esclateLabel,*escalateTextLabel,*IssueStatusLabel;
    IBOutlet UILabel *totalIssueLabel;
    
    NSString *TaskDetailsstr1;
    NSArray *Taskdataarray1,*TasksplitArray1;
    NSMutableArray *issuenoaArray,*descriptionArray,*issuestatusArray,*issuetypeArray,*assignedtoArray,*assignedbyArray,*buspriorityArray,*IssueIdArray,*projectidArray,*TeamNameArray,*projectNameArray,*longDesArray,*issueTypeNameArray,*isFileAttatchedArray;
    
    NSString *escalatedRescrcStr,*releaseImpactStr,*dateResolutionNeedByStr,*rejectReasonStr,*resolutionTypeStr,*dateResolvedStr,*dateClosedStr,*resolutionDtlsStr,*ResolutionTypeName,*isFileAtatched;
    NSMutableArray *escalatedRescrcAry,*releaseImpactAry,*dateResolutionNeedByAry,*rejectReasonAry,*resolutionTypeAry,*dateResolvedAry,*dateClosedAry,*resolutionDtlsAry;

    
    NSString  *IssueIdStr,*issueno,*description,*issuestatus,*issuetype,*assignedto,*assignedby,*buspriority,*TeamName,*projectid,*projectName,*longDes;
    
    //waste splitting
    NSMutableString *soapResults;
    NSMutableDictionary *songDict;
    NSMutableArray *songsArray;
    
    NSMutableArray *noAry;
    
    
    //search bar
    UIPickerView  *questionpkr;
    NSMutableArray *tableAry,*searchAry,*tempAry;
    
    NSMutableArray *searchdescriptionArray,*searchissueStatusArray,*searchissueTypeAray,*searchbusinessPriorityArray,*searcAssignToArray,*searcAssignByArray,*searcescalatedArray,*searchIssueIdArray,*searchIssueHistoryArray,*searchIssuenoArray,*searchIssueAssignArray,*searchIssueTeamNameArray,*searchProjectidArray,*searchProjectNameArray,*searchReleaseImpactArray,*searchDateResolutionNeedArray,*searchDateResolveAry,*searchCloseDateArray,*searchResolutionDetailsArray,*searchResolutionNameTypeArray,*searchRejectReasonArry,*searchIssueNoArray,*searchIsFileAttatchedArray;
    BOOL search;
    NSMutableArray *pickerAry,*pickerAry1;
    NSMutableArray *newpickerAry,*newpickerAry1;
    UIImageView *backgroundCellImage1,*backgroundCellImage;
    

    UIPopoverController *popController;
    IBOutlet UIButton *btn,*btn1;
    
    
    UILabel *pkrlbl;
    UIButton *pkrRemoveBtn;
    
    
    NSString *selectedProjectIdString,*selectedIssueIdString;
    NSString *selectedEscalatedTorescrcStr,*selectedReleaseImpactStr,*selecteddateResolutionNeedebyStr,*selectedrejectReasonStr,*selectedResolutionStr,*selectedDateReslvedStr,*selectedDateClosedStr,*selectedResolutionDtlsStr,*selectedIssueTypeNameStr;

    UIAlertView *resolutionAlertView,*logOutAlertView,*issueStatusAlertView;
    
}
-(IBAction)btnClk:(id)sender;
-(IBAction)btnClk1:(id)sender;
-(IBAction)pkrDoneClk:(id)sender;

-(IBAction)resolutionBtnClk:(id)sender;


@end
