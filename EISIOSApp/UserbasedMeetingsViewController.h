//
//  UserbasedMeetingsViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/24/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
@interface UserbasedMeetingsViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>
{
    Webservices *Servicecall;
    UIAlertView *LogoutAlert;
    IBOutlet UITableView *UserbasedMeetingTV;
    
    IBOutlet UIButton *HomeButton;
}
@property(nonatomic,strong)NSString *MeetingId,*ownerName;
@property(nonatomic,strong)NSMutableArray *OwnerNmaeArray;
@end
