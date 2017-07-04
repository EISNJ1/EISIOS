//
//  issueViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 18/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "issueViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Toast+UIView.h"

@interface issueViewController ()

@end

@implementation issueViewController

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
    [statusSearch setDelegate:self];
    [statusSearch setUserInteractionEnabled:NO];

    
    //-------------------Right side pop Buttons---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createIssueBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,createTimeSheetActionBarBtn,nil];
    
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    //[self DatafromDB];
    NSLog(@"%@",Useridstr);
    NSLog(@"%@",UserTypestr);
    NSLog(@"%@",OrgIdStr);

    [imageView setHidden:YES];
    
    UIButton *Eisbutton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [Eisbutton setImage:[UIImage imageNamed:@"homeicon.png"] forState:UIControlStateNormal];
    
    [Eisbutton setFrame:CGRectMake(0, 0, 53, 101)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 250, 80)];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    NSMutableString *UserName  = [[NSMutableString alloc]initWithString:@"WelCome Mr/Ms "];
    [UserName appendString:Usernamestr];
    [label setText:UserName];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [Eisbutton addSubview:label];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:Eisbutton];
    self.navigationItem.leftBarButtonItem = barButton;
    
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView=NO;
    
    [self.view addGestureRecognizer:tap];
    
    
    //------------Project Spinner  Calling-------------//
    
    
    //search arrays initialization
    
    searchdescriptionArray=[[NSMutableArray alloc]init];
    searchbusinessPriorityArray=[[NSMutableArray alloc]init];
    searcAssignToArray=[[NSMutableArray alloc]init];
    searcescalatedArray=[[NSMutableArray alloc]init];
    searchissueTypeAray=[[NSMutableArray alloc]init];
    searcAssignByArray=[[NSMutableArray alloc]init];
    searchissueStatusArray=[[NSMutableArray alloc]init];
    searchIssueIdArray=[[NSMutableArray alloc]init];
    searchIssuenoArray=[[NSMutableArray alloc]init];
    searchIssueHistoryArray=[[NSMutableArray alloc]init];
    searchProjectidArray=[[NSMutableArray alloc]init];
    searchProjectNameArray=[[NSMutableArray alloc]init];
    searchReleaseImpactArray=[[NSMutableArray alloc]init];
    searchDateResolutionNeedArray=[[NSMutableArray alloc]init];
    searchDateResolveAry=[[NSMutableArray alloc]init];
    searchCloseDateArray=[[NSMutableArray alloc]init];
    searchResolutionDetailsArray=[[NSMutableArray alloc]init];
    searchResolutionNameTypeArray=[[NSMutableArray alloc]init];
    searchRejectReasonArry=[[NSMutableArray alloc]init];
    searchIssueNoArray=[[NSMutableArray alloc]init];
    searchIsFileAttatchedArray=[[NSMutableArray alloc]init];

    
    
    [self tableService];
    
    [super viewDidLoad];
    // Do any additional setup after loading the vie.
}
-(void)viewWillAppear:(BOOL)animated
{
    statusSearch.text=@"";
    
    [self viewDidLoad];
    [issueDetailsTbl reloadData];

}
-(void)tableService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    //NSDictionary *credentials = @{ @"usertype":@"A",@"userID": @"1"  ,@"orgId":@"1"};
    
    NSDictionary *credentials2 = @{@"usertype":UserTypestr,@"userID":Useridstr,@"orgId":OrgIdStr};
    //NSDictionary *credentials2 = @{@"usertype":@"Y",@"userID":@"127",@"orgId":OrgIdStr};
    
    [Servicecall issueList:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
    
}
//-(void)DatafromDB
//{
//    appDel = [[UIApplication sharedApplication] delegate];
//    objectContext = appDel.managedObjectContext;
//    
//    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:objectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    [fetchRequest setEntity:entityDesc];
//    
//    NSError *error = nil;
//    NSArray *picArray = [objectContext executeFetchRequest:fetchRequest error:&error];
//    for(NSManagedObject *managedObject in picArray)
//    {
//        
//        Usernamestr  = [managedObject valueForKey:@"username"];
//        Useridstr  = [managedObject valueForKey:@"userid"];
//        UserTypestr = [managedObject valueForKey:@"userType"];
//        OrgIdStr = [managedObject valueForKey:@"orgId"];
//    }
//}

-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    
       //NSLog(@"the project spinner data is %@",Userlogindetails);
}


-(void)createIssueBtnClk
{
    createIssueViewController *createIssueView = [[createIssueViewController alloc]init];
    createIssueView = [self.storyboard instantiateViewControllerWithIdentifier:@"createIssue"];
    [self.navigationController pushViewController:createIssueView animated:YES];
}
-(void)homeBtnClk
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)logOutBtnClk
{
    logOutAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [logOutAlertView show];

    
}

