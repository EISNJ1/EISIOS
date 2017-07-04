//
//  requirementViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 01/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "requirementViewController.h"
#import "Webservices.h"
#import "Toast+UIView.h"

@interface requirementViewController()
{
    // project list search arrays
    
    NSMutableArray *requirementTypeTempArray,*ContactTempArray,*CriticallyTempArray,*ActivityTempArray,*SystemTempArray,*CoreProcessTempArray,*ProcessTempArray,*ProejctNameTempArray,*AssignReqIdTempArray,*ProejctIDTempAray,*SubProcessTempArray,*ReqDescriptionTempArray,*ReqHistoryTempArray,*requirementNameTempArray;
}

@end

@implementation requirementViewController

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
    [req2SearchBar setDelegate:self];
    [req2SearchBar setUserInteractionEnabled:NO];
    
    
    //-------------------Right side pop Button---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];
    
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    
    
    
    
    [self reqLstService];
    projectIDArray=[[NSMutableArray alloc]init];
    CriticallyTempArray=[[NSMutableArray alloc]init];
    requirementTypeTempArray=[[NSMutableArray alloc]init];
    ContactTempArray=[[NSMutableArray alloc]init];
    ActivityTempArray=[[NSMutableArray alloc]init];
    SystemTempArray=[[NSMutableArray alloc]init];
    CoreProcessTempArray=[[NSMutableArray alloc]init];
    ProcessTempArray=[[NSMutableArray alloc]init];
    ProejctNameTempArray=[[NSMutableArray alloc]init];
    AssignReqIdTempArray=[[NSMutableArray alloc]init];
    ProejctIDTempAray=[[NSMutableArray alloc]init];
    TempArray1=[[NSMutableArray alloc]init];
    SubProcessTempArray=[[NSMutableArray alloc]init];
    ReqDescriptionTempArray=[[NSMutableArray alloc]init];
    ReqHistoryTempArray=[[NSMutableArray alloc]init];
    requirementNameTempArray=[[NSMutableArray alloc]init];
    
    req1SearchBar.text=@"All";
    
    //req2 search bar arrays
    searchSystemArray=[[NSMutableArray alloc]init];
    searchContactArray=[[NSMutableArray alloc]init];
    searchReqtypeArray=[[NSMutableArray alloc]init];
    searchCriticalityArray=[[NSMutableArray alloc]init];
    searchActivityArray=[[NSMutableArray alloc]init];
    searchassignedIDArray=[[NSMutableArray alloc]init];
    searchProjectIDArray=[[NSMutableArray alloc]init];
    searchCoreprocessArray=[[NSMutableArray alloc]init];
    searchProcessArray=[[NSMutableArray alloc]init];
    searchSubprocessArray=[[NSMutableArray alloc]init];
    searchreqdescriptionArray=[[NSMutableArray alloc]init];
    searchReqHistoryArray=[[NSMutableArray alloc]init];
    searchRequiremnetNameArray=[[NSMutableArray alloc]init];
    
    //req2 search arrays
    search1ReqtypeArray=[[NSMutableArray alloc]init];
    search1SystemArray=[[NSMutableArray alloc]init];
    search1ContactArray=[[NSMutableArray alloc]init];
    search1CriticalityArray=[[NSMutableArray alloc]init];
    search1ActivityArray=[[NSMutableArray alloc]init];
    search1assignedIDArray=[[NSMutableArray alloc]init];
    search1ProjectIDArray=[[NSMutableArray alloc]init];
    search1CoreprocessArray=[[NSMutableArray alloc]init];
    search1ProcessArray=[[NSMutableArray alloc]init];
    search1SubprocessArray=[[NSMutableArray alloc]init];
    search1reqdescriptionArray=[[NSMutableArray alloc]init];
    search1ReqHistoryArray=[[NSMutableArray alloc]init];
    search1RequiremnetNameArray=[[NSMutableArray alloc]init];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self projectSpinnerService];
    [self reqLstService];
    [questionpkr removeFromSuperview];
    
    req1SearchBar.text=@"All";
    req2SearchBar.text=@"";
    [reqListTbl reloadData];
    
    
    
}
-(void)projectSpinnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr};
    [Servicecall reqProjectSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(void)reqLstService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"orgVp":OrgIdStr,@"userId":Useridstr,@"userType":UserTypestr};
    [Servicecall reqList:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}
-(IBAction)reqSearchBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 190, 360, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    req2SearchBar.text=nil;
    
}
-(IBAction)reqSearchBtnClk2:(id)sender
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
    popController.popoverContentSize = CGSizeMake(200, 260);
    
    
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 260)];
    [view1 setBackgroundColor:[UIColor grayColor]];
    [contentViewController.view addSubview:view1];
    
    
    UIButton *reqTypeBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [reqTypeBtn setTitle:@"REQUIREMENT TYPE" forState:UIControlStateNormal];
    reqTypeBtn.tag= 102;
    //[Chequebtn setBackgroundColor:[UIColor grayColor]];
    [reqTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reqTypeBtn.frame=CGRectMake(20, 10, 200, 40);
    [reqTypeBtn addTarget:self action:@selector(reqType) forControlEvents:UIControlEventTouchDown];
    // [contentViewController.view addSubview:Chequebtn];
    [view1 addSubview:reqTypeBtn];
    
    
    UIButton * contactBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [contactBtn setTitle:@"CONTACT" forState:UIControlStateNormal];
    [contactBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    contactBtn.tag = 101;
    contactBtn.frame=CGRectMake(20, 60, 150, 40);
    [contactBtn addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:contactBtn];
    
    
    UIButton * criticialityBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [criticialityBtn setTitle:@"CRITICALITY" forState:UIControlStateNormal];
    [criticialityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    criticialityBtn.tag = 101;
    criticialityBtn.frame=CGRectMake(20, 110, 150, 40);
    [criticialityBtn addTarget:self action:@selector(criticiality) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:criticialityBtn];
    
    UIButton * systemBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [systemBtn setTitle:@"SYSTEM" forState:UIControlStateNormal];
    [systemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    systemBtn.tag = 101;
    systemBtn.frame=CGRectMake(20, 160, 150, 40);
    [systemBtn addTarget:self action:@selector(system) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:systemBtn];
    
    
    UIButton * activityBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [activityBtn setTitle:@"ACTIVITY" forState:UIControlStateNormal];
    [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    activityBtn.tag = 101;
    activityBtn.frame=CGRectMake(20, 210, 150, 40);
    [activityBtn addTarget:self action:@selector(activity) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:activityBtn];
    
    [popController presentPopoverFromRect:reqSearchBtn2.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES ];
    
    
    
}
-(void)projectLsit
{
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:projectIDArray];
    tableAry=projectIDArray;
    
    [pickerarray11 removeAllObjects];
    for (id obj in pickerarray11)
    {
        
        if (![pickerarray11 containsObject:obj])
        {
            [pickerarray11 addObject:obj];
        }
    }
    //[pickerarray11 addObject:[PROJECT_NAMEArray objectAtInd]];
    
}

-(void)reqType
{
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:reqTypeArray];
    tableAry = reqTypeArray;
    NSLog(@"picker aray is %@",pickerAry);
    [pickerAry removeAllObjects];
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"Requirement Type (All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    req2SearchBar.text = @"Requirement Type (All)";
}
-(void)contact
{
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:contactAry];
    tableAry = contactAry;
    
    [pickerAry removeAllObjects];
    NSLog(@"new array is %@",pickerAry);
    
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
        
    }
    
    [pickerAry addObject:@"Contact(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    req2SearchBar.text = @"Contact(All)";
    
    
    
    
    
}
-(void)criticiality
{
    
    
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:criticialityAry];
    tableAry = criticialityAry;
    
    [pickerAry removeAllObjects];
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"Criticiality(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    req2SearchBar.text = @"Criticiality(All)";
}
-(void)system
{
    
    
    
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:systemAry];
    tableAry = systemAry;
    
    [pickerAry removeAllObjects];
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"System(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    req2SearchBar.text = @"System(All)";
    
}
-(void)activity
{
    
    [popController dismissPopoverAnimated:YES];
    [reqSearchBtn3 setUserInteractionEnabled:YES];
    
    tempAry = [[NSMutableArray alloc] initWithArray:activityAry];
    tableAry = activityAry;
    
    [pickerAry removeAllObjects];
    for (id obj in tableAry)
    {
        if (![pickerAry containsObject:obj])
        {
            [pickerAry addObject: obj];
        }
    }
    
    [pickerAry addObject:@"Activity(All)"];
    
    NSLog(@"new array is %@",pickerAry);
    
    req2SearchBar.text = @"Activity(All)";
    //
    
}
-(IBAction)reqSearchBtnClk3:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(400, 190, self.view.frame.size.width-448, 300)];//320
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
}

