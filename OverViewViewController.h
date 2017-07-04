//
//  OverViewViewController.h
//  EISIOSApp
//
//  Created by vm mac on 26/07/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "UserData.h"
#import "SimpleBarChart.h"




@interface OverViewViewController : UIViewController<NSXMLParserDelegate,WebserviceownProtocal>
{
    
    IBOutlet UILabel *chartTtlLbl1,*chartTtlLbl2,*chartTtlLbl3,*XLblTxt,*YLblTxt;
    
    NSArray *_values,*_values1,*xvalues,*_values2,*_values3,*_values4,*_values5,*_values6;
        NSArray *_barColors;
    
    NSInteger _currentBarColor;
    Webservices *servicesCall;
    
    IBOutlet UIView *OverView;
    IBOutlet UIScrollView *scroll;
    
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    UIAlertView *logoutalertView;
    
    NSXMLParser *effortAndBookedTimeXmlParser,*taskOverViewGraphXmlParser,*isueOverViewXmlParser;
    UIBarButtonItem *homeBtn,*logOutBtn;
    
    NSString *jsFilePath;
    
    UILabel *chartTitleLabel;
    
    
}
@property (strong, nonatomic) IBOutlet UIView *ChartView;
@property (strong, nonatomic) IBOutlet UIView *ChartView1;

@property (strong, nonatomic) IBOutlet UIView *ChartView2;
@property (strong,nonatomic) IBOutlet UIView  *ChartView3;



@end
