//
//  resolutionIssueViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 28/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "resolutionIssueViewController.h"

@interface resolutionIssueViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation resolutionIssueViewController
@synthesize projectIDStr,issueIdStr,escalatedToTblStr,releaseImpactTblStr,dateResolutionNeededByTblStr,rejectReasonTblStr,resolutionTypeTblStr,dateResolvedTblStr,dateClosedTblStr,resolutionDtlsTblStr;

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
    //Tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    [self.view addGestureRecognizer:tapGesture];
    
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
    
    

    

    
    NSLog(@"the id is %@",projectIDStr);
    NSLog(@"the id is %@",issueIdStr);
    

    NSLog(@"the id is %@",escalatedToTblStr);
    NSLog(@"the id is %@",releaseImpactTblStr);
    NSLog(@"the id is %@",dateResolutionNeededByTblStr);
    NSLog(@"the id is %@",rejectReasonTblStr);
    NSLog(@"the id is %@",resolutionTypeTblStr);
    NSLog(@"the id is %@",dateResolvedTblStr);
    NSLog(@"the id is %@",dateClosedTblStr);
    NSLog(@"the id is %@",resolutionDtlsTblStr);


    NSLog(@"SubString to is %@",dateResolvedTblStr);

    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    //-------------------Right side pop Buttons---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createIssueBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,createTimeSheetActionBarBtn,nil];

    
    [self assigntoSpinner];
    [self releaseImpactSpinner];
    [self rejectReasonSpinner];
    [self resolutionTypeSpinner];
    

    escalatedToTfd.text = escalatedToTblStr;
    releaseImpactTfd.text = releaseImpactTblStr;
    rejectReasonTfd.text = rejectReasonTblStr;
    resolutionTypeTfd.text = resolutionTypeTblStr;
    resolutionDescriptionTfd.text = resolutionDtlsTblStr;
    dateResolvedTfd.text=dateResolvedTblStr;
    dateClosedTfd.text=dateClosedTblStr;
    drnbTfd.text=dateResolutionNeededByTblStr;
    
    
    if ([escalatedToTblStr isEqualToString:@"null"]) {
        escalatedToTfd.text = nil;
    }

     if ([releaseImpactTblStr isEqualToString:@"null"]) {
        releaseImpactTfd.text = nil;
    }
     if ([dateResolutionNeededByTblStr isEqualToString:@"null"])
     {
        drnbTfd.text = nil;
    }
     else{
         dateResolutionNeededByTblStr = [dateResolutionNeededByTblStr substringToIndex:10];
         drnbTfd.text = dateResolutionNeededByTblStr;

     }
     if ([rejectReasonTblStr isEqualToString:@"null"]) {
        rejectReasonTfd.text = nil;
    }
     if ([resolutionTypeTblStr isEqualToString:@"null"]) {
        resolutionTypeTfd.text = nil;
    }
     if ([dateResolvedTblStr isEqualToString:@"null"]) {
        dateResolvedTfd.text = nil;
    }
     else{
         dateResolvedTblStr = [dateResolvedTblStr substringToIndex:10];
         dateResolvedTfd.text = dateResolvedTblStr;

     }
    
     if ([dateClosedTblStr isEqualToString:@"null"]) {
        dateClosedTfd.text = nil;
    }
     else{
         dateClosedTblStr = [dateClosedTblStr substringToIndex:10];
         dateClosedTfd.text = dateClosedTblStr;

     }
     if ([resolutionDtlsTblStr isEqualToString:@"null"])
     {
        resolutionDescriptionTfd.text = nil;
    }
    
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
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardhidden) name:UIKeyboardDidHideNotification object:Nil];
    
    [super viewWillAppear:animated];
}
-(void)keyboardhidden
{
    [resolutionDescriptionTfd resignFirstResponder];

    
}

-(void)assigntoSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    //NSDictionary *credentials2 = @{@"projectId":@"30"};
    NSDictionary *credentials2 = @{@"projectId":projectIDStr};

    [Servicecall resolutionAssignTo:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
    
}
-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    
}
-(void)releaseImpactSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
   // NSDictionary *credentials2 = @{@"orgId":OrgIdStr,@"prjctId":@"30"};
    NSDictionary *credentials2 = @{@"orgId":OrgIdStr};

    [Servicecall resolutionReleaseImpact:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
}
-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];

}
-(void)rejectReasonSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
   // NSDictionary *credentials2 = @{@"orgId":OrgIdStr,@"prjctId":@"30"};
    NSDictionary *credentials2 = @{@"orgId":OrgIdStr};

    [Servicecall resolutionRejectReason:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
    
}
-(void)didNotesCountFinished :(id)Notescountlist
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];

}
-(void)resolutionTypeSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
   // NSDictionary *credentials2 = @{@"orgId":OrgIdStr,@"prjctId":@"30"};
    NSDictionary *credentials2 = @{@"orgId":OrgIdStr};

    [Servicecall resolutionResolutionType:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
}
-(void)Serviceactiondone : (id)result
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
}

