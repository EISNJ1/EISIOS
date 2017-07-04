//
//  createRequirementViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 03/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "createRequirementViewController.h"

@interface createRequirementViewController ()


@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation createRequirementViewController
@synthesize projectTblStr,contactTblStr,coreProcessTblStr,processTblStr,subProcessTblStr,activityTblStr,reqDesTblStr,reqHistoryTblStr,reqTypeTblStr,criticialityTblStr,systemTblStr,assignedIdStr,requiremnetNamestr;

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
    [headingLabel setText:@"Save Requirement"];
    
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setObject:@"kumar" forKey:@"NewBtnValidation"];
    [defaults1 synchronize];
    
    //Tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture setCancelsTouchesInView:YES];

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
    
    
    
    
    [updateBtn setHidden:YES];
    [saveBtn setHidden:NO];
    
    
    //----------------view back ground stroke--------------------//
    createReqView.layer.cornerRadius = createReqView.frame.size.width / 2;
    createReqView.clipsToBounds = YES;
    createReqView.layer.borderWidth = 3.0f;
    createReqView.layer.borderColor = [UIColor greenColor].CGColor;
    createReqView.layer.cornerRadius = 10.0f;
    createReqView.layer.cornerRadius=4;
    
    reqDesTxtView.layer.cornerRadius = reqDesTxtView.frame.size.width / 2;
    reqDesTxtView.clipsToBounds = YES;
    reqDesTxtView.layer.borderWidth = 3.0f;
    reqDesTxtView.layer.borderColor = [UIColor greenColor].CGColor;
    reqDesTxtView.layer.cornerRadius = 10.0f;
    reqDesTxtView.layer.cornerRadius=4;

    reqHistoryTxtView.layer.cornerRadius = reqHistoryTxtView.frame.size.width / 2;
    reqHistoryTxtView.clipsToBounds = YES;
    reqHistoryTxtView.layer.borderWidth = 3.0f;
    reqHistoryTxtView.layer.borderColor = [UIColor greenColor].CGColor;
    reqHistoryTxtView.layer.cornerRadius = 10.0f;
    reqHistoryTxtView.layer.cornerRadius=4;

    
    //-------------------Right side pop Button---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk1)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];

    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    
    
    
    [reqHistoryTxtView setUserInteractionEnabled:NO];

   
        //projectTfd.text = projectTblStr;
        NSLog(@"project tablestr is %@",projectTfd.text);
        contactTfd.text = contactTblStr;
        coreProcessTfd.text = coreProcessTblStr;
        processTfd.text = processTblStr;
        subProcessTfd.text = subProcessTblStr;
        activityTfd.text = activityTblStr;
    
        //reqDesTxtView.text = reqDesTblStr;
    
    
        //reqHistoryTxtView.text = reqHistoryTblStr;
    
    historyStr= [self convertHTML:reqHistoryTblStr];
    
    NSLog(@"welcome to eisssss %@",reqHistoryTblStr);
    
        //reqDesTxtView.text = [reqDesTblStr stringByConvertingHTMLToPlainText];
       // reqHistoryTxtView.text = [reqHistoryTblStr stringByConvertingHTMLToPlainText];
    
    NSString *One=reqHistoryTxtView.text;
  //NSString *one1=[One stringByReplacingOccurrencesOfString:@"" withString:@"###"];
    //historyStr=[One stringByReplacingOccurrencesOfString:@"::" withString:@"###"];
    
    NSLog(@"reqhistory text view is %@",historyStr);
    [self convertHTML:historyStr];
    //reqHistoryTxtView.text=historyStr;

        reqTypeTfd.text = reqTypeTblStr;
        criticalityTfd.text = criticialityTblStr;
        systemTfd.text = systemTblStr;
        requiremnetNameTxtFld.text=requiremnetNamestr;

    [self projectSpinnerService];
    //[self contactSpinnerService];
    [self coreProcessSpinnerService];
    //[self processSpinnerService];
    //[self subProcessSpinner];
    //[self activitySpinner];
    [self typeSpinner];
    [self Criticality1Spinner];
    [self Criticality2Spinner];

    
    if ([projectTblStr length]>0)
    {
        [saveBtn setHidden:YES];
        [updateBtn setHidden:NO];
        //asisReqIdStr = asisReqIdStr;
        [headingLabel setText:@"Update Requirement"];
        NSLog(@"assigned id str is %@",assignedIdStr);
       
    }
    else
    {
        [headingLabel setText:@"Save Requirement"];
        //asisReqIdStr=@"0";
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    //Getting data
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    NSString *newBtnValidtionString = [defaults2 objectForKey:@"NewBtnValidation"];
    if ([newBtnValidtionString isEqualToString:@"anjan"])
    {
        [self createTimeetActionBtnClk1];
    }
    

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

-(void)createTimeetActionBtnClk1
{
    projectTfd.text = nil;
    contactTfd.text = nil;
    coreProcessTfd.text = nil;
    processTfd.text = nil;
    subProcessTfd.text = nil;
    activityTfd.text = nil;
    reqDesTxtView.text = nil;
    reqHistoryTxtView.text = nil;
    reqTypeTfd.text = nil;
    criticalityTfd.text = nil;
    systemTfd.text = nil;
    
    projectTblStr = nil;
    contactTblStr = nil;
    coreProcessTblStr = nil;
    processTblStr = nil;
    subProcessTblStr= nil;
    activityTblStr = nil;
    reqDesTblStr = nil;
    reqHistoryTblStr = nil;
    reqTypeTblStr = nil;
    criticialityTblStr = nil;
    systemTblStr = nil;
    
    //add extra variable
    asisReqIdStr = nil;
    //add
    
    [self projectSpinnerService];
    //[self contactSpinnerService];
    [self coreProcessSpinnerService];
    //[self processSpinnerService];
    //[self subProcessSpinner];
    //[self activitySpinner];
    [self typeSpinner];
    [self Criticality1Spinner];
    [self Criticality2Spinner];
    
    [saveBtn setHidden:NO];
    [updateBtn setHidden:YES];
    
        

}
- (void)viewDidLayoutSubviews
{
    //_scrollView.contentSize = CGSizeMake(320, 1000);
}


-(IBAction)projectBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 60, self.view.frame.size.width-314, 300)];//454
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];


}
-(IBAction)contactBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 115, self.view.frame.size.width-314, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}
-(IBAction)coreProcessBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 170, self.view.frame.size.width-314, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 102;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

    
}
-(IBAction)processBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 223, self.view.frame.size.width-314, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 103;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}
-(IBAction)subProcessBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 280, self.view.frame.size.width-314, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 104;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];//createReqView

}
-(IBAction)activityBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 345, self.view.frame.size.width-314, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 105;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}
-(IBAction)reqTypeBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 680, self.view.frame.size.width-314, 150)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 106;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}
-(IBAction)criticialityBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 740, self.view.frame.size.width-314, 150)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 107;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}
-(IBAction)systemBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];

    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(183, 700, self.view.frame.size.width-314, 150)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 108;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createReqView addSubview:questionpkr];

}