//parsing Deligate methods

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"issuesListResponse"])
    {
        TaskDetailsstr1    = [[NSString alloc] init];
        Taskdataarray1     = [[NSArray alloc]init];
        TasksplitArray1     = [[NSArray alloc]init];

        
        IssueIdArray       = [[NSMutableArray alloc]init];
        issuenoaArray      = [[NSMutableArray alloc]init];
        projectidArray     = [[NSMutableArray alloc]init];
        projectNameArray = [[NSMutableArray alloc]init];
        issuestatusArray   = [[NSMutableArray alloc]init];
        issuetypeArray     = [[NSMutableArray alloc]init];
        buspriorityArray   = [[NSMutableArray alloc]init];
        TeamNameArray      = [[NSMutableArray alloc]init];
        assignedtoArray    = [[NSMutableArray alloc]init];
        assignedbyArray    = [[NSMutableArray alloc]init];
        descriptionArray   = [[NSMutableArray alloc]init];
        longDesArray = [[NSMutableArray alloc]init];
        
        
        escalatedRescrcAry = [[NSMutableArray alloc]init];
        releaseImpactAry = [[NSMutableArray alloc]init];
        dateResolutionNeedByAry = [[NSMutableArray alloc]init];
        rejectReasonAry = [[NSMutableArray alloc]init];
        resolutionTypeAry = [[NSMutableArray alloc]init];
        dateResolvedAry = [[NSMutableArray alloc]init];
        dateClosedAry = [[NSMutableArray alloc]init];
        resolutionDtlsAry = [[NSMutableArray alloc]init];
        issueTypeNameArray=[[NSMutableArray alloc]init];

        isFileAttatchedArray=[[NSMutableArray alloc]init];
        
        //watse  splitting
        soapResults = [[NSMutableString alloc] init];
        songDict = [[NSMutableDictionary alloc] init];
        songsArray = [[NSMutableArray alloc] init];
        noAry = [[NSMutableArray alloc] init];
        
        
        pickerAry = [[NSMutableArray alloc] init];
        pickerAry1 = [[NSMutableArray alloc] init];
        newpickerAry = [[NSMutableArray alloc] init];
        newpickerAry1 = [[NSMutableArray alloc] init];

    }
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([string isEqualToString:@"Flase"])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else{
        

        
       
            NSString *chandu = @"*********";
            TaskDetailsstr1 = [TaskDetailsstr1 stringByAppendingString:chandu];
            TaskDetailsstr1 = [TaskDetailsstr1 stringByAppendingString:string];
            NSLog(@"agenda details are test %@",TaskDetailsstr1);
            Taskdataarray1 =[TaskDetailsstr1 componentsSeparatedByString:@"*********"];
        
        [soapResults appendString:string];
        
        

    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

    
  
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"issuesListResponse"])
        {
            
            
            if(soapResults)
                [songDict setObject:soapResults forKey:elementName];
            soapResults = nil;
            if(songDict)
                [songsArray addObject:songDict];
            NSLog(@"Final Songs Array is %@",songsArray);
            
            NSString *str1 = [songDict objectForKey:@"issuesListResponse"];
            //NSLog(@"Final Songs Array is %@",str1);
            
            NSArray *aArray = [str1 componentsSeparatedByString:@".;"];
            //NSLog(@"The Split array is %@",aArray);
            
            
            for (int i=1; i<[aArray count]; i++)
            {
                
                TasksplitArray1 =[[aArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray1 count]; j++)
                {
                    
                    IssueIdStr = [[TasksplitArray1 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"IssueId==" withString:@""];
                    
                    issueno  = [[TasksplitArray1 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"IssueNumber==" withString:@""];
                    
                    
                    projectid = [[TasksplitArray1 objectAtIndex:3] stringByReplacingOccurrencesOfString:@"PojectId==" withString:@""];
                    
                    
                    
                    
                    projectName = [[TasksplitArray1 objectAtIndex:4] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                    
                    issuestatus = [[TasksplitArray1 objectAtIndex:5] stringByReplacingOccurrencesOfString:@"IssueStatus==" withString:@""];
                    
                    issuetype = [[TasksplitArray1 objectAtIndex:6] stringByReplacingOccurrencesOfString:@"IssueType==" withString:@""];
                    
                    buspriority = [[TasksplitArray1 objectAtIndex:7] stringByReplacingOccurrencesOfString:@"BussPriority==" withString:@""];
                    
                    
                    TeamName = [[TasksplitArray1 objectAtIndex:8] stringByReplacingOccurrencesOfString:@"TeamName==" withString:@""];
                    
                    
                    assignedto = [[TasksplitArray1 objectAtIndex:9] stringByReplacingOccurrencesOfString:@"AssignedTo==" withString:@""];
                    
                    
                    assignedby = [[TasksplitArray1 objectAtIndex:10] stringByReplacingOccurrencesOfString:@"AssignedBy==" withString:@""];
                    
                    description = [[TasksplitArray1 objectAtIndex:11] stringByReplacingOccurrencesOfString:@"Description==" withString:@""];
                    
                    
                    longDes = [[TasksplitArray1 objectAtIndex:12] stringByReplacingOccurrencesOfString:@"LongDescription==" withString:@""];
                    
                    
                    escalatedRescrcStr = [[TasksplitArray1 objectAtIndex:13 ] stringByReplacingOccurrencesOfString:@"EscalatdToResrc==" withString:@""];
                    
                    releaseImpactStr = [[TasksplitArray1 objectAtIndex:14] stringByReplacingOccurrencesOfString:@"ReleasImpact==" withString:@""];
                    
                    dateResolutionNeedByStr = [[TasksplitArray1 objectAtIndex:15] stringByReplacingOccurrencesOfString:@"DateReslutionNeedBy==" withString:@""];
                    
                    rejectReasonStr = [[TasksplitArray1 objectAtIndex:16] stringByReplacingOccurrencesOfString:@"RejctRsn==" withString:@""];
                    
                    resolutionTypeStr = [[TasksplitArray1 objectAtIndex:17] stringByReplacingOccurrencesOfString:@"ResolutionTyp==" withString:@""];
                    
                    dateResolvedStr = [[TasksplitArray1 objectAtIndex:18] stringByReplacingOccurrencesOfString:@"DateRslvd==" withString:@""];
                    
                    dateClosedStr = [[TasksplitArray1 objectAtIndex:19] stringByReplacingOccurrencesOfString:@"DateClsd==" withString:@""];
                    
                    resolutionDtlsStr = [[TasksplitArray1 objectAtIndex:20] stringByReplacingOccurrencesOfString:@"ResolutionDtls==" withString:@""];
                    
                    ResolutionTypeName=[[TasksplitArray1 objectAtIndex:22]stringByReplacingOccurrencesOfString:@"ResolutionTypeName==" withString:@""];
                    
                    isFileAtatched=[[TasksplitArray1 objectAtIndex:21]stringByReplacingOccurrencesOfString:@"IsFileAttached==" withString:@""];
                }
                [IssueIdArray addObject:IssueIdStr];
                [issuenoaArray addObject:issueno];
                [projectidArray addObject:projectid];
                [TeamNameArray addObject: TeamName];
                
                [issuestatusArray addObject:issuestatus];
                [issuetypeArray addObject:issuetype];
                [buspriorityArray addObject:buspriority];
                [assignedtoArray addObject:assignedto];
                [assignedbyArray addObject:assignedby];
                [descriptionArray addObject:description];
                
                [projectNameArray addObject:projectName];
                [longDesArray addObject:longDes];
                [isFileAttatchedArray addObject:isFileAtatched];
                
                
                [escalatedRescrcAry addObject:escalatedRescrcStr];
                [releaseImpactAry addObject:releaseImpactStr];
                NSLog(@"Relaese impact array %@",releaseImpactAry);
                [dateResolutionNeedByAry addObject:dateResolutionNeedByStr];
                [rejectReasonAry addObject:rejectReasonStr];
                [resolutionTypeAry addObject:resolutionTypeStr];
                [dateResolvedAry addObject:dateResolvedStr];
                [dateClosedAry addObject:dateClosedStr];
                [resolutionDtlsAry addObject:resolutionDtlsStr];
                [issueTypeNameArray addObject:ResolutionTypeName];
                
                
                
                [pickerAry1 addObject:issuetype];
                [newpickerAry1 addObject:buspriority];
                
                tableAry = [[NSMutableArray alloc] init];
                searchAry = [[NSMutableArray alloc] init];
                tempAry = [[NSMutableArray alloc] initWithArray:issuestatusArray];
                tableAry = issuestatusArray;
                
                [btn setUserInteractionEnabled:NO];
                if ([statusSearch.text isEqualToString:@"Issue Type (All)"])
                {
                    [self issuetype];
                    
                }
                
                else if ([statusSearch.text isEqualToString:@"BusinessPriority(All)"])
                {
                    [self businespriority];
                }
                
            }
            
            NSLog(@"the issue status array is %@",IssueIdArray);
            
            [issueDetailsTbl reloadData];
            
        }

        
    }
    int total =[issuetypeArray count];
    
    NSString *totalIssueToast=[NSString stringWithFormat:@"%d",total];
    [self.view makeToast:totalIssueToast duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                   title:@"Total ISsues"];

}



//Aler View Deligate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == resolutionAlertView)
    {
        if(buttonIndex == 0)
        {
            
            
        }
        else if(buttonIndex == 1)
        {
            
            resolutionIssueViewController *resolutionView = [[resolutionIssueViewController alloc]init];
            resolutionView = [self.storyboard instantiateViewControllerWithIdentifier:@"resolutionissue"];
            resolutionView.projectIDStr = selectedProjectIdString;
            resolutionView.issueIdStr = selectedIssueIdString;
            
            

            resolutionView.escalatedToTblStr = selectedEscalatedTorescrcStr;
            resolutionView.releaseImpactTblStr = selectedReleaseImpactStr;
            resolutionView.dateResolutionNeededByTblStr = selecteddateResolutionNeedebyStr;
            resolutionView.rejectReasonTblStr = selectedrejectReasonStr;
            resolutionView.resolutionTypeTblStr = selectedIssueTypeNameStr;
            resolutionView.dateResolvedTblStr = selectedDateReslvedStr;
            resolutionView.dateClosedTblStr = selectedDateClosedStr;
            resolutionView.resolutionDtlsTblStr = selectedResolutionDtlsStr;

            [self.navigationController pushViewController:resolutionView animated:YES];
            //[issueDetailsTbl reloadData];
            
        }
    }
    
   else if (alertView==logOutAlertView)
    {
        if(buttonIndex == 0)
        {
            
        }

        else {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
    else
    {
        
    }
   
}


//TableView Deligate Methods

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
     if ([statusSearch.text length]>0 && ![statusSearch.text isEqualToString:@"Issue Type(All)"]&& ![statusSearch.text isEqualToString:@"BusinessPriority(All)"])
    {
        return [searchissueTypeAray count];

    }
    else
    {
        return [issuetypeArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([statusSearch.text length]>0 && ![statusSearch.text isEqualToString:@"Issue Type(All)"] && ![statusSearch.text isEqualToString:@"BusinessPriority(All)"])
    {

        
    static NSString *CellIdentifier = @"Cell";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //imageView = [[UIImageView alloc]init];
        //imageView.frame=CGRectMake(500, 50, 30, 30);
    }
  
    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
        imageView = [[UIImageView alloc]init];
        imageView.frame=CGRectMake(500, 50, 30, 30);
       
        //backgroundCellImage1=[[UIImageView alloc] initWithFrame:CGRectMake(650, 15, 60, 60)];
        //backgroundCellImage=[[UIImageView alloc] initWithFrame:CGRectMake(600, 50, 40, 40)];
        
        
        
        NSLog(@"isfileattatched array string is %@",[isFileAttatchedArray objectAtIndex:indexPath.row]);
        
        if (![[isFileAttatchedArray objectAtIndex:indexPath.row] isEqualToString:@"No attachment"])
        {
            
            imageView.image=[UIImage imageNamed:@"attatchment"];
            //cell.imageView.image =imageView.image;
            [cell.contentView addSubview:imageView];
            
        }
        else
        {
            
            imageView.image=nil;
            cell.imageView.image =imageView.image;
            
        }

    
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
    nameLbl.font=[UIFont systemFontOfSize:17];
    nameLbl.text = [searchdescriptionArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:17];
    nameLbl2.text= [searchissueStatusArray objectAtIndex:indexPath.row];
    IssueStatusLabel=nameLbl2;
    
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:17];
    nameLbl3.text= [searchissueTypeAray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
    nameLbl4.font=[UIFont systemFontOfSize:17];
    nameLbl4.text= [searchbusinessPriorityArray objectAtIndex:indexPath.row];

    UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
    nameLbl5.font=[UIFont systemFontOfSize:17];
    nameLbl5.text= [searcAssignToArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
    nameLbl6.font=[UIFont systemFontOfSize:17];
    nameLbl6.text= [searcAssignByArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl7 = (UILabel*)[cell viewWithTag:7];
    nameLbl7.font=[UIFont boldSystemFontOfSize:17];
    nameLbl7.text= @"Escalate To";
    esclateLabel=nameLbl7;
    [esclateLabel setHidden:YES];
    
    UILabel *nameLbl8 = (UILabel*)[cell viewWithTag:8];
    nameLbl8.font=[UIFont systemFontOfSize:17];
    //nameLbl8.text= [escalatedRescrcAry objectAtIndex:indexPath.row];
    escalateTextLabel=nameLbl8;
    [escalateTextLabel setHidden:YES];
        
        UILabel *nameLbl9 = (UILabel*)[cell viewWithTag:9];
        nameLbl9.font=[UIFont systemFontOfSize:17];
        nameLbl9.text= [searchIssueNoArray objectAtIndex:indexPath.row];
    

    if ([searcescalatedArray count]>0 &&![[searcescalatedArray objectAtIndex:indexPath.row] isEqualToString:@"null"])
    {
       
        [esclateLabel setHidden:NO];
        [escalateTextLabel setHidden:NO];
        escalateTextLabel.text=[searcescalatedArray objectAtIndex:indexPath.row];
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame=CGRectMake(560, 50, 60, 50);
        imgView.image=[UIImage imageNamed:@"Escalated1"];
        [cell.contentView addSubview:imgView];
     }
    
        
  
    UILongPressGestureRecognizer *longPressGesture =[[UILongPressGestureRecognizer alloc]
     initWithTarget:self action:@selector(longPress:)];
   
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
    
    }
    else
    {
        imageView = [[UIImageView alloc]init];
        imageView.frame=CGRectMake(500, 50, 30, 30);
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        cell.imageView.bounds = CGRectMake(300,7,32,32);
       //long row = [indexPath row];
        
        
        
        
        
        
        if (![[isFileAttatchedArray objectAtIndex:indexPath.row] isEqualToString:@"No attachment"])
        {
            
            imageView.image=[UIImage imageNamed:@"attatchment"];
            //cell.imageView.image =imageView.image;
             [cell.contentView addSubview:imageView];
        }
        else
        {
            
            imageView.image=nil;
            cell.imageView.image =imageView.image;
            
        }

        
        

       
        
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:17];
        nameLbl.text = [descriptionArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
        nameLbl2.font=[UIFont systemFontOfSize:17];
        nameLbl2.text= [issuestatusArray objectAtIndex:indexPath.row];
        IssueStatusLabel=nameLbl2;
        
        UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
        nameLbl3.font=[UIFont systemFontOfSize:17];
        nameLbl3.text= [issuetypeArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
        nameLbl4.font=[UIFont systemFontOfSize:17];
        nameLbl4.text= [buspriorityArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
        nameLbl5.font=[UIFont systemFontOfSize:17];
        nameLbl5.text= [assignedtoArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
        nameLbl6.font=[UIFont systemFontOfSize:17];
        nameLbl6.text= [assignedbyArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl7 = (UILabel*)[cell viewWithTag:7];
        nameLbl7.font=[UIFont boldSystemFontOfSize:17];
        nameLbl7.text= @"Escalate To";
        esclateLabel=nameLbl7;
        [esclateLabel setHidden:YES];
        
        UILabel *nameLbl8 = (UILabel*)[cell viewWithTag:8];
        nameLbl8.font=[UIFont systemFontOfSize:17];
        //nameLbl8.text= [escalatedRescrcAry objectAtIndex:indexPath.row];
        escalateTextLabel=nameLbl8;
        [escalateTextLabel setHidden:YES];
        
        UILabel *nameLbl9 = (UILabel*)[cell viewWithTag:9];
        nameLbl9.font=[UIFont systemFontOfSize:17];
        nameLbl9.text= [issuenoaArray objectAtIndex:indexPath.row];
        
        
        if ([escalatedRescrcAry count]>0 &&![[escalatedRescrcAry objectAtIndex:indexPath.row] isEqualToString:@"null"])
        {
            [esclateLabel setHidden:NO];
            [escalateTextLabel setHidden:NO];
            
            escalateTextLabel.text=[escalatedRescrcAry objectAtIndex:indexPath.row];
            UIImageView *imgView = [[UIImageView alloc]init];
            imgView.frame=CGRectMake(560, 50, 60, 50);
            imgView.image=[UIImage imageNamed:@"Escalated1"];
           [cell.contentView addSubview:imgView];
        }
        

        UILongPressGestureRecognizer *longPressGesture =[[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self action:@selector(longPress:)];
       [cell addGestureRecognizer:longPressGesture];
        
        return cell;
        
    }
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if ([statusSearch.text length]>0 && ![statusSearch.text isEqualToString:@"Issue Type(All)"] && ![statusSearch.text isEqualToString:@"BusinessPriority(All)"])
    {
    
        if (gesture.state == UIGestureRecognizerStateBegan)
    {
        
        //NSLog(@"issues status label text is %@",IssueStatusLabel.text);
        // get affected cell
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        
        // get indexPath of cell
        NSIndexPath *indexPath = [issueDetailsTbl indexPathForCell:cell];
        
        IssueStatusLabel.text=[searchissueStatusArray objectAtIndex:indexPath.row];
        NSLog(@"the iiiiiiiiiiiiii %@",IssueStatusLabel.text);
        if([IssueStatusLabel.text isEqualToString:@"Assigned"])
        {
            
            //for resolution screen
            selectedProjectIdString = [searchProjectidArray objectAtIndex:indexPath.row];
            selectedIssueIdString = [searchIssueIdArray objectAtIndex:indexPath.row];
            
            
            
            selectedEscalatedTorescrcStr = [searcescalatedArray objectAtIndex:indexPath.row];
            NSLog(@"selected resource is %@",selectedEscalatedTorescrcStr);
            selectedReleaseImpactStr = [searchReleaseImpactArray objectAtIndex:indexPath.row];
            NSLog(@"selected impact is %@",selectedReleaseImpactStr);
            selecteddateResolutionNeedebyStr = [searchDateResolutionNeedArray objectAtIndex:indexPath.row];
            selectedrejectReasonStr = [searchRejectReasonArry objectAtIndex:indexPath.row];
            selectedResolutionStr = [searchResolutionNameTypeArray objectAtIndex:indexPath.row];
            selectedDateReslvedStr = [searchDateResolveAry objectAtIndex:indexPath.row];
            selectedDateClosedStr = [searchCloseDateArray objectAtIndex:indexPath.row];
            selectedResolutionDtlsStr = [searchResolutionDetailsArray objectAtIndex:indexPath.row];
            selectedIssueTypeNameStr=[searchResolutionNameTypeArray objectAtIndex:indexPath.row];
            
            
            
            resolutionAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Resolution Screen?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
            [resolutionAlertView show];
            
            
        }
        
        else
        {
            
            [resolutionAlertView dismissWithClickedButtonIndex:0 animated:YES];
            issueStatusAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"It can't Escalated" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [issueStatusAlertView show];
            
        }
        
    }
    }
        else
        {
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                
                //NSLog(@"issues status label text is %@",IssueStatusLabel.text);
                // get affected cell
                UITableViewCell *cell = (UITableViewCell *)[gesture view];
                
                // get indexPath of cell
                NSIndexPath *indexPath = [issueDetailsTbl indexPathForCell:cell];
                
                IssueStatusLabel.text=[issuestatusArray objectAtIndex:indexPath.row];
                NSLog(@"the iiiiiiiiiiiiii %@",IssueStatusLabel.text);
                if([IssueStatusLabel.text isEqualToString:@"Assigned"])
                {
                    
                    //for resolution screen
                    selectedProjectIdString = [projectidArray objectAtIndex:indexPath.row];
                    selectedIssueIdString = [IssueIdArray objectAtIndex:indexPath.row];
                    
                    
                    
                    selectedEscalatedTorescrcStr = [escalatedRescrcAry objectAtIndex:indexPath.row];
                    NSLog(@"selected resource is %@",selectedEscalatedTorescrcStr);
                    selectedReleaseImpactStr = [releaseImpactAry objectAtIndex:indexPath.row];
                    NSLog(@"selected impact is %@",selectedReleaseImpactStr);
                    selecteddateResolutionNeedebyStr = [dateResolutionNeedByAry objectAtIndex:indexPath.row];
                    selectedrejectReasonStr = [rejectReasonAry objectAtIndex:indexPath.row];
                    selectedResolutionStr = [resolutionTypeAry objectAtIndex:indexPath.row];
                    selectedDateReslvedStr = [dateResolvedAry objectAtIndex:indexPath.row];
                    selectedDateClosedStr = [dateClosedAry objectAtIndex:indexPath.row];
                    selectedResolutionDtlsStr = [resolutionDtlsAry objectAtIndex:indexPath.row];
                    selectedIssueTypeNameStr=[issueTypeNameArray objectAtIndex:indexPath.row];
                    
                    
                    resolutionAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Resolution Screen?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
                    [resolutionAlertView show];
                    
                    
                }
                
                else
                {
                    
                    [resolutionAlertView dismissWithClickedButtonIndex:0 animated:YES];
                    issueStatusAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"It can't Escalated" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                    [issueStatusAlertView show];
                    
                }
        }
        
    //for resolution screen
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"UIGestureRecognizerStateEnded");
        //cell.backgroundColor = [UIColor clearColor];
        //Do Whatever You want on End of Gesture
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    createISSSUE = [[createIssueViewController alloc]init];
    if ([statusSearch.text isEqualToString:@""])
    {
    NSLog(@"Welcome");
    
    
    
    createISSSUE = [self.storyboard instantiateViewControllerWithIdentifier:@"createIssue"];
    
    createISSSUE.issueIdTblStr =       [IssueIdArray objectAtIndex:indexPath.row];
    createISSSUE.issueNoTblStr =       [issuenoaArray objectAtIndex:indexPath.row];
    createISSSUE.projectIdTblStr =     [projectidArray objectAtIndex:indexPath.row];
    createISSSUE.projectTblStr       = [projectNameArray objectAtIndex:indexPath.row];
    createISSSUE.issueStatusTblStr   = [issuestatusArray objectAtIndex:indexPath.row];
    createISSSUE.issueTypeTblStr     = [issuetypeArray objectAtIndex:indexPath.row];
    createISSSUE.assignToTblStr      = [assignedtoArray objectAtIndex:indexPath.row];
    createISSSUE.teamSubmittedTblStr = [TeamNameArray objectAtIndex:indexPath.row];
    createISSSUE.severityTblStr      = [buspriorityArray objectAtIndex:indexPath.row];
    createISSSUE.descriptionTblStr   = [descriptionArray objectAtIndex:indexPath.row];
    createISSSUE.isueHistoryTblStr   = [longDesArray objectAtIndex:indexPath.row];
    
    NSLog(@"the assignto table str is %@",[assignedtoArray objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:createISSSUE animated:YES];
    NSLog(@"the issue view controller is");
    
    
}
else
{
   // createISSSUE = [[createIssueViewController alloc]init];
    
    createISSSUE = [self.storyboard instantiateViewControllerWithIdentifier:@"createIssue"];
    
    createISSSUE.issueIdTblStr =       [searchIssueIdArray objectAtIndex:indexPath.row];
    createISSSUE.issueNoTblStr =       [searchIssuenoArray objectAtIndex:indexPath.row];
    createISSSUE.projectIdTblStr =     [searchProjectidArray objectAtIndex:indexPath.row];
    createISSSUE.projectTblStr       = [searchProjectNameArray objectAtIndex:indexPath.row];
    createISSSUE.issueStatusTblStr   = [searchissueStatusArray objectAtIndex:indexPath.row];
    createISSSUE.issueTypeTblStr     = [searchissueTypeAray objectAtIndex:indexPath.row];
    createISSSUE.assignToTblStr      = [searcAssignToArray objectAtIndex:indexPath.row];
    createISSSUE.teamSubmittedTblStr = [searchIssueTeamNameArray objectAtIndex:indexPath.row];
    createISSSUE.severityTblStr      = [searchbusinessPriorityArray objectAtIndex:indexPath.row];
    createISSSUE.descriptionTblStr   = [searchdescriptionArray objectAtIndex:indexPath.row];
    createISSSUE.isueHistoryTblStr   = [searchIssueHistoryArray objectAtIndex:indexPath.row];
     [self.navigationController pushViewController:createISSSUE animated:YES];

}
}


//searchBar Deligate Methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // called only once
    NSLog(@"hai");
    //    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 168, 728, 300)];
    //    [questionpkr setShowsSelectionIndicator:YES];
    //    questionpkr.delegate = self;
    //    questionpkr.dataSource = self;
    //    questionpkr.tag = 100;
    //    questionpkr.backgroundColor=[UIColor grayColor];
    //    [self.view addSubview:questionpkr];
    return YES;
}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    // called twice every time
//    NSLog(@"welcome");
//
//    //[searchBar setShowsCancelButton:YES animated:YES];
//}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    // called only once
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // called only once
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
    [statusSearch resignFirstResponder];
	if(search)
        return;
	search = YES;
    [statusSearch setShowsCancelButton:NO animated:YES];
    
    
}
//Users/rapid/Downloads/Quotes 19-02-13 OFC/Quotes.xcodeproj
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    //[statusSearch resignFirstResponder];
    
    if([searchText length] > 0)
    {
        search = YES;
        [self search];
        
        NSLog(@"is it >1");
    }
    else
    {
        search = NO;
        [statusSearch resignFirstResponder];
        
        tableAry = [[NSMutableArray alloc]initWithArray:tempAry];
    }
  
    for (int i=0; i<[buspriorityArray count];i++)
    {
        if ([statusSearch.text isEqualToString:[buspriorityArray objectAtIndex:i]])
        {
            [searchdescriptionArray addObject:[descriptionArray objectAtIndex:i]];
            [searchissueStatusArray addObject:[issuestatusArray objectAtIndex:i]];
            [searchissueTypeAray addObject:[issuetypeArray objectAtIndex:i]];
            [searchbusinessPriorityArray addObject:[buspriorityArray objectAtIndex:i]];
            [searcAssignByArray addObject:[assignedbyArray objectAtIndex:i]];
            [searcAssignToArray addObject:[assignedtoArray objectAtIndex:i]];
            [searcescalatedArray addObject:[escalatedRescrcAry objectAtIndex:i]];
            [searchIssueIdArray addObject:[IssueIdArray objectAtIndex:i]];
            [searchIssuenoArray addObject:[issuenoaArray objectAtIndex:i]];
            [searchProjectidArray addObject:[projectidArray objectAtIndex:i]];
            [searchProjectNameArray addObject:[projectNameArray objectAtIndex:i]];
            [searchIssueTeamNameArray addObject:[TeamNameArray objectAtIndex:i]];
            [searchIssueHistoryArray addObject:[longDesArray objectAtIndex:i]];
            [searchReleaseImpactArray addObject:[releaseImpactAry objectAtIndex:i]];
            [searchDateResolutionNeedArray addObject:[dateResolutionNeedByAry objectAtIndex:i]];
            [searchCloseDateArray addObject:[dateClosedAry objectAtIndex:i]];
            [searchDateResolveAry addObject:[dateResolvedAry objectAtIndex:i]];
            [searchResolutionDetailsArray addObject:[resolutionDtlsAry objectAtIndex:i]];
            [searchResolutionNameTypeArray addObject:[issueTypeNameArray objectAtIndex:i]];
            [searchRejectReasonArry addObject:[rejectReasonAry objectAtIndex:i]];
            [searchIssueNoArray addObject:[issuenoaArray objectAtIndex:i]];
            [searchIsFileAttatchedArray addObject:[isFileAttatchedArray objectAtIndex:i]];
            
            
            
        }
    }
    
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    NSLog(@"search desctiption array is %@",searchdescriptionArray);
    
 
    
    [issueDetailsTbl reloadData];

    
}




- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    /* same as search method */
    
    [tableAry removeAllObjects];
	NSString *searchText = statusSearch.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if ([searchAry count] > 0)
    {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [issueDetailsTbl reloadData];
    
}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    [tableAry removeAllObjects];
//    NSString *searchText1 = statusSearch.text;
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
//    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
//    if ([searchAry count] > 0)
//    {
//        [tableAry addObjectsFromArray:searchAry];
//    }
//    
//    search=YES;
//    [issueDetailsTbl reloadData];
//}
- (void) search
{
	[tableAry removeAllObjects];
	NSString *searchText = statusSearch.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if([searchAry count] > 0)
    {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [issueDetailsTbl reloadData];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [pickerAry count];
    }
    
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [pickerAry objectAtIndex:row];
    }
    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        
        [searchdescriptionArray removeAllObjects];
        [searcescalatedArray removeAllObjects];
        [searchissueStatusArray removeAllObjects];
        [searchissueTypeAray removeAllObjects];
        [searchbusinessPriorityArray removeAllObjects];
        [searcAssignByArray removeAllObjects];
        [searcAssignToArray removeAllObjects];
         [searchIssueHistoryArray removeAllObjects];
         [searchIssueIdArray removeAllObjects];
         [searchIssueTeamNameArray removeAllObjects];
         [searchProjectidArray removeAllObjects];
        [searchProjectNameArray removeAllObjects];
        statusSearch.text=[pickerAry objectAtIndex:row];
        NSLog(@"the project id isssssssss  %@ ",[pickerAry objectAtIndex:row]);
        //        [questionpkr removeFromSuperview];
        [statusSearch resignFirstResponder];
    
        if ([statusSearch.text isEqualToString:@"Issue Type(All)"])
        {
            NSLog(@"status search is working");

            statusSearch.text = nil;
            [self tableService];
            statusSearch.text = @"Issue Type(All)";
            

        }
        else
        {
            NSLog(@"welocme to eis");
            for (int i=0; i<[issuetypeArray count];i++)
            {
                if ([statusSearch.text isEqualToString:[issuetypeArray objectAtIndex:i]])
                {
                    [searchdescriptionArray addObject:[descriptionArray objectAtIndex:i]];
                    [searchissueStatusArray addObject:[issuestatusArray objectAtIndex:i]];
                    [searchissueTypeAray addObject:[issuetypeArray objectAtIndex:i]];
                    [searchbusinessPriorityArray addObject:[buspriorityArray objectAtIndex:i]];
                    [searcAssignByArray addObject:[assignedbyArray objectAtIndex:i]];
                    [searcAssignToArray addObject:[assignedtoArray objectAtIndex:i]];
                    [searcescalatedArray addObject:[escalatedRescrcAry objectAtIndex:i]];
                    [searchIssueIdArray addObject:[IssueIdArray objectAtIndex:i]];
                    [searchIssuenoArray addObject:[issuenoaArray objectAtIndex:i]];
                    [searchProjectidArray addObject:[projectidArray objectAtIndex:i]];
                    [searchProjectNameArray addObject:[projectNameArray objectAtIndex:i]];
                    [searchIssueTeamNameArray addObject:[TeamNameArray objectAtIndex:i]];
                    [searchIssueHistoryArray addObject:[longDesArray objectAtIndex:i]];
                    [searchReleaseImpactArray addObject:[releaseImpactAry objectAtIndex:i]];
                    [searchDateResolutionNeedArray addObject:[dateResolutionNeedByAry objectAtIndex:i]];
                    [searchCloseDateArray addObject:[dateClosedAry objectAtIndex:i]];
                    [searchDateResolveAry addObject:[dateResolvedAry objectAtIndex:i]];
                    [searchResolutionDetailsArray addObject:[resolutionDtlsAry objectAtIndex:i]];
                    [searchResolutionNameTypeArray addObject:[issueTypeNameArray objectAtIndex:i]];
                    [searchRejectReasonArry addObject:[rejectReasonAry objectAtIndex:i]];
                    [searchIssueNoArray addObject:[issuenoaArray objectAtIndex:i]];
                    [searchIsFileAttatchedArray addObject:[isFileAttatchedArray objectAtIndex:i]];
                }
                
            }
            
            
            [issueDetailsTbl reloadData];

            NSLog(@"search desctiption array is %@",searchdescriptionArray);
            NSLog(@"search issue status array is %@",searchissueStatusArray);
            NSLog(@"search issue type array is %@",searchissueTypeAray);
            NSLog(@"search businesspriority array is %@",searchbusinessPriorityArray);
            NSLog(@"search search assignby array is %@",searcAssignByArray);
            NSLog(@"search search assign to array is %@",searcAssignToArray);
            NSLog(@"search searchescalated array is %@",searcescalatedArray);
           
            
            
        }
        
        NSLog(@"%@",statusSearch.text);
        
        if ([statusSearch.text isEqualToString:@"BusinessPriority(All)"])
        {
            NSLog(@"business search is working");

            statusSearch.text = nil;
            [self tableService];
            statusSearch.text = @"BusinessPriority(All)";
        }
        else
        {
            for (int i=0; i<[buspriorityArray count];i++)
            {
                if ([statusSearch.text isEqualToString:[buspriorityArray objectAtIndex:i]])
                {
                    [searchdescriptionArray addObject:[descriptionArray objectAtIndex:i]];
                    [searchissueStatusArray addObject:[issuestatusArray objectAtIndex:i]];
                    [searchissueTypeAray addObject:[issuetypeArray objectAtIndex:i]];
                    [searchbusinessPriorityArray addObject:[buspriorityArray objectAtIndex:i]];
                    [searcAssignByArray addObject:[assignedbyArray objectAtIndex:i]];
                    [searcAssignToArray addObject:[assignedtoArray objectAtIndex:i]];
                    [searcescalatedArray addObject:[escalatedRescrcAry objectAtIndex:i]];
                    [searchIssueIdArray addObject:[IssueIdArray objectAtIndex:i]];
                    [searchIssuenoArray addObject:[issuenoaArray objectAtIndex:i]];
                    [searchProjectidArray addObject:[projectidArray objectAtIndex:i]];
                    [searchProjectNameArray addObject:[projectNameArray objectAtIndex:i]];
                    [searchIssueTeamNameArray addObject:[TeamNameArray objectAtIndex:i]];
                    [searchIssueHistoryArray addObject:[longDesArray objectAtIndex:i]];
                    [searchReleaseImpactArray addObject:[releaseImpactAry objectAtIndex:i]];
                    [searchDateResolutionNeedArray addObject:[dateResolutionNeedByAry objectAtIndex:i]];
                    [searchCloseDateArray addObject:[dateClosedAry objectAtIndex:i]];
                    [searchDateResolveAry addObject:[dateResolvedAry objectAtIndex:i]];
                    [searchResolutionDetailsArray addObject:[resolutionDtlsAry objectAtIndex:i]];
                    [searchResolutionNameTypeArray addObject:[issueTypeNameArray objectAtIndex:i]];
                    [searchRejectReasonArry addObject:[rejectReasonAry objectAtIndex:i]];
                    [searchIssueNoArray addObject:[issuenoaArray objectAtIndex:i]];
                    [searchIsFileAttatchedArray addObject:[isFileAttatchedArray objectAtIndex:i]];
                    
                }
                
            }
            [issueDetailsTbl reloadData];
            
            NSLog(@"search desctiption array is %@",searchdescriptionArray);
            NSLog(@"search issue status array is %@",searchissueStatusArray);
            NSLog(@"search issue type array is %@",searchissueTypeAray);
            NSLog(@"search businesspriority array is %@",searchbusinessPriorityArray);
            NSLog(@"search search assignby array is %@",searcAssignByArray);
            NSLog(@"search search assign to array is %@",searcAssignToArray);
            NSLog(@"search searchescalated array is %@",searcescalatedArray);

            
        }
        

    }
    
    
    
}
-(IBAction)btnClk:(id)sender
{
    
    
    pkrlbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 168, self.view.frame.size.width-40, 44)];//728
    [pkrlbl setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:pkrlbl];
    
    pkrRemoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pkrRemoveBtn setFrame:CGRectMake(self.view.frame.size.width-118, 168, 100, 44)];//650
    [pkrRemoveBtn addTarget:self action:@selector(pkrDoneClk:) forControlEvents:UIControlEventTouchUpInside];
    [pkrRemoveBtn setTitle:@"DONE" forState:UIControlStateNormal];
    [pkrRemoveBtn setBackgroundColor:[UIColor blackColor]];
    [pkrRemoveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:pkrRemoveBtn];
    
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 212, self.view.frame.size.width-40, 300)];//728
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
}