-(void)upDateService
{
    
    if ( ([escalatedToTfd.text length] == 0) || ([releaseImpactTfd.text length] == 0) || ([drnbTfd.text length] == 0)||([rejectReasonTfd.text length] == 0) ||([resolutionTypeTfd.text length] == 0)||([dateResolvedTfd.text length] == 0)||([dateClosedTfd.text length] == 0)|| ([resolutionDescriptionTfd.text length] == 0)  )
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Issue Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
       
    }
    
    else if ([Useridstr isEqualToString:selectEscalateIdStr])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You can't escalte to already assigned resources" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
    }
    else
    {
    
    NSLog(@"escalted to text field text is %@",escalatedToTfd.text);
        NSLog(@"the escalted str is %@",selectEscalateIdStr);
        NSLog(@"selectreleaseimpact %@",selectReleaseImpactIdStr);
         NSLog(@"selectreleaseimpact %@",selectResolutionIdStr);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"SaveAndUpdateTaskService";
    NSDictionary *credentials2 = @{@"escalatedToResrc":selectEscalateIdStr,@"releaseImpact":selectReleaseImpactIdStr,@"dateResolutionNededBy":drnbTfd.text,@"rejctRsn":selectRejectIdStr,@"resolutionTyp":selectResolutionIdStr,@"dateRslvd":dateResolvedTfd.text,@"dateClsd":dateClosedTfd.text,@"resolutionDtls":resolutionTypeTfd.text,@"issueId":issueIdStr};
//    NSDictionary *credentials2 = @{@"escalatedToResrc":selectEscalateIdStr,@"releaseImpact":releaseImpactTfd.text,@"dateResolutionNededBy":drnbTfd.text,@"rejctRsn":rejectReasonTfd.text,@"dupIssueIdRef":@"nodata",@"resolutionTyp":resolutionTypeTfd.text,@"dateRslvd":dateResolvedTfd.text,@"dateClsd":dateClosedTfd.text,@"resolutionDtls":resolutionDescriptionTfd.text,@"issueId":issueIdStr};

    [Servicecall resolutionUpdate:projectLstForTask ParticipantsListParameters:credentials2];
    [Servicecall setDelegate:self];
        
    }
}

-(void)Serviceactiondone1 : (id)result
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:result];
    xmlParser4.delegate = self;
    [xmlParser4 parse];
}
-(void)createIssueBtnClk
{
    createIssueViewController *createIssueView = [[createIssueViewController alloc]init];
    createIssueView = [self.storyboard instantiateViewControllerWithIdentifier:@"createIssue"];
    [self.navigationController pushViewController:createIssueView animated:YES];
}
-(void)homeBtnClk
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)logOutBtnClk
{
    UIAlertView *logOutAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [logOutAlertView show];
}
-(IBAction)escalatedToBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 69, self.view.frame.size.width-378, 300)];//390
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [resolutionBackView addSubview:questionpkr];

}
-(IBAction)releaseImapctBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 159, self.view.frame.size.width-378, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [resolutionBackView addSubview:questionpkr];

}
-(IBAction)drnbBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    
    datePkr = [[UIDatePicker alloc] initWithFrame:CGRectMake(260, 275, self.view.frame.size.width-378, 300)];
    [datePkr addTarget:self action:@selector(pickerChanged1:) forControlEvents:UIControlEventValueChanged];
    datePkr.tag = 100;
    datePkr.backgroundColor=[UIColor whiteColor];
    datePkr.datePickerMode = UIDatePickerModeDate;
    datePkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:datePkr];
    [resolutionBackView addSubview:datePkr];

    
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"%@",currentDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [datePkr setMinimumDate:currentDate];
    

}

