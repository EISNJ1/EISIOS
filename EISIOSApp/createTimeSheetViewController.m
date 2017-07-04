//
//  createTimeSheetViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "createTimeSheetViewController.h"

@interface createTimeSheetViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation createTimeSheetViewController

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
    
    
    

    
    //----------------view back ground stroke--------------------//
    createTimeShhetView.layer.cornerRadius = createTimeShhetView.frame.size.width / 2;
    createTimeShhetView.clipsToBounds = YES;
    createTimeShhetView.layer.borderWidth = 3.0f;
    createTimeShhetView.layer.borderColor = [UIColor cyanColor].CGColor;
    createTimeShhetView.layer.cornerRadius = 10.0f;
    createTimeShhetView.layer.cornerRadius=4;

    //-------------------Right side pop Button---------------------//
  
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];

    
    //-------------------picker dummy data-------------------------//
    pickerAry = [[NSArray alloc]initWithObjects:@"anjan",@"kumar",@"balu",@"raj", nil];
    taskCompletedAry = [[NSArray alloc]initWithObjects:@"Y",@"N", nil];
    
    //-------------------service parameters data------------------//
    //[self DatafromDB];
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];

    

    //------------Task Spinner,Project Spinner And Save Details Service Calling-------------//
    NSLog(@"user id str is 2222%@",Useridstr);
    
    
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"userType":UserTypestr, @"userId":Useridstr,@"orgID":OrgIdStr};
    [Servicecall createTimeSheetProject:projectLstForTask PublicDiscredentilas:credentials];
    [Servicecall setDelegate:self];

    
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
    [hoursSpendTfd resignFirstResponder];
    [estdHrsTfd resignFirstResponder];
    [reasonsTfd resignFirstResponder];
    
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touchObj = [touches anyObject];
//    CGPoint pnt = [touchObj locationInView:self.view];
//    [questionpkr removeFromSuperview];
//    [datePkr removeFromSuperview];
//    [hoursSpendTfd resignFirstResponder];
//    [estdHrsTfd resignFirstResponder];
//    [reasonsTfd resignFirstResponder];
//    
//}
-(void)userTapped
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    [hoursSpendTfd resignFirstResponder];
    [estdHrsTfd resignFirstResponder];
    [reasonsTfd resignFirstResponder];

}

-(void)DatafromDB
{
    appDel = [[UIApplication sharedApplication] delegate];
    objectContext = appDel.managedObjectContext;
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:objectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:entityDesc];
    
    NSError *error = nil;
    NSArray *picArray = [objectContext executeFetchRequest:fetchRequest error:&error];
    for(NSManagedObject *managedObject in picArray)
    {
        
        Usernamestr  = [managedObject valueForKey:@"username"];
        Useridstr  = [managedObject valueForKey:@"userid"];
        UserTypestr = [managedObject valueForKey:@"userType"];
        OrgIdStr = [managedObject valueForKey:@"orgId"];
    }
}

-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    //NSLog(@"the project spinner data is %@",Userlogindetails);
    
}

