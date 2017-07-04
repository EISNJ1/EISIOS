//
//  OverViewViewController.m
//  EISIOSApp
//
//  Created by vm mac on 26/07/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//

#import "OverViewViewController.h"
#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "TWRChart.h"
#import "Toast+UIView.h"

@interface OverViewViewController()
{
    NSMutableArray *effortAndBokedTimeArray,*effortAndBookedTimeSplitArray,*effortAndBookedTimeSplitDisplayArrray,*effortAndBookedTimeTaskEffortArray,*effortAndBookedTimeProjectName,*taskOverViewGraphListArray,*TaskOVerViewGraphSplitArray,*TaskOVerViewGraphTotalTaskArray,*TaskOverViewGraphCompletedTaskArray,*NotStartedTaskArray,*TaskOVerViewInProcessingTaskArray,*TaskOVerViewFutureTaskArray,*TaskOverViewProjectName,*TaskOverViewRemainingTasks,*issueOverChartArray,*issueOverViewChartSplitArray,*issueOverViewSplitDisplayArray,*issueOverViewChartArrayList,*issueChartTotalIssueCountArray,*issueChartTotalIssueFixedArray,*issueChartTotalIssueClsoedArray;
    
    }
@property(strong, nonatomic) TWRChartView *chartView;
@property(strong, nonatomic) TWRChartView *chartView1;
@property(strong, nonatomic) TWRChartView *chartView2;
@property(strong, nonatomic) TWRChartView *chartView3;
@property(strong, nonatomic) TWRBarChart  *bar;
@property(strong, nonatomic) TWRBarChart  *bar1;
@property(strong, nonatomic) TWRBarChart  *bar2;
@end

@implementation OverViewViewController
@synthesize ChartView,ChartView1,ChartView2,ChartView3;

//- (NSArray *)getXTitles:(int)num
//{
//    NSMutableArray *xTitles = [NSMutableArray array];
//    for (int i=0; i<num; i++)
//    {
//        //NSString * str = [NSString stringWithFormat:@"R-%d",i];
//        xTitles=
//    }
//    return xTitles;
//}



