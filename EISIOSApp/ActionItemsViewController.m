//
//  ActionItemsViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/18/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "ActionItemsViewController.h"
#import "Toast+UIView.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#define LEAGELNUM @"0123456789"
@interface ActionItemsViewController ()
{ UILabel *createdOnLabel;
        NSString * Flag;
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    NSString *MeetingId;
    
    NSXMLParser *AssignedToxmlParser,*SaveactionitemxmlParser,*ActionitemListxmlParser,*SavenotesxmlParser,*notesListxmlParser,*FeedBackListxmlParser,*FeedBackSavexmlParser;
    //----------------------PickerArrays-----------------
    NSArray *PriorityArray,*EffortUOmArrray;
    
    //--------------------AssigneTo----------------------
    
    NSMutableArray *AssignedToListArray,*ResourceIdArray,*ResourceNameArray;
    NSString *ResourceIdstr;
    NSArray *AssignedTosplitArray;
    
    //--------------------SaveAction items-------------------
    NSMutableArray *SavedActionitemDescriptionArray,*SavedPriorityArray,*SavedAssignedToArray,*ActionitemSavedList;
    NSArray *SavedSplitArray;
    
    //-------------------Notes----------------------
    NSString *publicPriv;
    NSMutableArray *NoteDescriptionArray,*NotePublicArray,*NoteRefrenceArray,*NotesListArray;
    NSArray *NotesSplitArray;
    
    //---------------FeedBack----------------
    
    NSMutableArray *PositiveDescArray,*NegativeDescArray,*FeedbackListArray;
    NSArray *FeedbackSplitArray;
    
}
@end

@implementation ActionItemsViewController
@synthesize projectId;
//-(void)DatafromDB
//{
//    
//
//
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
//        Useridstr    = [managedObject valueForKey:@"userid"];
//        orgIdstr     = [managedObject valueForKey:@"orgId"];
//        Usertypestr  = [managedObject valueForKey:@"userType"];
//        NSLog(@"detaisl %@ %@ ",orgIdstr,Useridstr);
//        
//        
//    }
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
    //self.view.translatesAutoresizingMaskIntoConstraints = YES;
    // [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
   
    PriorityArray  =[[NSArray alloc]initWithObjects:@"High",@"Low",@"Medium", nil];
    EffortUOmArrray=[[NSArray alloc]initWithObjects:@"Weeks",@"Days",nil];
    Servicecall = [[Webservices alloc]init];
    //[self DatafromDB];
 
    projectId1=projectId;
    NSLog(@"the project id is %@",projectId1);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    NSUserDefaults *StoredValues =[ NSUserDefaults standardUserDefaults];
    MeetingId=[StoredValues objectForKey:@"MeetingId"];
    NSLog(@"MeetingId %@",MeetingId);
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f]];
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    
    
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:Logoutpagebatbtn,Homepagebatbtn,nil];
    
    
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
    
    
    CGRect frame= SegmentControl.frame;
    [SegmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 60)];
    SegmentControl.tintColor =[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f];
    [SegmentControl setSelectedSegmentIndex:1];
    Flag = @"ActionItems";
    [self ActionitemsList];
    
    
    
    
    [ActionitemsTV removeFromSuperview];
    ActionitemsTV = [[UITableView alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 200)
                                                 style:UITableViewStylePlain];
    ActionitemsTV.backgroundColor = [UIColor lightGrayColor];
    ActionitemsTV.delegate = self;
    ActionitemsTV.dataSource = self;
    ActionitemsTV.tag = 2;
    [ScrollV addSubview:ActionitemsTV];
    [SegmentControl addTarget:self action:@selector(SegmentIndexTapped) forControlEvents:UIControlEventValueChanged];
    
    ActionitemDetialsView =(UIView *)[self.view viewWithTag:10];
    ActionitemDetialsView.tag= 3;
    ActionitemDetialsView.layer.cornerRadius = 15;
    ActionitemDetialsView.layer.borderWidth  = 2;
    ActionitemDetialsView.layer.borderColor  = [UIColor blackColor].CGColor;
    
    
    assigntoTxtfld = (UITextField *)[ActionitemDetialsView viewWithTag:2];
    assigntoTxtfld.layer.cornerRadius = 15;
    assigntoTxtfld.layer.borderWidth  = 2;
    assigntoTxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    assigntoTxtfld.delegate = self;
    UIButton *AssignTobtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [AssignTobtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    AssignTobtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [AssignTobtnpkr addTarget:self action:@selector(AssignToPickerTapped) forControlEvents:UIControlEventTouchUpInside];
    assigntoTxtfld.rightView = AssignTobtnpkr;
    assigntoTxtfld.rightViewMode = UITextFieldViewModeAlways;
    [assigntoTxtfld addSubview:AssignTobtnpkr];

    
    
    
    Duedatetxtfld = (UITextField *)[ActionitemDetialsView viewWithTag:7];
    Duedatetxtfld.layer.cornerRadius = 15;
    Duedatetxtfld.layer.borderWidth  = 2;
    Duedatetxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    Duedatetxtfld.delegate = self;
    UIButton *Datebtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Datebtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Datebtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Datebtnpkr addTarget:self action:@selector(DatePickerTapped) forControlEvents:UIControlEventTouchUpInside];
    Duedatetxtfld.rightView = Datebtnpkr;
    Duedatetxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Duedatetxtfld addSubview:Datebtnpkr];

    
    
    
    Prioritytxtfld = (UITextField *)[ActionitemDetialsView viewWithTag:4];
    Prioritytxtfld.layer.cornerRadius = 15;
    Prioritytxtfld.layer.borderWidth  = 2;
    Prioritytxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    Prioritytxtfld.delegate = self;
    UIButton *Prioritybtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Prioritybtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Prioritybtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Prioritybtnpkr addTarget:self action:@selector(priorityPickerTapped) forControlEvents:UIControlEventTouchUpInside];
    Prioritytxtfld.rightView = Prioritybtnpkr;
    Prioritytxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Prioritytxtfld addSubview:Prioritybtnpkr];

    
    
    
    Effortrequiredtxtfld = (UITextField *)[ActionitemDetialsView viewWithTag:5];
    Effortrequiredtxtfld.layer.cornerRadius = 15;
    Effortrequiredtxtfld.layer.borderWidth  = 2;
    Effortrequiredtxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    Effortrequiredtxtfld.delegate = self;
    
    EffortUomtxtfld = (UITextField *)[ActionitemDetialsView viewWithTag:6];
    EffortUomtxtfld.layer.cornerRadius = 15;
    EffortUomtxtfld.layer.borderWidth  = 2;
    EffortUomtxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    EffortUomtxtfld.delegate = self;
    EffortUombtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [EffortUombtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    EffortUombtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [EffortUombtnpkr addTarget:self action:@selector(EffortUOMPickerTapped) forControlEvents:UIControlEventTouchUpInside];
    EffortUomtxtfld.rightView = EffortUombtnpkr;
    EffortUomtxtfld.rightViewMode = UITextFieldViewModeAlways;
    [EffortUomtxtfld addSubview:EffortUombtnpkr];

    
    
    ActiondisTextView = (UITextView *)[ActionitemDetialsView viewWithTag:1];
    ActiondisTextView.layer.cornerRadius = 15;
    ActiondisTextView.layer.borderWidth  = 2;
    ActiondisTextView.layer.borderColor  = [UIColor blackColor].CGColor;
    ActiondisTextView.returnKeyType = UIReturnKeyDone;
    ActiondisTextView.delegate = self;
    
    Savebtn = (UIButton *)[self.view viewWithTag:1];
    Savebtn.frame=CGRectMake(250, 100, 30, 30);
    Savebtn.layer.cornerRadius = 10;
    Savebtn.layer.borderWidth  = 2;
    
    
    //Backbtn = (UIButton *)[self.view viewWithTag:4];
    //Backbtn.layer.cornerRadius = 10;
    //Backbtn.layer.borderWidth  = 2;
    //[Backbtn addTarget:self action:@selector(BackbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    Homebtn = (UIButton *)[self.view viewWithTag:2];
    Homebtn.layer.cornerRadius = 10;
    Homebtn.layer.borderWidth  = 2;
    [Homebtn addTarget:self action:@selector(HomePagebtnTapped1) forControlEvents:UIControlEventTouchUpInside];
    
    

    
  [super viewDidLoad];
    
  
}
-(void)HomePagebtnTapped1
{
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}
-(void)ActionitemsList
{
 NSString *Saveactionitemsurl = @"ActionItemsTabListService";
 NSDictionary *credentials = @{@"userId":Useridstr,@"agendaId":_ObjIdstr};
    [Servicecall SaveActionItemTablist:Saveactionitemsurl ActionItemListDictionary:credentials];
[Servicecall setDelegate:self];
}