-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    //NSLog(@"the project spinner data is %@",actionitemlist);
}
-(void)didNotesCountFinished :(id)Notescountlist
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    
    saveTimeSheetXmlParser=[[NSXMLParser alloc]initWithData:Notescountlist];
    saveTimeSheetXmlParser.delegate=self;
    [saveTimeSheetXmlParser parse];
    
    //NSLog(@"the project spinner data is %@",Notescountlist);
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"projectLstForTaskResponse"])
    {
        projectliststring       = [[NSString alloc] init];
        
        PROJECT_IDArray         = [[NSMutableArray alloc] init];
        
        PROJECT_NAMEArray       = [[NSMutableArray alloc] init];
        
        Projectlistdataarray    = [[NSArray alloc] init];
        
        projectlistsplitarray   = [[NSArray alloc] init];
        
    }
    if ([elementName isEqualToString:@"taskListForTimeSheetResponse"])
    {
        Timesheetstring      = [[NSString alloc] init];
        
        TimeTASK_IDArray     = [[NSMutableArray alloc] init];
        
        TimeTASK_NAMEArray   = [[NSMutableArray alloc] init];
        
        TimeSplitarray       = [[NSArray alloc] init];
        
        Timetaskdataarray    = [[NSArray alloc] init];
        
        TaskStartDateArray=[[NSMutableArray alloc]init];
        
        TaskEnddateArray=[[NSMutableArray alloc]init];
        
    }
    if ([elementName isEqualToString:@"saveTimeSheetResponse"])
    {
        Timesheetstring      = [[NSString alloc] init];
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
        else
        {
            NSString *chandu = @"*********";
            projectliststring= [projectliststring stringByAppendingString:chandu];
            projectliststring= [projectliststring stringByAppendingString:string];
            NSLog(@"project name details are %@",string);
            Projectlistdataarray =[projectliststring componentsSeparatedByString:@"*********"];
        }
    }
    
    if (parser == xmlParser1)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
        
        NSString *chandu = @"*********";
        
        
        Timesheetstring= [Timesheetstring stringByAppendingString:chandu];
        
        Timesheetstring= [Timesheetstring stringByAppendingString:string];
        NSLog(@"agenda details are test %@",Timesheetstring);
        Timetaskdataarray =[Timesheetstring componentsSeparatedByString:@"*********"];
        }
        
    }
    if (parser == saveTimeSheetXmlParser)
    {
        if ([string isEqualToString:@"Weekend"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Timesheet cant submitted on Weekend" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            NSString *chandu = @"*********";
            
            
            Timesheetstring= [Timesheetstring stringByAppendingString:chandu];
            
            Timesheetstring= [Timesheetstring stringByAppendingString:string];
            NSLog(@"agenda details are test %@",Timesheetstring);
            Timetaskdataarray =[Timesheetstring componentsSeparatedByString:@"*********"];
        }
        
    }
    
   
    
   
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            
            for (int i=1; i<[Projectlistdataarray count]; i++)
            {
                
                projectlistsplitarray=[[Projectlistdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                for (int j=1; j<[projectlistsplitarray count]; j++)
                {
                    projectidstr = [[projectlistsplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"PROJECT_ID==" withString:@""];
                    projectnamestr  = [[projectlistsplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                }
                
                
                [PROJECT_IDArray addObject:projectidstr];
                [PROJECT_NAMEArray addObject:projectnamestr];
                NSLog(@"project names array %@",PROJECT_NAMEArray);
            }
            
            if ([PROJECT_NAMEArray count]>0)
            {
                projectTfd.text=[PROJECT_NAMEArray objectAtIndex:0];
                pkrSelectionProjectId = [PROJECT_IDArray objectAtIndex:0];
                NSLog(@"project id is 22222sss%@",pkrSelectionProjectId);
                [self tasklListForTimeSheet];
            }
            
//            projectpicker = [[UIPickerView alloc] init];
//            
//            [projectpicker setDataSource: self];
//            
//            [projectpicker setDelegate: self];
//            
//            [projectpicker setFrame: CGRectMake(589,154, 250, 162.0f)];
//            
//            projectpicker.showsSelectionIndicator = YES;
//            
//            [projectpicker selectRow:2 inComponent:0 animated:YES];
//            [self.view addSubview:projectpicker];
        }
       
    }
    
    
    
    
    if (parser == xmlParser1)
    {
        
        
        if ([elementName isEqualToString:@"taskListForTimeSheetResponse"])
        {
            for (int i=1; i<[Timetaskdataarray count]; i++)
            {
                
                TimeSplitarray=[[Timetaskdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",projectlistsplitarray);
                
                for (int j=1; j<[TimeSplitarray count]; j++)
                {
                    TimesheetTaskIdstr = [[TimeSplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"TASK_ID==" withString:@""];
                    TimeTASK_NAMEStr  = [[TimeSplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"TASK_NAME==" withString:@""];
                    
                    startDateStr=[[TimeSplitarray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"TASK_STARTDATE==" withString:@""];
                    endDateStr=[[TimeSplitarray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"TASK_ENDATE==" withString:@""];
                    
                }
                
                
                [TimeTASK_IDArray addObject:TimesheetTaskIdstr];
                [TimeTASK_NAMEArray addObject:TimeTASK_NAMEStr];
                [TaskStartDateArray addObject:startDateStr];
                [TaskEnddateArray addObject:endDateStr];
                
                NSLog(@"start date array  is %@",TaskStartDateArray);
                NSLog(@"end date array  is %@",TaskEnddateArray);
                
                if ([TimeTASK_NAMEArray count] > 0)
                {
                    taskTfd.text=[TimeTASK_NAMEArray objectAtIndex:0];
                    pkrSelectionTaskId = [TimeTASK_IDArray objectAtIndex:0];
                }

                

                
            }
           
            //            taskpicker = [[UIPickerView alloc] init];
//            
//            [taskpicker setDataSource: self];
//            
//            [taskpicker setDelegate: self];
//            
//            [taskpicker setFrame: CGRectMake(589,194, 250, 162.0f)];
//            
//            taskpicker.showsSelectionIndicator = YES;
//            
//            [taskpicker selectRow:2 inComponent:0 animated:YES];
//            [self.view addSubview:taskpicker];
        }
    }

    

    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [PROJECT_NAMEArray count];
    }
    if (picker.tag==101) {
        return [TimeTASK_NAMEArray count];
    }
    else{
        return [taskCompletedAry count];

    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [PROJECT_NAMEArray objectAtIndex:row];
    }
    if (picker.tag==101) {
        return [TimeTASK_NAMEArray objectAtIndex:row];
    }
    else{
        return [taskCompletedAry objectAtIndex:row];

    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
       
        taskTfd.text = nil;
        pkrSelectionTaskId = nil;
        
        projectTfd.text=[PROJECT_NAMEArray objectAtIndex:row];
        NSLog(@"the project id isssssssss  %@ %@",[PROJECT_IDArray objectAtIndex:row],[PROJECT_NAMEArray objectAtIndex:row]);
        pkrSelectionProjectId = [PROJECT_IDArray objectAtIndex:row];
        
        [self tasklListForTimeSheet];
        //[questionpkr removeFromSuperview];
       

    }
    if (pickerView.tag==101)
    {
        

        taskTfd.text=[TimeTASK_NAMEArray objectAtIndex:row];
        NSLog(@"the time id isssssssss  %@ %@",[TimeTASK_IDArray objectAtIndex:row],[TimeTASK_NAMEArray objectAtIndex:row]);
        pkrSelectionTaskId = [TimeTASK_IDArray objectAtIndex:row];

        startDateStr1=[TaskStartDateArray objectAtIndex:row];
        endDateStr1=[TaskEnddateArray objectAtIndex:row];

    }
    
    if (pickerView.tag==102)
    {
            taskCompletedTfd.text=[taskCompletedAry objectAtIndex:row];
            //[questionpkr removeFromSuperview];
            
        }
    
    else{
        //taskTfd.text=[pickerAry objectAtIndex:row];

    }
    
    
    
}

//-(void) dueDateChanged2:(UIDatePicker *)sender
//{
//    
//   
//    //[dateTfd resignFirstResponder];
//    
//}

-(void)tasklListForTimeSheet
{
    NSLog(@"project selection is is %@",pkrSelectionProjectId);
    NSLog(@"user type is %@",UserTypestr);
    NSLog(@"userid str is %@",Useridstr);
    NSLog(@"orgid str is %@",OrgIdStr);
    Servicecall=[[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
NSDictionary *credentials1 =@{@"userType":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr,@"projectId":pkrSelectionProjectId};
    [Servicecall createTimeSheetTask:projectLstForTask PublicDiscredentilas:credentials1];
    [Servicecall setDelegate:self];
}

-(void)homeBtnClk
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
-(void)logOutBtnClk
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [alertView show];
    
    
    
}
//Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSLog(@"clickedButtonAtIndex and button index is %d",buttonIndex);
        
        
    }
    else {
        
        
        NSLog(@"clickedButtonAtIndex and button index is %d",buttonIndex);
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}


-(void)createTimeetActionBtnClk
{
    if (popController.popoverVisible) {
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
    [EvaluateBtn setTitle:@"Evaluate TimeSheet" forState:UIControlStateNormal];
    EvaluateBtn.tag= 102;
    //[Chequebtn setBackgroundColor:[UIColor grayColor]];
    [EvaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    EvaluateBtn.frame=CGRectMake(20, 10, 150, 40);
    [EvaluateBtn addTarget:self action:@selector(Evaluate) forControlEvents:UIControlEventTouchDown];
    // [contentViewController.view addSubview:Chequebtn];
    [view1 addSubview:EvaluateBtn];
    
    
    UIButton * statusBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [statusBtn setTitle:@"STATUS" forState:UIControlStateNormal];
    [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    statusBtn.tag = 101;
    statusBtn.frame=CGRectMake(20, 60, 60, 40);
    [statusBtn addTarget:self action:@selector(status) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:statusBtn];

        
    [popController presentPopoverFromBarButtonItem:createTimeSheetActionBarBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)Evaluate
{

//    [popController dismissPopoverAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    [popController dismissPopoverAnimated:YES];
    TimeSheetViewController *TimeSheetView = (TimeSheetViewController *)[self.navigationController.viewControllers objectAtIndex:2];
    [self.navigationController popToViewController:TimeSheetView animated:YES];

}
-(void)status
{
    [popController dismissPopoverAnimated:YES];
    statusTimeSheetViewController *statusTimeSheetView = [[statusTimeSheetViewController alloc]init];
    statusTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"statusTimeSheet"];
    [self.navigationController pushViewController:statusTimeSheetView animated:YES];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [hoursSpendTfd resignFirstResponder];
    [estdHrsTfd resignFirstResponder];
    [reasonsTfd resignFirstResponder];
    
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    
    if(textField == projectTfd) {
        
       

        
        
    }
    if (textField == taskTfd ) {
        
        
    }
    
    if (textField == dateTfd ) {
        
        
        
    }
        if (textField == taskCompletedTfd ) {
        
       
        
    }
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    if(textField == projectTfd) {
        
        
    }
    else if (textField == taskTfd ) {
        
                
    }
  
    else if (textField == reasonsTfd ) {
        
                NSLog(@"textViewDidBeginEditing:");
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.25f];
                CGRect frame = self.view.frame;
                frame.origin.y =frame.origin.y -180;
                [self.view setFrame:frame];
                [UIView commitAnimations];
    }

    else
    {
//        NSLog(@"textViewDidBeginEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y =frame.origin.y -180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [hoursSpendTfd resignFirstResponder];
    [estdHrsTfd resignFirstResponder];
    [reasonsTfd resignFirstResponder];
    if (textField == estdHrsTfd) {
        if ([estdHrsTfd.text length] > 0)
        {
            taskCompletedTfd.text = @"N";

        }
        else{
            taskCompletedTfd.text = @"Y";

        }
    }
    if (textField.tag==7 )
    {
    }
    
    else if (textField.tag==6)
    {
        
    }
    else if (textField == reasonsTfd ) {
        
                NSLog(@"textViewDidEndEditing:");
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.25f];
                CGRect frame = self.view.frame;
                frame.origin.y = frame.origin.y + 180;
                [self.view setFrame:frame];
                [UIView commitAnimations];
    }
    else
    {
//        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
    }
    
}
-(IBAction)projectPkrBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(255, 93, self.view.frame.size.width-388, 300)];//380
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    //[createTimeShhetView addSubview:questionpkr];

}
-(IBAction)taskPkrBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(255, 189, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [self.view addSubview:questionpkr];

}
-(IBAction)datePkrBtnClk:(id)sender
{
//    for (int i=0; i<[TimeTASK_NAMEArray count]; i++)
//    {
//        startDateStr1=[TaskStartDateArray objectAtIndex:i];
//        endDateStr1=[TaskEnddateArray objectAtIndex:i];
//    }
    NSLog(@"start date %@",startDateStr1);
    NSLog(@"end date  %@",endDateStr1);
    
    [questionpkr removeFromSuperview];

    datePkr = [[UIDatePicker alloc] init];
    datePkr.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    datePkr.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startdate=[[NSDate alloc]init];
    startdate=[dateFormatter dateFromString:startDateStr1];
    
    
    NSDate *enddate=[[NSDate alloc]init];
    enddate=[dateFormatter dateFromString:endDateStr1];
    
    NSLog(@"start date is 11%@",startdate);
    NSLog(@"end date is22 %@",enddate);
    
    [datePkr setMaximumDate:enddate];
    [datePkr setMinimumDate:startdate];
    [datePkr addTarget:self action:@selector(dueDateChanged2:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [datePkr sizeThatFits:CGSizeZero];
    datePkr.frame = CGRectMake(0.0, 250, pickerSize.width, 460);
    datePkr.backgroundColor = [UIColor whiteColor];
    [createTimeShhetView addSubview:datePkr];

}
-(void)dueDateChanged2:(UIDatePicker *)sender
{
//    NSLog(@"startdate is %@",startDateStr);
//    NSLog(@"endd date is %@",endDateStr);
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    dateTfd.text= [dateFormatter stringFromDate:[sender date]];
    
}

-(IBAction)taskCompletedPkrBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(255, 619, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 102;
    questionpkr.backgroundColor=[UIColor grayColor];
    //[self.view addSubview:questionpkr];
    [createTimeShhetView addSubview:questionpkr];

}
-(IBAction)saveBtnClk:(id)sender
{
        
    if (([projectTfd.text length] == 0)|| ([taskTfd.text length ]== 0) || ([hoursSpendTfd.text length]== 0) || ([dateTfd.text length]== 0)|| /*([estdHrsTfd.text length] == 0) || */ ([taskCompletedTfd.text length] == 0) )
    
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Time Sheet Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
    }
    else{
        
        if ([taskCompletedTfd.text isEqualToString:@"N"])
        {
            
            NSLog(@"service calling");
            
            NSString *saveTimeSheet = @"SaveAndUpdateTaskService";
            NSDictionary *credentials2 = @{@"taskId":pkrSelectionTaskId,@"submitDate":dateTfd.text,@"hoursSpent":hoursSpendTfd.text,@"estHrsCompl":estdHrsTfd.text,@"isTaskComplited":taskCompletedTfd.text,@"resourceId":Useridstr,@"projectId":pkrSelectionProjectId,@"reason":reasonsTfd.text };
            [Servicecall saveTimeSheet:saveTimeSheet PublicDiscredentilas:credentials2];
            [Servicecall setDelegate:self];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
//            int a = [hoursSpendTfd.text intValue];
//            int b = [estdHrsTfd.text intValue];
//            if (b>a)
//            {
//                if ([reasonsTfd.text length]== 0) {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter The Reason" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//                    [alertView show];
//
//                }
//                else{
//                    NSLog(@"service calling");
//                    
//                    NSString *saveTimeSheet = @"SaveAndUpdateTaskService";
//                    NSDictionary *credentials2 = @{@"taskId":pkrSelectionTaskId,@"submitDate":dateTfd.text,@"hoursSpent":hoursSpendTfd.text,@"estHrsCompl":estdHrsTfd.text,@"isTaskComplited":taskCompletedTfd.text,@"resourceId":Useridstr,@"projectId":pkrSelectionProjectId,@"reason":reasonsTfd.text };
//                    [Servicecall saveTimeSheet:saveTimeSheet PublicDiscredentilas:credentials2];
//                    [Servicecall setDelegate:self];
//                    
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//                    [alertView show];
//                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
//                    
//
//
//                }
//                
//            }
            
            
        }
        
        
        
        
        else if ([taskCompletedTfd.text isEqualToString:@"Y"])
        {
            
            
            NSLog(@"service Calling");
            
            NSString *saveTimeSheet = @"SaveAndUpdateTaskService";
            NSDictionary *credentials2 = @{@"taskId":pkrSelectionTaskId,@"submitDate":dateTfd.text,@"hoursSpent":hoursSpendTfd.text,@"estHrsCompl":estdHrsTfd.text,@"isTaskComplited":taskCompletedTfd.text,@"resourceId":Useridstr,@"projectId":pkrSelectionProjectId,@"reason":reasonsTfd.text };
            [Servicecall saveTimeSheet:saveTimeSheet PublicDiscredentilas:credentials2];
            [Servicecall setDelegate:self];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
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
