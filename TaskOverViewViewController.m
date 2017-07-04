//
//  TaskOverViewViewController.m
//  EISIOSApp
//
//  Created by vm mac on 13/06/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//

#import "TaskOverViewViewController.h"

@interface TaskOverViewViewController ()
{
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    
    NSString *taskNameStr,*resNameStr,*startDateStr,*endDateStr,*assignedHours,*needToSpend,*hoursSpent;
    
    NSMutableArray *taskOVerViewArray,*taskOverViewSplitArray,*taskOVerViewSplitDisplayArray,*taskOverViewResNameArray,*taskOverViewStartDateArray,*taskOVerViewEndDateArray,*taskOverViewAssignedHoursArray,*taskOverViewNeedToHoursArray,*taskOVerViewHoursSpentArray,*taskOverViewTaskNameArray;
}

@end

@implementation TaskOverViewViewController
//@synthesize navigationTitlestr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    //    [self.view addGestureRecognizer:tapGesture];
    
    
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
    
    
    
    
    
    
    //[self DatafromDB];
    //self.navigationItem.title = navigationTitlestr;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    
    [self taskList];
    
    
    
    
    
    
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,nil];
    
    [super viewDidLoad];
    
    
    
    
    //    UIColor *colour = [[UIColor alloc]initWithRed:57.0/255.0 green:156.0/255.0 blue:52.0/255.0 alpha:1.0];
    //    self.view.backgroundColor = colour;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
        else {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}
-(void)taskList
{
    serviceCall =[[Webservices alloc]init];
    
    NSString *TaskOverViewClass=@"TaskOverview";
    
    NSDictionary *TaskOverViewDictionary=@{@"userType":Usertypestr,@"userId":Useridstr,@"orgId":orgIdstr};
    
    [serviceCall TaskOVerView:TaskOverViewClass TaskOVerViewListParameters:TaskOverViewDictionary];
    [serviceCall setDelegate:self];
}