-(void)NotesList
{
    NSString *Saveactionitemsurl = @"NotesTabDisplayService";
    NSDictionary *credentials = @{@"objectId":_ObjIdstr,@"userId":Useridstr};
    [Servicecall NotesList:Saveactionitemsurl NotesListParametrs:credentials];
    [Servicecall setDelegate:self];
}
-(void)FeedbackList
{
    NSLog(@"agenda meeting id is %@",_AgendaBasedMeetingIdstr);
    NSString *Feedbackurl = @"FeedbackListService";
    NSDictionary *credentials = @{@"userId":Useridstr,@"meetingId":_AgendaBasedMeetingIdstr};
    [Servicecall Feedbacklisturl:Feedbackurl FeedbackCredentials:credentials];
    [Servicecall setDelegate:self];
    }
-(void)AssignToPickerTapped
{
    [DatePicker removeFromSuperview];
    NSString *AssignedTourl = @"ActionItemsTabAssignedToService";
    NSDictionary *credentials = @{@"projectId":projectId1};
    NSLog(@"hai%@",projectId1);
    [Servicecall AssignedTourl:AssignedTourl AssignedValues:credentials];
    [Servicecall setDelegate:self];
    
    [PickerView removeFromSuperview];
    PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(320, 475, self.view.frame.size.width-300, 350)];
    [PickerView setShowsSelectionIndicator:YES];
    PickerView.delegate = self;
    PickerView.dataSource = self;
    PickerView.tag = 1;
    PickerView.backgroundColor=[UIColor grayColor];
    PickerView.alpha = 0;
    [ContentView addSubview:PickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    PickerView.transform = transfrom;
    PickerView.alpha = PickerView.alpha * (-1) + 1;
    [UIView commitAnimations];
}
-(void)DatePickerTapped

{ 
    [PickerView removeFromSuperview];
    [DatePicker removeFromSuperview];
    DatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(315, 510,self.view.frame.size.width-400 , 350)];
    [DatePicker addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventValueChanged];
    DatePicker.backgroundColor=[UIColor whiteColor];
    [Duedatetxtfld setInputView:DatePicker];
    DatePicker.datePickerMode = UIDatePickerModeDate;
    DatePicker.backgroundColor=[UIColor grayColor];
    [DatePicker setMinimumDate: [NSDate date]];
    DatePicker.backgroundColor=[UIColor grayColor];
    DatePicker.alpha = 0;
    [ContentView addSubview:DatePicker];
    UIToolbar* pickerTB = [[UIToolbar alloc]initWithFrame:CGRectMake(-0, -40, 367, 44)];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton)];
    NSArray *itemsArray = [NSArray arrayWithObjects:doneButton, nil];
    [pickerTB setItems:itemsArray];
    [pickerTB setTintColor:[UIColor greenColor]];
    [pickerTB setBarStyle:UIBarStyleBlackTranslucent];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    DatePicker.transform = transfrom;
    DatePicker.alpha = DatePicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    
    
}
-(void)doneButton
{
    
    NSDate *currentDate = DatePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    Duedatetxtfld.text = [formatter stringFromDate:currentDate];
    [Duedatetxtfld resignFirstResponder];
    [DatePicker removeFromSuperview];

    
}
-(void)priorityPickerTapped
{ [DatePicker removeFromSuperview];
    [PickerView removeFromSuperview];
    PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(320, 725, self.view.frame.size.width-350, 350)];
    [PickerView setShowsSelectionIndicator:YES];
    PickerView.delegate = self;
    PickerView.dataSource = self;
    PickerView.tag = 2;
    PickerView.backgroundColor=[UIColor grayColor];
    PickerView.alpha = 0;
    [ContentView addSubview:PickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    PickerView.transform = transfrom;
    PickerView.alpha = PickerView.alpha * (-1) + 1;
    [UIView commitAnimations];
    
}