-(IBAction)rejectReasonBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 374, self.view.frame.size.width-378, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 102;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [resolutionBackView addSubview:questionpkr];

}
-(IBAction)resolutionTypeBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 466, self.view.frame.size.width-378, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 103;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [self.view addSubview:questionpkr];

}
-(IBAction)dataResolvedBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    
    datePkr = [[UIDatePicker alloc] initWithFrame:CGRectMake(260, 566, self.view.frame.size.width-378, 300)];
    [datePkr addTarget:self action:@selector(pickerChanged1:) forControlEvents:UIControlEventValueChanged];
    datePkr.tag = 101;
    datePkr.backgroundColor=[UIColor whiteColor];
    datePkr.datePickerMode = UIDatePickerModeDate;
    datePkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:datePkr];
    [resolutionBackView addSubview:datePkr];

    
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"%@",currentDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [datePkr setMinimumDate:currentDate];
}
-(IBAction)dateClosedBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    
    datePkr = [[UIDatePicker alloc] initWithFrame:CGRectMake(260, 652, self.view.frame.size.width-378, 300)];
    [datePkr addTarget:self action:@selector(pickerChanged1:) forControlEvents:UIControlEventValueChanged];
    datePkr.tag = 102;
    datePkr.backgroundColor=[UIColor whiteColor];
    datePkr.datePickerMode = UIDatePickerModeDate;
    datePkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:datePkr];
    [resolutionBackView addSubview:datePkr];

    
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"%@",currentDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [datePkr setMinimumDate:currentDate];
}

-(IBAction)resolutionUpdateBtnClk:(id)sender
{
    [self upDateService];
    
}
-(IBAction)resolutionHomeBtnClk:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