-(IBAction)btnClk1:(id)sender
{
    
    if (popController.popoverVisible)
    {
        [popController dismissPopoverAnimated:YES];
        return;
    }
    
    UIViewController *contentViewController = [[UIViewController alloc] init];
    contentViewController.view.backgroundColor = [UIColor whiteColor];
    //detailViewController *detailView = [[detailViewController alloc]init];
     popController = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    popController.popoverContentSize = CGSizeMake(200, 110);
    
    
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 110)];
    [view1 setBackgroundColor:[UIColor yellowColor]];
    [contentViewController.view addSubview:view1];
    
    
    UIButton *EvaluateBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [EvaluateBtn setTitle:@"Issue Type" forState:UIControlStateNormal];
    EvaluateBtn.tag= 102;
    //[Chequebtn setBackgroundColor:[UIColor grayColor]];
    [EvaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    EvaluateBtn.frame=CGRectMake(20, 10, 150, 40);
    [EvaluateBtn addTarget:self action:@selector(issuetype) forControlEvents:UIControlEventTouchDown];
    // [contentViewController.view addSubview:Chequebtn];
    [view1 addSubview:EvaluateBtn];
    
    
    UIButton * statusBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [statusBtn setTitle:@"Business Prority" forState:UIControlStateNormal];
    [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    statusBtn.tag = 101;
    statusBtn.frame=CGRectMake(20, 60, 150, 40);
    [statusBtn addTarget:self action:@selector(businespriority) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:statusBtn];
    
    
//    [popController presentPopoverFromBarButtonItem:createTimeSheetActionBarBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [popController presentPopoverFromRect:btn1.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES ];
    
    
    
    

}

- (IBAction)upLoadFile:(id)sender
{
    selectionView = [[UIView alloc] initWithFrame:CGRectMake(87, 523, 606, 241)];
    selectionView.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor;
    selectionView.layer.borderWidth = 2.0f;
    selectionView.layer.cornerRadius = 14;
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:1];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[selectionView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    [self.view addSubview:selectionView];
    
    UIButton *Musicbtn = [[UIButton alloc]initWithFrame:CGRectMake(125, 96, 107, 85)];
    [Musicbtn setImage:[UIImage imageNamed:@"gallery.png"] forState:UIControlStateNormal];
    [Musicbtn addTarget:self action:@selector(ChooseFromGallery:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:Musicbtn];
    
    UIButton *SoundRecordbtn = [[UIButton alloc]initWithFrame:CGRectMake(445, 95 , 107, 85)];
    [SoundRecordbtn setImage:[UIImage imageNamed:@"Camera-icon.png"] forState:UIControlStateNormal];
    [SoundRecordbtn addTarget:self action:@selector(atachmentsGalaryBtnClk:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:SoundRecordbtn];
    

}
-(IBAction)atachmentsGalaryBtnClk:(id)sender
{
    [selectionView removeFromSuperview];
    camImagePickerController = [[UIImagePickerController alloc] init];
    camImagePickerController.delegate=self;
    camImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camImagePickerController  animated:YES completion:nil];
}

- (IBAction)ChooseFromGallery:(id)sender {
    [selectionView removeFromSuperview];
    GalleryImage = [[UIImagePickerController alloc] init];
    GalleryImage.delegate = self;
    GalleryImage.allowsEditing = YES;
    GalleryImage.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:GalleryImage animated:YES completion:nil];
}
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary*) info

