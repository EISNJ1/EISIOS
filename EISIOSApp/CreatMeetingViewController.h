//
//  CreatMeetingViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AgendaViewController.h"
#import "GoalViewController.h"
#import "ParticipantsViewController.h"
@class AgendaViewController;
@interface CreatMeetingViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    Webservices *Servicecall;
    AgendaViewController *AgendaVC;
    GoalViewController *GoalsVC;
    ParticipantsViewController *ParticipantVC;
    
    
    IBOutlet UIScrollView *ScrolV;
    IBOutlet UIView *CreatmeetingView;
    IBOutlet UIButton *Savebtn,*homebtn,*agendabtn,*goalsbtn,*participentbtn;
    IBOutlet UITextField *Projectstxtfld,*Meetingtypetxtfld,*Meetingtitletxtfld,*Meetingdistxtfld,*Meetingtimetxtfld,*Meetinglengthtxtfld,*Confrencermtxtfld;
    UIAlertView *LogoutAlert;
    
    NSString *timeLength1,*MeetingResponseStr;
    UIButton *ProjectListbtn;
}
@property (nonatomic,strong)NSString *navigationTitlestr,*SavebtnTitlestr;
@property (assign) BOOL locationUseBool;
//---------Update Meeting----------

@property (nonatomic,strong)NSString *MeetingId,*Hoursstr,*MeetingTypestr,*ProjectNamestr,*MeetingDatestr,*ConferenceRoomstr,*MeetingDescriptionstr,*MeetingTitlestr,*Starttimestr,*ProjId,*MeetingTypeId,*ConfOwnerId,*agendaLenthStr;
@property(nonatomic,strong)NSArray *DateArray;
@end