//parsing Deligate methods

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser == xmlParser)
    {
        if ([elementName isEqualToString:@"assignResFrIsses1Response"])
        {
            taskDetailsstr1        = [[NSString alloc] init];
            taskdataarray1   = [[NSArray alloc]init];
            resourceIdArray   = [[NSMutableArray alloc]init];
            resourceNameArray  = [[NSMutableArray alloc]init];
        }
    }
    
    else if (parser == xmlParser1)
        
    {
        if ([elementName isEqualToString:@"releseImpactListResponse"])
        {
            taskDetailsstr2        = [[NSString alloc] init];
            taskdataarray2   = [[NSArray alloc]init];
            statusIdArray =  [[NSMutableArray alloc]init];
            StatusNameArray   = [[NSMutableArray alloc]init];

        }
    }
    
    else if (parser == xmlParser2)
    {
        if ([elementName isEqualToString:@"rejctReasonListResponse"])
        {
            taskDetailsstr3  = [[NSString alloc] init];
            taskdataarray3   = [[NSArray alloc]init];
            rejectstatusIdAry   = [[NSMutableArray alloc]init];
            rejectStatusNameAry   = [[NSMutableArray alloc]init];
            
        }
        
    }
    else if (parser == xmlParser3)
    {
        if ([elementName isEqualToString:@"resolutionTypeListResponse"])
        {
            taskDetailsstr4  = [[NSString alloc] init];
            taskdataarray4   = [[NSArray alloc]init];
            resolutionTypeStatusIdAry = [[NSMutableArray alloc]init];
            resolutionTypeStatusNameAry   = [[NSMutableArray alloc]init];
            
        }
        
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
            taskDetailsstr1 = [taskDetailsstr1 stringByAppendingString:chandu];
            taskDetailsstr1= [taskDetailsstr1 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",taskDetailsstr1);
            taskdataarray1 =[taskDetailsstr1 componentsSeparatedByString:@"*********"];
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
            taskDetailsstr2= [taskDetailsstr2 stringByAppendingString:chandu];
            taskDetailsstr2= [taskDetailsstr2 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",taskDetailsstr2);
            taskdataarray2 =[taskDetailsstr2 componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == xmlParser2)
    {
        if ([string isEqualToString:@"Flase"])
        {
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            taskDetailsstr3= [taskDetailsstr3 stringByAppendingString:chandu];
            taskDetailsstr3= [taskDetailsstr3 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",taskDetailsstr3);
            taskdataarray3 =[taskDetailsstr3 componentsSeparatedByString:@"*********"];
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
            taskDetailsstr4 = [taskDetailsstr4 stringByAppendingString:chandu];
            taskDetailsstr4 = [taskDetailsstr4 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",taskDetailsstr4);
            taskdataarray4 =[taskDetailsstr4 componentsSeparatedByString:@"*********"];
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
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];

        }
    }
   
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
    {
        if ([elementName isEqualToString:@"assignResFrIsses1Response"])
            
        {
            for (int i=1; i<[taskdataarray1 count]; i++)
            {
                
                tasksplitArray1 = [[taskdataarray1 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[tasksplitArray1 count]; j++)
                {
                    resourceIdStr = [[tasksplitArray1 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ResourceId==" withString:@""];
                    
                    resourceNameStr = [[tasksplitArray1 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""];
                    
                }
                
                [resourceIdArray addObject:resourceIdStr];
                [resourceNameArray addObject:resourceNameStr];
                NSLog(@"project name is %@ %@",resourceIdArray,resourceNameArray);
                
                
                
                NSString *tempString = escalatedToTblStr;
                for(int i=0; i<[resourceNameArray count]; i++)
                {
                    if([tempString isEqualToString:[resourceNameArray objectAtIndex:i]])
                    {
                        
                        selectEscalateIdStr = [resourceIdArray objectAtIndex:i];

                        
                    }
                }

                
                
          }

        }
    }
    
    
    if (parser == xmlParser1)
    {
        if ([elementName isEqualToString:@"releseImpactListResponse"])
            
        {
            for (int i=1; i<[taskdataarray2 count]; i++)
            {
                
                tasksplitArray2 = [[taskdataarray2 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[tasksplitArray2 count]; j++)
                {
                    statusIdStr = [[tasksplitArray2 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"STATUS_ID==" withString:@""];
                    
                    StatusNameStr = [[tasksplitArray2 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"STATUS_NAME==" withString:@""];
                    
                }
                
                [statusIdArray addObject:statusIdStr];
                [StatusNameArray addObject:StatusNameStr];
                NSLog(@"project name is %@ %@",statusIdArray,StatusNameArray);
                
                
                NSString *tempString = releaseImpactTblStr;
                for(int i=0; i<[statusIdArray count];i++)
                {
                    if([tempString isEqualToString:[StatusNameArray objectAtIndex:i]])
                    {
                        
                        selectReleaseImpactIdStr = [StatusNameArray objectAtIndex:i];
                        releaseImpactTfd.text=selectReleaseImpactIdStr;
                        NSLog(@"selectRelease impact id is %@",selectReleaseImpactIdStr);
                        
                        
                    }
                }
                
                //
                //                }
                //
                //                else if (pickerView.tag==102) {
                //                    rejectReasonTfd.text = [rejectStatusNameAry objectAtIndex:row];
                //                    selectRejectIdStr = [rejectstatusIdAry objectAtIndex:row];
                //
                //                }
                //
                //                else if (pickerView.tag==103) {
                //                    resolutionTypeTfd.text = [resolutionTypeStatusNameAry objectAtIndex:row];
                //                    selectResolutionIdStr = [resolutionTypeStatusIdAry objectAtIndex:row];
                //                    
                //                }
                
            }

        }
        
    }
    
    if (parser == xmlParser2)
    {
        if ([elementName isEqualToString:@"rejctReasonListResponse"])
            
        {
            for (int i=1; i<[taskdataarray3 count]; i++)
            {
                
                tasksplitArray3 = [[taskdataarray3 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[tasksplitArray3 count]; j++)
                {
                    rejectstatusIdStr = [[tasksplitArray3 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"STATUS_ID==" withString:@""];
                    
                    rejectStatusNameStr = [[tasksplitArray3 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"STATUS_NAME==" withString:@""];
                    
                }
                
                [rejectstatusIdAry addObject:rejectstatusIdStr];
                [rejectStatusNameAry addObject:rejectStatusNameStr];
                NSLog(@"project name is %@ %@",rejectstatusIdAry,rejectStatusNameAry);
                
                
                NSString *tempString = rejectReasonTblStr;
                for(int i=0; i<[rejectstatusIdAry count];i++)
                {
                    if([tempString isEqualToString:[rejectStatusNameAry objectAtIndex:i]])
                    {
                        
                        selectRejectIdStr = [rejectStatusNameAry objectAtIndex:i];
                        rejectReasonTfd.text=selectRejectIdStr;
                        NSLog(@"selectRelease impact id is %@",selectReleaseImpactIdStr);
                        
                        
                    }
                }
               

                
            }
        }
            
    }
    
    if (parser == xmlParser3)
    {
        if ([elementName isEqualToString:@"resolutionTypeListResponse"])
            
        {
            for (int i=1; i<[taskdataarray4 count]; i++)
            {
                
                tasksplitArray4 = [[taskdataarray4 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[tasksplitArray4 count]; j++)
                {
                    resolutionTypeStatusIdStr = [[tasksplitArray4 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"STATUS_ID==" withString:@""];
                    
                    resolutionTypeStatusNameStr = [[tasksplitArray4 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"STATUS_NAME==" withString:@""];
                    
                }
                
                [resolutionTypeStatusIdAry addObject:resolutionTypeStatusIdStr];
                [resolutionTypeStatusNameAry addObject:resolutionTypeStatusNameStr];
                NSLog(@"project name is %@ %@",resolutionTypeStatusIdAry,resolutionTypeStatusNameAry);
                
                
                NSString *tempString = resolutionTypeTblStr;
                for(int i=0; i<[resolutionTypeStatusIdAry count];i++)
                {
                    if([tempString isEqualToString:[resolutionTypeStatusNameAry objectAtIndex:i]])
                    {
                        
                        selectResolutionIdStr = [resolutionTypeStatusNameAry objectAtIndex:i];
                        resolutionTypeTfd.text=selectResolutionIdStr;
                        NSLog(@"selectRelease impact id is %@",selectReleaseImpactIdStr);
                        
                        
                    }
                }
                
                
               

                
                
            }

        }
        
    }

    
}





//picker Deligate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [resourceNameArray count];
    }
    else if (picker.tag==101) {
        return [StatusNameArray count];
    }
    else if(picker.tag == 102)
    {
        return [rejectStatusNameAry count];
        
    }
    else if(picker.tag == 103)
    {
        return [resolutionTypeStatusNameAry count];
        
    }

    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [resourceNameArray objectAtIndex:row];
    }
    else if (picker.tag==101) {
        return [StatusNameArray objectAtIndex:row];
    }
    else if (picker.tag==102) {
        return [rejectStatusNameAry objectAtIndex:row];
    }
    else if (picker.tag==103) {
        return [resolutionTypeStatusNameAry objectAtIndex:row];
    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100) {
        escalatedToTfd.text = [resourceNameArray objectAtIndex:row];
        selectEscalateIdStr = [resourceIdArray objectAtIndex:row];
       
        
    }
    else if (pickerView.tag==101) {
        releaseImpactTfd.text = [StatusNameArray objectAtIndex:row];
        selectReleaseImpactIdStr = [statusIdArray objectAtIndex:row];

    }
    
    else if (pickerView.tag==102)
    {
        rejectReasonTfd.text = [rejectStatusNameAry objectAtIndex:row];
        selectRejectIdStr = [rejectstatusIdAry objectAtIndex:row];

    }
    
    else if (pickerView.tag==103)
    {
        resolutionTypeTfd.text = [resolutionTypeStatusNameAry objectAtIndex:row];
        selectResolutionIdStr = [resolutionTypeStatusIdAry objectAtIndex:row];

    }

    
    
    
}


//Date Picker Method
- (void)pickerChanged1:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    
    NSDate *selectedDate = datePkr.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    if (datePkr.tag == 100)
    {
        drnbTfd.text = [formatter stringFromDate:selectedDate];
        
    }
    else if (datePkr.tag == 101)
    {
        dateResolvedTfd.text = [formatter stringFromDate:selectedDate];
        
    }
    else if (datePkr.tag == 102)
    {
        dateClosedTfd.text = [formatter stringFromDate:selectedDate];
        
    }
}


//Aler View Deligate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
        
    }
    else if(buttonIndex == 1){
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

//Touches
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touchObj = [touches anyObject];
//    CGPoint pnt = [touchObj locationInView:self.view];
//    [questionpkr removeFromSuperview];
//    [datePkr removeFromSuperview];
//    [resolutionDescriptionTfd resignFirstResponder];
//
//}

-(void)userTapped
{
    
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    [resolutionDescriptionTfd resignFirstResponder];

    
}
//TextField Deligate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [resolutionDescriptionTfd resignFirstResponder];
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
     if (textField == resolutionDescriptionTfd )
     {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y =frame.origin.y -180;
        [self.view setFrame:frame];
        [UIView commitAnimations];
         
    }
    
 
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [resolutionDescriptionTfd resignFirstResponder];
     if (textField == resolutionDescriptionTfd )
     {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y = frame.origin.y + 180;
        [self.view setFrame:frame];
        [UIView commitAnimations];
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