{
    
    
    if (picker == camImagePickerController)
    {
        ImageforUpload=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        ImageforUpload = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(ImageforUpload, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    else if (picker == GalleryImage){
        ImageforUpload = [info valueForKey:UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSData* imageData = UIImageJPEGRepresentation(ImageforUpload, 1.0);
    fileBytes = [imageData base64Encoding];
    //NSLog(@"bytes %@",imageData);
    
    int len = [imageData length];
    byteLenth = [NSString stringWithFormat:@"%d",len];
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datestr = [formatter stringFromDate:date];
    
    
    
    //Or you can get the image url from AssetsLibrary
    //NSString *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
        
        
    };
    
    fileName = [[NSMutableString alloc]initWithString:IssueIdStr];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyyMMdd_HHmmss"];
    imagedatestr = [formatter1 stringFromDate:date];
    [fileName appendString:@"_"];
    [fileName appendString:imagedatestr];
    [fileName appendString:@"image.jpg"];
    
    Servicecall=[[Webservices alloc]init];
    
    NSLog(@"nslog file name is %@",fileName);
    NSLog(@"issue id str is %@",IssueIdStr);
    NSLog(@"attatchemnt id str is %@",fileBytes);
    NSString *SAveAttatchmentClassName=@"IssuesAttachment";
    NSDictionary *SaveAttachmentParameters=@{@"issueId":IssueIdStr,@"attachmentName":fileName,@"attachmentBytes":fileBytes};
[Servicecall SaveAttatchmentInIssue:SAveAttatchmentClassName SaveAttatchmentIssuesDictionary:SaveAttachmentParameters];
    [Servicecall setDelegate:self];
    
//    saveIssueAttachment(String issueId,String attachmentName, String attachmentBytes){
//        attachmentList(String issueId){
//            Josphine • Wed, 5:15 PM
    
}



-(void)issuetype
{
    [popController dismissPopoverAnimated:YES];
    [btn setUserInteractionEnabled:YES];

    tempAry = [[NSMutableArray alloc] initWithArray:issuetypeArray];
    tableAry = issuetypeArray;
    
    [pickerAry removeAllObjects];
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"Issue Type(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    statusSearch.text = @"Issue Type(All)";
}

-(void)businespriority
{
    [popController dismissPopoverAnimated:YES];
    [btn setUserInteractionEnabled:YES];

    tempAry = [[NSMutableArray alloc] initWithArray:buspriorityArray];
    tableAry = buspriorityArray;
    
    [pickerAry removeAllObjects];

    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"BusinessPriority(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    statusSearch.text = @"BusinessPriority(All)";
}

-(IBAction)pkrDoneClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [pkrRemoveBtn removeFromSuperview];
    [pkrlbl removeFromSuperview];
}


-(IBAction)resolutionBtnClk:(id)sender

{
    resolutionIssueViewController *resolutionView = [[resolutionIssueViewController alloc]init];
    resolutionView = [self.storyboard instantiateViewControllerWithIdentifier:@"resolutionissue"];
    resolutionView.projectIDStr = selectedProjectIdString;
    resolutionView.issueIdStr = selectedIssueIdString;

    [self.navigationController pushViewController:resolutionView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard
{
    
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
