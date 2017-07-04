//
//  LineChartViewController.m
//  EISIOSApp
//
//  Created by vm mac on 13/06/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//

#import "LineChartViewController.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"
#import "TWRChart.h"


@interface LineChartViewController ()
{
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    
    NSString *programIdstr,*programNamestr,*programNameIdstr,*projectIdstr,*projectNamestr,*budgetCoststr;
    
    NSMutableArray *programArray,*programSplitArray,*programIdArray,*programNameArray,*programNmaeIdArray,*projectArray,*projectSplitArray,*projectIdArray,*projectNameArray,*budgetCostArray;
    
    
    
}
@property(strong, nonatomic) TWRChartView *chartView;

@end

@implementation LineChartViewController
@synthesize ChartView;
int i=1;

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
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    
    
    
    
    homeBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClicked)];
    
    logoutBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logoutBtnClicked)];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:homeBtn,logoutBtn,nil];
    
    
    
    

    
    [self projectList];
    
    ChartView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-10, 400)];
    //ChartView1.backgroundColor=[UIColor blueColor];
    _chartView = [[TWRChartView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 400)];
    _chartView.backgroundColor = [UIColor clearColor];
    jsFilePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"js"];
    [_chartView setChartJsFilePath:jsFilePath];
    [ChartView addSubview:_chartView];
    [lineChartView addSubview:ChartView];

    
    
    [super viewDidLoad];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didFinishService:(id)Userlogindetails
{
    ProgramDetailsXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    ProgramDetailsXmlParser.delegate=self;
    [ProgramDetailsXmlParser parse];
    
    
    ProjectCostXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    ProjectCostXmlParser.delegate=self;
    [ProjectCostXmlParser parse];
}

-(void)homeBtnClicked
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)logoutBtnClicked
{
    
    logoutAlertView =[[UIAlertView alloc]initWithTitle:nil message:@"Do You Want Exit ?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
    [logoutAlertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==logoutAlertView)
    {
        
        if (buttonIndex==0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else
        {
            
        }
    }
}
-(void)projectList
{
    serviceCall =[[Webservices alloc]init];
    
    NSString * ProgramClass=@"ExecuteDashBoard";
    
    NSDictionary * ProgramDetailsDictionary=@{@"orgId":orgIdstr};
    
    [serviceCall ProjectCostDetails:ProgramClass ProjectCostParameters:ProgramDetailsDictionary];
    [serviceCall setDelegate:self];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==ProgramDetailsXmlParser)
    {
        if ([elementName isEqualToString:@"getEachProgramBudgsResponse"])
        {
            programIdstr=[NSString new];
            programNamestr=[NSString new];
            programNameIdstr=[NSString new];
            
            programArray=[NSMutableArray new];
            programNameArray=[NSMutableArray new];
            programSplitArray=[NSMutableArray new];
            programNmaeIdArray=[NSMutableArray new];
            programIdArray=[NSMutableArray new];
        }
    }
    
    if (parser==ProjectCostXmlParser)
    {
        if ([elementName isEqualToString:@"getPrjBudCstLstResponse"])
        {
            projectIdstr=[NSString new];
            projectNamestr=[NSString new];
            budgetCoststr=[NSString new];
            
            projectArray=[NSMutableArray new];
            projectSplitArray=[NSMutableArray new];
            projectIdArray=[NSMutableArray new];
            projectNameArray=[NSMutableArray new];
            budgetCostArray=[NSMutableArray new];
            
        }
        
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (parser==ProgramDetailsXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Error May Occured" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
            [programArray addObject:string];
        }
    }
    
    if (parser==ProjectCostXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Error Occured" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [projectArray addObject:string];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if (parser==ProgramDetailsXmlParser)
    {
        if ([elementName isEqualToString:@"getPrjBudCstLstResponse"])
        {
            for (int i=0; i<[programArray count]; i++)
            {
                programSplitArray=[[programArray objectAtIndex:i]componentsSeparatedByString:@"###"];
                
                programIdstr=[[programSplitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"ProgramId==" withString:@" "];
                
                programNamestr=[[programSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@" "];
                
                programNameIdstr=[[programSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"ProgramName==" withString:@" "];
                
                [programIdArray addObject:programIdstr];
                [programNameArray addObject:programNamestr];
                [programNmaeIdArray addObject:programNameIdstr];
            }
            
            
            
            NSLog(@"the array values are %@ %@ %@",programIdArray,programNameArray,programNmaeIdArray);
            
            [self ProgramList];
        }
    }
    if (parser==ProjectCostXmlParser)
    {
        if ([elementName isEqualToString:@"getPrjBudCstLstResponse"])
        {
            for (int i=0; i<[projectArray count]; i++)
            {
                projectSplitArray=[[projectArray objectAtIndex:i]componentsSeparatedByString:@"###"];
                
                projectIdstr=[[projectSplitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"ProjectId==" withString:@" "];
                
                projectNamestr=[[projectSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"ProjectName==" withString:@" "];
                
                budgetCoststr=[[projectSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"BudgetCost==" withString:@""];
                
                
                [projectIdArray addObject:projectIdstr];
                [projectNameArray addObject:projectNamestr];
                [budgetCostArray addObject:budgetCoststr];
            }
            NSLog(@"the array values are %@ %@ %@",projectIdArray,projectNameArray,budgetCostArray);
            
           // [self createLineChart];
        }
        
    }
    
}

-(void)ProgramList
{
    serviceCall=[[Webservices alloc]init];
    
    NSString *ProgramClass=@"ExecuteDashBoard";
    
    NSDictionary *ProgramDictionary =@{@"programId":programIdstr};
    
    [serviceCall ProgramList:ProgramClass ProgramListParameters:ProgramDictionary];
    
    [serviceCall setDelegate:self];
    //[self drawStockChart];
    

}

@end
