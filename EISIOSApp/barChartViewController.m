//
//  barChartViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 22/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "barChartViewController.h"

@interface barChartViewController ()

@end

@implementation barChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,900)];
    scrollView.showsVerticalScrollIndicator=YES;
    scrollView.scrollEnabled=YES;
    scrollView.userInteractionEnabled=YES;
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,1200);
    
    
   
    //[self.view addSubview:scrollView];
    
    pinchgeusture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(twoFingerPinch:)];
    [scrollView addGestureRecognizer:pinchgeusture];
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
   
    //Getting data
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    NSString *tableString = [defaults2 objectForKey:@"TableString"];
    NSLog(@"uname = %@ ",tableString);
    
    //YLblTxt.transform = CGAffineTransformMakeRotation(M_PI_2);
    //XLblTxt.layer.transform=CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    YLblTxt.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    [YLblTxt setFrame:CGRectMake(20, 350, 40, 350)];
    
    
    if ([tableString isEqualToString:@"Organisation Resource Report"])
    {
        [self organaizationResourcrReporService];
        chartTtlLbl.text = @"Organisation Resource Report";
        XLblTxt.text = @"Organisation";
        YLblTxt.text = @"No Of Resources";
        

    }
    else if ([tableString isEqualToString:@"People by skills Report"])
    {
        [self peopleBySkillsReportService];
        chartTtlLbl.text = @"People by skills Report";
        XLblTxt.text = @"Resources";
        YLblTxt.text = @"No Of Projects";
    }
    else if ([tableString isEqualToString:@"Number of projects by Resource Report"])
    {

        [self numberOfProjectsByResourceReportService];
        chartTtlLbl.text = @"Number of projects by Resource Report";
        XLblTxt.text = @"Resources";
        YLblTxt.text = @"No Of Projects";
    }
    else if ([tableString isEqualToString:@"Average Billing Rate by Organisation"])
    {
        [self AverageBillingRatebyOrganisationService];
        chartTtlLbl.text = @"Average Billing Rate by Organisation";
        XLblTxt.text = @"Organisation";
        YLblTxt.text = @"Avg Billing Rate";
        
    }
    
    else if ([tableString isEqualToString:@"Number of Resources by Programs"])
    {
        [self NumberofResourcesbyProgramsService];
        chartTtlLbl.text = @"Number of Resources by Programs";
        XLblTxt.text = @"Program";
        YLblTxt.text = @"No Of Resources";

    }
    else if ([tableString isEqualToString:@"Allocated capacity to Program"])
    {
        [self AllocatedcapacitytoProgramService];
        chartTtlLbl.text = @"Allocated capacity to Program";
        XLblTxt.text = @"Program";
        YLblTxt.text = @"Allocated Capacity";

        
    }
    else if ([tableString isEqualToString:@"Allocated capacity to Project"])
    {
        [self AllocatedcapacitytoProjectService];
        chartTtlLbl.text = @"Allocated capacity to Project";
        XLblTxt.text = @"Project";
        YLblTxt.text = @"Allocated Capacity";

    }
    
    else if ([tableString isEqualToString:@"Assigned capacity to Program"])
    {
         [self AssignedcapacitytoProgramService];
         chartTtlLbl.text = @"Assigned capacity to Program";
         XLblTxt.text = @"Program";
         YLblTxt.text = @"Assigned Capacity";

    }
    
    else if ([tableString isEqualToString:@"Assigned capacity to project"])
    {
        [self AssignedcapacitytoProjectService];
        chartTtlLbl.text = @"Assigned capacity to project";
        XLblTxt.text = @"Project";
        YLblTxt.text = @"Assigned Capacity";

    }
    
    else if ([tableString isEqualToString:@"Average Cost of Resource by Program"])
    {
        [self AverageCostofResourcebyProgramService];
        chartTtlLbl.text = @"Average Cost of Resource by Program";
        XLblTxt.text = @"Program";
        YLblTxt.text = @"Avg Cost Of Resource By Program";

    }
    else if ([tableString isEqualToString:@"Program By Owner Reports"])
        
    {
        
        NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
        programOwnerStr = [defaults2 objectForKey:@"TableString1"];
        NSLog(@"uname = %@ ",programOwnerStr);

        
        [self progrmaByOwnerService];
        chartTtlLbl.text = @"Program Owner Budget Report";
        XLblTxt.text = @"Program";
        YLblTxt.text = @"No Of Resources";
        
    }
    else if ([tableString isEqualToString:@"No of Resource By Project"])
        
    {
         [self ProejctsForAll];
       
        chartTtlLbl.text = @"No of Resource By Project";
        XLblTxt.text = @"Projects";
        YLblTxt.text = @"Count";
        
    }
    else if ([tableString isEqualToString:@"No Of Resource By Team"])
        
    {
        
       
         [self TeamResourcesForAdmin];
        chartTtlLbl.text = @"No Of Resource By Team";
        XLblTxt.text = @"Resource";
        YLblTxt.text = @"Count";
    }

