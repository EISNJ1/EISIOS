//
//  barChartViewController.h
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 22/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleBarChart.h"
#import "Webservices.h"


@interface barChartViewController : UIViewController<SimpleBarChartDataSource, SimpleBarChartDelegate,NSXMLParserDelegate,WebserviceownProtocal>
{
    
    IBOutlet UILabel *chartTtlLbl,*XLblTxt,*YLblTxt;
    
    UIPinchGestureRecognizer *pinchgeusture;
    
    NSArray *_values,*_values1;
	SimpleBarChart *_chart;
	NSArray *_barColors;
	NSInteger _currentBarColor;
    
    
    NSString *Useridstr,*Usernamestr,*UserTypestr,*OrgIdStr;
    Webservices *Servicecall;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5,*xmlParser6,*xmlParser7,*xmlParser8,*xmlParser9,*xmlParser10,*effortAndBookedTimeXmlParser,*TeamResourcesForAdminXmlParser,*ProejctsForAllXmlParser;
    
    //1
    NSString *orgResourceRepResponseStr,*orgNameStr,*noOfResStr;
    NSArray *orgResourceRepResponseSplitAry,*orgResourceRepResponseDataAry;
    NSMutableArray *orgNameAry,*noOfResAry;
    
    //2
    
    //3
    NSString *noOfProjectsStr,*resrc_NameStr,*noOfPrjctsStr;
    NSMutableArray *noOfProjectsSplitAry,*noOfProjectsDataAry;
    NSMutableArray *resrc_NameAry,*noOfPrjctsAry;
    
    //4
    NSString *avgBilRateOrgStr,*avgBillRateStr,*avgBillRateOrgNameStr;
    NSArray *avgBilRateSplitAry,*avgBilRateDataAry;
    NSMutableArray *avgBillRateAry,*avgBillRateOrgNameAry;
    
            
    //5
    
    NSString *noOfResByProgramsResponseStr,*noOfResByProgramIDStr,*noOfResByPrgmByOrgNameStr;
    NSArray *noOfResByProgramsResponseSplitAry,*noOfResByProgramsResponseDataAry;
    NSMutableArray *noOfResByProgramIDAry,*noOfResByPrgmByOrgNameAry;

    //6
    NSMutableString *alctedCapToProgrmResponseStr,*allocatedCapacitySumStr,*allocatedCapacityProgramNameStr;
    NSArray *alctedCapToProgrmResponseSplitAry,*alctedCapToProgrmResponseDataAry;
    NSMutableArray *allocatedCapacitySumAry,*allocatedCapacityProgramNameAry;
    
    //7
    NSString *alctedCapToProjResponseStr,*allocatedCapacityProjSumStr,*allocatedCapacityProjProgramNameStr;
    NSArray *alctedCapToProjResponseSplitAry,*alctedCapToProjResponseDataAry;
    NSMutableArray *allocatedCapacityProjSumAry,*allocatedCapacityProjProgramNameAry;
    
    //8
    NSString *asgnedCapToProgramResponseStr,*AssaignedCapacitySumStr,*assignedCapacityProjectNmaeStr;
    NSArray *asgnedCapToProgramResponseSplitAry,*asgnedCapToProgramResponseDataAry;
    NSMutableArray *AssaignedCapacitySumAry,*assignedCapacityProjectNmaeAry;
    
    
    //9
    NSString *asgnedCapToProjResponseStr,*asgnedCapToProjResponseSumStr,*asgnedCapToProjResponseProjectNmaeStr;
    NSArray *asgnedCapToProjResponseSplitAry,*asgnedCapToProjResponseDataAry;
    NSMutableArray *asgnedCapToProjResponseSumAry,*asgnedCapToProjResponseProjectNmaeAry;
    
    //10
    NSString *getAvgCstResProgrmResponseStr,*getAvgCstResProgrmResponseProgramIDStr,*getAvgCstResProgrmResponseProgramNmaeStr,*AvgCstResStr,*ProgIdCountStr;
    NSArray *getAvgCstResProgrmResponseSplitAry,*getAvgCstResProgrmResponseDataAry;
    NSMutableArray *getAvgCstResProgrmResponseProgramIDAry,*getAvgCstResProgrmResponseProgramNmaeAry,*AvgCstResAry,*ProgIdCountAry;
    
    //11
    NSString *getOwnerResDetsChartResponseStr,*getOwnerResDetsChartResponseIDStr,*getOwnerResDetsChartResponseNameStr;
    NSArray *getOwnerResDetsChartResponseSplitAry,*getOwnerResDetsChartResponseDataAry;
    NSMutableArray *getOwnerResDetsChartResponseIDAry,*getOwnerResDetsChartResponseNameAry;
    
    
    NSMutableArray *effortAndBokedTimeArray,*effortAndBookedTimeSplitArray,*effortAndBookedTimeSplitDisplayArrray,*effortAndBookedTimeTaskEffortArray;
    
    NSMutableArray *teamNameForResourceArray,*teamResourceCountArray,*teamNameResourceListArray,*teamNameResourceSplitArray;
    
    NSMutableArray *proejctsForAllListArray,*proejctsForAllSplitArray,*projectsForAllProjectsArray,*proejctsListForAllCountArray,*filterTeamResourceArray;
    
    NSArray *FilterTeamResourceArray,*FilterProjectsForAllArray,*FilterProjectsForAllCountArray;
    NSMutableString *resourceNameStr,*resourcecountStr,*projectsForAllStr,*proejctsForaAllCountStr;
    
    NSMutableArray *FilterTeamResourceCountArray;
    NSString *programOwnerStr;
    UIScrollView *scrollView;
    
}
@end
