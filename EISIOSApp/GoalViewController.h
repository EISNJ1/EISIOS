//
//  GoalViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/14/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface GoalViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    Webservices *Servicecall;
    IBOutlet UIScrollView *ScrollV;
    IBOutlet UITableView *GoalsTV;
    UIView *GoalsDetailsView;
    UIButton *GoalsCount,*Savebtn,*Backbtn,*Homebtn;
    UITextField *Goalstimetxtfld;
    UITextView *GoalsDistextView;
    UIAlertView *LogoutAlert;
    IBOutlet UIView *ContentView;
}
@property(atomic)int Hours;
@property(nonatomic,strong)NSString *MeetingId;
@end