-(IBAction)saveBtn:(id)sender
{
    if ( ([projectTfd.text length] == 0) || ([contactTfd.text length] == 0) || ([coreProcessTfd.text length] == 0)||([processTfd.text length] == 0) ||([subProcessTfd.text length] == 0)||([activityTfd.text length] == 0)||([reqDesTxtView.text length] == 0)|| /*([reqHistoryTxtView.text length] == 0)||*/ ([reqTypeTfd.text length] == 0) || ([criticalityTfd.text length] == 0)|| ([systemTfd.text length] == 0) ||([requiremnetNameTxtFld.text length]==0))
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Requirement Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
        
    }
    else{

    [self saveService];
    }
}
-(IBAction)upDateBtnClk:(id)sender
{
    if ( ([projectTfd.text length] == 0) || ([contactTfd.text length] == 0) ||([contactTfd.text isEqualToString:@"null"]) || ([coreProcessTfd.text length] == 0)||([processTfd.text length] == 0) ||([subProcessTfd.text length] == 0)||([activityTfd.text length] == 0)|| /*([reqHistoryTxtView.text length] == 0)||*/ ([reqTypeTfd.text length] == 0) || ([criticalityTfd.text length] == 0)|| ([systemTfd.text length] == 0) ||([requiremnetNameTxtFld.text length] == 0))
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Update the Requirement Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
        
    }
    else{
       

    [self upDateService];
    }
}

-(IBAction)ObjectBtnClk:(id)sender
{
    
    if ([assignedIdStr length] == 0)
    {
        NSLog(@"error");
        
    }
    else
    {
        NSLog(@"assigned req id is %@",assignedIdStr);
    requirementObjectViewController *objReqView = [[requirementObjectViewController alloc]init];
    objReqView = [self.storyboard instantiateViewControllerWithIdentifier:@"reqObjectView"];
    objReqView.getAssignReqIdStr = assignedIdStr;
    objReqView.ProjectIdStr2=pkrProjectIDStr;
    [self.navigationController pushViewController:objReqView animated:YES];
    }
}

-(IBAction)homeBtnClk:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)projectSpinnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr};
    [Servicecall reqProjectSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

}
-(void)contactSpinnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"projectId":pkrProjectIDStr};
    [Servicecall reqContactSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}
-(void)coreProcessSpinnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"orgId":OrgIdStr};
    [Servicecall reqCoreProcessSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}