-(void)EffortUOMPickerTapped
{
    NSLog(@"textViewDidBeginEditing:");
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.25f];
//    CGRect frame = ScrollV.frame;
//    frame.origin.y =frame.origin.y -180;
//    [ScrollV setFrame:frame];
//    [UIView commitAnimations];
    [PickerView removeFromSuperview];
    PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(320, 685, self.view.frame.size.width-350, 350)];
    [PickerView setShowsSelectionIndicator:YES];
    PickerView.delegate = self;
    PickerView.dataSource = self;
    PickerView.tag = 3;
    PickerView.backgroundColor=[UIColor grayColor];
    PickerView.alpha = 0;
    [ContentView addSubview:PickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    PickerView.transform = transfrom;
    PickerView.alpha = PickerView.alpha * (-1) + 1;
    [UIView commitAnimations];
}

-(void)PublicPrivateBtnTapped:(id)sender
{
    
    
	
	UIButton *btn=sender;
	
    if(btn.selected)
	{
		
		[btn setTitle:@"Public" forState:UIControlStateNormal];
        publicPriv = @"Public";
    }
	else
	{
		[btn setTitle:@"Private" forState:UIControlStateNormal];
		publicPriv =@"Private";
        
	}
	btn.selected=!btn.selected;
	
}


-(IBAction)SaveActionItemsList:(id)sender
{
    if ([Flag isEqualToString:@"ActionItems"])
    {
        if ([ActiondisTextView.text length]==0)
        {
            [ActiondisTextView setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Enter Discription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 600)]];
        }
        else if ([assigntoTxtfld.text length]==0)
        {
            [ActiondisTextView setBackgroundColor:[UIColor whiteColor]];
            [assigntoTxtfld setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Select Assign" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 650)]];
            
        }
        else if ([Duedatetxtfld.text length]==0)
        {
            [ActiondisTextView setBackgroundColor:[UIColor whiteColor]];
            [assigntoTxtfld setBackgroundColor:[UIColor whiteColor]];
            [Duedatetxtfld setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Enter DueDate" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 730)]];
            
        }
        else if ([Prioritytxtfld.text length]==0)
        {
            [ActiondisTextView setBackgroundColor:[UIColor whiteColor]];
            [assigntoTxtfld setBackgroundColor:[UIColor whiteColor]];
            [Duedatetxtfld setBackgroundColor:[UIColor whiteColor]];
            [Prioritytxtfld setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Select Priority" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 810)]];
        }
        
        else if ([Effortrequiredtxtfld.text length]==0)
        {
            [ActiondisTextView setBackgroundColor:[UIColor whiteColor]];
            [assigntoTxtfld setBackgroundColor:[UIColor whiteColor]];
            [Duedatetxtfld setBackgroundColor:[UIColor whiteColor]];
            [Prioritytxtfld setBackgroundColor:[UIColor whiteColor]];
            [Effortrequiredtxtfld setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Enter EffortRequired" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 900)]];
        }
        
        else if ([EffortUomtxtfld.text length]==0)
        {
            [EffortUomtxtfld setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Select EffortUOM " duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(650, 980)]];
        }
        
       

        else{
        NSString *category = @"actionItem";
        NSString *Saveactionitemsurl = @"ActionItemsTabSaveService";
        NSDictionary *credentials = @{@"ObjId":_ObjIdstr,@"ObjDesc":_ObjDistr,@"category":category,@"actionItemDesc":ActiondisTextView.text,@"assignedId":ResourceIdstr,@"dueDate":Duedatetxtfld.text,@"priority":Prioritytxtfld.text,@"effortReq":Effortrequiredtxtfld.text,@"effortUom":EffortUomtxtfld.text,@"created_by":Useridstr};
        [Servicecall SaveActionitemsList:Saveactionitemsurl SaveActionItemParametres:credentials];
        [Servicecall setDelegate:self];
            
            [ActiondisTextView setBackgroundColor:[UIColor whiteColor]];
            [assigntoTxtfld setBackgroundColor:[UIColor whiteColor]];
            [Duedatetxtfld setBackgroundColor:[UIColor whiteColor]];
            [Prioritytxtfld setBackgroundColor:[UIColor whiteColor]];
            [Effortrequiredtxtfld setBackgroundColor:[UIColor whiteColor]];
            [EffortUomtxtfld setBackgroundColor:[UIColor whiteColor]];
            ActiondisTextView.text = @"";
            
            assigntoTxtfld.text  = @"";
            Duedatetxtfld.text   = @"";
            Prioritytxtfld.text  =@"" ;
            Effortrequiredtxtfld.text =@"";
            EffortUomtxtfld.text =@"" ;


        }
    }
    
    if ([Flag isEqualToString:@"Notes"])
    {
      if ([EnterNotesTxtView.text length]==0)
        {
            [EnterNotesTxtView setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Enter NotesDiscription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 940)]];
        }
        else{
        NSString *noteCategory =@"addNotes";
        NSString *SaveaNotesurl = @"SaveNotesTabService";
        NSDictionary *credentials = @{@"ObjId":_ObjIdstr,@"noteCategory":noteCategory,@"noteRef":_ObjDistr,@"noteDesc":EnterNotesTxtView.text,@"assignedId":Useridstr,@"publicPriv":publicPriv};
        [Servicecall SaveNotes:SaveaNotesurl NotesparametrsForSave:credentials];
        [Servicecall setDelegate:self];
            
        [EnterNotesTxtView setBackgroundColor:[UIColor whiteColor]];
            
        EnterNotesTxtView.text = nil;
        }
        
        
    }
    
    
    if ([Flag isEqualToString:@"FeedBack"])
    {
        if ([PositiveFeedBacltxtview.text length]==0)
        {
            [PositiveFeedBacltxtview setBackgroundColor:[UIColor redColor]];
            [self.view makeToast:@"Enter PositiveFeedBack" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 960)]];
        }
       
       else{
        NSString *SaveFeedBackurl = @"SaveFeedbackService";
        NSDictionary *credentials = @{@"meetingId":_AgendaBasedMeetingIdstr,@"userId":Useridstr,@"positiveComments":PositiveFeedBacltxtview.text,@"negativeComm":NegativefeedbacktxtView.text};
        [Servicecall SaveFeedbackurl:SaveFeedBackurl SaveFeedBackCredentials:credentials];
        [Servicecall setDelegate:self];
        PositiveFeedBacltxtview.text = nil;
        NegativefeedbacktxtView.text =nil;
        [PositiveFeedBacltxtview setBackgroundColor:[UIColor whiteColor]];
       }
        

    }

    
    
    

}

