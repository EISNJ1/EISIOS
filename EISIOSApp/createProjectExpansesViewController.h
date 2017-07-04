//
//  createProjectExpansesViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 16/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "Base64.h"

@interface createProjectExpansesViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    IBOutlet UITextField *projectTfd,*dateTfd,*amountTfd,*categoryTfd;
    IBOutlet UITextView *attachmentsTextView,*attatchmentTxtview1;
    IBOutlet UIButton *expensesSaveBtn,*expensesHomeBtn,*expansesUpdateBtn,*imageNameBtn,*galleryBtn,*cameraBtn;
    IBOutlet UIView *createExpencesView;
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIAlertView *logoutalertView;
    UIPickerView *questionpkr;
    UIDatePicker *datePkr;
    IBOutlet UIImageView *atachmentsImageView;
    IBOutlet UIWebView *displayWebview;
    IBOutlet UITableView *projectlisttableview;
    
    IBOutlet UILabel *imageNameLbl,*headingLabel,*attatchmentlabel;
    
    UIImagePickerController *camImagePickerController,*galaryImagePickerController;
    

    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*attatchmentXmlParser,*attatchmentListXmlParser;
    
    //1
    NSString *projectStr,*projectIDStr,*projectNmaeStr;
    NSArray *projectNameSplitAry,*projectNameDataAry;
    NSMutableArray *projectIdArray,*projectNameArray,*projectnamearray,*projectidarray;
    NSString *pkrProjectIDStr,*pkrCategoryIDStr;
    
    //2
    NSString *categoryliststring,*categoryCodeIDStr,*categoryValuesStr;
    NSArray *categorylistdataarray,*categorylistsplitarray;
    NSMutableArray *categoryCodeIDArray,*categoryValuesArray;
    
    
    NSString *byteArray,*fileName;
    
    //3
    NSString *saveStr;
    NSMutableString *pkrProjectAmountIDStr,*pkrExpAtachIDStr;
    NSArray *saveDataAry,*saveSplitAry;
    
    NSString *attatchmentNameStr,*fileurlStr;
    NSMutableArray *attatchmentListArray,*attatchmentListSplitArray,*attatchmentnameArray,*attatchemntListFileurlArray;
    
    //4
    NSString *getBytesStr;
    NSArray *getBytesDataArray,*fileurlarray;
    
    
    
}
@property(nonatomic,strong)NSString *tblProjectNmae,*tblCategoryName,*tblProjectAmountID,*tblExpAttachID,*tblDateStr,*tblAmountStr,*tblImageNameStr,*fileurl,*projectIdStr,*projectIdCategryIdStr;

@property(nonatomic,strong)UIScrollView *scroolview;

-(IBAction)expansesSaveBtnClk:(id)sender;
-(IBAction)expansesUpdateBtnClk:(id)sender;
-(IBAction)expansesHomeBtnClk:(id)sender;

-(IBAction)expansesProjectBtnClk:(id)sender;
-(IBAction)expansesDateBtnClk:(id)sender;
-(IBAction)expansesCategoryBtnClk:(id)sender;

-(IBAction)atachmentsCamBtnClk:(id)sender;
-(IBAction)atachmentsGalaryBtnClk:(id)sender;

@end
