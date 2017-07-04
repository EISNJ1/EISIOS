//
//  ActionItemsViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/18/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface ActionItemsViewController : UIViewController<WebserviceownProtocal,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate>
{
    Webservices *Servicecall;
    IBOutlet UIScrollView *ScrollV;
    IBOutlet UIView *ContentView;
     UITableView *ActionitemsTV;
    IBOutlet UISegmentedControl *SegmentControl;
    IBOutlet UIView *ActionitemDetialsView;
    IBOutlet UIButton *Savebtn,*Homebtn,*PublicORpvtBtn,*EffortUombtnpkr;
    UITextField *assigntoTxtfld,*Duedatetxtfld,*Prioritytxtfld,*Effortrequiredtxtfld,*EffortUomtxtfld;
    UITextView *EnterNotesTxtView,*PositiveFeedBacltxtview,*NegativefeedbacktxtView,*ActiondisTextView;
    UIPickerView *PickerView;
    UIDatePicker *DatePicker;
    UIAlertView *LogoutAlert;
    
    NSString *projectId1;
}
@property(nonatomic,strong)NSString *ObjIdstr,*ObjDistr,*AgendaBasedMeetingIdstr,*projectId;
@end