-(void)SegmentIndexTapped
{
    
    if (SegmentControl.selectedSegmentIndex==0)
    {
        [self NotesList];
        
        Flag = @"Notes";
        [PositiveFeedBacltxtview removeFromSuperview];
        [NegativefeedbacktxtView removeFromSuperview];
        [ActionitemDetialsView setHidden:YES];
        [PublicORpvtBtn setHidden:NO];
        [EnterNotesTxtView setHidden:NO];
        EnterNotesTxtView =[[UITextView alloc]initWithFrame:CGRectMake(163, 500, 240, 138)];
        EnterNotesTxtView.tag= 4;
        EnterNotesTxtView.delegate = self;
        EnterNotesTxtView.returnKeyType = UIReturnKeyDone;
        EnterNotesTxtView.layer.cornerRadius = 15;
        EnterNotesTxtView.layer.borderWidth  = 2;
        EnterNotesTxtView.layer.borderColor  = [UIColor blackColor].CGColor;
        [ScrollV addSubview:EnterNotesTxtView];
        
        PublicORpvtBtn =[[UIButton alloc]initWithFrame:CGRectMake(492, 520, 110, 45)];
        PublicORpvtBtn.backgroundColor = [UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f];

        PublicORpvtBtn.layer.cornerRadius = 10;
        PublicORpvtBtn.layer.borderWidth  = 2;
        [PublicORpvtBtn setTitle:@"Public" forState:UIControlStateNormal];
        publicPriv = @"Public";
        [PublicORpvtBtn addTarget:self action:@selector(PublicPrivateBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [ScrollV addSubview:PublicORpvtBtn];
        
        
        [ActionitemsTV removeFromSuperview];
        ActionitemsTV = [[UITableView alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 300)
                                                     style:UITableViewStylePlain];
        
        ActionitemsTV.delegate = self;
        ActionitemsTV.dataSource = self;
        ActionitemsTV.tag = 1;
        ActionitemsTV.backgroundColor = [UIColor lightGrayColor];
        [ScrollV addSubview:ActionitemsTV];
        
    }
    
    if (SegmentControl.selectedSegmentIndex==1)
    {
        
         Flag = @"ActionItems";
        [PublicORpvtBtn removeFromSuperview];
        [EnterNotesTxtView removeFromSuperview];
        [PositiveFeedBacltxtview removeFromSuperview];
        [NegativefeedbacktxtView removeFromSuperview];
       
        [ActionitemDetialsView setHidden:NO];
        [ActionitemsTV removeFromSuperview];
        ActionitemsTV = [[UITableView alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 200)
                                                     style:UITableViewStylePlain];
        ActionitemsTV.backgroundColor = [UIColor lightGrayColor];
        ActionitemsTV.delegate = self;
        ActionitemsTV.dataSource = self;
        ActionitemsTV.tag = 2;
        [ScrollV addSubview:ActionitemsTV];
        
    }
    
    if (SegmentControl.selectedSegmentIndex==2)
    {
        
        [self FeedbackList];
        Flag = @"FeedBack";
        [ActionitemDetialsView setHidden:YES];
        [PublicORpvtBtn removeFromSuperview];
        [EnterNotesTxtView removeFromSuperview];
        [PositiveFeedBacltxtview setHidden:NO];
        [NegativefeedbacktxtView setHidden:NO];
        
        [ActionitemsTV removeFromSuperview];
        ActionitemsTV = [[UITableView alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 200)
                                                     style:UITableViewStylePlain];
        ActionitemsTV.delegate = self;
        ActionitemsTV.dataSource = self;
        ActionitemsTV.tag = 3;
        ActionitemsTV.backgroundColor = [UIColor lightGrayColor];
        [ScrollV addSubview:ActionitemsTV];
        
        PositiveFeedBacltxtview =[[UITextView alloc]initWithFrame:CGRectMake(124, 653, 240, 128)];
        PositiveFeedBacltxtview.tag= 5;
        PositiveFeedBacltxtview.delegate = self;
        PositiveFeedBacltxtview.returnKeyType = UIReturnKeyNext;
        PositiveFeedBacltxtview.layer.cornerRadius = 15;
        PositiveFeedBacltxtview.layer.borderWidth  = 2;
        PositiveFeedBacltxtview.layer.borderColor  = [UIColor blackColor].CGColor;
        [ScrollV addSubview:PositiveFeedBacltxtview];
        
        NegativefeedbacktxtView =[[UITextView alloc]initWithFrame:CGRectMake(442, 653, 240, 128)];
        NegativefeedbacktxtView.tag= 5;
        NegativefeedbacktxtView.delegate = self;
        NegativefeedbacktxtView.returnKeyType = UIReturnKeyDone;
        NegativefeedbacktxtView.layer.cornerRadius = 15;
        NegativefeedbacktxtView.layer.borderWidth  = 2;
        NegativefeedbacktxtView.layer.borderColor  = [UIColor blackColor].CGColor;
        [ScrollV addSubview:NegativefeedbacktxtView];

        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==2)
    {
        return [SavedAssignedToArray count];
    }
    if (tableView.tag ==1)
    {
        return [NoteDescriptionArray count];
    }
    return [NegativeDescArray count];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==3)
    {
        return 100;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2)
   {
       
       
       static NSString *CellIdentifier;
       CellIdentifier  = @"myCell";
       UILabel *ActionitemsDislbl,*ActionitemsDisdatalbl,*Prioritylbl,*Prioritydatalbl,*AssignTolbl,*AssignToDatalbl;
       
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       
       if (cell == nil)
       {
           
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
           cell.contentView.backgroundColor = [UIColor whiteColor];
           [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
           [cell.contentView.layer setBorderWidth:2.0f];
           cell.contentView.layer.cornerRadius = 12;
           cell.contentView.clipsToBounds = YES;
           tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
           
           
           ActionitemsDislbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20,258, 29)];
           ActionitemsDislbl.tag = 1001;
           ActionitemsDislbl.numberOfLines=2;
           ActionitemsDislbl.font=[UIFont systemFontOfSize:20];
           [cell.contentView addSubview:ActionitemsDislbl];
           
           ActionitemsDisdatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 16,508, 36)];
           ActionitemsDisdatalbl.tag = 1002;
           ActionitemsDisdatalbl.numberOfLines=2;
           ActionitemsDisdatalbl.font=[UIFont systemFontOfSize:20];
           [cell.contentView addSubview:ActionitemsDisdatalbl];
           
           Prioritylbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 63,247, 24)];
           Prioritylbl.font=[UIFont systemFontOfSize:20];
           Prioritylbl.tag = 1003;
           Prioritylbl.numberOfLines=2;
           Prioritylbl.font = [UIFont fontWithName:@"Magra" size:20.0 ];
           [cell.contentView addSubview:Prioritylbl];
           
           Prioritydatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 53,400, 39)];
           Prioritydatalbl.tag = 1004;
           Prioritydatalbl.font=[UIFont systemFontOfSize:20];
           [cell.contentView addSubview:Prioritydatalbl];
           
           
           
           AssignTolbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 112,247, 24)];
           AssignTolbl.font=[UIFont systemFontOfSize:20];
           AssignTolbl.tag = 1005;
           AssignTolbl.numberOfLines=2;
           AssignTolbl.font = [UIFont fontWithName:@"Magra" size:20.0 ];
           [cell.contentView addSubview:AssignTolbl];
           
           AssignToDatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 102,400, 40)];
           AssignToDatalbl.tag = 1006;
           AssignToDatalbl.font=[UIFont systemFontOfSize:20];
           [cell.contentView addSubview:AssignToDatalbl];
       }
       else
       {
           
           ActionitemsDislbl       = (UILabel *)[cell.contentView viewWithTag:1001];
           ActionitemsDisdatalbl   = (UILabel *)[cell.contentView viewWithTag:1002];
           Prioritylbl             =(UILabel *)[cell.contentView viewWithTag:1003];
           Prioritydatalbl         =(UILabel *)[cell.contentView viewWithTag:1004];
           AssignTolbl             =(UILabel *)[cell.contentView viewWithTag:1005];
           AssignToDatalbl         =(UILabel *)[cell.contentView viewWithTag:1006];
       }
       
       
       ActionitemsDislbl.text=@"ActionitemDiscription ";
       ActionitemsDisdatalbl.text=[SavedActionitemDescriptionArray objectAtIndex:indexPath.row];
       Prioritylbl.text=@"Priority        ";
       Prioritydatalbl.text=[SavedPriorityArray objectAtIndex:indexPath.row];
       AssignTolbl.text=@"Assign To      ";
       AssignToDatalbl.text=[SavedAssignedToArray objectAtIndex:indexPath.row];
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    
//    }
//    cell.contentView.backgroundColor = [UIColor whiteColor];
//    
//    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
//    [cell.contentView.layer setBorderWidth:2.0f];
//    cell.contentView.layer.cornerRadius = 12;
//    cell.contentView.clipsToBounds = YES;
//    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    
//    
//    CGRect frame3=CGRectMake(20, 20,258, 29);
//    UILabel* ActionitemsDislbl = (UILabel*) [cell viewWithTag:3];
//    if (!ActionitemsDislbl)
//    {
//        ActionitemsDislbl=[[UILabel alloc]init];
//        ActionitemsDislbl.frame=frame3;
//        ActionitemsDislbl.text=@"ActionitemDiscription ";
//        ActionitemsDislbl.font=[UIFont systemFontOfSize:20];
//        
//        
//    }
//    [ActionitemsDislbl setNumberOfLines:0];
//    [ActionitemsDislbl sizeToFit];
//    [cell addSubview:ActionitemsDislbl];
//     
//    CGRect frame=CGRectMake(290, 16,508, 36);
//    UILabel* ActionitemsDisdatalbl = (UILabel*) [cell viewWithTag:3];
//    if (!ActionitemsDisdatalbl)
//    {
//        ActionitemsDisdatalbl=[[UILabel alloc]init];
//        ActionitemsDisdatalbl.frame=frame;
//        ActionitemsDisdatalbl.font=[UIFont systemFontOfSize:20];
//            
//            
//    }
//    ActionitemsDisdatalbl.text=[SavedActionitemDescriptionArray objectAtIndex:indexPath.row];
//    [ActionitemsDislbl setNumberOfLines:0];
//    [ActionitemsDislbl sizeToFit];
//    [cell addSubview:ActionitemsDisdatalbl];
//        
//    
//    
//    
//    
//    UILabel *Prioritylbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 63,247, 24)];
//    Prioritylbl.text=@"Priority        ";
//    Prioritylbl.font=[UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:Prioritylbl];
//        
//    UILabel *Prioritydatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 53,400, 39)];
//    Prioritydatalbl.text=[SavedPriorityArray objectAtIndex:indexPath.row];
//    Prioritydatalbl.font=[UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:Prioritydatalbl];
//        
//    
//        
//        
//    UILabel *AssignTolbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 112,247, 24)];
//    AssignTolbl.text=@"Assign To      ";
//    AssignTolbl.font=[UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:AssignTolbl];
//        
//    UILabel *AssignToDatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 102,400, 40)];
//    AssignToDatalbl.text=[SavedAssignedToArray objectAtIndex:indexPath.row];
//    AssignToDatalbl.font=[UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:AssignToDatalbl];
//    
       return cell;
    
    
   }
    else if (tableView.tag ==1)
    {
        static NSString *CellIdentifier;
        CellIdentifier  = @"myCell";
        UILabel *Noteslbl,*notesdatalbl,*Publiclbl,*Publicdatalbl,*Notereflbl,*Noterefdatalbl;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
            [cell.contentView.layer setBorderWidth:2.0f];
            cell.contentView.layer.cornerRadius = 12;
            cell.contentView.clipsToBounds = YES;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            
            
            Noteslbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20,258, 29)];
            Noteslbl.tag = 1001;
            Noteslbl.numberOfLines=2;
            Noteslbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:Noteslbl];
            
            notesdatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 16,508, 36)];
            notesdatalbl.tag = 1002;
            notesdatalbl.numberOfLines=2;
            notesdatalbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:notesdatalbl];
            
            Publiclbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 63,247, 24)];
            Publiclbl.font=[UIFont systemFontOfSize:20];
            Publiclbl.tag = 1003;
            Publiclbl.numberOfLines=2;
            Publiclbl.font = [UIFont fontWithName:@"Magra" size:20.0 ];
            [cell.contentView addSubview:Publiclbl];
            
            Publicdatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 53,400, 39)];
            Publicdatalbl.tag = 1004;
            Publicdatalbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:Publicdatalbl];

            
            
            Notereflbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 112,247, 24)];
            Notereflbl.font=[UIFont systemFontOfSize:20];
            Notereflbl.tag = 1005;
            Notereflbl.numberOfLines=2;
            Notereflbl.font = [UIFont fontWithName:@"Magra" size:20.0 ];
            [cell.contentView addSubview:Notereflbl];
            
            Noterefdatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 102,400, 40)];
            Noterefdatalbl.tag = 1006;
            Noterefdatalbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:Noterefdatalbl];
        }
            else
            {
                
                Noteslbl       = (UILabel *)[cell.contentView viewWithTag:1001];
                notesdatalbl   = (UILabel *)[cell.contentView viewWithTag:1002];
                Publiclbl      =(UILabel *)[cell.contentView viewWithTag:1003];
                Publicdatalbl  =(UILabel *)[cell.contentView viewWithTag:1004];
                Notereflbl     =(UILabel *)[cell.contentView viewWithTag:1005];
                Noterefdatalbl =(UILabel *)[cell.contentView viewWithTag:1006];
            }
            
            
            Noteslbl.text=@"Notes ";
            notesdatalbl.text=[NoteDescriptionArray objectAtIndex:indexPath.row];
            Publiclbl.text=@"Publi/Private        ";
            Publicdatalbl.text=[NotePublicArray objectAtIndex:indexPath.row];
            Notereflbl.text=@"Agenda Name      ";
            Noterefdatalbl.text=[NoteRefrenceArray objectAtIndex:indexPath.row];
        
        return cell;
}
    

    
    else
    {
        static NSString *CellIdentifier;
        CellIdentifier  = @"myCell";
        UILabel *Positivedatalbl,*Negatvelbl,*Positivelbl,*negativedatalbl;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
            [cell.contentView.layer setBorderWidth:2.0f];
            cell.contentView.layer.cornerRadius = 12;
            cell.contentView.clipsToBounds = YES;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            
            
            Negatvelbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 63,247, 24)];
            Negatvelbl.tag = 1001;
            Negatvelbl.numberOfLines=2;
            Negatvelbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:Negatvelbl];
            
            negativedatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 53,400, 39)];
            negativedatalbl.tag = 1005;
            negativedatalbl.numberOfLines=2;
            negativedatalbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:negativedatalbl];
            
            Positivelbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20,258, 29)];
            Positivelbl.font=[UIFont systemFontOfSize:20];
            Positivelbl.tag = 1002;
            Positivelbl.numberOfLines=2;
            Positivelbl.font = [UIFont fontWithName:@"Magra" size:20.0 ];
            [cell.contentView addSubview:Positivelbl];
            
            Positivedatalbl = [[UILabel alloc]initWithFrame:CGRectMake(290, 16,508, 36)];
            Positivedatalbl.tag = 103;
            Positivedatalbl.font=[UIFont systemFontOfSize:20];
            [cell.contentView addSubview:Positivedatalbl];


        }
        else
        {
            
            Positivelbl = (UILabel *)[cell.contentView viewWithTag:1002];
            Negatvelbl = (UILabel *)[cell.contentView viewWithTag:1001];
            Positivedatalbl =(UILabel *)[cell.contentView viewWithTag:103];
            negativedatalbl =(UILabel *)[cell.contentView viewWithTag:1005];
        }
        
        
        Negatvelbl.text=@"Negative Feedback        ";
        Positivelbl.text = @"Positive Feedback   ";
        Positivedatalbl.text=[PositiveDescArray objectAtIndex:indexPath.row];
        negativedatalbl.text=[NegativeDescArray objectAtIndex:indexPath.row];
        
            
            
