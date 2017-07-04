//
//  AgendaViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/14/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "CreatMeetingViewController.h"
@class CreatMeetingViewController;
@interface AgendaViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITextViewDelegate>
{
    Webservices *Servicecall;
    IBOutlet UIScrollView *ScrollV;
    IBOutlet UITableView *AgendaTV;
    UITextView *AgendaDistextView;
 IBOutlet UIButton *AgendaCount,*Savebtn,*Backbtn,*Homebtn;
    UITextField *Agendtimetxtfld;
    UIView *Agenddetailsview;
    UIAlertView *LogoutAlert;
    IBOutlet UIView *ContentView;
    
    NSString *agendatime;
    
    CreatMeetingViewController *cvc;
}
@property(atomic)int Hours;
@property(nonatomic,strong)NSString *MeetingId,*agendaTimeBugstr;
@property(nonatomic,strong)UITextField *agendatimeTxtFld;
@end