-(void)processSpinnerService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"coreProcessId":pkrCoreProcessIDStr};
    [Servicecall reqProcessSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

    
}
-(void)subProcessSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"processId":pkrprocessIDStr};
    [Servicecall reqSubProcessSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)activitySpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"subProcessId":pkrSubProcessIDStr};
    [Servicecall reqActivitySpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)typeSpinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"orgId":OrgIdStr};
    [Servicecall reqTypeSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(void)Criticality1Spinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"orgId":OrgIdStr};
    [Servicecall reqCriticality1Spinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

    
}
-(void)Criticality2Spinner
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"orgId":OrgIdStr};
    [Servicecall reqCriticality2Spinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)saveService
{
    NSDate *aDate = [NSDate date];
    //converting Date to String
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr  = [formatter stringFromDate:aDate];
    NSMutableString *str = [[NSMutableString alloc]initWithString:Usernamestr];
    [str appendString:@"###"];
    [str appendString:dateStr];//[formatter stringFromDate:aDate]];
    [str appendString:@"###"];
    [str appendString:reqDesTxtView.text];
    
    NSLog(@" str values are %@",str);
    
    
    
    
//NSString *stringformat=@"<b> Usernamestr </b></font><b> datestr </b></font> hgfhfh<br>";
//    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[stringformat dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    
//    NSLog(@"attributed string is %@",attrStr);
    
    //UILabel * myLabel = [[UILabel alloc] init];
    //myLabel.attributedText = attrStr;
    
    //reqHistoryTxtView.text = reqDesTxtView.text;
    NSLog(@"resource id str is %@",pkrResourceIDStr);
    Servicecall = [[Webservices alloc]init];
    
    NSString *projectLstForTask = @"RequirementGatheringService";
    
    
    


    NSDictionary *credentials = @{@"projectId":pkrProjectIDStr,@"resourceId":pkrResourceIDStr,@"coreProcessId":pkrCoreProcessIDStr,@"processId":pkrprocessIDStr,@"subProcessId":pkrSubProcessIDStr,@"activityId":pkrActivityIDStr,@"description":str,@"history":reqDesTxtView.text,@"reqType":pkrReqTypeIDStr,@"criticality":pkrCriticiality1IDStr,@"system":pkrCriticiality2IDStr,@"saveUpdateType":@"SaveReqGath",@"asisReqId":@"0",@"userId":Useridstr,@"requirementName":requiremnetNameTxtFld.text};
    NSLog(@"The dict is %@",credentials);
    [Servicecall saveRequirement:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

    

    reqDesTxtView.text = nil;
    
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"###" withString:@":"];
    //reqHistoryTxtView.text=str1;
}


-(NSString *)convertHTML:(NSString *)html
{
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSLog(@" html converting values are %@",html);
    
     reqHistoryTxtView.text = html;
    
    return html;
    
    
}

-(void)upDateService
{
    
  //  NSMutableString *str1 = [[NSMutableString alloc]init];
  //  [str1 setString:reqHistoryTxtView.text];
    if ([reqDesTxtView.text length]>0)
    {
       // [str1 appendString:@" "];
        
        NSDate *aDate = [NSDate date];
        //converting Date to String
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *dateStr  = [formatter stringFromDate:aDate];
        NSMutableString *str1 = [[NSMutableString alloc]initWithString:Usernamestr];
        [str1 appendString:@"###"];
        [str1 appendString:dateStr];//[formatter stringFromDate:aDate]];
        [str1 appendString:@"###"];
        [str1 appendString:reqDesTxtView.text];
        
        NSLog(@" str values are %@",str1);

      //  [str1 appendString:Usernamestr];
     //   [str1 appendString:@"###"];
     //   [str1 appendString:dateStr];//[formatter stringFromDate:aDate]];
     //   [str1 appendString:@"###"];
     //   [str1 appendString:reqDesTxtView.text];
        //[str1 appendString:reqDesTxtView.text];
        //[self convertHTML:str1];
       // reqHistoryTxtView.text = str1;
 NSLog(@" str111 values are %@",str1);
   
    
    NSLog(@"resource id is %@",pkrResourceIDStr);
    NSLog(@"project id pkr is %@",pkrProjectIDStr);
    NSLog(@"history str is %@",historyStr);
    NSLog(@"   str1 values are %@",str1);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"projectId":pkrProjectIDStr,@"resourceId":pkrResourceIDStr,@"coreProcessId":pkrCoreProcessIDStr,@"processId":pkrprocessIDStr,@"subProcessId":pkrSubProcessIDStr,@"activityId":pkrActivityIDStr,@"description":str1,@"history":reqHistoryTxtView.text,@"reqType":pkrReqTypeIDStr,@"criticality":pkrCriticiality1IDStr,@"system":pkrCriticiality2IDStr,@"saveUpdateType":@"UpdateReqGath",@"asisReqId":assignedIdStr,@"userId":Useridstr,@"requirementName":requiremnetNameTxtFld.text};
    NSLog(@"The dict is %@",credentials);
    [Servicecall updateRequirement:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    reqDesTxtView.text = nil;
}
    else
    {
        Servicecall = [[Webservices alloc]init];
        NSString *projectLstForTask = @"RequirementGatheringService";
        NSDictionary *credentials = @{@"projectId":pkrProjectIDStr,@"resourceId":pkrResourceIDStr,@"coreProcessId":pkrCoreProcessIDStr,@"processId":pkrprocessIDStr,@"subProcessId":pkrSubProcessIDStr,@"activityId":pkrActivityIDStr,@"description":@"null",@"hist ory":reqHistoryTxtView.text,@"reqType":pkrReqTypeIDStr,@"criticality":pkrCriticiality1IDStr,@"system":pkrCriticiality2IDStr,@"saveUpdateType":@"UpdateReqGath",@"asisReqId":assignedIdStr,@"userId":Useridstr,@"requirementName":requiremnetNameTxtFld.text};
        NSLog(@"The dict is %@",credentials);
        [Servicecall updateRequirement:projectLstForTask TaskListParameters:credentials];
        [Servicecall setDelegate:self];
        reqDesTxtView.text = nil;

    }
}




-(void)didFinishService:(id)Userlogindetails
{
    
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
    
}

-(void)didfinishactionitemlist :(id)actionitemlist;
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);

}
-(void)didNotesCountFinished :(id)Notescountlist;
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);

}

-(void)Serviceactiondone : (id)result
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
}