//            
//            UILabel *Positivelbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 63,247, 24)];
//
//            Positivelbl.font=[UIFont systemFontOfSize:20];
//            [cell.contentView addSubview:Positivelbl];
        
        
        
            
            
        
        
            
        
        return cell;

        
    }
    
}
 
    





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==1) {
        return [ResourceNameArray count];
    }
    if (picker.tag==2) {
        
        return [PriorityArray count];
    }
    else{
        return [EffortUOmArrray count];
        
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==1) {
        return [ResourceNameArray objectAtIndex:row];
    }
    if (picker.tag==2) {
        return [PriorityArray objectAtIndex:row];
    }
    else{
        return [EffortUOmArrray objectAtIndex:row];
        
    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==1) {
        assigntoTxtfld.text=[ResourceNameArray objectAtIndex:row];
        
        ResourceIdstr = [ResourceIdArray objectAtIndex:row];
        

        [PickerView removeFromSuperview];
    }
    if (pickerView.tag==2) {
        Prioritytxtfld.text=[PriorityArray objectAtIndex:row];
        //RoleCodestr = [RoleCodeIdaArray objectAtIndex:row];
        
        [PickerView removeFromSuperview];
    }
    
    if (pickerView.tag==3) {
        NSInteger row = [PickerView selectedRowInComponent:0];
        //Choose it for other components
        NSString *yourComponentValue  = [EffortUOmArrray objectAtIndex:row];
 //       NSLog(@"hai %@",yourComponentValue);
//        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = ScrollV.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [ScrollV setFrame:frame];
//        [UIView commitAnimations];
        [PickerView removeFromSuperview];
        EffortUomtxtfld.text = [EffortUOmArrray objectAtIndex:row];
    }
    
    
    
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==AssignedToxmlParser)
    {
        if([elementName isEqualToString:@"actionItemAssignedToListResponse"])
        {
            AssignedToListArray  =[NSMutableArray new];
            ResourceIdArray      =[NSMutableArray new];
            ResourceNameArray    =[NSMutableArray new];
            AssignedTosplitArray =[NSArray new];
        }
    }
    if (parser==ActionitemListxmlParser)
    {
        if([elementName isEqualToString:@"actionItemTabListResponse"])
        {
            ActionitemSavedList                   =[NSMutableArray new];
            SavedActionitemDescriptionArray       =[NSMutableArray new];
            SavedAssignedToArray                  =[NSMutableArray new];
            SavedPriorityArray                    =[NSMutableArray new];
            SavedSplitArray                       =[NSArray new];
        }
    }

    if (parser==notesListxmlParser)
    {
        if([elementName isEqualToString:@"notesListResponse"])
        {
            NoteRefrenceArray          =[NSMutableArray new];
            NoteDescriptionArray       =[NSMutableArray new];
            NotePublicArray            =[NSMutableArray new];
            NotesListArray             =[NSMutableArray new];
            NotesSplitArray            =[NSArray new];
        }
    }
    if (parser==FeedBackListxmlParser)
    {
        if([elementName isEqualToString:@"feedbackListResponse"])
        {
            PositiveDescArray          =[NSMutableArray new];
            NegativeDescArray          =[NSMutableArray new];
            FeedbackListArray          =[NSMutableArray new];
            FeedbackSplitArray         =[NSArray new];
        }
    }
    
    
