//
//  MeetingListViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 10/31/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "CreatMeetingViewController.h"
#import "ActionItemsViewController.h"
#import "UserbasedMeetingsViewController.h"
@interface MeetingListViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

{
    CreatMeetingViewController *CreatMeetingtV ;
    ActionItemsViewController  *ActionItemsVC;
    UserbasedMeetingsViewController *UserbasedMeetings;
    IBOutlet UITextField *PublicNotestxt,*meetingDesTxtFld;
    IBOutlet UIScrollView *scrollV;
    IBOutlet UITableView *MeetingListTV,*AgendaListTv,*PublicCountTV,*ActionItemListTV;
    IBOutlet UILabel *Notescountlbl,*Actionitemlbl,*Feedbacklbl,*PublicCountlbl;
    Webservices *Servicecall;
    IBOutlet UIButton *Notebtn,*Feedbackbtn,*Actionitembtn;
    IBOutlet UIView *PublicNotesView;
    IBOutlet UIImageView *ArrowsImgV;
    UIButton *arrowsImg,*arrowsImg1;
    UIAlertView *LogoutAlert,*alertView1,*alertView2;
    IBOutlet UIView *ContentView;
    NSString *objestidstr,*meetingidstr2,*statusStr;
    IBOutlet UILabel *totalListLabel;
    
    IBOutlet UISearchBar *MeetingSearchBar;
    UIPickerView *MeetingSearchPickerView;
    UIButton *agendaBtn;
    NSMutableArray *meetingdatesArray;
    IBOutlet UIButton *selectMEetingTypeButton;
    IBOutlet UILabel *meetingTypeLabel;
    NSString *flagstr;
    NSString *meetingidstr;
    
}
@property (strong, nonatomic) IBOutlet UIButton *agendaButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(nonatomic)IBOutlet  UIButton *bn;
- (IBAction)agendaBtnClicked:(id)sender;
@end
