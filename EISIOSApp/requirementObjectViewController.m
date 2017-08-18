//
//  requirementObjectViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 05/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "requirementObjectViewController.h"

@interface requirementObjectViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation requirementObjectViewController
@synthesize getAssignReqIdStr;

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
    
    
    
    //Tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    //[self.view addGestureRecognizer:tapGesture];
    [reqobjectView addGestureRecognizer:tapGesture];
    
    
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
    
    
    
    //    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
    //                                                                       attribute:NSLayoutAttributeTop
    //                                                                       relatedBy:0
    //                                                                          toItem:self.view
    //                                                                       attribute:NSLayoutAttributeTop
    //                                                                      multiplier:1.0
    //                                                                        constant:304];
    //    [self.view addConstraint:topConstraint];
    
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    
    
    
    
    
    //----------------view back ground stroke--------------------//
    reqobjectView.layer.cornerRadius = reqobjectView.frame.size.width / 2;
    reqobjectView.clipsToBounds = YES;
    reqobjectView.layer.borderWidth = 3.0f;
    reqobjectView.layer.borderColor = [UIColor greenColor].CGColor;
    reqobjectView.layer.cornerRadius = 10.0f;
    reqobjectView.layer.cornerRadius=4;
    
    commentsTextView.layer.cornerRadius = commentsTextView.frame.size.width / 2;
    commentsTextView.clipsToBounds = YES;
    commentsTextView.layer.borderWidth = 3.0f;
    commentsTextView.layer.borderColor = [UIColor greenColor].CGColor;
    commentsTextView.layer.cornerRadius = 10.0f;
    commentsTextView.layer.cornerRadius=4;
    
    
    
    
    //-------------------Right side pop Button---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];
    
    
    [saveBtn setHidden:NO];
    [updateBtn setHidden:YES];
    
    [self objectListService];
    
    [self objectSpinnerListService];
    [self purposeSpinnerListService];
    [self resourceSpinnerListService];
    [self complexitySpinnerListService];
    
    existingAndApprovalAry = [[NSArray alloc]initWithObjects:@"Y",@"N", nil];
    
    
    
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
    [commentsTextView resignFirstResponder];
    
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
    //save the data to defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"anjan" forKey:@"NewBtnValidation"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)objectTypeBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 60, self.view.frame.size.width-363, 300)];//405
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [reqobjectView addSubview:questionpkr];
    
    
}
-(IBAction)purposeBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 203, self.view.frame.size.width-363, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [reqobjectView addSubview:questionpkr];
    
    
}
-(IBAction)existingBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 270, self.view.frame.size.width-363, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 102;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [reqobjectView addSubview:questionpkr];
    
    
}
-(IBAction)approvalBtnClk:(id)sender;
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 337, self.view.frame.size.width-363, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 103;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [reqobjectView addSubview:questionpkr];
    
}
-(IBAction)resourceBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 420, self.view.frame.size.width-363, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 104;
    questionpkr.backgroundColor=[UIColor grayColor];
    
    [questionpkr reloadAllComponents];
    
    [self.view addSubview:questionpkr];
    //[reqobjectView addSubview:questionpkr];
    // NSLog(@"resource name array is %@",resourceNameAry);
    
    
    
}
-(IBAction)complexityBtnClk:(id)sender
{
    [self.scrollView setScrollEnabled:NO];
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 499, self.view.frame.size.width-363, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 105;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [reqobjectView addSubview:questionpkr];
    
    
    
}
-(IBAction)saveBtnClk:(id)sender
{
    if ( ([objectTypeTfd.text length] == 0) || ([objectNameTfd.text length] == 0) || ([purposeTfd.text length] == 0)||([exixtingTfd.text length] == 0) ||([approvalTfd.text length] == 0)||([resourceTfd.text length] == 0)||([complexityTfd.text length] == 0)|| ([commentsTextView.text length] == 0) )
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill Requirement Object Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
        
    }
    else{
        [self saveRequirement];
    }
}
-(IBAction)updateBtnClk:(id)sender
{
    if ( ([objectTypeTfd.text length] == 0) || ([objectNameTfd.text length] == 0) || ([purposeTfd.text length] == 0)||([exixtingTfd.text length] == 0) ||([approvalTfd.text length] == 0)||([resourceTfd.text length] == 0)||([complexityTfd.text length] == 0)|| ([commentsTextView.text length] == 0) )
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill Requirement Object Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
        
        
    }
    else{
        [self updateRequirement];
    }
    
}
-(IBAction)homeBtnClk:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)objectListService
{
    NSLog(@"the id is %@",getAssignReqIdStr);
    
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = [NSString stringWithFormat:@"requirement/v1/requirementObjectList?requirementId=%@",getAssignReqIdStr];
    //NSDictionary *credentials = @{@"assignReqId":getAssignReqIdStr};
    [Servicecall requirementobjectlist:projectLstForTask];
    [Servicecall setDelegate:self];
}
-(void)requirementobject:(id)requirementobjectresponse
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=requirementobjectresponse;
    NSLog(@"requirement object list is %@",dict);
    
    if ([[dict valueForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"object list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else
    {
        resultArray=[[NSMutableArray alloc]init];
        resultArray=[dict valueForKey:@"resAL"];
        
        objLstIdAry         = [[NSMutableArray alloc] init];
        objLstTypeAry       = [[NSMutableArray alloc] init];
        objLstcomplexityAry       = [[NSMutableArray alloc] init];
        objLstPurposeAry       = [[NSMutableArray alloc] init];
        objLstExistingNewAry       = [[NSMutableArray alloc] init];
        objLstResourceNameAry = [[NSMutableArray alloc] init];
        objLstObjNameAry = [[NSMutableArray alloc] init];
        tblLstAppAry = [[NSMutableArray alloc] init];
        objLstCommentArry = [[NSMutableArray alloc] init];
        for (NSDictionary *fid in resultArray)
        {
            [objLstTypeAry addObject:[fid valueForKey:@"reqObjectType"]];
            [objLstcomplexityAry addObject:[fid valueForKey:@"complexity"]];
            [objLstPurposeAry addObject:[fid valueForKey:@"purpose"]];
            [objLstResourceNameAry addObject:[fid valueForKey:@"resourceName"]];
            [objLstIdAry addObject:[fid valueForKey:@"reqObjectId"]];
            [tblLstAppAry addObject:[fid valueForKey:@"approval"]];
            [objLstObjNameAry addObject:[fid valueForKey:@"reqObjectName"]];
            [objLstCommentArry addObject:[fid valueForKey:@"comment"]];
            [objLstExistingNewAry addObject:[fid valueForKey:@"existingNew"]];
        }
        [objectTblView reloadData];

        NSLog(@"object list type is %@",objLstTypeAry);
        NSLog(@"object list complexity is %@",objLstcomplexityAry);
        NSLog(@"object list purpose %@",objLstPurposeAry);
        NSLog(@"object list resource name is %@",objLstResourceNameAry);
        NSLog(@"object list id is %@",objLstIdAry);
    }

}


-(void)objectSpinnerListService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = [NSString stringWithFormat:@"requirement/v1/requirementObjectTypeSpinner?orgId=%@",OrgIdStr];
    [Servicecall requirementobjectspinner:projectLstForTask];
    [Servicecall setDelegate:self];
}
-(void)requirementobjectspinner:(id)requirementobjectspinnerresponse
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=requirementobjectspinnerresponse;
    NSLog(@"requiremnet object spinner response is %@",dict);
    
    if([[dict valueForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"object type list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else
    {
        resultArray=[[NSMutableArray alloc]init];
        resultArray=[dict valueForKey:@"resAL"];
        
        codeIDArray         = [[NSMutableArray alloc] init];
        objectTypeArray       = [[NSMutableArray alloc] init];
        
        for (NSDictionary *fid in resultArray)
        {
            [codeIDArray addObject:[fid valueForKey:@"reqObjectTypeId"]];
            [objectTypeArray addObject:[fid valueForKey:@"reqObjectType"]];
        }
        
        NSLog(@"requirement object type id is %@",codeIDArray);
        NSLog(@"requirement object type name is %@",objectTypeArray);
    }
}

-(void)purposeSpinnerListService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = [NSString stringWithFormat:@"requirement/v1/requirementObjPurposeSpinner?orgId=%@",OrgIdStr];
    //NSDictionary *credentials = @{@"orgId":OrgIdStr};
    [Servicecall requirementpurpose:projectLstForTask];
    [Servicecall setDelegate:self];
}

-(void)requirementpurpose:(id)requirementpurposeresponse
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=requirementpurposeresponse;
    NSLog(@"requirement purpose response is %@",dict);
    
    if([[dict valueForKey:@"statusMessage"]isEqualToString:@"No Data"])
{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"object type list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertview show];
}

else
{
    resultArray=[[NSMutableArray alloc]init];
    resultArray=[dict valueForKey:@"resAL"];
    
    purposeCodeIDAry         = [[NSMutableArray alloc] init];
    puurposeAry       = [[NSMutableArray alloc] init];
    
    for (NSDictionary *fid in resultArray)
    {
        [purposeCodeIDAry addObject:[fid valueForKey:@"purposeId"]];
        [puurposeAry addObject:[fid valueForKey:@"purpose"]];
    }
    
    NSLog(@"purpose id is %@",purposeCodeIDAry);
    NSLog(@"purpose name is %@",puurposeAry);
}
}

-(void)resourceSpinnerListService
{
    NSLog(@"resource list display");
    NSLog(@"the project id is %@",_ProjectIdStr2);
    
    NSString *TaskListUrl = [NSString stringWithFormat:@"requirement/v1/reqGathContactSpinner?projectId=%@",_ProjectIdStr2];
    [Servicecall contacttypelistUrl:TaskListUrl];
    [Servicecall setDelegate:self];
}
-(void)contacttype:(id)contacttyperesponse
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=contacttyperesponse;
    NSLog(@"resource type response is %@",dict);
    
    if([[dict valueForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"object type list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
    else
    {
        resultArray=[[NSMutableArray alloc]init];
        resultArray=[dict valueForKey:@"resAL"];
        
        resourceIdAry         = [NSMutableArray new];
        resourceNameAry         = [NSMutableArray new];
        resourcenamearray=[[NSMutableArray alloc]init];
        resourceidarray=[[NSMutableArray alloc]init];
        
        for (NSDictionary *fid in resultArray)
        {
            [resourceIdAry addObject:[fid valueForKey:@"resourceId"]];
            [resourceNameAry addObject:[fid valueForKey:@"resourceName"]];
        }
        
        resourcenamearray=[NSMutableArray arrayWithArray:resourceNameAry];
        resourceidarray=[NSMutableArray arrayWithArray:resourceIdAry];

        
        NSLog(@"resource id is %@",resourceIdAry);
        NSLog(@"resource name is %@",resourceNameAry);
    }
}

-(void)complexitySpinnerListService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = [NSString stringWithFormat:@"requirement/v1/requirementObjComplexitySpinner?orgId=%@",OrgIdStr];
    [Servicecall requirementcomplexity:projectLstForTask];
    [Servicecall setDelegate:self];
}
-(void)requirementcomplexity:(id)requirementcomplexityresponse
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=requirementcomplexityresponse;
    NSLog(@"requirement complexity response is %@",requirementcomplexityresponse);

    if([[dict valueForKey:@"statusMessage"]isEqualToString:@"No Data"])
{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"object type list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertview show];
}

else
{
    resultArray=[[NSMutableArray alloc]init];
    resultArray=[dict valueForKey:@"resAL"];
    
    complexityCodeIdAry         = [[NSMutableArray alloc] init];
    complexityAry         = [[NSMutableArray alloc] init];
    
    for (NSDictionary *fid in resultArray)
    {
        [complexityCodeIdAry addObject:[fid valueForKey:@"complexityId"]];
        [complexityAry addObject:[fid valueForKey:@"complexity"]];
    }
    
    NSLog(@"complexity id is %@",complexityCodeIdAry);
    NSLog(@"complexityname  is %@",complexityAry);
}

}
-(void)saveRequirement
{
   NSLog(@"the resource id is %@",pkrResourceIDStr);
   
    NSString *saverequirement = [NSString stringWithFormat:@"requirement/v1/saveorUpdateReqObject"];
    NSString *credentials =[NSString stringWithFormat:@"objectType=%@&objectName=%@&complexity=%@&purpose=%@&existingNew=%@&approval=%@&resourceName=%@&comments=%@&asisReqId=%@&isTaskCompl=%@&reqObjId=%@&saveUpdateType=%@",pkrObjectTypeIDStr,objectNameTfd.text,pkrComplexityIDStr,pkrPurposeIDStr,exixtingTfd.text,approvalTfd.text,pkrResourceIDStr,commentsTextView.text,getAssignReqIdStr,@"",@"0",@"SaveObject"];
     Servicecall = [[Webservices alloc]init];
    [Servicecall saveRequirementobject:saverequirement saveRequirementobjectparams:credentials];
    [Servicecall setDelegate:self];
}

-(void)saverequirementobject:(id)saverequirementObject
{
    NSData *data=[[NSData alloc]initWithData:saverequirementObject];
    NSError *error;
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"the response is %@",dict);
    if ([[dict valueForKey:@"statusMessage"]isEqualToString:@"Inserted"])
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"requirement object saved successfully" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        [alertview show];
        
        objectTypeTfd.text = nil;
        objectNameTfd.text = nil;
        purposeTfd.text = nil;
        exixtingTfd.text = nil;
        
        approvalTfd.text = nil;
        resourceTfd.text = nil;
        complexityTfd.text = nil;
        commentsTextView.text = nil;
    }
    if ([[dict valueForKey:@"statusMessage"]isEqualToString:@"Updated"]) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"requirement object updated successfully" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        [alertview show];
    }
    
}

