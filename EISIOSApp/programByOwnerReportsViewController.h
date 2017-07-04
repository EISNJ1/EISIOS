//
//  programByOwnerReportsViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 29/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface programByOwnerReportsViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal>
{
    IBOutlet UITableView *programOwnerReportsTbl;
    UIBarButtonItem *homeBtn,*logOutBtn;
    UIAlertView *logoutalertView;
    
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser;
    
    NSString *getNoOfPrgmsForOwnerResponseStr;
    NSArray *getNoOfPrgmsForOwnerResponseSplitAry,*getNoOfPrgmsForOwnerResponseDataAry;
    
    NSMutableArray * Org_IdAry,*Program_OwnerAry,*First_NameAry,*BudgetAry,*NoofProgramsAry,*NoofResourcesAry;
    NSString * Org_IdStr,*Program_OwnerStr,*First_NameStr,*BudgetStr,*NoofProgramsStr,*NoofResourcesStr;


}
@end
