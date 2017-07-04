//
//  LineChartViewController.h
//  EISIOSApp
//
//  Created by vm mac on 13/06/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"



@interface LineChartViewController : UIViewController<UIAlertViewDelegate,NSXMLParserDelegate>

{
    UIBarButtonItem *homeBtn,*logoutBtn;
    
    UIAlertView *logoutAlertView;
    
    NSXMLParser *ProgramDetailsXmlParser,*ProjectCostXmlParser;
    
    Webservices *serviceCall;
    
    IBOutlet UIView *lineChartView;
    NSString *jsFilePath;
}
@property (strong, nonatomic) IBOutlet UIView *ChartView;
@end