[super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
        NSLog(@"Pinch scale: %f", recognizer.scale);
    if (recognizer.scale >1.0f && recognizer.scale < 4.5f)
    {
        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        scrollView.transform = transform;
        scrollView.contentSize=CGSizeMake(self.view.frame.size.width+200, 1200);
    }
}
-(void)loadGraph
{
    
   
    
	_barColors						= @[[UIColor orangeColor]];
	_currentBarColor				= 0;
    
    //	CGRect chartFrame				= CGRectMake(0.0,
    //												 0.0,
    //												 300,
    //												 300.0);
    
    CGRect chartFrame				= CGRectMake(60,128-20,self.view.frame.size.width-40-40,self.view.frame.size.height-192-40);//728//1024
	_chart							= [[SimpleBarChart alloc] initWithFrame:chartFrame];
	//_chart.center					= CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
	_chart.delegate					= self;
	_chart.dataSource				= self;
	_chart.barShadowOffset			= CGSizeMake(2.0, 1.0);
	_chart.animationDuration		= 1.0;
	_chart.barShadowColor			= [UIColor clearColor];
	_chart.barShadowAlpha			= 0.5;
	_chart.barShadowRadius			= 1.0;
	_chart.barWidth					= 18.0;
	_chart.xLabelType				= SimpleBarChartXLabelTypeHorizontal;//SimpleBarChartXLabelTypeVerticle;
	_chart.incrementValue			= 10;
	_chart.barTextType				= SimpleBarChartBarTextTypeTop;
	_chart.barTextColor				= [UIColor blackColor];
    //
	_chart.gridColor				= [UIColor clearColor];
    //
    
    
	[scrollView addSubview:_chart];
    
    
	[_chart reloadData];

}
//- (void)viewDidAppear:(BOOL)animated

//{
//	[super viewDidAppear:animated];
//    
//	[_chart reloadData];
//}


#pragma mark SimpleBarChartDataSource

- (NSUInteger)numberOfBarsInBarChart:(SimpleBarChart *)barChart
{
	//return _values.count;
    return [_values count];

}

- (CGFloat)barChart:(SimpleBarChart *)barChart valueForBarAtIndex:(NSUInteger)index
{
	//return [[_values objectAtIndex:index] floatValue];
    return [[_values objectAtIndex:index]floatValue];

}

- (NSString *)barChart:(SimpleBarChart *)barChart textForBarAtIndex:(NSUInteger)index
{
	//return [[_values objectAtIndex:index] stringValue];
    return [_values objectAtIndex:index];

}

- (NSString *)barChart:(SimpleBarChart *)barChart xLabelForBarAtIndex:(NSUInteger)index
{
	//return [[_values objectAtIndex:index] stringValue];
    //return [_values objectAtIndex:index];
    return [_values1 objectAtIndex:index];

    
}

- (UIColor *)barChart:(SimpleBarChart *)barChart colorForBarAtIndex:(NSUInteger)index
{
	return [_barColors objectAtIndex:_currentBarColor];
}
-(void)organaizationResourcrReporService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr};
    [Servicecall organizationReportGraph:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

}

-(void)didFinishService :(id)Userlogindetails
{
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
}

-(void)peopleBySkillsReportService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall peopleBySkillsReport:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
}
-(void)numberOfProjectsByResourceReportService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall noOfProjectsReports:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)didNotesCountFinished :(id)Notescountlist
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    
}

-(void)AverageBillingRatebyOrganisationService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall avgBlgRateByOrganization:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)Serviceactiondone : (id)result
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
}

-(void)NumberofResourcesbyProgramsService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr,@"userId":Useridstr};
    [Servicecall noOfResourcesByPrgrm:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)Serviceactiondone1:(id)result
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:result];
    xmlParser4.delegate = self;
    [xmlParser4 parse];
    
    TeamResourcesForAdminXmlParser=[[NSXMLParser alloc]initWithData:result];
    TeamResourcesForAdminXmlParser.delegate=self;
    [TeamResourcesForAdminXmlParser parse];
    
    ProejctsForAllXmlParser=[[NSXMLParser alloc]initWithData:result];
    ProejctsForAllXmlParser.delegate=self;
    [ProejctsForAllXmlParser parse];

}

-(void)AllocatedcapacitytoProgramService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall allocataedCapacityToPrgrm:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)didFinishData :(id)Data
{
    xmlParser5 = [[NSXMLParser alloc]initWithData:Data];
    xmlParser5.delegate = self;
    [xmlParser5 parse];
}

-(void)AllocatedcapacitytoProjectService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall allocatedCapacityToProject:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(void)didEndTask :(id)Taskend
{
    xmlParser6 = [[NSXMLParser alloc]initWithData:Taskend];
    xmlParser6.delegate = self;
    [xmlParser6 parse];
}