-(void)homeBtnClk
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
-(void)logOutBtnClk
{
    logoutalertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [logoutalertView show];
    
    
    
}

-(void)createTimeetActionBtnClk
{
    createRequirementViewController *createReqView = [[createRequirementViewController alloc]init];
    createReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"createReq"];
    [self.navigationController pushViewController:createReqView animated:YES];
    
}



-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser1 = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
    
    
}
-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser.delegate = self;
    [xmlParser parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
}

//picker deligate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [PROJECT_NAMEArray count];
    }
    else if (picker.tag==101)
    {
        return [pickerAry count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [PROJECT_NAMEArray objectAtIndex:row];
    }
    if (picker.tag==101)
    {
        return [pickerAry objectAtIndex:row];
    }
    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        
        [CriticallyTempArray removeAllObjects];
        [requirementTypeTempArray removeAllObjects];
        [SystemTempArray removeAllObjects];
        [ActivityTempArray removeAllObjects];
        [ContactTempArray removeAllObjects];
        [AssignReqIdTempArray removeAllObjects];
        [ProejctIDTempAray removeAllObjects];
        [CoreProcessTempArray removeAllObjects];
        [ProcessTempArray removeAllObjects];
        [SubProcessTempArray removeAllObjects];
        [ReqDescriptionTempArray removeAllObjects];
        [ReqHistoryTempArray removeAllObjects];
        [requirementNameTempArray removeAllObjects];
        
        
        req1SearchBar.text=[PROJECT_NAMEArray objectAtIndex:row];
        [questionpkr removeFromSuperview];
        [self search1];
        
        if([req1SearchBar.text isEqualToString:@"All"])
        {
            NSLog(@"status search is working %@",pkrProjectIDStr);
            
            req1SearchBar.text = nil;
            [self reqLstService];
            req1SearchBar.text = @"All";
            
            int total=[requirementNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            
            
        }
        else{
        
        for (int i=0; i<[projectNameArray count]; i++)
        {
            if ([req1SearchBar.text isEqualToString:[projectNameArray objectAtIndex:i]])
            {
                [CriticallyTempArray addObject:[criticialityAry objectAtIndex:i]];
                [requirementTypeTempArray addObject:[reqTypeArray objectAtIndex:i]];
                [SystemTempArray addObject:[systemAry objectAtIndex:i]];
                [ActivityTempArray addObject:[activityAry objectAtIndex:i]];
                [ContactTempArray addObject:[contactAry objectAtIndex:i]];
                [AssignReqIdTempArray addObject:[assignReqIdAry objectAtIndex:i]];
                [ProejctIDTempAray addObject:[projectIDArray objectAtIndex:i]];
                [CoreProcessTempArray addObject:[coreProcessAry objectAtIndex:i]];
                [SubProcessTempArray addObject:[subProcessAry objectAtIndex:i]];
                [ProcessTempArray addObject:[processAry objectAtIndex:i]];
                [ReqDescriptionTempArray addObject:[reqDescriptionAry objectAtIndex:i]];
                [ReqHistoryTempArray addObject:[reqHistoryAry objectAtIndex:i]];
                [requirementNameTempArray addObject:[requirementNameArray objectAtIndex:i]];
            }
        }
        [reqListTbl reloadData];
        NSLog(@"critically temp array is %@",CriticallyTempArray);
        NSLog(@"critically temp array is %@",requirementTypeTempArray);
        
        NSLog(@"critically temp array is %@",SystemTempArray);
        
        NSLog(@"critically temp array is %@",ActivityTempArray);
        
        NSLog(@"critically temp array is %@",ContactTempArray);
            
            int total=[requirementNameTempArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
        }
    }
    if (pickerView.tag==101)
    {
        
        [searchContactArray removeAllObjects];
        [searchActivityArray removeAllObjects];
        [searchSystemArray removeAllObjects];
        [searchReqtypeArray removeAllObjects];
        [searchCriticalityArray removeAllObjects];
        
        [search1ContactArray removeAllObjects];
        [search1ActivityArray removeAllObjects];
        [search1SystemArray removeAllObjects];
        [search1ReqtypeArray removeAllObjects];
        [search1CriticalityArray removeAllObjects];
        [search1assignedIDArray removeAllObjects];
        [search1ProjectIDArray removeAllObjects];
        [search1ProcessArray removeAllObjects];
        [search1SubprocessArray removeAllObjects];
        [search1CoreprocessArray removeAllObjects];
        [search1reqdescriptionArray  removeAllObjects];
        [search1ReqHistoryArray removeAllObjects];
        [search1RequiremnetNameArray removeAllObjects];
        

        
        req2SearchBar.text=[pickerAry objectAtIndex:row];
        //NSLog(@"the project id isssssssss  %@ ",[newpickerAry1 objectAtIndex:row]);
        [questionpkr removeFromSuperview];
        [req2SearchBar resignFirstResponder];
        
        
        
        
        if ([req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
        {
            NSLog(@"status search is working %@",pkrProjectIDStr);
            
            req2SearchBar.text = nil;
            [self reqLstService];
            req2SearchBar.text = @"Requirement Type (All)";
            
            
        }
    else if(![req1SearchBar.text isEqualToString:@"All"] && ![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
      {
    
          NSLog(@"welcome to eis2222222");
          
          for (int i=0 ; i<[requirementTypeTempArray count]; i++)
          {
              if ([req2SearchBar.text isEqualToString:[requirementTypeTempArray objectAtIndex:i]])
              {
                  [search1ReqtypeArray addObject:[requirementTypeTempArray objectAtIndex:i]];
                  [search1SystemArray addObject:[SystemTempArray objectAtIndex:i]];
                  [search1ContactArray addObject:[ContactTempArray objectAtIndex:i]];
                  [search1ActivityArray addObject:[ActivityTempArray objectAtIndex:i]];
                  [search1CriticalityArray addObject:[CriticallyTempArray objectAtIndex:i]];
                  [search1assignedIDArray addObject:[AssignReqIdTempArray objectAtIndex:i]];
                  [search1ProjectIDArray addObject:[ProejctIDTempAray objectAtIndex:i]];
                  [search1ProcessArray addObject:[ProcessTempArray objectAtIndex:i]];
                  [search1CoreprocessArray addObject:[CoreProcessTempArray objectAtIndex:i]];
                  [search1SubprocessArray addObject:[SubProcessTempArray objectAtIndex:i]];
                  [search1reqdescriptionArray addObject:[ReqDescriptionTempArray objectAtIndex:i]];
                  [search1ReqHistoryArray addObject:[ReqHistoryTempArray objectAtIndex:i]];
                  [search1RequiremnetNameArray addObject:[requirementNameTempArray objectAtIndex:i]];
              }
          }
          [reqListTbl reloadData];
          NSLog(@"second reqtype array is %@",search1ReqtypeArray);
          NSLog(@"second reqtype array is %@",search1ActivityArray);
          NSLog(@"second reqtype array is %@",search1SystemArray);
          NSLog(@"second reqtype array is %@",search1CriticalityArray);
          NSLog(@"second reqtype array is %@",search1ContactArray);
          int total=[search1RequiremnetNameArray count];
          NSString *totaltask=[NSString stringWithFormat:@"%d",total];
          NSLog(@"total count of task created by search is %@",totaltask);
          [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                         title:@"Total Reqirement"];
      }
        else
        {
            NSLog(@"welcome to eis");
            for (int i=0; i<[reqTypeArray count];i++)
            {
                if ([req2SearchBar.text isEqualToString:[reqTypeArray objectAtIndex:i]])
                {
                    [searchReqtypeArray addObject:[reqTypeArray objectAtIndex:i]];
                    [searchCriticalityArray addObject:[criticialityAry objectAtIndex:i]];
                    [searchSystemArray addObject:[systemAry objectAtIndex:i]];
                    [searchActivityArray addObject:[activityAry objectAtIndex:i]];
                    [searchContactArray addObject:[contactAry objectAtIndex:i]];
                    [searchassignedIDArray addObject:[assignReqIdAry objectAtIndex:i]];
                    [searchProjectIDArray addObject:[projectIDArray objectAtIndex:i]];
                    [searchCoreprocessArray addObject:[coreProcessAry objectAtIndex:i]];
                    [searchSubprocessArray addObject:[subProcessAry objectAtIndex:i]];
                    [searchProcessArray addObject:[processAry objectAtIndex:i]];
                    [searchreqdescriptionArray addObject:[reqDescriptionAry objectAtIndex:i]];
                    [searchReqHistoryArray addObject:[reqHistoryAry objectAtIndex:i]];
                    [searchRequiremnetNameArray addObject:[requirementNameArray objectAtIndex:i]];
                }
            }
             [reqListTbl reloadData];
            NSLog(@"reqtype is %@",searchReqtypeArray);
            NSLog(@"criticality array is %@",searchCriticalityArray);
            NSLog(@"system array is %@",searchSystemArray);
            NSLog(@"activity array is %@",searchActivityArray);
            NSLog(@"contact array is %@",searchContactArray);
            
            int total=[searchRequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
         
            [reqListTbl reloadData];
            
        }
        NSLog(@"%@",req2SearchBar.text);
        
        if ([req2SearchBar.text isEqualToString:@"Contact(All)"])
        {
            NSLog(@"business search is working");
            
            req2SearchBar.text = nil;
            [self reqLstService];
            req2SearchBar.text = @"Contact(All)";
            
            
            
        }
        else if(![req1SearchBar.text isEqualToString:@"All"] && ![req2SearchBar.text isEqualToString:@"Contact(All)"])
        {
            
            NSLog(@"welcome to eis2222222");
            
            for (int i=0 ; i<[ContactTempArray count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[ContactTempArray objectAtIndex:i]])
                {
                    [search1ReqtypeArray addObject:[requirementTypeTempArray objectAtIndex:i]];
                    [search1SystemArray addObject:[SystemTempArray objectAtIndex:i]];
                    [search1ContactArray addObject:[ContactTempArray objectAtIndex:i]];
                    [search1ActivityArray addObject:[ActivityTempArray objectAtIndex:i]];
                    [search1CriticalityArray addObject:[CriticallyTempArray objectAtIndex:i]];
                    [search1assignedIDArray addObject:[AssignReqIdTempArray objectAtIndex:i]];
                    [search1ProjectIDArray addObject:[ProejctIDTempAray objectAtIndex:i]];
                    [search1SubprocessArray addObject:[SubProcessTempArray objectAtIndex:i]];
                    [search1ProcessArray addObject:[ProcessTempArray objectAtIndex:i]];
                    [search1CoreprocessArray addObject:[CoreProcessTempArray objectAtIndex:i]];
                    [search1reqdescriptionArray addObject:[ReqDescriptionTempArray objectAtIndex:i]];
                    [search1ReqHistoryArray addObject:[ReqHistoryTempArray objectAtIndex:i]];
                    [search1RequiremnetNameArray addObject:[requirementNameTempArray objectAtIndex:i]];
                    
                }
                //[reqListTbl reloadData];
            }
              [reqListTbl reloadData];
            
            NSLog(@"second reqtype array is %@",search1ReqtypeArray);
            NSLog(@"second reqtype array is %@",search1ActivityArray);
            NSLog(@"second reqtype array is %@",search1SystemArray);
            NSLog(@"second reqtype array is %@",search1CriticalityArray);
            NSLog(@"second reqtype array is %@",search1ContactArray);
           
            int total=[search1RequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
        }
        else
        {
            NSLog(@"welcome to eis");
            for (int i=0; i<[contactAry count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[contactAry objectAtIndex:i]])
                {
                    [searchReqtypeArray addObject:[reqTypeArray objectAtIndex:i]];
                    [searchCriticalityArray addObject:[criticialityAry objectAtIndex:i]];
                    [searchSystemArray addObject:[systemAry objectAtIndex:i]];
                    [searchActivityArray addObject:[activityAry objectAtIndex:i]];
                    [searchContactArray addObject:[contactAry objectAtIndex:i]];
                    [searchassignedIDArray addObject:[assignReqIdAry objectAtIndex:i]];
                    [searchProjectIDArray addObject:[projectIDArray objectAtIndex:i]];
                    [searchCoreprocessArray addObject:[coreProcessAry objectAtIndex:i]];
                    [searchSubprocessArray addObject:[subProcessAry objectAtIndex:i]];
                    [searchProcessArray addObject:[processAry objectAtIndex:i]];
                    [searchreqdescriptionArray addObject:[reqDescriptionAry objectAtIndex:i]];
                    [searchReqHistoryArray addObject:[reqHistoryAry objectAtIndex:i]];
                    [searchRequiremnetNameArray addObject:[requirementNameArray objectAtIndex:i]];
                }
              
            }
              [reqListTbl reloadData];
            NSLog(@"reqtype is %@",searchReqtypeArray);
            NSLog(@"criticality array is %@",searchCriticalityArray);
            NSLog(@"system array is %@",searchSystemArray);
            NSLog(@"activity array is %@",searchActivityArray);
            NSLog(@"contact array is %@",searchContactArray);
            
            int total=[searchRequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            
            [reqListTbl reloadData];
            
        }


        
        if ([req2SearchBar.text isEqualToString:@"Criticiality(All)"])
        {
            NSLog(@"business search is working");
            
            req2SearchBar.text = nil;
            [self reqLstService];
            req2SearchBar.text = @"Criticiality(All)";
            
            
            
        }
        else if(![req1SearchBar.text isEqualToString:@"All"] && ![req2SearchBar.text isEqualToString:@"Criticiality(All)"])
        {
            
            NSLog(@"welcome to eis2222222");
            
            for (int i=0 ; i<[CriticallyTempArray count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[CriticallyTempArray objectAtIndex:i]])
                {
                    [search1ReqtypeArray addObject:[requirementTypeTempArray objectAtIndex:i]];
                    [search1SystemArray addObject:[SystemTempArray objectAtIndex:i]];
                    [search1ContactArray addObject:[ContactTempArray objectAtIndex:i]];
                    [search1ActivityArray addObject:[ActivityTempArray objectAtIndex:i]];
                    [search1CriticalityArray addObject:[CriticallyTempArray objectAtIndex:i]];
                    [search1assignedIDArray addObject:[AssignReqIdTempArray objectAtIndex:i]];
                    [search1ProjectIDArray addObject:[ProejctIDTempAray objectAtIndex:i]];
                    [search1SubprocessArray addObject:[SubProcessTempArray objectAtIndex:i]];
                    [search1ProcessArray addObject:[ProcessTempArray objectAtIndex:i]];
                    [search1CoreprocessArray addObject:[CoreProcessTempArray objectAtIndex:i]];
                    [search1reqdescriptionArray addObject:[ReqDescriptionTempArray objectAtIndex:i]];
                    [search1ReqHistoryArray addObject:[ReqHistoryTempArray objectAtIndex:i]];
                    [search1RequiremnetNameArray addObject:[requirementNameTempArray objectAtIndex:i]];

                }
            }
            [reqListTbl reloadData];
            NSLog(@"second reqtype array is %@",search1ReqtypeArray);
            NSLog(@"second reqtype array is %@",search1ActivityArray);
            NSLog(@"second reqtype array is %@",search1SystemArray);
            NSLog(@"second reqtype array is %@",search1CriticalityArray);
            NSLog(@"second reqtype array is %@",search1ContactArray);
            
            int total=[search1RequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
        }
        else
        {
            NSLog(@"welcome to eis");
            for (int i=0; i<[criticialityAry count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[criticialityAry objectAtIndex:i]])
                {
                    [searchReqtypeArray addObject:[reqTypeArray objectAtIndex:i]];
                    [searchCriticalityArray addObject:[criticialityAry objectAtIndex:i]];
                    [searchSystemArray addObject:[systemAry objectAtIndex:i]];
                    [searchActivityArray addObject:[activityAry objectAtIndex:i]];
                    [searchContactArray addObject:[contactAry objectAtIndex:i]];
                    [searchassignedIDArray addObject:[assignReqIdAry objectAtIndex:i]];
                    [searchProjectIDArray addObject:[projectIDArray objectAtIndex:i]];
                    [searchCoreprocessArray addObject:[coreProcessAry objectAtIndex:i]];
                    [searchSubprocessArray addObject:[subProcessAry objectAtIndex:i]];
                    [searchProcessArray addObject:[processAry objectAtIndex:i]];
                    [searchreqdescriptionArray addObject:[reqDescriptionAry objectAtIndex:i]];
                    [searchReqHistoryArray addObject:[reqHistoryAry objectAtIndex:i]];
                    [searchRequiremnetNameArray addObject:[requirementNameArray objectAtIndex:i]];

                }
            }
            [reqListTbl reloadData];
            NSLog(@"reqtype is %@",searchReqtypeArray);
            NSLog(@"criticality array is %@",searchCriticalityArray);
            NSLog(@"system array is %@",searchSystemArray);
            NSLog(@"activity array is %@",searchActivityArray);
            NSLog(@"contact array is %@",searchContactArray);
            
            int total=[searchRequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            
            [reqListTbl reloadData];
            
        }

        if ([req2SearchBar.text isEqualToString:@"System(All)"])
        {
            NSLog(@"business search is working");
            
            req2SearchBar.text = nil;
            [self reqLstService];
            req2SearchBar.text = @"System(All)";
            
            
            
        }
        else if(![req1SearchBar.text isEqualToString:@"All"] && ![req2SearchBar.text isEqualToString:@"System(All)"])
        {
            
            NSLog(@"welcome to eis2222222");
            
            for (int i=0 ; i<[SystemTempArray count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[SystemTempArray objectAtIndex:i]])
                {
                    [search1ReqtypeArray addObject:[requirementTypeTempArray objectAtIndex:i]];
                    [search1SystemArray addObject:[SystemTempArray objectAtIndex:i]];
                    [search1ContactArray addObject:[ContactTempArray objectAtIndex:i]];
                    [search1ActivityArray addObject:[ActivityTempArray objectAtIndex:i]];
                    [search1CriticalityArray addObject:[CriticallyTempArray objectAtIndex:i]];
                    [search1assignedIDArray addObject:[AssignReqIdTempArray objectAtIndex:i]];
                    [search1ProjectIDArray addObject:[ProejctIDTempAray objectAtIndex:i]];
                    [search1SubprocessArray addObject:[SubProcessTempArray objectAtIndex:i]];
                    [search1ProcessArray addObject:[ProcessTempArray objectAtIndex:i]];
                    [search1CoreprocessArray addObject:[CoreProcessTempArray objectAtIndex:i]];
                    [search1reqdescriptionArray addObject:[ReqDescriptionTempArray objectAtIndex:i]];
                    [search1ReqHistoryArray addObject:[ReqHistoryTempArray objectAtIndex:i]];
                    [search1RequiremnetNameArray addObject:[requirementNameTempArray objectAtIndex:i]];
                    

                }
            }
            
            
            int total=[search1RequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            [reqListTbl reloadData];
            NSLog(@"second reqtype array is %@",search1ReqtypeArray);
            NSLog(@"second reqtype array is %@",search1ActivityArray);
            NSLog(@"second reqtype array is %@",search1SystemArray);
            NSLog(@"second reqtype array is %@",search1CriticalityArray);
            NSLog(@"second reqtype array is %@",search1ContactArray);
        }
        else
        {
            NSLog(@"welcome to eis");
            for (int i=0; i<[systemAry count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[systemAry objectAtIndex:i]])
                {
                    [searchReqtypeArray addObject:[reqTypeArray objectAtIndex:i]];
                    [searchCriticalityArray addObject:[criticialityAry objectAtIndex:i]];
                    [searchSystemArray addObject:[systemAry objectAtIndex:i]];
                    [searchActivityArray addObject:[activityAry objectAtIndex:i]];
                    [searchContactArray addObject:[contactAry objectAtIndex:i]];
                    [searchassignedIDArray addObject:[assignReqIdAry objectAtIndex:i]];
                    [searchProjectIDArray addObject:[projectIDArray objectAtIndex:i]];
                    [searchCoreprocessArray addObject:[coreProcessAry objectAtIndex:i]];
                    [searchSubprocessArray addObject:[subProcessAry objectAtIndex:i]];
                    [searchProcessArray addObject:[processAry objectAtIndex:i]];
                    [searchreqdescriptionArray addObject:[reqDescriptionAry objectAtIndex:i]];
                    [searchReqHistoryArray addObject:[reqHistoryAry objectAtIndex:i]];
                    [searchRequiremnetNameArray addObject:[requirementNameArray objectAtIndex:i]];
                    

                }
            }
            
            int total=[searchRequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            [reqListTbl reloadData];
            NSLog(@"reqtype is %@",searchReqtypeArray);
            NSLog(@"criticality array is %@",searchCriticalityArray);
            NSLog(@"system array is %@",searchSystemArray);
            NSLog(@"activity array is %@",searchActivityArray);
            NSLog(@"contact array is %@",searchContactArray);
            
            [reqListTbl reloadData];
            
        }
        

        if ([req2SearchBar.text isEqualToString:@"Activity(All)"])
        {
            NSLog(@"business search is working");
            
            req2SearchBar.text = nil;
            [self reqLstService];
            req2SearchBar.text = @"Activity(All)";
            
            
            
        }
        else if(![req1SearchBar.text isEqualToString:@"All"] && ![req2SearchBar.text isEqualToString:@"Activity(All)"])
        {
            
            NSLog(@"welcome to eis2222222");
            
            for (int i=0 ; i<[ActivityTempArray count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[ActivityTempArray objectAtIndex:i]])
                {
                    [search1ReqtypeArray addObject:[requirementTypeTempArray objectAtIndex:i]];
                    [search1SystemArray addObject:[SystemTempArray objectAtIndex:i]];
                    [search1ContactArray addObject:[ContactTempArray objectAtIndex:i]];
                    [search1ActivityArray addObject:[ActivityTempArray objectAtIndex:i]];
                    [search1CriticalityArray addObject:[CriticallyTempArray objectAtIndex:i]];
                    [search1assignedIDArray addObject:[AssignReqIdTempArray objectAtIndex:i]];
                    [search1ProjectIDArray addObject:[ProejctIDTempAray objectAtIndex:i]];
                    [search1SubprocessArray addObject:[SubProcessTempArray objectAtIndex:i]];
                    [search1ProcessArray addObject:[ProcessTempArray objectAtIndex:i]];
                    [search1CoreprocessArray addObject:[CoreProcessTempArray objectAtIndex:i]];
                    [search1reqdescriptionArray addObject:[ReqDescriptionTempArray objectAtIndex:i]];
                    [search1ReqHistoryArray addObject:[ReqHistoryTempArray objectAtIndex:i]];
                    [search1RequiremnetNameArray addObject:[requirementNameTempArray objectAtIndex:i]];
                }
            }
            
            int total=[search1RequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            [reqListTbl reloadData];
            NSLog(@"second reqtype array is %@",search1ReqtypeArray);
            NSLog(@"second reqtype array is %@",search1ActivityArray);
            NSLog(@"second reqtype array is %@",search1SystemArray);
            NSLog(@"second reqtype array is %@",search1CriticalityArray);
            NSLog(@"second reqtype array is %@",search1ContactArray);
        }
        else
        {
            NSLog(@"welcome to eis");
            for (int i=0; i<[activityAry count]; i++)
            {
                if ([req2SearchBar.text isEqualToString:[activityAry objectAtIndex:i]])
                {
                    [searchReqtypeArray addObject:[reqTypeArray objectAtIndex:i]];
                    [searchCriticalityArray addObject:[criticialityAry objectAtIndex:i]];
                    [searchSystemArray addObject:[systemAry objectAtIndex:i]];
                    [searchActivityArray addObject:[activityAry objectAtIndex:i]];
                    [searchContactArray addObject:[contactAry objectAtIndex:i]];
                    [searchassignedIDArray addObject:[assignReqIdAry objectAtIndex:i]];
                    [searchProjectIDArray addObject:[projectIDArray objectAtIndex:i]];
                    [searchCoreprocessArray addObject:[coreProcessAry objectAtIndex:i]];
                    [searchSubprocessArray addObject:[subProcessAry objectAtIndex:i]];
                    [searchProcessArray addObject:[processAry objectAtIndex:i]];
                    [searchreqdescriptionArray addObject:[reqDescriptionAry objectAtIndex:i]];
                    [searchReqHistoryArray addObject:[reqHistoryAry objectAtIndex:i]];
                    [searchRequiremnetNameArray addObject:[requirementNameArray objectAtIndex:i]];
                    

                }
            }
            
            int total=[searchRequiremnetNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            [reqListTbl reloadData];
            NSLog(@"reqtype is %@",searchReqtypeArray);
            NSLog(@"criticality array is %@",searchCriticalityArray);
            NSLog(@"system array is %@",searchSystemArray);
            NSLog(@"activity array is %@",searchActivityArray);
            NSLog(@"contact array is %@",searchContactArray);
            
            [reqListTbl reloadData];
            
        }
        
        
        /* same as search method */
//        [tableAry removeAllObjects];
//        NSString *searchText = req2SearchBar.text;
//        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
//        searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
//        if ([searchAry count] > 0)
//        {
//            [tableAry addObjectsFromArray:searchAry];
//        }
//        
//        search=YES;
//        [reqListTbl reloadData];
        
        
        
        
    }
    
}
-(void) reqLstService1
{
    
}
-(void)search1
{
    
    [TempArray1 removeAllObjects];
    NSString *searchText = req1SearchBar.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchArray1=(NSMutableArray*)[tempArray1 filteredArrayUsingPredicate:predicate];
    
    if ([searchArray1 count]>0)
    {
        [TempArray1 addObjectsFromArray:searchArray1];
        
        projectSearchArray=TempArray1;
    }
    NSLog(@"project search array is %@",projectSearchArray);
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

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar
{
    
    [req2SearchBar resignFirstResponder];
    if(search)
        return;
    search = YES;
    [req2SearchBar setShowsCancelButton:NO animated:YES];
    
    
}
//Users/rapid/Downloads/Quotes 19-02-13 OFC/Quotes.xcodeproj
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    [req2SearchBar resignFirstResponder];
    
    if([searchText length] > 0)
    {
        search = YES;
        [self search];
        
        NSLog(@"is it >1");
    }
    else
    {
        search = NO;
        [req2SearchBar resignFirstResponder];
        
        tableAry = [[NSMutableArray alloc]initWithArray:tempAry];
        NSLog(@"table array is %@",tableAry);
    }
    [reqListTbl reloadData];
    
}




- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    /* same as search method */
    
    [tableAry removeAllObjects];
    NSString *searchText = req2SearchBar.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if ([searchAry count] > 0)
    {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [reqListTbl reloadData];
    
}

- (void)search
{
    [tableAry removeAllObjects];
    NSString *searchText = req2SearchBar.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if ([searchAry count] > 0)
    {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [reqListTbl reloadData];
}


//touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchObj = [touches anyObject];
    CGPoint pnt = [touchObj locationInView:self.view];
    [questionpkr removeFromSuperview];
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"reqGatheringListResponse"])
    {
        reqStr          = [[NSString alloc] init];
        projectIdStr=[[NSString alloc]init];
        reqFalseString       = [[NSMutableString alloc] init];
        reqSplitAry   = [[NSArray alloc] init];
        reqDataAry    = [[NSArray alloc] init];
        
        reqTypeArray        = [[NSMutableArray alloc] init];
        contactAry  = [[NSMutableArray alloc] init];
        criticialityAry    = [[NSMutableArray alloc] init];
        activityAry         = [[NSMutableArray alloc] init];
        systemAry     = [[NSMutableArray alloc] init];
        projectNameArray=[[NSMutableArray alloc]init];
        reqlistProjectNameStr=[[NSString alloc]init];
        
        assignReqIdAry     = [[NSMutableArray alloc] init];
        isTaskGeneratedAry     = [[NSMutableArray alloc] init];
        coreProcessAry     = [[NSMutableArray alloc] init];
        processAry     = [[NSMutableArray alloc] init];
        subProcessAry     = [[NSMutableArray alloc] init];
        reqDescriptionAry     = [[NSMutableArray alloc] init];
        reqHistoryAry     = [[NSMutableArray alloc] init];
        requirementNameArray=[[NSMutableArray alloc]init];
        
        
        
        //watse  splitting
        soapResults = [[NSMutableString alloc] init];
        songDict = [[NSMutableDictionary alloc] init];
        songsArray = [[NSMutableArray alloc] init];
        noAry = [[NSMutableArray alloc] init];
        
        
        
        pickerAry = [[NSMutableArray alloc] init];
        pickerAry1 = [[NSMutableArray alloc] init];
        picker2 = [[NSMutableArray alloc] init];
        picker3 = [[NSMutableArray alloc] init];
        picker4 = [[NSMutableArray alloc] init];
        pickerarray11=[[NSMutableArray alloc]init];
        newpickerAry = [[NSMutableArray alloc] init];
        newpickerAry1 = [[NSMutableArray alloc] init];
        newpickerAry2 = [[NSMutableArray alloc] init];
        newpickerAry3 = [[NSMutableArray alloc] init];
        newpickerAry4 = [[NSMutableArray alloc] init];
        
        
        
    }
    
    
    else if ([elementName isEqualToString:@"projLstForReqGathResponse"])
    {
        projectliststring       = [[NSString alloc] init];
        Projectlistdataarray    = [[NSArray alloc] init];
        projectlistsplitarray   = [[NSArray alloc] init];
        
        PROJECT_IDArray         = [[NSMutableArray alloc] init];
        PROJECT_NAMEArray       = [[NSMutableArray alloc]init];
        
    }
    
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    if (parser == xmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"/* The List is Empty */" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            //  NSString *chandu = @"*********";
            
            
            //            reqStr= [reqStr stringByAppendingString:chandu];
            //            reqStr= [reqStr stringByAppendingString:string];
            //            //NSLog(@"agenda details are test %@",string);
            //            reqDataAry =[reqStr componentsSeparatedByString:@"*********"];
            
            [soapResults appendString:string];
            
        }
    }
    
    
    else if (parser == xmlParser1)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            projectliststring= [projectliststring stringByAppendingString:chandu];
            projectliststring= [projectliststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            Projectlistdataarray =[projectliststring componentsSeparatedByString:@"*********"];
        }
    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"reqGatheringListResponse"])
        {
            
            
            if(soapResults)
                [songDict setObject:soapResults forKey:elementName];
            soapResults = nil;
            
            NSString *str1 = [songDict objectForKey:@"reqGatheringListResponse"];
            //NSLog(@"Final Songs Array is %@",str1);
            
            NSArray *aArray = [str1 componentsSeparatedByString:@".;"];
            //NSLog(@"The Split array is %@",aArray);
            
            
            for (int i=1; i<[aArray count]; i++)
            {
                
                reqSplitAry =[[aArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                NSLog(@"split  is %@",reqSplitAry);
                
                for (int j=1; j<[reqSplitAry count]; j++)
                {
                    reqTypeStr = [[reqSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"reqType==" withString:@""];
                    
                    contactStr = [[reqSplitAry objectAtIndex:6] stringByReplacingOccurrencesOfString:@"Name==" withString:@""];
                    
                    criticialityStr = [[reqSplitAry objectAtIndex:3] stringByReplacingOccurrencesOfString:@"CRITICALITY==" withString:@""];
                    
                    activityStr = [[reqSplitAry objectAtIndex:5] stringByReplacingOccurrencesOfString:@"ActivityName==" withString:@""];
                    
                    systemStr = [[reqSplitAry objectAtIndex:4] stringByReplacingOccurrencesOfString:@"System==" withString:@""];
                    
                    
                    
                    
                    assignReqIdStr = [[reqSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"AssignReqId==" withString:@""];
                    
                    isTaskGeneratedStr = [[reqSplitAry objectAtIndex:7] stringByReplacingOccurrencesOfString:@"IsTaskGenerated==" withString:@""];
                    
                    coreProcessStr = [[reqSplitAry objectAtIndex:8] stringByReplacingOccurrencesOfString:@"CoreProcess==" withString:@""];
                    
                    processStr = [[reqSplitAry objectAtIndex:9] stringByReplacingOccurrencesOfString:@"Process==" withString:@""];
                    
                    subProcessStr = [[reqSplitAry objectAtIndex:10] stringByReplacingOccurrencesOfString:@"SubProcess==" withString:@""];
                    
                    reqDescriptionStr = [[reqSplitAry objectAtIndex:11] stringByReplacingOccurrencesOfString:@"ReqDescription==" withString:@""];
                    
                    reqHistoryStr = [[reqSplitAry objectAtIndex:12] stringByReplacingOccurrencesOfString:@"ReqHistory==" withString:@""];
                    
                    projectIdStr=[[reqSplitAry objectAtIndex:13]stringByReplacingOccurrencesOfString:@"projectId==" withString:@""];
                    
                    reqlistProjectNameStr=[[reqSplitAry objectAtIndex:14]stringByReplacingOccurrencesOfString:@"projectName==" withString:@""];
                    requirementNameStr=[[reqSplitAry objectAtIndex:15]stringByReplacingOccurrencesOfString:@"requirementName==" withString:@""];
                    
                    reqhstrStr=[reqHistoryStr stringByReplacingOccurrencesOfString:@"  " withString:@"###"];
                    
                    
                }
                [reqTypeArray addObject:reqTypeStr];
                [contactAry addObject:contactStr];
                [criticialityAry addObject:criticialityStr];
                [activityAry addObject:activityStr];
                [systemAry addObject:systemStr];
                [projectIDArray addObject:projectIdStr];
                [projectNameArray addObject:reqlistProjectNameStr];
                [requirementNameArray addObject:requirementNameStr];
                NSLog(@"project array is %@",requirementNameArray);
                
                
                [assignReqIdAry addObject:assignReqIdStr];
                [isTaskGeneratedAry addObject:isTaskGeneratedStr];
                [coreProcessAry addObject:coreProcessStr];
                [processAry addObject:processStr];
                [subProcessAry addObject:subProcessStr];
                [reqDescriptionAry addObject:reqDescriptionStr];
                [reqHistoryAry addObject:reqhstrStr];
                
                
                [pickerarray11 addObject:projectIdStr];
                [pickerAry1 addObject:reqTypeStr];
                [newpickerAry1 addObject:contactStr];
                [newpickerAry2 addObject:criticialityStr];
                [newpickerAry3 addObject:systemStr];
                [newpickerAry4 addObject:activityStr];
                
                tableAry = [[NSMutableArray alloc] init];
                searchAry = [[NSMutableArray alloc] init];
                tempAry = [[NSMutableArray alloc]initWithArray:projectIDArray];
                tableAry = projectIDArray;
                
                projectSearchArray=[[NSMutableArray alloc]init];
                tempArray1=[[NSMutableArray alloc]initWithArray:projectNameArray];
                searchArray1=[[NSMutableArray alloc]init];
                projectSearchArray=projectNameArray;
                
                [reqSearchBtn3 setUserInteractionEnabled:NO];
                
                if ([req1SearchBar.text isEqualToString:pkrProjectIDStr])
                {
                    [self projectLsit];
                }
                if ([req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
                {
                    [self reqType];
                    
                }
                
                else if ([req2SearchBar.text isEqualToString:@"Contact(All)"])
                {
                    [self contact];
                }
                else if ([req2SearchBar.text isEqualToString:@"Criticiality(All)"])
                {
                    [self criticiality];
                }
                else if ([req2SearchBar.text isEqualToString:@"System(All)"])
                {
                    [self system];
                }
                else if ([req2SearchBar.text isEqualToString:@"Activity(All)"])
                {
                    [self activity];
                }
                
            }
            int total=[requirementNameArray count];
            NSString *totaltask=[NSString stringWithFormat:@"%d",total];
            NSLog(@"total count of task created by search is %@",totaltask);
            [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                           title:@"Total Reqirement"];
            NSLog(@"  is %@ ",reqHistoryAry);
            
            [reqListTbl reloadData];
            
        }
        
    }
    
    
    
    if (parser == xmlParser1)
    {
        
        if ([elementName isEqualToString:@"projLstForReqGathResponse"])
        {
            
            for (int i=1; i<[Projectlistdataarray count]; i++)
            {
                
                projectlistsplitarray=[[Projectlistdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[projectlistsplitarray count]; j++)
                {
                    projectidstr = [[projectlistsplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"PROJECT_ID==" withString:@""];
                    projectnamestr  = [[projectlistsplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                }
                
                
                [PROJECT_IDArray addObject:projectidstr];
                [PROJECT_NAMEArray addObject:projectnamestr];
                NSLog(@"split  is %@,%@",PROJECT_IDArray,PROJECT_NAMEArray);
                
                
            }
            
            [PROJECT_NAMEArray insertObject:@"All" atIndex:0];
            
        }
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(![req1SearchBar.text isEqualToString:@"All"]&&[req2SearchBar.text isEqualToString:@""])
    {
        return [requirementTypeTempArray count];
    }
    if(([req1SearchBar.text isEqualToString:@"All"] && [req2SearchBar.text length]>0) &&
        ![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
    {
        return [searchReqtypeArray count];
        NSLog(@"welcome");
    }
    if((![req1SearchBar.text isEqualToString:@"All"] &&![req2SearchBar.text isEqualToString:@"Requirement Type(All)"]))
    {
        return [search1ReqtypeArray  count];
        NSLog(@"welcome1");
    }
    else
    {
        NSLog(@"table array count is 231455%d",[tableAry count]);
        return [reqTypeArray count];
        
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(![req1SearchBar.text isEqualToString:@"All"]&&[req2SearchBar.text isEqualToString:@""])
    {
        
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.contentView.layer setBorderColor:[UIColor greenColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:25];
        nameLbl.text = [requirementTypeTempArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = @"WELCOME";
        
        
        UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
        nameLbl2.font=[UIFont systemFontOfSize:25];
        nameLbl2.text= [ContactTempArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
        nameLbl3.font=[UIFont systemFontOfSize:25];
        nameLbl3.text= [CriticallyTempArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
        nameLbl4.font=[UIFont systemFontOfSize:25];
        nameLbl4.text= [ActivityTempArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
        nameLbl5.font=[UIFont systemFontOfSize:25];
        nameLbl5.text= [SystemTempArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
        nameLbl6.font=[UIFont systemFontOfSize:25];
        nameLbl6.text= [requirementNameTempArray objectAtIndex:indexPath.row];
        
        
        
        
        return cell;
    }
 if(([req1SearchBar.text isEqualToString:@"All"] && [req2SearchBar.text length]>0) &&![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
 {
        
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.contentView.layer setBorderColor:[UIColor greenColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:25];
        nameLbl.text = [searchReqtypeArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = @"WELCOME";
        
        
        UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
        nameLbl2.font=[UIFont systemFontOfSize:25];
        nameLbl2.text= [searchContactArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
        nameLbl3.font=[UIFont systemFontOfSize:25];
        nameLbl3.text= [searchCriticalityArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
        nameLbl4.font=[UIFont systemFontOfSize:25];
        nameLbl4.text= [searchActivityArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
        nameLbl5.font=[UIFont systemFontOfSize:25];
        nameLbl5.text= [searchSystemArray objectAtIndex:indexPath.row];
     
     UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
     nameLbl6.font=[UIFont systemFontOfSize:25];
     nameLbl6.text= [searchRequiremnetNameArray objectAtIndex:indexPath.row];
     
//     int total=[searchRequiremnetNameArray count];
//     NSString *totaltask=[NSString stringWithFormat:@"%d",total];
//     NSLog(@"total count of task created by search is %@",totaltask);
//     [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
//                    title:@"Total Reqirement"];
     
     
        return cell;
    }
    if(![req1SearchBar.text isEqualToString:@"All"]&&![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
   {
        
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.contentView.layer setBorderColor:[UIColor greenColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:25];
        nameLbl.text = [search1ReqtypeArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = @"WELCOME";
        
        
        UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
        nameLbl2.font=[UIFont systemFontOfSize:25];
        nameLbl2.text= [search1ContactArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
        nameLbl3.font=[UIFont systemFontOfSize:25];
        nameLbl3.text= [search1CriticalityArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
        nameLbl4.font=[UIFont systemFontOfSize:25];
        nameLbl4.text= [search1ActivityArray objectAtIndex:indexPath.row];
        
        UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
        nameLbl5.font=[UIFont systemFontOfSize:25];
        nameLbl5.text= [search1SystemArray objectAtIndex:indexPath.row];
       
       UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
       nameLbl6.font=[UIFont systemFontOfSize:25];
       nameLbl6.text= [search1RequiremnetNameArray objectAtIndex:indexPath.row];
       
//       int total=[search1RequiremnetNameArray count];
//       NSString *totaltask=[NSString stringWithFormat:@"%d",total];
//       NSLog(@"total count of task created by search is %@",totaltask);
//       [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
//                      title:@"Total Reqirement"];
       
        
        return cell;
    }

    else
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.contentView.layer setBorderColor:[UIColor greenColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:25];
        nameLbl.text = [reqTypeArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = @"WELCOME";
        
        
        UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
        nameLbl2.font=[UIFont systemFontOfSize:25];
        nameLbl2.text= [contactAry objectAtIndex:indexPath.row];
        
        UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
        nameLbl3.font=[UIFont systemFontOfSize:25];
        nameLbl3.text= [criticialityAry objectAtIndex:indexPath.row];
        
        UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
        nameLbl4.font=[UIFont systemFontOfSize:25];
        nameLbl4.text= [activityAry objectAtIndex:indexPath.row];
        
        UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
        nameLbl5.font=[UIFont systemFontOfSize:25];
        nameLbl5.text= [systemAry objectAtIndex:indexPath.row];
        
        UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
        nameLbl6.font=[UIFont systemFontOfSize:25];
        nameLbl6.text= [requirementNameArray objectAtIndex:indexPath.row];
        
//        int total=[requirementNameArray count];
//        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
//        NSLog(@"total count of task created by search is %@",totaltask);
//        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
//                       title:@"Total Reqirement"];
        
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![req1SearchBar.text isEqualToString:@"All"]&&[req2SearchBar.text isEqualToString:@""])

    {
        createRequirementViewController *createReqView = [[createRequirementViewController alloc]init];
        createReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"createReq"];
        
       
        
        
        createReqView.assignedIdStr = [AssignReqIdTempArray objectAtIndex:indexPath.row];
        createReqView.projectTblStr=[ProejctIDTempAray objectAtIndex:indexPath.row];
        NSLog(@"project tbl id str is %@",[assignReqIdAry objectAtIndex:indexPath.row]);
        createReqView.contactTblStr = [ContactTempArray objectAtIndex:indexPath.row];
        createReqView.coreProcessTblStr = [CoreProcessTempArray objectAtIndex:indexPath.row];
        createReqView.processTblStr = [ProcessTempArray objectAtIndex:indexPath.row];
        createReqView.subProcessTblStr = [SubProcessTempArray objectAtIndex:indexPath.row];
        createReqView.activityTblStr = [ActivityTempArray objectAtIndex:indexPath.row];
        createReqView.reqDesTblStr = [ReqDescriptionTempArray objectAtIndex:indexPath.row];
        createReqView.reqHistoryTblStr = [ReqHistoryTempArray objectAtIndex:indexPath.row];
        createReqView.reqTypeTblStr = [requirementTypeTempArray objectAtIndex:indexPath.row];
        createReqView.criticialityTblStr = [CriticallyTempArray objectAtIndex:indexPath.row];
        createReqView.systemTblStr = [SystemTempArray objectAtIndex:indexPath.row];
        createReqView.requiremnetNamestr=[requirementNameTempArray objectAtIndex:indexPath.row];
        
         [self.navigationController pushViewController:createReqView animated:YES];
        

    }
  else if(([req1SearchBar.text isEqualToString:@"All"] && [req2SearchBar.text length]>0) &&![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
     {
         createRequirementViewController *createReqView = [[createRequirementViewController alloc]init];
         createReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"createReq"];
         
        
         
         
         createReqView.assignedIdStr = [searchassignedIDArray objectAtIndex:indexPath.row];
         createReqView.projectTblStr=[searchProjectIDArray objectAtIndex:indexPath.row];
         NSLog(@"project tbl id str is %@",[assignReqIdAry objectAtIndex:indexPath.row]);
         createReqView.contactTblStr = [searchContactArray objectAtIndex:indexPath.row];
         createReqView.coreProcessTblStr = [searchCoreprocessArray objectAtIndex:indexPath.row];
         createReqView.processTblStr = [searchProcessArray objectAtIndex:indexPath.row];
         createReqView.subProcessTblStr = [searchSubprocessArray objectAtIndex:indexPath.row];
         createReqView.activityTblStr = [searchActivityArray objectAtIndex:indexPath.row];
         createReqView.reqDesTblStr = [searchreqdescriptionArray objectAtIndex:indexPath.row];
         createReqView.reqHistoryTblStr = [searchReqHistoryArray objectAtIndex:indexPath.row];
         createReqView.reqTypeTblStr = [searchReqtypeArray objectAtIndex:indexPath.row];
         createReqView.criticialityTblStr = [searchCriticalityArray objectAtIndex:indexPath.row];
         createReqView.systemTblStr = [searchSystemArray objectAtIndex:indexPath.row];
         createReqView.requiremnetNamestr=[searchRequiremnetNameArray objectAtIndex:indexPath.row];
          [self.navigationController pushViewController:createReqView animated:YES];
         
 
     }
else if(![req1SearchBar.text isEqualToString:@"All"]&&![req2SearchBar.text isEqualToString:@"Requirement Type(All)"])
     {
         createRequirementViewController *createReqView = [[createRequirementViewController alloc]init];
         createReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"createReq"];
         
        
         
         
         createReqView.assignedIdStr = [search1assignedIDArray objectAtIndex:indexPath.row];
         createReqView.projectTblStr=[search1ProjectIDArray objectAtIndex:indexPath.row];
         NSLog(@"project tbl id str is %@",[assignReqIdAry objectAtIndex:indexPath.row]);
         createReqView.contactTblStr = [search1ContactArray objectAtIndex:indexPath.row];
         createReqView.coreProcessTblStr = [search1CoreprocessArray objectAtIndex:indexPath.row];
         createReqView.processTblStr = [search1ProcessArray objectAtIndex:indexPath.row];
         createReqView.subProcessTblStr = [search1SubprocessArray objectAtIndex:indexPath.row];
         createReqView.activityTblStr = [search1ActivityArray objectAtIndex:indexPath.row];
         createReqView.reqDesTblStr = [search1reqdescriptionArray objectAtIndex:indexPath.row];
         createReqView.reqHistoryTblStr = [search1ReqHistoryArray objectAtIndex:indexPath.row];
         createReqView.reqTypeTblStr = [search1ReqtypeArray objectAtIndex:indexPath.row];
         createReqView.criticialityTblStr = [search1CriticalityArray objectAtIndex:indexPath.row];
         createReqView.systemTblStr = [search1SystemArray objectAtIndex:indexPath.row];
         createReqView.requiremnetNamestr=[search1RequiremnetNameArray objectAtIndex:indexPath.row];
          [self.navigationController pushViewController:createReqView animated:YES];
     }
    else
    {
    
    createRequirementViewController *createReqView = [[createRequirementViewController alloc]init];
    createReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"createReq"];
    
        
    
    createReqView.assignedIdStr = [assignReqIdAry objectAtIndex:indexPath.row];
    createReqView.projectTblStr=[projectIDArray objectAtIndex:indexPath.row];
    NSLog(@"project tbl id str is %@",[assignReqIdAry objectAtIndex:indexPath.row]);
    createReqView.contactTblStr = [contactAry objectAtIndex:indexPath.row];
    createReqView.coreProcessTblStr = [coreProcessAry objectAtIndex:indexPath.row];
    createReqView.processTblStr = [processAry objectAtIndex:indexPath.row];
    createReqView.subProcessTblStr = [subProcessAry objectAtIndex:indexPath.row];
    createReqView.activityTblStr = [activityAry objectAtIndex:indexPath.row];
    createReqView.reqDesTblStr = [reqDescriptionAry objectAtIndex:indexPath.row];
    createReqView.reqHistoryTblStr = [reqHistoryAry objectAtIndex:indexPath.row];
    createReqView.reqTypeTblStr = [reqTypeArray objectAtIndex:indexPath.row];
    createReqView.criticialityTblStr = [criticialityAry objectAtIndex:indexPath.row];
    createReqView.systemTblStr = [systemAry objectAtIndex:indexPath.row];
        createReqView.requiremnetNamestr=[requirementNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:createReqView animated:YES];

    }
    
}


//Delegate Method
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
