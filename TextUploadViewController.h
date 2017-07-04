//
//  TextUploadViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 12/22/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"
#import "TaskListViewController.h"
#import "Webservices.h"
@class TaskListViewController;
@interface TextUploadViewController : UIViewController<UIBubbleTableViewDataSource,WebserviceownProtocal,NSXMLParserDelegate>
{
    Webservices *Servicecall;
    UIAlertView *LogoutAlert;
    IBOutlet UIView *ContentView;
    IBOutlet UIScrollView *ScrollView;
   
}
@property(nonatomic,strong)NSString *taskIdstr;
@end