- (void)viewDidLoad
{
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,nil];
    
   // scroll.contentSize = CGSizeMake(0, scroll.contentSize.height);
    //[scroll setContentSize:CGSizeMake(120, 20)];
    //[scroll addSubview:OverView];
    //[self.view addSubview:scroll];
    
    
    //[self DatafromDB];
    //self.navigationItem.title = navigationTitlestr;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    NSLog(@"username str is %@",Usernamestr);
    NSLog(@"user id str is %@",Useridstr);
    NSLog(@"orgid str is %@",orgIdstr);
    NSLog(@"usertype str is %@",Usertypestr);
    
    
    
    [self effortAndBookedTime];
    [self issuesGraphData];
    [self issueOVerview];
    
    
    
    ChartView1=[[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-10, 400)];
    //ChartView1.backgroundColor=[UIColor blueColor];
    _chartView = [[TWRChartView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 400)];
    _chartView.backgroundColor = [UIColor clearColor];
    jsFilePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"js"];
    [_chartView setChartJsFilePath:jsFilePath];
    [ChartView1 addSubview:_chartView];
    [OverView addSubview:ChartView1];
    
    ChartView2=[[UIView alloc]initWithFrame:CGRectMake(0, 410, self.view.frame.size.width-10, 400)];
    //ChartView2.backgroundColor=[UIColor redColor];
    _chartView1 = [[TWRChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    _chartView1.backgroundColor = [UIColor clearColor];
    jsFilePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"js"];
    [_chartView1 setChartJsFilePath:jsFilePath];
    [ChartView2 addSubview:_chartView1];
    [OverView addSubview:ChartView2];
    
    ChartView3=[[UIView alloc]initWithFrame:CGRectMake(0, 850, self.view.frame.size.width-10, 400)];
    //ChartView2.backgroundColor=[UIColor redColor];
    _chartView2 = [[TWRChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    _chartView2.backgroundColor = [UIColor clearColor];
    jsFilePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"js"];
    [_chartView2 setChartJsFilePath:jsFilePath];
    [ChartView3 addSubview:_chartView2];
    [OverView addSubview:ChartView3];
    
    [self loadGraph];
    [self loadGraph1];
    [self loadGraph2];
    [OverView setNeedsDisplay];

    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)homeBtnClk
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
-(void)logOutBtnClk
{
    logoutalertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [logoutalertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == logoutalertView)
    {
        if(buttonIndex == 0)
        {
            
            
        }
        else
        {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}


- (void)viewDidLayoutSubviews
{
     scroll.contentSize = CGSizeMake(320, 1600);
}


//effort and booked time service call
-(void)effortAndBookedTime
{
    servicesCall=[[Webservices alloc]init];
    NSString *EffortAndBookedClass=@"ExecuteDashboardNewService";
    NSDictionary *EffortAndBookedTimeDictionary=@{@"userType":Usertypestr,@"userId":Useridstr,@"orgId":orgIdstr};
    
    [servicesCall OVerViewEffortAndBookedTime:EffortAndBookedClass OverViewBookedAndTimeParameters:EffortAndBookedTimeDictionary];
    [servicesCall setDelegate:self];
    
}

//task graph data service call

-(void)issuesGraphData
{
    servicesCall=[[Webservices alloc]init];
    NSString *TaskOverViewGraphClass=@"ExecuteDashboardNewService";
    NSDictionary *TaskOverViewGraphDisctionary=@{@"userType":Usertypestr,@"userId":Useridstr,@"orgId":orgIdstr};
    
    [servicesCall taskOverViewGraph:TaskOverViewGraphClass TaskOverViewGraphParameters:TaskOverViewGraphDisctionary];
    [servicesCall setDelegate:self];

}
-(void)issueOVerview
{
    servicesCall=[[Webservices alloc]init];
    NSString *issueOVerViewClass=@"ExecuteDashboardNewService";
    NSDictionary *IssueOverViewParameters=@{@"userType":Usertypestr,@"userId":Useridstr,@"orgId":orgIdstr};
    
    [servicesCall issuesOverViewChart:issueOVerViewClass IssueOverviewParameters:IssueOverViewParameters];
    [servicesCall setDelegate:self];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)Serviceactiondone1:(id)result
{
    effortAndBookedTimeXmlParser=[[NSXMLParser alloc]initWithData:result];
    effortAndBookedTimeXmlParser.delegate=self;
    [effortAndBookedTimeXmlParser parse];
    
    taskOverViewGraphXmlParser=[[NSXMLParser alloc]initWithData:result];
    taskOverViewGraphXmlParser.delegate=self;
    [taskOverViewGraphXmlParser parse];
    
    isueOverViewXmlParser=[[NSXMLParser alloc]initWithData:result];
    isueOverViewXmlParser.delegate=self;
    [isueOverViewXmlParser parse];
    
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==effortAndBookedTimeXmlParser)
    {
        if([elementName isEqualToString:@"effortAndBookedTimeOvervieGraphResponse"])
        {
            effortAndBokedTimeArray                      =[NSMutableArray new];
            effortAndBookedTimeSplitArray                =[NSMutableArray new];
            effortAndBookedTimeSplitDisplayArrray        =[NSMutableArray new];
            effortAndBookedTimeTaskEffortArray           =[NSMutableArray new];
            effortAndBookedTimeProjectName               =[NSMutableArray new];
        }
    }
    
        if (parser==taskOverViewGraphXmlParser)
        {
            if ([elementName isEqualToString:@"taskOverviewChartResponse"])
            {
                taskOverViewGraphListArray       =[NSMutableArray new];
                TaskOVerViewGraphSplitArray      =[NSMutableArray new];
                TaskOVerViewGraphTotalTaskArray  =[NSMutableArray new];
                TaskOverViewRemainingTasks       =[NSMutableArray new];
                TaskOVerViewFutureTaskArray      =[NSMutableArray new];
                TaskOVerViewInProcessingTaskArray=[NSMutableArray new];
                TaskOverViewGraphCompletedTaskArray=[NSMutableArray new];
                NotStartedTaskArray              =[NSMutableArray new];
                TaskOverViewProjectName          =[NSMutableArray new];
            }
        }
    if (parser==isueOverViewXmlParser)
    {
        if ([elementName isEqualToString:@"issusOverviewChartResponse"])
        {
            issueOverChartArray              =[NSMutableArray new];
            issueOverViewChartSplitArray     =[NSMutableArray new];
            issueOverViewSplitDisplayArray   =[NSMutableArray new];
            issueOverViewChartArrayList      =[NSMutableArray new];
            issueChartTotalIssueCountArray   =[NSMutableArray new];
            issueChartTotalIssueFixedArray   =[NSMutableArray new];
            issueChartTotalIssueClsoedArray  =[NSMutableArray new];
        }
    }
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    
    
    if (parser == effortAndBookedTimeXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            [self.view makeToast:@"No Data" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:nil];
        }
        else
        {
            [effortAndBokedTimeArray addObject:string];
        }
    }
        if (parser==taskOverViewGraphXmlParser)
        {
           if([string isEqualToString:@"Flase"])
          {
    [self.view makeToast:@"No Data" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                                title:nil];
          }
          else
          {
            [taskOverViewGraphListArray addObject:string];
          }
        }
    if (parser==isueOverViewXmlParser)
    {
        if([string isEqualToString:@"Flase"])
        {
            [self.view makeToast:@"No Data" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:nil];
        }
        else
        {
            [issueOverChartArray addObject:string];
        }
    }

}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == effortAndBookedTimeXmlParser)
    {
        if([elementName isEqualToString:@"effortAndBookedTimeOvervieGraphResponse"])
        {
            for (int i = 0; i<[effortAndBokedTimeArray count]; i++)
            {
                effortAndBookedTimeSplitArray=[[effortAndBokedTimeArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [effortAndBookedTimeSplitDisplayArrray addObject:[[effortAndBookedTimeSplitArray objectAtIndex:7] stringByReplacingOccurrencesOfString: @"TaskEffort==" withString:@""]];
                
                [effortAndBookedTimeTaskEffortArray addObject:[[effortAndBookedTimeSplitArray objectAtIndex:8] stringByReplacingOccurrencesOfString: @"bookedTime==" withString:@""]];
                
                [effortAndBookedTimeProjectName addObject:[[effortAndBookedTimeSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"teamName==" withString:@""]];
                
        }
            
          
          [self loadGraph];
            
            NSLog(@"project names are %@",effortAndBookedTimeProjectName);
        }
        //chartTitleLabel.text=@"TaskOverViewEffortTime";
        

        
    }
    if (parser == taskOverViewGraphXmlParser)
    {
        if([elementName isEqualToString:@"taskOverviewChartResponse"])
        {
            for (int i = 0; i<[taskOverViewGraphListArray count];i++)
            {
                TaskOVerViewGraphSplitArray=[[taskOverViewGraphListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [TaskOVerViewGraphTotalTaskArray addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:7] stringByReplacingOccurrencesOfString: @"totalTaskCount==" withString:@""]];
                
                [TaskOverViewGraphCompletedTaskArray addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:8] stringByReplacingOccurrencesOfString: @"compltdTaskCount==" withString:@""]];
                
                [TaskOVerViewInProcessingTaskArray addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:9] stringByReplacingOccurrencesOfString: @"curentProcesingTaskCount==" withString:@""]];
                
                [TaskOVerViewFutureTaskArray addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:11] stringByReplacingOccurrencesOfString: @"futureTaskCount==" withString:@""]];
                

                [NotStartedTaskArray addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:10] stringByReplacingOccurrencesOfString: @"notStartedTaskCount==" withString:@""]];
                
                [TaskOverViewProjectName addObject:[[TaskOVerViewGraphSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"teamTaskName==" withString:@""]];
                
                
            }
            
            
            NSLog(@"the array values are %@ %@ %@ %@ %@ %@",TaskOVerViewGraphTotalTaskArray,TaskOverViewGraphCompletedTaskArray,TaskOVerViewInProcessingTaskArray,TaskOVerViewFutureTaskArray,TaskOverViewRemainingTasks,TaskOverViewGraphCompletedTaskArray);
            
            NSLog(@"project names are %@",TaskOverViewProjectName);
             [self loadGraph1];
        }
   
        chartTitleLabel.text=@"TaskOverViewCompletedTask";
       

    }
    if (parser == isueOverViewXmlParser)
    {
        if([elementName isEqualToString:@"issusOverviewChartResponse"])
        {
            for (int i = 0; i<[issueOverChartArray count]; i++)
            {
                issueOverViewChartSplitArray=[[issueOverChartArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [issueOverViewSplitDisplayArray addObject:[[issueOverViewChartSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"programName==" withString:@""]];
                
                [issueChartTotalIssueCountArray addObject:[[issueOverViewChartSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"totalIssueCount==" withString:@""]];
                
                 [issueChartTotalIssueFixedArray addObject:[[issueOverViewChartSplitArray objectAtIndex:4] stringByReplacingOccurrencesOfString: @"fixedIssueCount==" withString:@""]];
                
                [issueChartTotalIssueClsoedArray addObject:[[issueOverViewChartSplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString: @"closedIssueCount==" withString:@""]];
                
                
            }
            
            
            
            NSLog(@"array values are %@ %@ %@ %@",issueOverViewSplitDisplayArray,issueChartTotalIssueCountArray,issueChartTotalIssueFixedArray,issueChartTotalIssueClsoedArray);
            
            [self loadGraph2];
        }
        
    }
    chartTitleLabel.text=@"TaskOverViewIssues";
    
}

//-(void)loadGraph
//{
//    NSArray *vals = effortAndBookedTimeSplitDisplayArrray;
//    NSArray *refs = effortAndBookedTimeProjectName;
//    DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:ChartView.bounds
//                                                   color:[UIColor whiteColor]
//                                              references:refs
//                                               andValues:vals];
//    chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    chrt.bounds = ChartView.bounds;
//    [ChartView addSubview:chrt];
//
//    
//}

-(void)loadGraph
{
    NSLog(@"chart label text is %@",chartTitleLabel.text);
    
    TWRDataSet *dataSet1 = [[TWRDataSet alloc]initWithDataPoints:effortAndBookedTimeSplitDisplayArrray
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];
    
    TWRDataSet *dataSet2 = [[TWRDataSet alloc]initWithDataPoints:effortAndBookedTimeTaskEffortArray
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];

    
    NSArray *labels = effortAndBookedTimeProjectName;
    
    _bar = [[TWRBarChart alloc]initWithLabels:labels
                                            dataSets:@[dataSet1,dataSet2]
                                                  animated:YES];
    
    [_chartView loadBarChart:_bar];
   
    NSLog(@"welcome to chart 1");
    [self loadGraph1];
    [self loadGraph2];
    
    
}
-(void)loadGraph1
{
   
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:TaskOVerViewGraphTotalTaskArray
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];
    
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:TaskOverViewGraphCompletedTaskArray
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    
    TWRDataSet *dataSet3 = [[TWRDataSet alloc] initWithDataPoints:TaskOVerViewInProcessingTaskArray
                                                        fillColor:[[UIColor blueColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    
    TWRDataSet *dataSet4 = [[TWRDataSet alloc] initWithDataPoints:TaskOVerViewFutureTaskArray
                                                        fillColor:[[UIColor greenColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    
    
    NSArray *labels = effortAndBookedTimeProjectName;
    
  _bar1 = [[TWRBarChart alloc]initWithLabels:labels dataSets:@[dataSet1,dataSet2,dataSet3,dataSet4]
                                                  animated:YES];
    
    
    [_chartView1 loadBarChart:_bar1];
    NSLog(@"welcome to chart 2");
    
}

-(void)loadGraph2
{
    
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueCountArray
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];
    
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueFixedArray
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    TWRDataSet *dataSet3= [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueClsoedArray
                                                        fillColor:[[UIColor blueColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor blueColor]];
   
    
    

    
    NSArray *labels = TaskOverViewProjectName;
   _bar2 = [[TWRBarChart alloc]initWithLabels:labels
                                                  dataSets:@[dataSet1,dataSet2,dataSet3]
                                                  animated:YES];
    
    [_chartView2 loadBarChart:_bar2];
    NSLog(@"welcome to chart 3");
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadGraph];
    [self loadGraph1];
    [self loadGraph2];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadGraph];
    [self loadGraph1];
    [self loadGraph2];
}
//
//-(void)loadGraph2
//    {
//       
//        TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueCountArray
//                                                            fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
//                                                          strokeColor:[UIColor orangeColor]];
//        
//        TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueFixedArray
//                                                            fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
//                                                          strokeColor:[UIColor redColor]];
//        TWRDataSet *dataSet3= [[TWRDataSet alloc] initWithDataPoints:issueChartTotalIssueClsoedArray
//                                                           fillColor:[[UIColor blueColor] colorWithAlphaComponent:0.5]
//                                                         strokeColor:[UIColor blueColor]];
//        
//        
//        
//        NSArray *labels = issueOverViewSplitDisplayArray;
//        TWRBarChart *bar2 = [[TWRBarChart alloc]initWithLabels:labels
//                                                      dataSets:@[dataSet1,dataSet2,dataSet3]
//                                                      animated:YES];
//        
//        [_chartView2 loadBarChart:bar2];
//        //[ChartView2 addSubview:_chartView2];
//        NSLog(@"loading graph 2");
//    }


@end
