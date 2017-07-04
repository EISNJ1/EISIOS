//
//  VideoViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 12/20/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface VideoViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UIImagePickerControllerDelegate>
{
    Webservices *Servicecall;
    UIAlertView *LogoutAlert;
    UIView *selectionView;
    IBOutlet UITableView *VideosTV;
    UIProgressView *activeindicator;
    IBOutlet UIButton *homebtn;
}
@property(nonatomic,strong)NSString *TaskIdstr;
@end
