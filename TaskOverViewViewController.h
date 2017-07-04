//
//  TaskOverViewViewController.h
//  EISIOSApp
//
//  Created by vm mac on 13/06/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "Toast+UIView.h"
    
    @interface TaskOverViewViewController : UIViewController<UITableViewDelegate,NSXMLParserDelegate,UITableViewDataSource>
    {
        UIBarButtonItem *homeBtn,*logOutBtn;
        
        UIAlertView *logoutalertView;
        
        Webservices *serviceCall;
        
        NSXMLParser *taskOVerViewXmlParser;
        
        IBOutlet UIScrollView *scrollView;
        
        IBOutlet UITableView *taskOverViewTableView;
        
        IBOutlet UIButton *homeBtn1;
        
    }
    //@property(nonatomic,strong)NSString *navigationTitlestr;


@end
