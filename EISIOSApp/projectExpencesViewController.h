//
//  projectExpencesViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 15/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "createProjectExpansesViewController.h"

@interface projectExpencesViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal,UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UITableView *expancesLstTl;
    UIPickerView *questionpkr;
    IBOutlet UILabel *totalLbl,*totalAmountLbl;
    IBOutlet UITextField *projectNmaeTfd;
    IBOutlet UIButton *pkrBtn;
    UIBarButtonItem *createTimeSheetActionBarBtn,*homeBtn,*logOutBtn;
    UIAlertView *logoutalertView;


    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*fileurlXmlParser;
    
    //1
    NSString *projectStr,*projectIDStr,*projectNmaeStr;
    NSArray *projectNameSplitAry,*projectNameDataAry;
    NSMutableArray *projectIdArray,*projectNameArray;
    NSString *pkrProjectIDStr;
    
    //2
    NSString *expancesliststring,*expancesIDStr,*expancesDateStr,*expancesAmountStr,*expancesCategoryIDStr,*expancesAttatchIDStr,*expancesValueStr,*expancesCategoryStr,*expensesPrjname,*expensesProjectIdStr;
    
    NSArray *expanceslistdataarray,*expanceslistsplitarray;
    NSMutableArray *expancesIDArray,*expancesDateArray,*expancesAmountArray,*expancesCategoryIDArray,*expancesAttatchIDArray,*expancesValueArray,*expancesCategoryArray,*expensesProjectnameArray,*expensesProjectIdArray;
    
    NSMutableArray *fileurlArray,*fileurlbyteArray;
    NSArray *fileUrlArray,*fileurlSplitAary;
    NSString *fileurlstr,*fileurldatastr,*FileurlStr,*FileurlLengthStr;
    NSMutableString *fileurl,*filelength;
    
}

-(IBAction)pkrBtnClk:(id)sender;

@end
