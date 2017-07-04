//
//  createIssueViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 18/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "NSString+HTML.h"


@interface createIssueViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,NSXMLParserDelegate,UITextViewDelegate,WebserviceownProtocal,UITableViewDelegate,UITableViewDataSource>
{
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    IBOutlet UIView *createIssueView;
    IBOutlet UITextField *projectTfd,*statusTfd,*typeTfd,*assignToTfd,*teamSubmittedTfd,*severityTfd,*descriptionTfd,*issueEntryTfd;
    IBOutlet UITextView *issueHistoryTextView;
    IBOutlet UIButton *updateBtn,*saveBtn,*projectListBtn;
    UIImagePickerController *camImagePickerController,*GalleryImage;
    UIImage *ImageforUpload;
    UITableView *attatchmentTableView;
    UIWebView *webView;
    NSURL *url;
    UITextView *textView;
    UIImageView *ImgView;
    
    
    Webservices *Servicecall;
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5,*xmlParser6,*xmlParser7,*saveAttatchmentXmlParser,*attatchmentListXmlParser;
    
    
    NSString *TaskDetailsstr1,*projectname,*newprojectidstr;
    NSArray *Taskdataarray1,*TasksplitArray1;
    NSMutableArray *projectnameArray,*newprojectidstrArray;
    
    NSString *TaskDetailsstr2,*statusname,*STATUS_IDStr;
    NSArray *Taskdataarray2,*TasksplitArray2;
    NSMutableArray *statusnameArray,*STATUS_IDArray;
    IBOutlet UILabel *titleLabel;
    
    
    NSString *TaskDetailsstr3,*statustype,*TypESTATUS_IDStr;
    NSArray *Taskdataarray3,*TasksplitArray3;
    NSMutableArray *statustypeArray,*TypESTATUS_IDArray;
    
    
    NSString *TaskDetailsstr5,*resourcename,*ResourceIdStr;
    NSArray *Taskdataarray5,*TasksplitArray5;
    NSMutableArray *resourcenamearray,*ResourceIdArray;
    
    NSString *TaskDetailsstr6,*teamsubmittedname,*TeamIdStr;
    NSArray *Taskdataarray6,*TasksplitArray6;
    NSMutableArray *TeamnameArray,*TeamIdArray;
    
    NSString *TaskDetailsstr4,*businessname,*BUSINESS_PRIORITY_IDStr;
    NSArray *Taskdataarray4,*TasksplitArray4;
    NSMutableArray *businessnameArray,*BUSINESS_PRIORITY_IDArray;
    
    
    NSString *TaskDetailsstr7,*issuehistryStr,*issuehistryStr1,*issuehistrStr2;
    NSMutableArray *Taskdataarray7,*Taskdataarray8;
    NSString *saveissueIDStr,*saveissueNumStr,*saveAttatchmentStr,*issueDescStr;

    UIPickerView *questionpkr;
    
    UIView *selectionView;
    NSMutableString *fileName;
    NSString*fileType,*fileBytes,*byteLenth,*TaskHistorystr,*datestr,*imagedatestr,*imagedatastr;
    
    NSArray *AttatchmentListArray,*AttatchmentListSplitArray;
    NSMutableArray *AttatchmentListArray1,*AttatchmentFileNameArray,*AttatchmentFileUrlArray,*TitlesArray;
    NSString *AttatchmentName,*AttachmentUrl,*AttatchmentUrlData;
    
    
    
    
    NSString *issueNoStr, *issueStatusStr,*businessPriortyStr, *issueTypeStr, *projectIdStr,*teamImpactStr, *resourceIdStr;

}
-(IBAction)issueSaveBtnClk:(id)sender;
-(IBAction)issueHomeBtnClk:(id)sender;
-(IBAction)issueUpdateClk:(id)sender;

-(IBAction)projectBtnClk:(id)sender;
-(IBAction)statusBtnClk:(id)sender;
-(IBAction)typeBtnClk:(id)sender;
-(IBAction)assignToBtnClk:(id)sender;
-(IBAction)teamSubmittedBtnClk:(id)sender;
-(IBAction)severityBtnClk:(id)sender;

@property(nonatomic,strong)NSString  *issueIdTblStr,*issueNoTblStr,*projectIdTblStr,*projectTblStr,*issueStatusTblStr,*issueTypeTblStr,*assignToTblStr, *teamSubmittedTblStr,*severityTblStr,*descriptionTblStr,*isueHistoryTblStr;
@end