-(void)Serviceactiondone1 : (id)result
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:result];
    xmlParser4.delegate = self;
    [xmlParser4 parse];

}
-(void)didFinishData :(id)Data
{
    xmlParser5 = [[NSXMLParser alloc]initWithData:Data];
    xmlParser5.delegate = self;
    [xmlParser5 parse];

}
-(void)didEndTask :(id)Taskend
{
    xmlParser6 = [[NSXMLParser alloc]initWithData:Taskend];
    xmlParser6.delegate = self;
    [xmlParser6 parse];

}
-(void)serviceCal :(id)ServerData
{
    xmlParser7 = [[NSXMLParser alloc]initWithData:ServerData];
    xmlParser7.delegate = self;
    [xmlParser7 parse];

}
-(void)Servicecal1 :(id)ServerData
{
    xmlParser8 = [[NSXMLParser alloc]initWithData:ServerData];
    xmlParser8.delegate = self;
    [xmlParser8 parse];

}

-(void)ServiceCalls :(id)ServiceCal
{
    xmlParser9 = [[NSXMLParser alloc]initWithData:ServiceCal];
    xmlParser9.delegate = self;
    [xmlParser9 parse];
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
    if ([elementName isEqualToString:@"projLstForReqGathResponse"])
    {
        projectliststring       = [[NSString alloc] init];
        Projectlistdataarray    = [[NSArray alloc] init];
        projectlistsplitarray   = [[NSArray alloc] init];
        
        PROJECT_IDArray         = [[NSMutableArray alloc] init];
        PROJECT_NAMEArray       = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"reqGathContactListResponse"])
    {
        resourceListString       = [[NSString alloc] init];
        resouceListDataAry    = [[NSArray alloc] init];
        resourceListSplitary   = [[NSArray alloc] init];
        
        resourceIdAry         = [[NSMutableArray alloc] init];
        resourceNameAry       = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"coreProcessListResponse"])
    {
        coreProcessListString       = [[NSString alloc] init];
        coreProcessDataAry    = [[NSArray alloc] init];
        coreProcessSplitary   = [[NSArray alloc] init];
        
        coreProcessIdAry         = [[NSMutableArray alloc] init];
        coreProcessCodeAry         = [[NSMutableArray alloc] init];
        coreProcessNameAry         = [[NSMutableArray alloc] init];
        coreProcessDescAry         = [[NSMutableArray alloc] init];

        
    }
    
    else if ([elementName isEqualToString:@"processListResponse"])
    {
        processListString       = [[NSString alloc] init];
        processDataAry    = [[NSArray alloc] init];
        processSplitary   = [[NSArray alloc] init];
        
        processIdAry         = [[NSMutableArray alloc] init];
        processCodeAry         = [[NSMutableArray alloc] init];
        processNameAry         = [[NSMutableArray alloc] init];
        processDescAry         = [[NSMutableArray alloc] init];
        
        
    }
    
    else if ([elementName isEqualToString:@"subProcessListResponse"])
    {
        subProcessListString       = [[NSString alloc] init];
        subProcessDataAry    = [[NSArray alloc] init];
        subProcessSplitary   = [[NSArray alloc] init];
        
        subProcessIdAry         = [[NSMutableArray alloc] init];
        subProcessCodeAry         = [[NSMutableArray alloc] init];
        subProcessNameAry         = [[NSMutableArray alloc] init];
        subProcessDescAry         = [[NSMutableArray alloc] init];
        
        
    }
    
    else if ([elementName isEqualToString:@"activityListResponse"])
    {
        activityListString       = [[NSString alloc] init];
        activityDataAry    = [[NSArray alloc] init];
        activitySplitary   = [[NSArray alloc] init];
        
        activityIdAry         = [[NSMutableArray alloc] init];
        activityNameAry         = [[NSMutableArray alloc] init];
        activityDescAry         = [[NSMutableArray alloc] init];
        
        
    }
    
    else if ([elementName isEqualToString:@"getReqTypesListResponse"])
    {
        typeListString       = [[NSString alloc] init];
        typeDataAry    = [[NSArray alloc] init];
        typeSplitary   = [[NSArray alloc] init];
        
        reqTypeIdAry         = [[NSMutableArray alloc] init];
        reqTpeAry         = [[NSMutableArray alloc] init];
        
        
    }
    
    
    else if ([elementName isEqualToString:@"getCriticalityListResponse"])
    {
        criticialityListString1       = [[NSString alloc] init];
        criticalityDataAry1    = [[NSArray alloc] init];
        criticalitySplitary1   = [[NSArray alloc] init];
        
        criticialitySystemIdAry1         = [[NSMutableArray alloc] init];
        citicialitySystemAry1         = [[NSMutableArray alloc] init];
        
        
    }

    else if ([elementName isEqualToString:@"getSystemListResponse"])
    {
        criticialityListString2       = [[NSString alloc] init];
        criticalityDataAry2    = [[NSArray alloc] init];
        criticalitySplitary2   = [[NSArray alloc] init];
        
        criticialitySystemIdAry2         = [[NSMutableArray alloc] init];
        citicialitySystemAry2         = [[NSMutableArray alloc] init];
        
        
    }
    else if ([elementName isEqualToString:@"saveOrUpdateReqGatherResponse"])
    {
        saveString       = [[NSString alloc] init];
        saveAry    = [[NSArray alloc] init];
        
        
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
            
            
            projectliststring= [projectliststring stringByAppendingString:chandu];
            projectliststring= [projectliststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            Projectlistdataarray =[projectliststring componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == xmlParser1)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            //UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            //[alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            resourceListString= [resourceListString stringByAppendingString:chandu];
            resourceListString= [resourceListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            resouceListDataAry =[resourceListString componentsSeparatedByString:@"*********"];
        }
    }
    
    else if (parser == xmlParser2)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            //UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            //[alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            coreProcessListString= [coreProcessListString stringByAppendingString:chandu];
            coreProcessListString= [coreProcessListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            coreProcessDataAry =[coreProcessListString componentsSeparatedByString:@"*********"];
        }
    }

    
    else if (parser == xmlParser3)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            //UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            //[alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            processListString= [processListString stringByAppendingString:chandu];
            processListString= [processListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            processDataAry =[processListString componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == xmlParser4)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            subProcessListString= [subProcessListString stringByAppendingString:chandu];
            subProcessListString= [subProcessListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            subProcessDataAry =[subProcessListString componentsSeparatedByString:@"*********"];
        }
    }

    
    else if (parser == xmlParser5)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            activityListString= [activityListString stringByAppendingString:chandu];
            activityListString= [activityListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            activityDataAry =[activityListString componentsSeparatedByString:@"*********"];
        }
    }
    
    else if (parser == xmlParser6)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            typeListString= [typeListString stringByAppendingString:chandu];
            typeListString= [typeListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            typeDataAry =[typeListString componentsSeparatedByString:@"*********"];
        }
    }
    
    
    else if (parser == xmlParser7)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            criticialityListString1= [criticialityListString1 stringByAppendingString:chandu];
            criticialityListString1= [criticialityListString1 stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            criticalityDataAry1 =[criticialityListString1 componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == xmlParser8)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            criticialityListString2= [criticialityListString2 stringByAppendingString:chandu];
            criticialityListString2= [criticialityListString2 stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            criticalityDataAry2 =[criticialityListString2 componentsSeparatedByString:@"*********"];
            
        }
    }

    else if (parser == xmlParser9)
    {
        
        if ([string isEqualToString:@"Flase"]||[string isEqualToString:@"Problem"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Requirement Not Saved" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        
        {
            
           //string=[string stringByConvertingHTMLToPlainText];
            
            NSLog(@"string is  tss %@",string);
            saveString= [saveString stringByAppendingString:string];
            saveAry = [saveString componentsSeparatedByString:@"###"];
            [updateBtn setHidden:NO];
            [saveBtn setHidden:YES];
            assignedIdStr = [saveAry objectAtIndex:1];
            
            historyStr=[saveAry objectAtIndex:2];
            
            NSLog(@" history values are   %@",historyStr);
            
            
            
            NSLog(@" reqhistory values are  %@",historyStr);
            
            NSString *historyreqstr;
  historyreqstr=  [self convertHTML:historyStr];
            NSLog(@" history req values are  %@",historyreqstr);
           
           // [[NSAttributedString alloc] initWithData:[historyStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
            
            
            
          //  historyStr=[historyStr stringByConvertingHTMLToPlainText];

            
            NSLog(@"plain text is %@",historyStr);
            
            
            
           
            //textView.attributedText = attributedString;
            
            
            
            
            
            
//          NSString *one1=  [historyStr stringByReplacingOccurrencesOfString:@"::" withString:@"###"];
//            NSString *one2=  [one1 stringByReplacingOccurrencesOfString:@":" withString:@"###"];
//            
//            historyStr=one2;
//            
//            NSLog(@"history str is %@",historyStr);
//            
//            NSLog(@"asisreqidstr is %@",asisReqIdStr);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
    else if (parser == xmlParser10)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        if ([string isEqualToString:@"ReqGathNotUpdated"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"Not Updated" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }

        else{
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            
            saveString= [saveString stringByAppendingString:string];
            saveAry = [saveString componentsSeparatedByString:@"###"];
            [updateBtn setHidden:NO];
            [saveBtn setHidden:YES];
            assignedIdStr = [saveAry objectAtIndex:1];
            
            historyStr=[saveAry objectAtIndex:2];
            
            
            
            NSLog(@" req updated values are  %@",historyStr);
            
                      [self convertHTML:historyStr];
           
        }
    }


    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
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
                
                
                if ([projectTfd.text length] == 0)
                {
                    
                    projectTfd.text = [PROJECT_NAMEArray objectAtIndex:0];
                    pkrProjectIDStr = [PROJECT_IDArray objectAtIndex:0];
                    [self contactSpinnerService];
                   
                    
                }
                else
                {
                
                NSString *tempString = projectTblStr;
                for(int i=0; i<[PROJECT_IDArray count];i++)
                {
                    if([tempString isEqualToString:[PROJECT_IDArray objectAtIndex:i]])
                    {
                        [updateBtn setHidden:NO];
                        [saveBtn setHidden:YES];
                        
                        pkrProjectIDStr = [PROJECT_IDArray objectAtIndex:i];
                        projectTfd.text=[PROJECT_NAMEArray objectAtIndex:i];
                        [self contactSpinnerService];
                       
                    }
                }
                    
                    
                }
                
            }
           
        }
        
    }
    
    
   else  if (parser == xmlParser1)
    {
        
        if ([elementName isEqualToString:@"reqGathContactListResponse"])
        {
            
            for (int i=1; i<[resouceListDataAry count]; i++)
            {
                
                resourceListSplitary=[[resouceListDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[resourceListSplitary count]; j++)
                {
                    resourceIdString = [[resourceListSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ResourceId==" withString:@""];
                    resourceNameString  = [[resourceListSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""];
                    
                }
                
                
                [resourceIdAry addObject:resourceIdString];
                [resourceNameAry addObject:resourceNameString];
                NSLog(@"split  is %@,%@",resourceIdAry,resourceNameAry);
                
//                if ([projectTblStr length] == 0)
//                {
//                    
//                    contactTfd.text = [resourceNameAry objectAtIndex:0];
//                    pkrResourceIDStr = [resourceIdAry objectAtIndex:0];
//                    
//                }
//                
                
                NSString *tempString = contactTblStr;
                for(int i=0; i<[resourceNameAry count]; i++)
                {
                    if([tempString isEqualToString:[resourceNameAry objectAtIndex:i]])
                    {
                        
                        pkrResourceIDStr = [resourceIdAry objectAtIndex:i];
                        
                    }
                }
                
                
            }
            
        }
        
    }
   else  if (parser == xmlParser2)
   {
       
       if ([elementName isEqualToString:@"coreProcessListResponse"])
       {
           
           for (int i=1; i<[coreProcessDataAry count]; i++)
           {
               
               coreProcessSplitary=[[coreProcessDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[coreProcessSplitary count]; j++)
               {
                   coreProcessIdString = [[coreProcessSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"CoreprocesId==" withString:@""];
                   coreProcessCodeString  = [[coreProcessSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"CoreProcessCode==" withString:@""];
                   coreProcessNameString = [[coreProcessSplitary objectAtIndex:3] stringByReplacingOccurrencesOfString:@"CoreProcessName==" withString:@""];
                   coreProcessDesString  = [[coreProcessSplitary objectAtIndex:4] stringByReplacingOccurrencesOfString:@"CoreProDescription==" withString:@""];
               }
               
               
               [coreProcessIdAry addObject:coreProcessIdString];
               [coreProcessCodeAry addObject:coreProcessCodeString];
               [coreProcessNameAry addObject:coreProcessNameString];
               [coreProcessDescAry addObject:coreProcessDesString];
               NSLog(@"split  is %@,%@,%@,%@",coreProcessIdAry,coreProcessCodeAry,coreProcessNameAry,coreProcessDescAry);
               
//               if ([projectTblStr length] == 0)
//               {
//                   
//                   coreProcessTfd.text = [coreProcessNameAry objectAtIndex:0];
//                   pkrCoreProcessIDStr = [coreProcessIdAry objectAtIndex:0];
//                   [self processSpinnerService];
//                   
//               }
               NSString *tempString = coreProcessTblStr;
               for(int i=0; i<[coreProcessNameAry count]; i++)
               {
                   if([tempString isEqualToString:[coreProcessNameAry objectAtIndex:i]])
                   {
                       
                       pkrCoreProcessIDStr = [coreProcessIdAry objectAtIndex:i];
                       [self processSpinnerService];

                   }
               }

               
               
           }
           
       }
       
   }

    
    
    
    
   else  if (parser == xmlParser3)
   {
       
       if ([elementName isEqualToString:@"processListResponse"])
       {
           
           for (int i=1; i<[processDataAry count]; i++)
           {
               
               processSplitary=[[processDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[processSplitary count]; j++)
               {
                   processIdString = [[processSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ProcessId==" withString:@""];
                   processCodeString  = [[processSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ProcessCode==" withString:@""];
                   processNameString = [[processSplitary objectAtIndex:3] stringByReplacingOccurrencesOfString:@"ProcessName==" withString:@""];
                   processDesString  = [[processSplitary objectAtIndex:4] stringByReplacingOccurrencesOfString:@"ProcessDescription==" withString:@""];
               }
               
               
               [processIdAry addObject:processIdString];
               [processCodeAry addObject:processCodeString];
               [processNameAry addObject:processNameString];
               [processDescAry addObject:processDesString];
               NSLog(@"split  is %@,%@,%@,%@",processIdAry,processCodeAry,processNameAry,processDescAry);

//               if ([projectTblStr length] == 0)
//               {
//                   
//                   processTfd.text = [processNameAry objectAtIndex:0];
//                   pkrprocessIDStr = [processIdAry objectAtIndex:0];
//                   [self subProcessSpinner];
//                   
//               }
//               
               
               
               NSString *tempString = processTblStr;
               for(int i=0; i<[processNameAry count]; i++)
               {
                   if([tempString isEqualToString:[processNameAry objectAtIndex:i]])
                   {
                       
                       pkrprocessIDStr = [processIdAry objectAtIndex:i];
                       [self subProcessSpinner];

                   }
               }
               
               
               
               
           }
           
       }
       
   }
    
    
   else  if (parser == xmlParser4)
   {
       
       if ([elementName isEqualToString:@"subProcessListResponse"])
       {
           
           for (int i=1; i<[subProcessDataAry count]; i++)
           {
               
               subProcessSplitary=[[subProcessDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[subProcessSplitary count]; j++)
               {
                   subProcessIdString = [[subProcessSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"SubProcessId==" withString:@""];
                   subProcessCodeString  = [[subProcessSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"SubProcessCode==" withString:@""];
                   subProcessNameString = [[subProcessSplitary objectAtIndex:3] stringByReplacingOccurrencesOfString:@"SubProcessName==" withString:@""];
                   subProcessDesString  = [[subProcessSplitary objectAtIndex:4] stringByReplacingOccurrencesOfString:@"SubProDescription==" withString:@""];
               }
               
               
               [subProcessIdAry addObject:subProcessIdString];
               [subProcessCodeAry addObject:subProcessCodeString];
               [subProcessNameAry addObject:subProcessNameString];
               [subProcessDescAry addObject:subProcessDesString];
               NSLog(@"split  is %@,%@,%@,%@",subProcessIdAry,subProcessCodeAry,subProcessNameAry,subProcessDescAry);
               
//               
//               if ([projectTblStr length] == 0)
//               {
//                   
//                   subProcessTfd.text = [subProcessNameAry objectAtIndex:0];
//                   pkrSubProcessIDStr = [subProcessIdAry objectAtIndex:0];
//                   [self activitySpinner];
//                   
//               }
//               
               
               
               
               NSString *tempString = subProcessTblStr;
               for(int i=0; i<[subProcessNameAry count]; i++)
               {
                   if([tempString isEqualToString:[subProcessNameAry objectAtIndex:i]])
                   {
                       
                       pkrSubProcessIDStr = [subProcessIdAry objectAtIndex:i];
                       [self activitySpinner];
                       
                   }
               }
               
               
               
               
               
           }
           
       }
       
   }
    
    
    
    
    
   else  if (parser == xmlParser5)
   {
       
       if ([elementName isEqualToString:@"activityListResponse"])
       {
           
           for (int i=1; i<[activityDataAry count]; i++)
           {
               
               activitySplitary=[[activityDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[activitySplitary count]; j++)
               {
                   activityIdString = [[activitySplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ActivityId==" withString:@""];
                   activityNameString  = [[activitySplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ActivityName==" withString:@""];
                   activityDesString = [[activitySplitary objectAtIndex:3] stringByReplacingOccurrencesOfString:@"ActivityDescription==" withString:@""];
               }
               
               [activityIdAry addObject:activityIdString];
               [activityNameAry addObject:activityNameString];
               [activityDescAry addObject:activityDesString];
               NSLog(@"split  is %@,%@,%@",activityIdAry,activityNameAry,activityDescAry);
               
               
//               if ([projectTblStr length] == 0)
//               {
//                   
//                   activityTfd.text = [activityNameAry objectAtIndex:0];
//                   pkrActivityIDStr = [activityIdAry objectAtIndex:0];
//                   
//               }
//               
               
               
               NSString *tempString = activityTblStr;
               for(int i=0; i<[activityNameAry count]; i++)
               {
                   if([tempString isEqualToString:[activityNameAry objectAtIndex:i]])
                   {
                       
                       pkrActivityIDStr = [activityIdAry objectAtIndex:i];
                       
                   }
               }

               
               
               
               
               
               
           }
           
       }
       
   }

    
    
    
   else  if (parser == xmlParser6)
   {
       
       if ([elementName isEqualToString:@"getReqTypesListResponse"])
       {
           
           for (int i=1; i<[typeDataAry count]; i++)
           {
               
               typeSplitary=[[typeDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[typeSplitary count]; j++)
               {
                   reqTypeIdStr = [[typeSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"REQUIREMENT_TYPE_ID==" withString:@""];
                   reqTpeStr  = [[typeSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"REQUIREMENT_TYPE==" withString:@""];
               }
               
               [reqTypeIdAry addObject:reqTypeIdStr];
               [reqTpeAry addObject:reqTpeStr];
               NSLog(@"split  is %@,%@",reqTypeIdAry,reqTpeAry);
               
               
               NSString *tempString = reqTypeTblStr;
               for(int i=0; i<[reqTpeAry count]; i++)
               {
                   if([tempString isEqualToString:[reqTpeAry objectAtIndex:i]])
                   {
                       
                       pkrReqTypeIDStr = [reqTypeIdAry objectAtIndex:i];
                       
                   }
               }

               
           }
           
       }
       
   }
    
    
    
   else  if (parser == xmlParser7)
   {
       
       if ([elementName isEqualToString:@"getCriticalityListResponse"])
       {
           
           for (int i=1; i<[criticalityDataAry1 count]; i++)
           {
               
               criticalitySplitary1=[[criticalityDataAry1 objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[criticalitySplitary1 count]; j++)
               {
                   criticialitySystemIdStr1 = [[criticalitySplitary1 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"CRITICALITY_ID==" withString:@""];
                   criticialitySystemStr1  = [[criticalitySplitary1 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"CRITICALITY==" withString:@""];
               }
               
               
               [criticialitySystemIdAry1 addObject:criticialitySystemIdStr1];
               [citicialitySystemAry1 addObject:criticialitySystemStr1];
               NSLog(@"split  is %@,%@",criticialitySystemIdAry1,citicialitySystemAry1);
               
               
               
               NSString *tempString = criticialityTblStr;
               for(int i=0; i<[citicialitySystemAry1 count];i++)
               {
                   if([tempString isEqualToString:[citicialitySystemAry1 objectAtIndex:i]])
                   {
                       
                       pkrCriticiality1IDStr = [criticialitySystemIdAry1 objectAtIndex:i];
                       
                   }
               }

               
               
               
           }
           
       }
       
   }

   else  if (parser == xmlParser8)
   {
       
       if ([elementName isEqualToString:@"getSystemListResponse"])
       {
           
           for (int i=1; i<[criticalityDataAry2 count]; i++)
           {
               
               criticalitySplitary2=[[criticalityDataAry2 objectAtIndex:i] componentsSeparatedByString:@"###"];
               
               //NSLog(@"split  is %@",projectlistsplitarray);
               
               for (int j=1; j<[criticalitySplitary2 count]; j++)
               {
                   criticialitySystemIdStr2 = [[criticalitySplitary2 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"SYSTEM_ID==" withString:@""];
                   criticialitySystemStr2  = [[criticalitySplitary2 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"SYSTEM==" withString:@""];
               }
               
               [criticialitySystemIdAry2 addObject:criticialitySystemIdStr2];
               [citicialitySystemAry2 addObject:criticialitySystemStr2];
               NSLog(@"split  is %@,%@",criticialitySystemIdAry2,citicialitySystemAry2);
               
               
               
               NSString *tempString = systemTblStr;
               for(int i=0; i<[citicialitySystemAry2 count]; i++)
               {
                   if([tempString isEqualToString:[citicialitySystemAry2 objectAtIndex:i]])
                   {
                       
                       pkrCriticiality2IDStr = [criticialitySystemIdAry2 objectAtIndex:i];
                       
                   }
               }

               
               
           }
           
       }
       
   }




}

//picker deligate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [PROJECT_NAMEArray count];
    }
    else if (picker.tag==101) {
        return [resourceNameAry count];
    }
    else if (picker.tag==102) {
        return [coreProcessNameAry count];
    }
    else if (picker.tag==103) {
        return [processNameAry count];
    }
    else if (picker.tag==104) {
        return [subProcessNameAry count];
    }
    else if (picker.tag==105) {
        return [activityNameAry count];
    }
    else if (picker.tag==106) {
        return [reqTpeAry count];
    }
    else if (picker.tag==107) {
        return [citicialitySystemAry1 count];
    }
    else if (picker.tag==108) {
        return [citicialitySystemAry2 count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [PROJECT_NAMEArray objectAtIndex:row];
    }
    else if (picker.tag==101) {
        return [resourceNameAry objectAtIndex:row];

    }
    else if (picker.tag==102) {
        return [coreProcessNameAry objectAtIndex:row];
    }
    else if (picker.tag==103) {
        return [processNameAry objectAtIndex:row];
    }
    else if (picker.tag==104) {
        return [subProcessNameAry objectAtIndex:row];

    }
    else if (picker.tag==105) {
        return [activityNameAry objectAtIndex:row];

    }
    else if (picker.tag==106) {
        return [reqTpeAry objectAtIndex:row];

    }
    else if (picker.tag==107) {
        return [citicialitySystemAry1 objectAtIndex:row];

    }
    else if (picker.tag==108) {
        return [citicialitySystemAry2 objectAtIndex:row];

    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100) {
        projectTfd.text=[PROJECT_NAMEArray objectAtIndex:row];
        pkrProjectIDStr = [PROJECT_IDArray objectAtIndex:row];
        
        [self contactSpinnerService];

        
    }
    else if (pickerView.tag==101) {
        contactTfd.text=[resourceNameAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrResourceIDStr = [resourceIdAry objectAtIndex:row];

    }
    
    else if (pickerView.tag==102) {
        coreProcessTfd.text=[coreProcessNameAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrCoreProcessIDStr = [coreProcessIdAry objectAtIndex:row];
        [self processSpinnerService];


    }
    else if (pickerView.tag==103) {
        processTfd.text=[processNameAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrprocessIDStr = [processIdAry objectAtIndex:row];
        
        [self subProcessSpinner];

    }
    else if (pickerView.tag==104) {
        subProcessTfd.text=[subProcessNameAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrSubProcessIDStr = [subProcessIdAry objectAtIndex:row];
        
        [self activitySpinner];


    }
    else if (pickerView.tag==105) {
        activityTfd.text=[activityNameAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrActivityIDStr = [activityIdAry objectAtIndex:row];

    }
    else if (pickerView.tag==106) {
        reqTypeTfd.text=[reqTpeAry objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrReqTypeIDStr = [reqTypeIdAry objectAtIndex:row];

    }
    else if (pickerView.tag==107) {
        criticalityTfd.text=[citicialitySystemAry1 objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrCriticiality1IDStr = [criticialitySystemIdAry1 objectAtIndex:row];

        
    }
    else if (pickerView.tag==108) {
        systemTfd.text=[citicialitySystemAry2 objectAtIndex:row];
        
        //[questionpkr removeFromSuperview];
        pkrCriticiality2IDStr = [criticialitySystemIdAry2 objectAtIndex:row];

    }
    
    
}
//touches

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touchObj = [touches anyObject];
//    CGPoint pnt = [touchObj locationInView:self.view];
//    [questionpkr removeFromSuperview];
//    
//}

-(void)userTapped
{
    
    [questionpkr removeFromSuperview];
    [self.scrollView setScrollEnabled:YES];

    
}

//Delegate Method
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