-(void)AssignedcapacitytoProgramService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall assignedCapacityToProgram:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)serviceCal :(id)ServerData
{
    xmlParser7 = [[NSXMLParser alloc]initWithData:ServerData];
    xmlParser7.delegate = self;
    [xmlParser7 parse];
}

-(void)AssignedcapacitytoProjectService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall assignedCapacityToProject:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)Servicecal1 :(id)ServerData
{
    xmlParser8 = [[NSXMLParser alloc]initWithData:ServerData];
    xmlParser8.delegate = self;
    [xmlParser8 parse];
}

-(void)AverageCostofResourcebyProgramService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"orgId":OrgIdStr};
    [Servicecall avgCostOfReourceByPrgrm:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(void)ServiceCalls :(id)ServiceCal
{
    xmlParser9 = [[NSXMLParser alloc]initWithData:ServiceCal];
    xmlParser9.delegate = self;
    [xmlParser9 parse];
}

-(void)progrmaByOwnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"programOwner":programOwnerStr};
    [Servicecall prgrmByOwnerDetails:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)TeamResourcesForAdmin
{
    NSLog(@"usertype is %@",UserTypestr);
    NSLog(@"user id str is %@",Useridstr);
    Servicecall=[[Webservices alloc]init];
    NSString *TeamResourceForAdminClass1=@"ExecuteDashBoard";
    NSDictionary *TeamResourceForAdminParametrs1=@{@"userType":UserTypestr,@"orgId":OrgIdStr,@"userId":Useridstr};
    [Servicecall TeamResourcesForAdmin:TeamResourceForAdminClass1 TeamResourceForAdminParameters:TeamResourceForAdminParametrs1];
    [Servicecall setDelegate:self];
    
    NSLog(@"the dictionary is %@",TeamResourceForAdminParametrs1);
    
}
-(void)ProejctsForAll
{
    NSLog(@"usertype is %@",UserTypestr);
    NSLog(@"user id str is %@",Useridstr);
    Servicecall=[[Webservices alloc]init];
    NSString *ProejctsForAllClass1=@"ExecuteDashBoard";
    NSDictionary *ProejctsForAllDictionary1=@{@"userType":UserTypestr,@"orgId":OrgIdStr,@"userId":Useridstr};
    [Servicecall ProejctsForAll:ProejctsForAllClass1 ProjectsForAllParameters:ProejctsForAllDictionary1];
    [Servicecall setDelegate:self];

}
-(void)ServiceCalls1 :(id)ServiceCal1
{
    xmlParser10 = [[NSXMLParser alloc]initWithData:ServiceCal1];
    xmlParser10.delegate = self;
    [xmlParser10 parse];

}






