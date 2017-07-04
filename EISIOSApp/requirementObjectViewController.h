//
//  requirementObjectViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 05/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface requirementObjectViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr,*ProjectIdStr,*ProjectIdStr1;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5,*xmlParser6;
    
    IBOutlet UIButton *saveBtn,*updateBtn;
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    IBOutlet UITableView *objectTblView;
    IBOutlet UIView *reqobjectView;
    IBOutlet UITextField *objectTypeTfd,*objectNameTfd,*purposeTfd,*exixtingTfd,*approvalTfd,*resourceTfd,*complexityTfd;
    IBOutlet UITextView *commentsTextView;
    UIPickerView *questionpkr;
    NSArray *existingAndApprovalAry;
    UIAlertView *logoutalertView;

   
   
    
      //Object List
    NSString *objLststring;
    NSArray *objLstdataarray,*objLstplitarray;
    
    NSMutableArray *objLstIdAry,*objLstTypeAry,*objLstcomplexityAry,*objLstPurposeAry,*objLstExistingNewAry,*objLstResourceNameAry,*objLstObjNameAry,*tblLstAppAry,*objLstCommentArry;
    
    NSString *objLstIdStr,*objLstTypeStr,*objLstcomplexityStr,*objLstPurposeStr,*objLstExistingNewStr,*objLstResourceNameStr,*objLstObjNameStr,*tblLstAppStr,*objLstCommentStr,*objectResourceStr1;

    
    
    //1
    NSString *objectTypeliststring,*codeIDStr,*objectTypeStr;
    NSArray *objectTypelistdataarray,*objectTypesplitarray;
    NSMutableArray *codeIDArray,*objectTypeArray;
    
    //2
    NSString *purposeListString,*purposeCodeIDStr,*puurposeStr;
    NSArray *purposeListDataAry,*purposeeListSplitary;
    NSMutableArray *purposeCodeIDAry,*puurposeAry;
    
    //3
    NSString *resourceListString,*resourceIdStr,*resourceNameStr,*string1;
    NSMutableArray *resourceIdAry,*resourceNameAry,*resourceDataAry,*resourceSplitary,*resourcenamearray,*resourceidarray;
   

    
    //4
    NSString *complexityListString,*complexityCodeIdStr,*complexityStr;
    NSArray *complexityDataAry,*complexitySplitary;
    NSMutableArray *complexityCodeIdAry,*complexityAry;

    
    NSString *pkrObjectTypeIDStr,*pkrPurposeIDStr,*pkrResourceIDStr,*pkrComplexityIDStr,*getassignReqstr;
    
    NSString *projectTblStr,*pkrReqProectIDStr;
}
@property(nonatomic,strong)NSString *getAssignReqIdStr,*ProjectIdStr2;

-(IBAction)objectTypeBtnClk:(id)sender;
-(IBAction)purposeBtnClk:(id)sender;
-(IBAction)existingBtnClk:(id)sender;
-(IBAction)approvalBtnClk:(id)sender;
-(IBAction)resourceBtnClk:(id)sender;
-(IBAction)complexityBtnClk:(id)sender;
-(IBAction)saveBtnClk:(id)sender;
-(IBAction)updateBtnClk:(id)sender;

-(IBAction)homeBtnClk:(id)sender;


@end
