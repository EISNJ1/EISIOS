//
//  ParticipantsViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/15/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
@interface ParticipantsViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    Webservices *Servicecall;
    IBOutlet UIScrollView *ScrollV;
    IBOutlet UITableView *ParticipantTV;
    UIView *ParticipantsDetailsView;
    UIButton *Savebtn,*Backbtn,*Homebtn;
    UIPickerView *ParticipantsPicker;
    UITextField *ParticipantsNametxtfld,*Roletxtfld,*Flagtxtfld;
    UIAlertView *LogoutAlert;
    
}
@property(nonatomic,strong)NSString *MeetingId,*ProjectIdStr;
@end