-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"orgResourceRepResponse"])
    {
        orgResourceRepResponseStr          = [[NSString alloc] init];
        orgResourceRepResponseSplitAry   = [[NSArray alloc] init];
        orgResourceRepResponseDataAry    = [[NSArray alloc] init];
        
        orgNameAry        = [[NSMutableArray alloc] init];
        noOfResAry  = [[NSMutableArray alloc] init];
        
    }
    else if ([elementName isEqualToString:@"noOfProjsByResReprtResponse"])
    {
        noOfProjectsStr          = [[NSString alloc] init];
        noOfProjectsSplitAry   = [[NSMutableArray alloc] init];
        noOfProjectsDataAry    = [[NSMutableArray alloc] init];
        
        resrc_NameAry        = [[NSMutableArray alloc] init];
        noOfPrjctsAry  = [[NSMutableArray alloc] init];
        
    }

    else if ([elementName isEqualToString:@"avgBilngRateByOrgResponse"])
    {
        avgBilRateOrgStr          = [[NSString alloc] init];
        avgBilRateSplitAry   = [[NSArray alloc] init];
        avgBilRateDataAry    = [[NSArray alloc] init];
        
        avgBillRateAry        = [[NSMutableArray alloc] init];
        avgBillRateOrgNameAry  = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"noOfResByProgramsResponse"])
    {
        noOfResByProgramsResponseStr          = [[NSString alloc] init];
        noOfResByProgramsResponseSplitAry   = [[NSArray alloc] init];
        noOfResByProgramsResponseDataAry    = [[NSArray alloc] init];
        
        noOfResByProgramIDAry        = [[NSMutableArray alloc] init];
        noOfResByPrgmByOrgNameAry  = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"alctedCapToProgrmResponse"])
    {
        alctedCapToProgrmResponseStr          = [[NSString alloc] init];
        alctedCapToProgrmResponseSplitAry   = [NSArray new];
        alctedCapToProgrmResponseDataAry    = [NSArray new];
        
        allocatedCapacitySumAry        = [NSMutableArray new];
        allocatedCapacityProgramNameAry  = [NSMutableArray new];
        
    }
    
    else if ([elementName isEqualToString:@"alctedCapToProjResponse"])
    {
        alctedCapToProjResponseStr          = [[NSString alloc] init];
        alctedCapToProjResponseSplitAry   = [[NSArray alloc] init];
        alctedCapToProjResponseDataAry    = [[NSArray alloc] init];
        
        allocatedCapacityProjSumAry        = [[NSMutableArray alloc] init];
        allocatedCapacityProjProgramNameAry  = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"asgnedCapToProgramResponse"])
    {
        asgnedCapToProgramResponseStr          = [[NSString alloc] init];
        asgnedCapToProgramResponseSplitAry   = [[NSArray alloc] init];
        asgnedCapToProgramResponseDataAry    = [[NSArray alloc] init];
        
        AssaignedCapacitySumAry        = [[NSMutableArray alloc] init];
        assignedCapacityProjectNmaeAry  = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"asgnedCapToProjResponse"])
    {
        asgnedCapToProjResponseStr          = [[NSString alloc] init];
        asgnedCapToProjResponseSplitAry   = [[NSArray alloc] init];
        asgnedCapToProjResponseDataAry    = [[NSArray alloc] init];
        
        asgnedCapToProjResponseSumAry        = [[NSMutableArray alloc] init];
        asgnedCapToProjResponseProjectNmaeAry  = [[NSMutableArray alloc] init];
        
    }

    else if ([elementName isEqualToString:@"getAvgCstResProgrmResponse"])
    {
        getAvgCstResProgrmResponseStr          = [[NSString alloc] init];
        getAvgCstResProgrmResponseSplitAry   = [[NSArray alloc] init];
        getAvgCstResProgrmResponseDataAry    = [[NSArray alloc] init];
        
        getAvgCstResProgrmResponseProgramIDAry        = [[NSMutableArray alloc] init];
        getAvgCstResProgrmResponseProgramNmaeAry  = [[NSMutableArray alloc] init];
        
        AvgCstResAry        = [[NSMutableArray alloc] init];
        ProgIdCountAry  = [[NSMutableArray alloc] init];
        
    }

    else if ([elementName isEqualToString:@"getOwnerResDetsChartResponse"])
    {
        getOwnerResDetsChartResponseStr          = [[NSString alloc] init];
        getOwnerResDetsChartResponseSplitAry   = [[NSArray alloc] init];
        getOwnerResDetsChartResponseDataAry    = [[NSArray alloc] init];
        
        getOwnerResDetsChartResponseIDAry        = [[NSMutableArray alloc] init];
        getOwnerResDetsChartResponseNameAry  = [[NSMutableArray alloc] init];
        
        
    }
    else if ([elementName isEqualToString:@"teamResForAdminResponse"])
    {
        //getOwnerResDetsChartResponseStr          = [[NSString alloc] init];
        teamNameResourceListArray   = [[NSMutableArray alloc] init];
        teamNameResourceSplitArray    = [[NSMutableArray alloc] init];
        
        teamNameForResourceArray        = [[NSMutableArray alloc] init];
        teamResourceCountArray  = [[NSMutableArray alloc] init];
        
        FilterTeamResourceArray=[[NSMutableArray alloc]init];
        FilterTeamResourceCountArray=[[NSMutableArray alloc]init];
        
        
    }
    else if ([elementName isEqualToString:@"projectsForAllResponse"])
    {
        //getOwnerResDetsChartResponseStr          = [[NSString alloc] init];
        projectsForAllProjectsArray   = [[NSMutableArray alloc] init];
        proejctsForAllListArray    = [[NSMutableArray alloc] init];
        
        proejctsForAllSplitArray        = [[NSMutableArray alloc] init];
        proejctsListForAllCountArray  = [[NSMutableArray alloc] init];
        FilterProjectsForAllArray=[[NSMutableArray alloc]init];
        FilterProjectsForAllCountArray=[[NSMutableArray alloc]init];
        filterTeamResourceArray=[[NSMutableArray alloc]init];
        
    }
    


}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    if (parser == xmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            orgResourceRepResponseStr = [orgResourceRepResponseStr stringByAppendingString:chandu];
            orgResourceRepResponseStr = [orgResourceRepResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            orgResourceRepResponseDataAry = [orgResourceRepResponseStr componentsSeparatedByString:@"*********"];
        }
    }
    
    if (parser == xmlParser2)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            [noOfProjectsDataAry addObject:string];
            