-(void)updateRequirement
{
    
    NSLog(@"resource pkr str is %@",pkrResourceIDStr);
//    Servicecall = [[Webservices alloc]init];
//    NSString *projectLstForTask = @"RequirementGatheringService";
//    NSDictionary *credentials = @{@"objectType":pkrObjectTypeIDStr,@"objectName":objectNameTfd.text,@"complexity":pkrComplexityIDStr,@"purpose":pkrPurposeIDStr,@"existingNew":exixtingTfd.text,@"approval":approvalTfd.text,@"resourceName":pkrResourceIDStr,@"comments":commentsTextView.text,@"asisReqId":getAssignReqIdStr,@"isTaskCompl":@"",@"reqObjId":pkrReqProectIDStr,@"saveUpdateType":@"UpdateObject"};
//    
//    [Servicecall updateRequirementObject:projectLstForTask TaskListParameters:credentials];
//    [Servicecall setDelegate:self];

    NSString *saverequirement = [NSString stringWithFormat:@"requirement/v1/saveorUpdateReqObject"];
    NSString *credentials =[NSString stringWithFormat:@"objectType=%@&objectName=%@&complexity=%@&purpose=%@&existingNew=%@&approval=%@&resourceName=%@&comments=%@&asisReqId=%@&isTaskCompl=%@&reqObjId=%@&saveUpdateType=%@",pkrObjectTypeIDStr,objectNameTfd.text,pkrComplexityIDStr,pkrPurposeIDStr,exixtingTfd.text,approvalTfd.text,pkrResourceIDStr,commentsTextView.text,getAssignReqIdStr,@"",pkrReqProectIDStr,@"UpdateObject"];
    
    NSLog(@"the dict is %@",credentials);
    Servicecall = [[Webservices alloc]init];
    [Servicecall saveRequirementobject:saverequirement saveRequirementobjectparams:credentials];
    [Servicecall setDelegate:self];
}