-(void)didFinishService:(id)Userlogindetails
{
    taskOVerViewXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    taskOVerViewXmlParser.delegate=self;
    [taskOVerViewXmlParser parse];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==taskOVerViewXmlParser)
    {
        if([elementName isEqualToString:@"getTaskOverviewListResponse"])
        {
            taskOVerViewArray       =[NSMutableArray new];
            taskOverViewSplitArray      =[NSMutableArray new];
            taskOVerViewEndDateArray        =[NSMutableArray new];
            taskOverViewStartDateArray  =[NSMutableArray new];
            taskOverViewResNameArray  =[NSMutableArray new];
            taskOVerViewHoursSpentArray  =[NSMutableArray new];
            taskOverViewNeedToHoursArray  =[NSMutableArray new];
            taskOverViewAssignedHoursArray  =[NSMutableArray new];
            taskOverViewTaskNameArray=[NSMutableArray new];
            taskNameStr=[NSString new];
            resNameStr=[NSString new];
            startDateStr=[NSString new];
            endDateStr=[NSString new];
            assignedHours=[NSString new];
            hoursSpent=[NSString new];
            needToSpend=[NSString new];
            
            
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    
    
    if (parser == taskOVerViewXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Task" message:@"Task Overview List Not Displayed" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [taskOVerViewArray addObject:string];
        }
        
        
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == taskOVerViewXmlParser)
    {
        if([elementName isEqualToString:@"getTaskOverviewListResponse"])
        {
            for (int i = 0; i<[taskOVerViewArray count]; i++)
            {
                taskOverViewSplitArray=[[taskOVerViewArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [taskOVerViewSplitDisplayArray addObject:[[taskOverViewSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"taskId==" withString:@""]];
                [taskOverViewResNameArray addObject:[[taskOverViewSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"resName==" withString:@""]];
                [taskOverViewStartDateArray addObject:[[taskOverViewSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"plannedStartDate==" withString:@""]];
                [taskOVerViewEndDateArray addObject:[[taskOverViewSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"plannedEndDate==" withString:@""]];
                [taskOverViewAssignedHoursArray addObject:[[taskOverViewSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString:@"assignedHours==" withString:@""]];
                [taskOverViewTaskNameArray addObject:[[taskOverViewSplitArray objectAtIndex:10]stringByReplacingOccurrencesOfString:@"taskName==" withString:@""]];
                [taskOVerViewHoursSpentArray addObject:[[taskOverViewSplitArray objectAtIndex:7]stringByReplacingOccurrencesOfString:@"hourSpent==" withString:@""]];
                [taskOverViewNeedToHoursArray addObject:[[taskOverViewSplitArray objectAtIndex:8]stringByReplacingOccurrencesOfString:@"needTospend==" withString:@""]];
                
                
            }
            NSLog(@"the array values are %@ %@ %@ %@ %@ %@ %@",taskOverViewResNameArray,taskOverViewStartDateArray,taskOVerViewEndDateArray,taskOverViewAssignedHoursArray,taskOverViewTaskNameArray,taskOVerViewHoursSpentArray,taskOverViewNeedToHoursArray);
            
           
            int count=[taskOverViewTaskNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",count];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 500)]
                           title:@"Total Tasks"];
             [taskOverViewTableView reloadData];

        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskOverViewResNameArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EIS11";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    [cell.contentView.layer setBorderColor:[UIColor purpleColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    
    
    //cell.textLabel.text = [dashBoardListAry objectAtIndex:indexPath.row];
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:100];
    nameLbl.font=[UIFont systemFontOfSize:25];
    nameLbl.text =@"Resource Name :";
    //[cell.contentView addSubview:nameLbl];
    //cell.textLabel.text = @"WELCOME";
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:200];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    nameLbl2.text= @"Task Name :";
    
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:300];
    nameLbl3.font=[UIFont systemFontOfSize:25];
    nameLbl3.text= @"Start Date :";
    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:400];
    nameLbl4.font=[UIFont systemFontOfSize:25];
    nameLbl4.text= @"End Date :";
    
    UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:500];
    nameLbl5.font=[UIFont systemFontOfSize:25];
    nameLbl5.text= @"Assigned Hours :";
    
    UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:600];
    nameLbl6.font=[UIFont systemFontOfSize:25];
    nameLbl6.text= @"Hours Spent :";
    
    UILabel *nameLbl7 = (UILabel*)[cell viewWithTag:700];
    nameLbl7.font=[UIFont systemFontOfSize:25];
    nameLbl7.text= @"Need To Spent :";
    
    UILabel *nameLbl8 = (UILabel*)[cell viewWithTag:800];
    nameLbl8.font=[UIFont systemFontOfSize:25];
    nameLbl8.text= [taskOverViewResNameArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl9 = (UILabel*)[cell viewWithTag:900];
    nameLbl9.font=[UIFont systemFontOfSize:25];
    nameLbl9.text= [taskOverViewTaskNameArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl10 = (UILabel*)[cell viewWithTag:1000];
    nameLbl10.font=[UIFont systemFontOfSize:25];
    nameLbl10.text= [taskOverViewStartDateArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl11 = (UILabel*)[cell viewWithTag:1100];
    nameLbl11.font=[UIFont systemFontOfSize:25];
    nameLbl11.text= [taskOVerViewEndDateArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl12 = (UILabel*)[cell viewWithTag:1200];
    nameLbl12.font=[UIFont systemFontOfSize:25];
    nameLbl12.text= [taskOverViewAssignedHoursArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl13 = (UILabel*)[cell viewWithTag:1300];
    nameLbl13.font=[UIFont systemFontOfSize:25];
    nameLbl13.text= [taskOVerViewHoursSpentArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl14 = (UILabel*)[cell viewWithTag:1400];
    nameLbl14.font=[UIFont systemFontOfSize:25];
    nameLbl14.text= [taskOverViewNeedToHoursArray objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
    
}
@end