//
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == AssignedToxmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Goals" message:@"No Participant Assigned" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [AssignedToListArray addObject:string];
            NSLog(@"Agenda List %@",string);
            
        }
        
        
    }
    if (parser == SaveactionitemxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"ActionItems" message:@"Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSLog(@"Action item Saved? %@",string);
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"ActionItems" message:@"Data Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            //[ResourceListArray addObject:string];
            
        }

        
    }
    if (parser == ActionitemListxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"ActionItems" message:@"ActionItemList Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            [ActionitemSavedList addObject:string];
            
        }
        
   }
    
    if (parser == SavenotesxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Notes" message:@"Notes Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSLog(@"Saved List %@",string);
            //[ActionitemSavedList addObject:string];
            
        }
    }
    if (parser == notesListxmlParser)
    {
            if ([string isEqualToString:@"Flase"])
            {
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Notes" message:@"NotesList Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            else{
                NSLog(@"Notes List %@",string);
                [NotesListArray addObject:string];
                
            }
        }
    if (parser == FeedBackListxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"FeedBack" message:@"FeedBack List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSLog(@"FeedBack List %@",string);
            [FeedbackListArray addObject:string];
            
        }
    }
    if (parser == FeedBackSavexmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"FeedBack" message:@"FeedBack Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSLog(@"FeedBack List %@",string);
            
            
        }
    }
    

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == AssignedToxmlParser)
    {
        if([elementName isEqualToString:@"actionItemAssignedToListResponse"])
        {
            for (int i = 0; i<[AssignedToListArray count]; i++)
            {
                AssignedTosplitArray=[[AssignedToListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [ResourceIdArray addObject:[[AssignedTosplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"ResourceId==" withString:@""]];
                [ResourceNameArray addObject:[[AssignedTosplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString: @"ResourceName==" withString:@""]];
                
            }
            [PickerView reloadAllComponents];
        }
    }
    if (parser == SaveactionitemxmlParser)
    {
        
        if([elementName isEqualToString:@"saveActionItemResponse"])
        {
            [self ActionitemsList];
        }
        
    }
    if (parser == ActionitemListxmlParser)
    {
        if([elementName isEqualToString:@"actionItemTabListResponse"])
        {
            for (int i = 0; i<[ActionitemSavedList count]; i++)
            {
                SavedSplitArray=[[ActionitemSavedList objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [SavedActionitemDescriptionArray addObject:[[SavedSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"Description==" withString:@""]];
                [SavedAssignedToArray addObject:[[SavedSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString: @"AssignedTo==" withString:@""]];
                [SavedPriorityArray addObject:[[SavedSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString: @"Priority==" withString:@""]];
                NSLog(@"Resiurce name %@",SavedPriorityArray);
            }
            
            [ActionitemsTV reloadData];
            
            
        }
    }
    
    if (parser == SavenotesxmlParser)
    {
        
        if([elementName isEqualToString:@"saveNotesResponse"])
        {
            [self NotesList];
        }
        [ActionitemsTV reloadData];
        
    }
    
    if (parser == notesListxmlParser)
    {
        if([elementName isEqualToString:@"notesListResponse"])
        {
            for (int i = 0; i<[NotesListArray count]; i++)
            {
                NotesSplitArray=[[NotesListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [NoteRefrenceArray addObject:[[NotesSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"NoteRefrence==" withString:@""]];
                [NoteDescriptionArray addObject:[[NotesSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString: @"NoteDescription==" withString:@""]];
                 [NotePublicArray addObject:[[NotesSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString: @"NotePublic==" withString:@""]];
                NSLog(@"role name %@",NoteDescriptionArray);
            }
            
            [ActionitemsTV reloadData];
            
            
        }
    }
    
    if (parser==FeedBackListxmlParser)
    {
        if([elementName isEqualToString:@"feedbackListResponse"])
        {
            for (int i = 0; i<[FeedbackListArray count]; i++)
            {

            FeedbackSplitArray=[[FeedbackListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
            
            [PositiveDescArray addObject:[[FeedbackSplitArray objectAtIndex:4] stringByReplacingOccurrencesOfString: @"PositiveDesc==" withString:@""]];
            [NegativeDescArray addObject:[[FeedbackSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString: @"NegativeDesc==" withString:@""]];
            }
            [ActionitemsTV reloadData];
      }
   }
    
    if (parser==FeedBackSavexmlParser)
    {
        if([elementName isEqualToString:@"saveFeedBackResponse"])
        {
            [self FeedbackList];
        }
    }
    
}


-(void)Serviceactiondone:(id)result
{
    AssignedToxmlParser = [[NSXMLParser alloc]initWithData:result];
    AssignedToxmlParser.delegate = self;
    [AssignedToxmlParser parse];
}
-(void)didEndTask:(id)Taskend
{
    SaveactionitemxmlParser = [[NSXMLParser alloc]initWithData:Taskend];
    SaveactionitemxmlParser.delegate = self;
    [SaveactionitemxmlParser parse];
}

-(void)Serviceactiondone1:(id)result
{
    ActionitemListxmlParser = [[NSXMLParser alloc]initWithData:result];
    ActionitemListxmlParser.delegate = self;
    [ActionitemListxmlParser parse];

}
-(void)didFinishData:(id)Data
{
    SavenotesxmlParser = [[NSXMLParser alloc]initWithData:Data];
    SavenotesxmlParser.delegate = self;
    [SavenotesxmlParser parse];
}
-(void)serviceCal:(id)ServerData{
    
    
    notesListxmlParser = [[NSXMLParser alloc]initWithData:ServerData];
    notesListxmlParser.delegate = self;
    [notesListxmlParser parse];
}
-(void)Servicecal1:(id)ServerData{
    
    
    FeedBackListxmlParser = [[NSXMLParser alloc]initWithData:ServerData];
    FeedBackListxmlParser.delegate = self;
    [FeedBackListxmlParser parse];
}
-(void)ServiceCalls:(id)ServiceCal
{
    FeedBackSavexmlParser = [[NSXMLParser alloc]initWithData:ServiceCal];
    FeedBackSavexmlParser.delegate = self;
    [FeedBackSavexmlParser parse];

}




    

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [EnterNotesTxtView resignFirstResponder];
    if (textView == EnterNotesTxtView ) {
        
        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
        
    }
    if (textView == PositiveFeedBacltxtview ) {
        
        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
    }
    if (textView == NegativefeedbacktxtView ) {
        
        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
        

    }
    
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == EnterNotesTxtView)
    {
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationDuration:0.25f];
     CGRect frame = self.view.frame;
     frame.origin.y =frame.origin.y -10;
     [self.view setFrame:frame];
     [UIView commitAnimations];
    
    }
    
    if (textView == PositiveFeedBacltxtview)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y =frame.origin.y -10;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    if (textView == NegativefeedbacktxtView)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y =frame.origin.y-10;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    

    return YES;
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if( [text isEqualToString:[text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]] ) {
        return YES;
    } else {
        
        [NegativefeedbacktxtView becomeFirstResponder];
        if (textView == NegativefeedbacktxtView)
        {
            [self SaveActionItemsList:nil];

        }
        if (textView == EnterNotesTxtView)
        {
            [self SaveActionItemsList:nil];
            
        }
        if (textView == ActiondisTextView)
        {
            [textView resignFirstResponder];
        }
        
    }
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    

    if (textField == Effortrequiredtxtfld)
    {
        
        return YES;
    }
    
    return NO;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == Effortrequiredtxtfld ) {
        
        NSLog(@"textViewDidBeginEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y =frame.origin.y -180;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    if (textField == EffortUomtxtfld ) {
        
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
    
    [Effortrequiredtxtfld resignFirstResponder];
    if (textField == Effortrequiredtxtfld ) {
        
        NSLog(@"textViewDidEndEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y = frame.origin.y + 180;
        [self.view setFrame:frame];
        [UIView commitAnimations];
        [textField resignFirstResponder];
    }
    if (textField == EffortUomtxtfld ) {
        
//        NSLog(@"textViewDidEndEditing:");
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 180;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
    }
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == Effortrequiredtxtfld) {
        [theTextField resignFirstResponder];
    }
    if (theTextField==Duedatetxtfld)
    {
        [theTextField resignFirstResponder];
        [DatePicker removeFromSuperview];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:LEAGELNUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]     componentsJoinedByString:@""];
    BOOL lengthresult = [string isEqualToString:filtered];
    
    return lengthresult;
    
    
}

-(void)HomePagebtnTapped
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)BackbtnTapped
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
}
-(void)LogoutbtnTapped
{
    LogoutAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [LogoutAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == LogoutAlert)
    {
        if(buttonIndex == 0)
        {
            
            
            
        }
        else {
            
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self layout];
    
}



-(void)layout
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"Change to custom UI for landscape");
        
        CGRect a = CGRectMake(0, 0, 1024, 768);
        self.view.frame = a;
        ActionitemsTV.frame = CGRectMake(20, 74, self.view.frame.size.width-40, 200);
        
        
    }
    else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"Change to custom UI for portrait");
        CGRect a = CGRectMake(0, 0, 768, 1024);
        self.view.frame = a;
        ActionitemsTV.frame = CGRectMake(20, 74, self.view.frame.size.width-40, 200);
        
        
    }
    
}



@end