//            noOfProjectsStr = [noOfProjectsStr stringByAppendingString:chandu];
//            noOfProjectsStr = [noOfProjectsStr stringByAppendingString:string];
//            //NSLog(@"agenda details are test %@",string);
//            noOfProjectsDataAry = [noOfProjectsStr componentsSeparatedByString:@"*********"];
        }
    }

    if (parser == xmlParser3)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            avgBilRateOrgStr = [avgBilRateOrgStr stringByAppendingString:chandu];
            avgBilRateOrgStr = [avgBilRateOrgStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            avgBilRateDataAry = [avgBilRateOrgStr componentsSeparatedByString:@"*********"];
        }
    }

    if (parser == xmlParser4)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            noOfResByProgramsResponseStr = [noOfResByProgramsResponseStr stringByAppendingString:chandu];
            noOfResByProgramsResponseStr = [noOfResByProgramsResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            noOfResByProgramsResponseDataAry = [noOfResByProgramsResponseStr componentsSeparatedByString:@"*********"];
        }
    }
    
    
    if (parser == xmlParser5)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            alctedCapToProgrmResponseStr = [alctedCapToProgrmResponseStr stringByAppendingString:chandu];
            alctedCapToProgrmResponseStr = [alctedCapToProgrmResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            alctedCapToProgrmResponseDataAry = [alctedCapToProgrmResponseStr componentsSeparatedByString:@"*********"];
        }
    }

    
    if (parser == xmlParser6)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            alctedCapToProjResponseStr = [alctedCapToProjResponseStr stringByAppendingString:chandu];
            alctedCapToProjResponseStr = [alctedCapToProjResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            alctedCapToProjResponseDataAry = [alctedCapToProjResponseStr componentsSeparatedByString:@"*********"];
        }
    }
    
    if (parser == xmlParser7)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            asgnedCapToProgramResponseStr = [asgnedCapToProgramResponseStr stringByAppendingString:chandu];
            asgnedCapToProgramResponseStr = [asgnedCapToProgramResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            asgnedCapToProgramResponseDataAry = [asgnedCapToProgramResponseStr componentsSeparatedByString:@"*********"];
        }
    }

    if (parser == xmlParser8)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            asgnedCapToProjResponseStr = [asgnedCapToProjResponseStr stringByAppendingString:chandu];
            asgnedCapToProjResponseStr = [asgnedCapToProjResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            asgnedCapToProjResponseDataAry = [asgnedCapToProjResponseStr componentsSeparatedByString:@"*********"];
        }
    }

    if (parser == xmlParser9)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            getAvgCstResProgrmResponseStr = [getAvgCstResProgrmResponseStr stringByAppendingString:chandu];
            getAvgCstResProgrmResponseStr = [getAvgCstResProgrmResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            getAvgCstResProgrmResponseDataAry = [getAvgCstResProgrmResponseStr componentsSeparatedByString:@"*********"];
        }
    }
    if (parser == xmlParser10)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            getOwnerResDetsChartResponseStr = [getOwnerResDetsChartResponseStr stringByAppendingString:chandu];
            getOwnerResDetsChartResponseStr = [getOwnerResDetsChartResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            getOwnerResDetsChartResponseDataAry = [getOwnerResDetsChartResponseStr componentsSeparatedByString:@"*********"];
        }
    }
   if (parser == TeamResourcesForAdminXmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [teamNameResourceListArray addObject:string];
        }
    }
    if (parser == ProejctsForAllXmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [proejctsForAllListArray addObject:string];
        }
    }


}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"orgResourceRepResponse"])
        {
            
            for (int i=1; i<[orgResourceRepResponseDataAry count]; i++)
            {
                
                orgResourceRepResponseSplitAry = [[orgResourceRepResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
               // NSLog(@"split  is %@",orgResourceRepResponseSplitAry);
                
                for (int j=1; j<[orgResourceRepResponseSplitAry count]; j++)
                {
                    orgNameStr = [[orgResourceRepResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"orgName==" withString:@""];
                    
                    noOfResStr = [[orgResourceRepResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"noOfRes==" withString:@""];
                    
                }
                
                
                [orgNameAry addObject:orgNameStr];
                [noOfResAry addObject:noOfResStr];
                
                

            }
            //NSLog(@"split  is %@ %@ %@ %@ %@",reqTypeArray,contactAry,criticialityAry,activityAry,systemAry);
            _values = noOfResAry;
            _values1 = orgNameAry;
            
            NSLog(@"  is %@ %@",orgNameAry,noOfResAry);
            [self loadGraph];
            
            
        }
        
    }
    //
    
    if (parser == xmlParser2)
    {
        
        if ([elementName isEqualToString:@"noOfProjsByResReprtResponse"])
        {
            
            for (int i=1; i<[noOfProjectsDataAry count]; i++)
            {
                [noOfProjectsSplitAry removeObject:@""];

                noOfProjectsSplitAry = [[noOfProjectsDataAry objectAtIndex:i]componentsSeparatedByString:@"###"];
               // [noOfProjectsSplitAry objectAtIndex:i]componentsSeparatedByString:@"&#xE1;s"
                
                 //NSLog(@"split  is %@",noOfProjectsSplitAry);
                
                for (int j=1; j<[noOfProjectsSplitAry count];j++)
                {
                    resrc_NameStr = [[noOfProjectsSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"Resrc_Name==" withString:@""];
                    
                    noOfPrjctsStr = [[noOfProjectsSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"noOfPrjcts==" withString:@""];
                    
                   
                    [resrc_NameAry addObject:resrc_NameStr];
                    [noOfPrjctsAry addObject:noOfPrjctsStr];
                    //[resrc_NameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                    //[noOfPrjctsStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                }
                
                
               
                
                
                
            }
            //NSLog(@"split  is %@ %@ %@ %@ %@",reqTypeArray,contactAry,criticialityAry,activityAry,systemAry);
            _values = noOfPrjctsAry;
            _values1 = resrc_NameAry;
            
            NSLog(@"  is %@ %@",resrc_NameAry,noOfPrjctsAry);
            [self loadGraph];
            
            
        }
        
    }
    
    if (parser == xmlParser3)
    {
        
        if ([elementName isEqualToString:@"avgBilngRateByOrgResponse"])
        {
            
            for (int i=1; i<[avgBilRateDataAry count]; i++)
            {
                
                avgBilRateSplitAry = [[avgBilRateDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",avgBilRateSplitAry);
                
                for (int j=1; j<[avgBilRateSplitAry count]; j++)
                {
                    avgBillRateStr = [[avgBilRateSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"avgBillRate==" withString:@""];
                    
                    avgBillRateOrgNameStr = [[avgBilRateSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"orgName==" withString:@""];
                    
                }
                
                
                [avgBillRateAry addObject:avgBillRateStr];
                [avgBillRateOrgNameAry addObject:avgBillRateOrgNameStr];
                
                
                
            }
            _values = avgBillRateAry;
            _values1 = avgBillRateOrgNameAry;
            
            NSLog(@"  is %@ %@",avgBillRateAry,avgBillRateOrgNameAry);
            [self loadGraph];
            
            
        }
        
    }

    if (parser == xmlParser4)
    {
        
        if ([elementName isEqualToString:@"noOfResByProgramsResponse"])
        {
            
            for (int i=1; i<[noOfResByProgramsResponseDataAry count]; i++)
            {
                
                noOfResByProgramsResponseSplitAry = [[noOfResByProgramsResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",avgBilRateSplitAry);
                
                for (int j=1; j<[noOfResByProgramsResponseSplitAry count]; j++)
                {
                    noOfResByPrgmByOrgNameStr = [[noOfResByProgramsResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@""];
                    
                    noOfResByProgramIDStr = [[noOfResByProgramsResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"noOfRes==" withString:@""];
                    
                }
                
                
                [noOfResByPrgmByOrgNameAry addObject:noOfResByPrgmByOrgNameStr];
                [noOfResByProgramIDAry addObject:noOfResByProgramIDStr];
                
                
                
            }
            _values = noOfResByProgramIDAry;
            _values1 = noOfResByPrgmByOrgNameAry;
            
            NSLog(@"  is %@ %@",noOfResByPrgmByOrgNameAry,noOfResByProgramIDAry);
            [self loadGraph];
            
            
        }
        
    }

    
    if (parser == xmlParser5)
    {
        
        if ([elementName isEqualToString:@"alctedCapToProgrmResponse"])
        {
            
            for (int i=1; i<[alctedCapToProgrmResponseDataAry count]; i++)
            {
                
                alctedCapToProgrmResponseSplitAry = [[alctedCapToProgrmResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",avgBilRateSplitAry);
                
                for (int j=1; j<[alctedCapToProgrmResponseSplitAry count]; j++)
                {
                    allocatedCapacitySumStr = [[alctedCapToProgrmResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"AllocatedCapacitySum==" withString:@""];
                    
                    allocatedCapacityProgramNameStr = [[alctedCapToProgrmResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@""];
                    
                }
                [allocatedCapacitySumAry addObject:allocatedCapacitySumStr];
                [allocatedCapacityProgramNameAry addObject:allocatedCapacityProgramNameStr];
                
                
                
            }
            _values = allocatedCapacitySumAry;
            _values1 = allocatedCapacityProgramNameAry;
            
            NSLog(@"  is %@ %@",allocatedCapacitySumAry,allocatedCapacityProgramNameAry);
            [self loadGraph];
            
            
        }
        
    }
    
    if (parser == xmlParser6)
    {
        
        if ([elementName isEqualToString:@"alctedCapToProjResponse"])
        {
            
            for (int i=1; i<[alctedCapToProjResponseDataAry count]; i++)
            {
                
                alctedCapToProjResponseSplitAry = [[alctedCapToProjResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",alctedCapToProjResponseSplitAry);
                
                for (int j=1; j<[alctedCapToProjResponseSplitAry count]; j++)
                {
                    allocatedCapacityProjSumStr = [[alctedCapToProjResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"AllocatedCapacitySum==" withString:@""];
                    
                    allocatedCapacityProjProgramNameStr = [[alctedCapToProjResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ProjectName==" withString:@""];
                    
                   
                }
                [allocatedCapacityProjSumAry addObject:allocatedCapacityProjSumStr];
                [allocatedCapacityProjProgramNameAry addObject:allocatedCapacityProjProgramNameStr];
                
                
                
            }
            _values = allocatedCapacityProjSumAry;
            _values1 = allocatedCapacityProjProgramNameAry;
            
            NSLog(@"  is %@ %@",allocatedCapacityProjSumAry,allocatedCapacityProjProgramNameAry);
            [self loadGraph];
            
            
        }
        
    }

    if (parser == xmlParser7)
    {
        
        if ([elementName isEqualToString:@"asgnedCapToProgramResponse"])
        {
            
            for (int i=1; i<[asgnedCapToProgramResponseDataAry count]; i++)
            {
                
                asgnedCapToProgramResponseSplitAry = [[asgnedCapToProgramResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",alctedCapToProjResponseSplitAry);
                
                for (int j=1; j<[asgnedCapToProgramResponseSplitAry count]; j++)
                {
                    AssaignedCapacitySumStr = [[asgnedCapToProgramResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"AssaignedCapacitySum==" withString:@""];
                    
                    assignedCapacityProjectNmaeStr = [[asgnedCapToProgramResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@""];
                    
                    
                }
                [AssaignedCapacitySumAry addObject:AssaignedCapacitySumStr];
                [assignedCapacityProjectNmaeAry addObject:assignedCapacityProjectNmaeStr];
                
                
                
            }
            _values = AssaignedCapacitySumAry;
            _values1 = assignedCapacityProjectNmaeAry;
            
            NSLog(@"  is %@ %@",AssaignedCapacitySumAry,assignedCapacityProjectNmaeAry);
            [self loadGraph];
            
            
        }
        
    }

    if (parser == xmlParser8)
    {
        
        if ([elementName isEqualToString:@"asgnedCapToProjResponse"])
        {
            
            for (int i=1; i<[asgnedCapToProjResponseDataAry count]; i++)
            {
                
                asgnedCapToProjResponseSplitAry = [[asgnedCapToProjResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",asgnedCapToProjResponseSplitAry);
                
                for (int j=1; j<[asgnedCapToProjResponseSplitAry count]; j++)
                {
                    asgnedCapToProjResponseSumStr = [[asgnedCapToProjResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"AllocatedCapacitySum==" withString:@""];
                    
                    asgnedCapToProjResponseProjectNmaeStr = [[asgnedCapToProjResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ProjectName==" withString:@""];
                    
                    
                }
                [asgnedCapToProjResponseSumAry addObject:asgnedCapToProjResponseSumStr];
                [asgnedCapToProjResponseProjectNmaeAry addObject:asgnedCapToProjResponseProjectNmaeStr];
                
                
            }
            _values = asgnedCapToProjResponseSumAry;
            _values1 = asgnedCapToProjResponseProjectNmaeAry;
            
            NSLog(@"  is %@ %@",asgnedCapToProjResponseSumAry,asgnedCapToProjResponseProjectNmaeAry);
            [self loadGraph];
            
            
        }
        
    }

    if (parser == xmlParser9)
    {
        
        if ([elementName isEqualToString:@"getAvgCstResProgrmResponse"])
        {
            
            for (int i=1; i<[getAvgCstResProgrmResponseDataAry count]; i++)
            {
                
                getAvgCstResProgrmResponseSplitAry = [[getAvgCstResProgrmResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",asgnedCapToProjResponseSplitAry);
                
                for (int j=1; j<[getAvgCstResProgrmResponseSplitAry count]; j++)
                {
                    getAvgCstResProgrmResponseProgramIDStr = [[getAvgCstResProgrmResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ProgramId==" withString:@""];
                    
                    getAvgCstResProgrmResponseProgramNmaeStr = [[getAvgCstResProgrmResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@""];
                    
                    AvgCstResStr = [[getAvgCstResProgrmResponseSplitAry objectAtIndex:3] stringByReplacingOccurrencesOfString:@"AvgCstRes==" withString:@""];
                    
                    ProgIdCountStr = [[getAvgCstResProgrmResponseSplitAry objectAtIndex:4] stringByReplacingOccurrencesOfString:@"ProgIdCount==" withString:@""];



                }
                [getAvgCstResProgrmResponseProgramIDAry addObject:getAvgCstResProgrmResponseProgramIDStr];
                [getAvgCstResProgrmResponseProgramNmaeAry addObject:getAvgCstResProgrmResponseProgramNmaeStr];
                
                [AvgCstResAry addObject:AvgCstResStr];
                [ProgIdCountAry addObject:ProgIdCountStr];

            }
            _values = AvgCstResAry;
            _values1 = getAvgCstResProgrmResponseProgramNmaeAry;
            
            NSLog(@"  is %@ %@ %@ %@",getAvgCstResProgrmResponseProgramIDAry,getAvgCstResProgrmResponseProgramNmaeAry,AvgCstResAry,ProgIdCountAry);
            [self loadGraph];
            
            
        }
        
    }

    if (parser == xmlParser10)
    {
        
        if ([elementName isEqualToString:@"getOwnerResDetsChartResponse"])
        {
            
            for (int i=1; i<[getOwnerResDetsChartResponseDataAry count]; i++)
            {
                
                getOwnerResDetsChartResponseSplitAry = [[getOwnerResDetsChartResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",asgnedCapToProjResponseSplitAry);
                
                for (int j=1; j<[getOwnerResDetsChartResponseSplitAry count]; j++)
                {
                    getOwnerResDetsChartResponseIDStr = [[getOwnerResDetsChartResponseSplitAry objectAtIndex:3] stringByReplacingOccurrencesOfString:@"No.OfResources==" withString:@""];
                    
                    getOwnerResDetsChartResponseNameStr = [[getOwnerResDetsChartResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Program_Name==" withString:@""];
                    
                    
                    
                    
                    
                }
                [getOwnerResDetsChartResponseIDAry addObject:getOwnerResDetsChartResponseIDStr];
                [getOwnerResDetsChartResponseNameAry addObject:getOwnerResDetsChartResponseNameStr];
                
                
                
            }
            _values = getOwnerResDetsChartResponseIDAry;
            _values1 = getOwnerResDetsChartResponseNameAry;
            
            NSLog(@"  is %@ %@ ",getOwnerResDetsChartResponseIDAry,getOwnerResDetsChartResponseNameAry);
            [self loadGraph];
            
            
        }
        
    }
    if (parser == TeamResourcesForAdminXmlParser)
    {
        
        if ([elementName isEqualToString:@"teamResForAdminResponse"])
        {
            
            for (int i=0; i<[teamNameResourceListArray count]; i++)
            {
                
                teamNameResourceSplitArray = [[teamNameResourceListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",asgnedCapToProjResponseSplitAry);
                
                for (int j=0; j<[teamNameResourceSplitArray count]; j++)
                {
                    resourceNameStr= [[teamNameResourceSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"teamName==" withString:@""];
                    
                    resourcecountStr=[[teamNameResourceSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"teamResCount==" withString:@""];
                
                    
                    
                }
                
                [teamNameForResourceArray addObject:resourceNameStr];
                [teamResourceCountArray addObject:resourcecountStr];
                
                FilterTeamResourceArray = [[NSSet setWithArray:teamNameForResourceArray] allObjects];
                
//                for (int i=0; i<[FilterTeamResourceArray count]; i++)
//                {
//                    if ([resourceNameStr isEqualToString:[teamNameForResourceArray objectAtIndex:i]])
//                    {
//                        [FilterTeamResourceCountArray addObject:[teamResourceCountArray objectAtIndex:i]];
//                    }
//                }
//                NSLog(@"filter team resource count array is %@ %@",FilterTeamResourceArray,FilterTeamResourceCountArray);
                
            }
            
            _values =teamResourceCountArray ;
            _values1 =FilterTeamResourceArray;
 ;
            
            NSLog(@"  is %@ %@ ",FilterTeamResourceArray,teamResourceCountArray);
            [self loadGraph];
            
            
        }
        
    }
    if (parser == ProejctsForAllXmlParser)
    {
        
        if ([elementName isEqualToString:@"projectsForAllResponse"])
        {
            
            for (int i=0; i<[proejctsForAllListArray count]; i++)
            {
                
                proejctsForAllSplitArray = [[proejctsForAllListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",asgnedCapToProjResponseSplitAry);
                
                for (int j=0; j<[proejctsForAllSplitArray count]; j++)
                {
                    projectsForAllStr=[[proejctsForAllSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"projectName==" withString:@""];
                    
                    proejctsForaAllCountStr=[[proejctsForAllSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"projResCount==" withString:@""];
                    
                    
                    
                    
                    
                }
                [projectsForAllProjectsArray addObject:projectsForAllStr];
                [proejctsListForAllCountArray addObject:proejctsForaAllCountStr];
                
                
                FilterProjectsForAllArray = [[NSSet setWithArray:projectsForAllProjectsArray] allObjects];
                filterTeamResourceArray=[FilterProjectsForAllArray mutableCopy];
            }
            
            //FilterProjectsForAllCountArray=[[NSSet setWithArray:proejctsListForAllCountArray]allObjects];
           
            NSLog(@"filter array is %@",projectsForAllProjectsArray);
            _values = proejctsListForAllCountArray;
            _values1 = projectsForAllProjectsArray;
            
            //NSLog(@"  is %@ %@ ",getOwnerResDetsChartResponseIDAry,getOwnerResDetsChartResponseNameAry);
            [self loadGraph];
            
            
        }
        
    }


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