-(void)didFinishService :(id)Userlogindetails
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
    // NSLog(@"the xml parser 3 value is");
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    
}

-(void)didfinishactionitemlist :(id)actionitemlist
{
    
    
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    
}
-(void)didNotesCountFinished :(id)Notescountlist
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    
}
//-(void)Serviceactiondone : (id)result
//{
//
//}
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
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"getObjectListResponse"])
    {
        objLststring       = [[NSString alloc] init];
        objLstdataarray    = [[NSArray alloc] init];
        objLstplitarray   = [[NSArray alloc] init];
        
        objLstIdAry         = [[NSMutableArray alloc] init];
        objLstTypeAry       = [[NSMutableArray alloc] init];
        objLstcomplexityAry       = [[NSMutableArray alloc] init];
        objLstPurposeAry       = [[NSMutableArray alloc] init];
        objLstExistingNewAry       = [[NSMutableArray alloc] init];
        objLstResourceNameAry = [[NSMutableArray alloc] init];
        objLstObjNameAry = [[NSMutableArray alloc] init];
        tblLstAppAry = [[NSMutableArray alloc] init];
        objLstCommentArry = [[NSMutableArray alloc] init];
    }
    
    else if ([elementName isEqualToString:@"getObjectTypeListResponse"])
    {
        objectTypeliststring       = [[NSString alloc] init];
        objectTypelistdataarray    = [[NSArray alloc] init];
        objectTypesplitarray   = [[NSArray alloc] init];
        
        codeIDArray         = [[NSMutableArray alloc] init];
        objectTypeArray       = [[NSMutableArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"getPurposeListResponse"])
    {
        purposeListString       = [[NSString alloc] init];
        purposeListDataAry    = [[NSArray alloc] init];
        purposeeListSplitary   = [[NSArray alloc] init];
        
        purposeCodeIDAry         = [[NSMutableArray alloc] init];
        puurposeAry       = [[NSMutableArray alloc] init];
        
        
    }
    
    else if ([elementName isEqualToString:@"resListFrProjectResponse"])
    {
        resourceListString = [[NSString alloc]init];
        resourceDataAry    = [[NSMutableArray alloc] init];
        resourceSplitary   = [[NSMutableArray alloc]init];
        
        resourceIdAry         = [NSMutableArray new];
        resourceNameAry         = [NSMutableArray new];
        
        NSLog(@"the resource response array is");
        
        
    }
    
    else if ([elementName isEqualToString:@"getComplexityListResponse"])
    {
        complexityListString       = [[NSString alloc] init];
        complexityDataAry    = [[NSArray alloc] init];
        complexitySplitary   = [[NSArray alloc] init];
        
        complexityCodeIdAry         = [[NSMutableArray alloc] init];
        complexityAry         = [[NSMutableArray alloc] init];
        
        
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
            
            
            objLststring = [objLststring stringByAppendingString:chandu];
            objLststring= [objLststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            objLstdataarray =[objLststring componentsSeparatedByString:@"*********"];
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
            
            
            objectTypeliststring = [objectTypeliststring stringByAppendingString:chandu];
            objectTypeliststring= [objectTypeliststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            objectTypelistdataarray =[objectTypeliststring componentsSeparatedByString:@"*********"];
        }
    }
    if (parser == xmlParser2)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            NSString *chandu = @"*********";
            
            
            purposeListString = [purposeListString stringByAppendingString:chandu];
            purposeListString= [purposeListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            purposeListDataAry =[purposeListString componentsSeparatedByString:@"*********"];
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
            
            
            resourceListString = [resourceListString stringByAppendingString:chandu];
            resourceListString = [resourceListString stringByAppendingString:string];
            
            resourceDataAry = [resourceListString componentsSeparatedByString:@"*********"];
            
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
            
            
            complexityListString = [complexityListString stringByAppendingString:chandu];
            complexityListString = [complexityListString stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            complexityDataAry = [complexityListString componentsSeparatedByString:@"*********"];
        }
    }
    if (parser == xmlParser5)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error OCcured" message:@" Object Not Saved" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
       else if ([string isEqualToString:@"Already Exists"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }

        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [self objectListService];
            [self resourceSpinnerListService];
            
            
            objectTypeTfd.text = nil;
            objectNameTfd.text = nil;
            purposeTfd.text = nil;
            exixtingTfd.text = nil;
            
            approvalTfd.text = nil;
            resourceTfd.text = nil;
            complexityTfd.text = nil;
            commentsTextView.text = nil;
           
            
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
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            
            [self objectListService];
            [self resourceSpinnerListService];
           
            
            
        }
    }
    
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"getObjectListResponse"])
        {
            
            for (int i=1; i<[objLstdataarray count]; i++)
            {
                
                objLstplitarray = [[objLstdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[objLstplitarray count]; j++)
                {
                    objLstIdStr = [[objLstplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ReqObjId==" withString:@""];
                    
                    objLstTypeStr  = [[objLstplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ObjType==" withString:@""];
                    
                    
                    
                    objLstcomplexityStr = [[objLstplitarray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"COMPLEXITY==" withString:@""];
                    
                    objLstPurposeStr  = [[objLstplitarray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"PURPOSE==" withString:@""];
                    
                    objLstExistingNewStr = [[objLstplitarray objectAtIndex:5] stringByReplacingOccurrencesOfString:@"EXISTINGNEW==" withString:@""];
                    
                    objLstResourceNameStr  = [[objLstplitarray objectAtIndex:6] stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""];
                    
                    objectResourceStr1=[objLstResourceNameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    objLstObjNameStr = [[objLstplitarray objectAtIndex:7] stringByReplacingOccurrencesOfString:@"ObjName==" withString:@""];
                    
                    tblLstAppStr  = [[objLstplitarray objectAtIndex:8] stringByReplacingOccurrencesOfString:@"Approval==" withString:@""];
                    
                    objLstCommentStr = [[objLstplitarray objectAtIndex:9] stringByReplacingOccurrencesOfString:@"Comment==" withString:@""];
                    
                }
                
                
                [objLstIdAry addObject:objLstIdStr];
                [objLstTypeAry addObject:objLstTypeStr];
                
                [objLstcomplexityAry addObject:objLstcomplexityStr];
                [objLstPurposeAry addObject:objLstPurposeStr];
                
                [objLstExistingNewAry addObject:objLstExistingNewStr];
                [objLstResourceNameAry addObject:objectResourceStr1];
                
                [objLstObjNameAry addObject:objLstObjNameStr];
                [tblLstAppAry addObject:tblLstAppStr];
                
                [objLstCommentArry addObject:objLstCommentStr];
                
                
                
            }
            
            NSLog(@"split  is %@,%@",objLstIdAry,objLstTypeAry);
            
            NSLog(@"split  is %@,%@",objLstcomplexityAry,objLstPurposeAry);
            
            NSLog(@"split  is %@,%@",objLstExistingNewAry,objLstResourceNameAry);
            
            NSLog(@"split  is %@,%@",objLstObjNameAry,tblLstAppAry);
            
            NSLog(@"split  is %@",objLstCommentArry);
            
            [objectTblView reloadData];
            
        }
        
    }
    
    
    
    else if (parser == xmlParser1)
    {
        
        if ([elementName isEqualToString:@"getObjectTypeListResponse"])
        {
            
            for (int i=1; i<[objectTypelistdataarray count]; i++)
            {
                
                objectTypesplitarray = [[objectTypelistdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[objectTypesplitarray count]; j++)
                {
                    codeIDStr = [[objectTypesplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"CodeId==" withString:@""];
                    
                    objectTypeStr  = [[objectTypesplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ObjType==" withString:@""];
                    
                }
                
                
                [codeIDArray addObject:codeIDStr];
                [objectTypeArray addObject:objectTypeStr];
                NSLog(@"split  is %@,%@",codeIDArray,objectTypeArray);
                
            }
            
        }
        
    }
    else  if (parser == xmlParser2)
    {
        
        if ([elementName isEqualToString:@"getPurposeListResponse"])
        {
            
            for (int i=1; i<[purposeListDataAry count]; i++)
            {
                
                purposeeListSplitary = [[purposeListDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[purposeeListSplitary count]; j++)
                {
                    purposeCodeIDStr = [[purposeeListSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"CodeId==" withString:@""];
                    
                    puurposeStr  = [[purposeeListSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Purpose==" withString:@""];
                    
                }
                
                
                [purposeCodeIDAry addObject:purposeCodeIDStr];
                [puurposeAry addObject:puurposeStr];
                
                
                NSLog(@"split  is %@,%@",purposeCodeIDAry,puurposeAry);
                
                
                
            }
            
        }
        
    }
    
    
    
    
    
    else if (parser == xmlParser3)
    {
        if ([elementName isEqualToString:@"resListFrProjectResponse"])
        {
            
            for (int i=1; i<[resourceDataAry count]; i++)
            {
                
                resourceSplitary = [[resourceDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                
                resourceIdStr = [[resourceSplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"RESOURCE_ID==" withString:@""];
                
                resourceNameStr  = [[resourceSplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"RESOURCE_NAME==" withString:@""];
                
                string1=[resourceNameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                [resourceIdAry addObject:resourceIdStr];
                [resourceNameAry addObject:string1];
                
                
            }
            
            
            NSLog(@"resource lsit is %@",resourceIdAry);
            NSLog(@"resource name is %@",resourceNameAry);
            
            
            resourcenamearray=[NSMutableArray arrayWithArray:resourceNameAry];
            resourceidarray=[NSMutableArray arrayWithArray:resourceIdAry];
            NSLog(@"the resource name array values for resource field is %@",resourcenamearray);
            NSLog(@"the resource id array values for resource field is %@",resourceidarray);
            
        }
     
        
    }
    
    
    else  if (parser == xmlParser4)
    {
        
        
        if ([elementName isEqualToString:@"getComplexityListResponse"])
        {
            
            for (int i=1; i<[complexityDataAry count]; i++)
            {
                
                complexitySplitary=[[complexityDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[complexitySplitary count]; j++)
                {
                    complexityCodeIdStr = [[complexitySplitary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"CodeId==" withString:@""];
                    
                    complexityStr  = [[complexitySplitary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Complexity==" withString:@""];
                    
                }
                
                
                [complexityCodeIdAry addObject:complexityCodeIdStr];
                [complexityAry addObject:complexityStr];
                NSLog(@"split  is %@,%@",complexityCodeIdAry,complexityAry);
                
                
            }
            
        }
        
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [objLstIdAry count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    [cell.contentView.layer setBorderColor:[UIColor greenColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    
    // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
    nameLbl.font=[UIFont systemFontOfSize:25];
    nameLbl.text = [objLstTypeAry objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"WELCOME";
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    nameLbl2.text= [objLstcomplexityAry objectAtIndex:indexPath.row];
    
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:25];
    nameLbl3.text= [objLstPurposeAry objectAtIndex:indexPath.row];
    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
    nameLbl4.font=[UIFont systemFontOfSize:25];
    nameLbl4.text= [objLstResourceNameAry objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [saveBtn setHidden:YES];
    [updateBtn setHidden:NO];
    
    objectTypeTfd.text = [objLstTypeAry objectAtIndex:indexPath.row];
    objectNameTfd.text = [objLstObjNameAry objectAtIndex:indexPath.row];
    purposeTfd.text = [objLstPurposeAry objectAtIndex:indexPath.row];
    exixtingTfd.text = [objLstExistingNewAry objectAtIndex:indexPath.row];
    approvalTfd.text = [tblLstAppAry objectAtIndex:indexPath.row];
    resourceTfd.text = [objLstResourceNameAry objectAtIndex:indexPath.row];
    complexityTfd.text = [objLstcomplexityAry objectAtIndex:indexPath.row];
    commentsTextView.text = [objLstCommentArry objectAtIndex:indexPath.row];
    
    pkrReqProectIDStr = [objLstIdAry objectAtIndex:indexPath.row];
    
    NSLog(@"resource name array is %@",resourcenamearray);
    
    [self resourceSpinnerListService];
    
    NSString *tempString1 = objectTypeTfd.text;
    for(int i=0; i<[objectTypeArray count]; i++)
    {
        if([tempString1 isEqualToString:[objectTypeArray objectAtIndex:i]])
        {
            
            pkrObjectTypeIDStr = [codeIDArray objectAtIndex:i];
            
            
        }
    }
    
    NSString *tempString2 = purposeTfd.text;
    for(int i=0; i<[puurposeAry count]; i++)
    {
        if([tempString2 isEqualToString:[puurposeAry objectAtIndex:i]])
        {
            
            pkrPurposeIDStr = [purposeCodeIDAry objectAtIndex:i];
            
            
        }
        
    }
    
    
    NSString *tempString3 = resourceTfd.text;
    NSLog(@"%@ fghjkl",resourceTfd.text);
    NSLog(@"resource name array is shaikkkkkkkk%@",resourcenamearray);
    NSLog(@"object list resource name array is 2222222%@",objLstResourceNameAry);
    
    
        for(int i=0; i<[resourcenamearray count]; i++)
    {
        if([tempString3 isEqualToString:[resourcenamearray objectAtIndex:i]])
        {
            
            pkrResourceIDStr = [resourceidarray objectAtIndex:i];
            
            
        }
        NSLog(@"pkr resource shaik is %@",pkrResourceIDStr);
        
    }
    
    NSString *tempString4 = complexityTfd.text;
    for(int i=0; i<[complexityAry count]; i++)
    {
        if([tempString4 isEqualToString:[complexityAry objectAtIndex:i]])
        {
            
            pkrComplexityIDStr = [complexityCodeIdAry objectAtIndex:i];
            
            
        }
        
    }
    
    NSLog(@"1 %@",pkrObjectTypeIDStr);
    NSLog(@"2 %@",pkrPurposeIDStr);
    
    NSLog(@"3 %@",pkrResourceIDStr);
    NSLog(@"4 %@",pkrComplexityIDStr);
    NSLog(@"5 %@",pkrReqProectIDStr);
    
    
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
        return [objectTypeArray count];
    }
    if (picker.tag==101) {
        return [puurposeAry count];
    }
    if (picker.tag==102) {
        return [existingAndApprovalAry count];
    }
    if (picker.tag==103) {
        return [existingAndApprovalAry count];
    }
    if (picker.tag==104)
    {
        return [resourcenamearray count];
        
    }
    if (picker.tag==105) {
        return [complexityAry count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [objectTypeArray objectAtIndex:row];
    }
    else if (picker.tag==101) {
        return [puurposeAry objectAtIndex:row];
        
    }
    else if (picker.tag==102) {
        return [existingAndApprovalAry objectAtIndex:row];
    }
    else if (picker.tag==103) {
        return [existingAndApprovalAry objectAtIndex:row];
    }
    else if (picker.tag==104)
    {
        return [resourcenamearray objectAtIndex:row];
        
    }
    else if (picker.tag==105)
    {
        return [complexityAry objectAtIndex:row];
        
    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        objectTypeTfd.text=[objectTypeArray objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        pkrObjectTypeIDStr = [codeIDArray objectAtIndex:row];
        
    }
    else if (pickerView.tag==101)
    {
        purposeTfd.text=[puurposeAry objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        pkrPurposeIDStr = [purposeCodeIDAry objectAtIndex:row];
    }
    
    else if (pickerView.tag==102)
    {
        exixtingTfd.text=[existingAndApprovalAry objectAtIndex:row];
        //[questionpkr removeFromSuperview];
    }
    else if (pickerView.tag==103)
    {
        approvalTfd.text=[existingAndApprovalAry objectAtIndex:row];
        //[questionpkr removeFromSuperview];
    }
    else if (pickerView.tag==104)
    {
        resourceTfd.text=[resourcenamearray objectAtIndex:row];
        pkrResourceIDStr = [resourceidarray objectAtIndex:row];
         [questionpkr removeFromSuperview];
    }
    else if (pickerView.tag==105)
    {
        complexityTfd.text=[complexityAry objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        pkrComplexityIDStr = [complexityCodeIdAry objectAtIndex:row];
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
    [self.scrollView setScrollEnabled:YES];
    [questionpkr removeFromSuperview];
    [commentsTextView resignFirstResponder];
    
}



//Text view deligate methods

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewDidBeginEditing:");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.view.frame;
    frame.origin.y =frame.origin.y -253;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    /*YOUR CODE HERE*/
}
-(void)textViewDidChange:(UITextView *)textView
{
    
}
-(void)textViewDidChangeSelection:(UITextView *)textView
{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textViewDidEndEditing:");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y + 253;
    [self.view setFrame:frame];
    [UIView commitAnimations];
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
