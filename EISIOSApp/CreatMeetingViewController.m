//
//  CreatMeetingViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "CreatMeetingViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "Toast+UIView.h"
@interface CreatMeetingViewController ()
{
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5;
    UIPickerView*  ProjectListpicker;
    UIDatePicker *DatePicker;
    
    //-----------ProjectList-----------------//
    
    NSMutableArray *ProjectListArray,*PROJECT_IDArray,*PROJECT_NAMEArray;
    NSArray *ProjectlistSplitArray;
    NSString *ProjectIdstr;
    
    //----------MeetingList-----------------//
    NSMutableArray *MeetingCODE_IDArray,*MeetingVALUEArray,*MeetingListArray;
    NSArray *MeetingSplitArray;
    NSString *MeetingcodeIdstr,*meetingidstr;
    
    //--------ConfRoomList---------------//
    NSMutableArray *ConfRoomlIstArray,*ConferenceRoomIdArray,*ConferenceRoomNameArray,*Savemeetingrespocearray,*saveMeetingResArray,*saveMeetingResponse1Array,*meetingsplitResponseArray;
    NSArray *ConfRoomSplitArray;
    NSString *ConfroomIdstr,*meetingid,*conferencestr;
    
    //----------DatePicker------------------
    NSArray *dateSplitArray;
    
    //---------Update Meeting----------
    
    NSString *MeetingId,*Hoursstr,*MeetingTypestr,*ProjectNamestr,*MeetingDatestr,*ConferenceRoomstr,*MeetingDescriptionstr,*pickertimestr,*savemeetingstr,*UpdateDateTime,*MeetingDateStr,*MeetingTimeStr,*CurrentDateStr,*CurrentTimeStr,*projectidStr;
    NSDate *MeetingDate,*MeetingTime,*CurrentDate,*CurrentTime;
    
    NSMutableArray *timelengthArray,*timelengthSplitArray,*timelengthSplitDisplayArray,*resultarray,*resultarray1,*resultArray2,*resultarray3;
    
    NSString *timeLength;
     int agendaCount,agendacountint;
    
}
@end

@implementation CreatMeetingViewController
@synthesize navigationTitlestr,SavebtnTitlestr,agendaLenthStr;
//-(void)DatafromDB
//{
//    
//    
//    self.navigationItem.title = navigationTitlestr;
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
//        NSLog(@"detaisl %@ %@ ",Usernamestr,Usertypestr);
//        
//        
//    }
//}
//

- (void)viewDidLoad
{
 
    
    
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
    
    

    
    
    
    //[self DatafromDB];
    self.navigationItem.title = navigationTitlestr;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
     NSLog(@"username strssss is %@",Usernamestr);
     NSLog(@"userid strssss is %@",Useridstr);
     NSLog(@"orgidstr strssss is %@",orgIdstr);
     NSLog(@"usertype strssss is %@",Usertypestr);
    
    
    
    Meetingdistxtfld.text   = _MeetingDescriptionstr;
    Projectstxtfld.text     = _ProjectNamestr;
    Meetingtypetxtfld.text  = _MeetingTypestr;
    Meetingtitletxtfld.text = _MeetingTitlestr;
    Meetinglengthtxtfld.text= _Hoursstr;
    NSLog(@"horss strssss is %@",_Hoursstr);
    Confrencermtxtfld.text  = _ConferenceRoomstr;
   _MeetingDatestr = [_MeetingDatestr stringByAppendingString:@" "];
    Meetingtimetxtfld.text=[_MeetingDatestr stringByAppendingString:_Starttimestr];
    meetingidstr=_MeetingId;
    
    
    NSLog(@"meeting time text field is %@",Meetingtimetxtfld.text);
    NSLog(@"meeting id is updated%@",meetingidstr);
    timeLength1=[[NSString alloc]init];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = [formatter dateFromString:_MeetingDatestr];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    _MeetingDatestr = [formatter stringFromDate:date];
    NSLog(@"meetinfg date str is %@",_MeetingDatestr);
    dateSplitArray = [[NSArray alloc]initWithObjects:_MeetingDatestr,_Starttimestr,nil];
    
    NSLog(@"the date array values are %@",dateSplitArray);
    //Meetingtimetxtfld.text = [_MeetingDatestr stringByAppendingString:_Starttimestr];
    NSLog(@"meeting time text field is  %@",Meetingtimetxtfld.text);
    
    //NSLog(@"MeetingId %@",MeetingDescriptionstr);
    Servicecall = [[Webservices alloc]init];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f]];
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    UIButton* Creatmeetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Creatmeetbtn setImage:[UIImage imageNamed:@"expenses_new_icon.png"] forState:UIControlStateNormal];
    [Creatmeetbtn addTarget:self action:@selector(CreatmeetingV) forControlEvents:UIControlEventTouchUpInside];
    [Creatmeetbtn sizeToFit];
    UIBarButtonItem *Creatpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Creatmeetbtn];
    
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:Logoutpagebatbtn,Homepagebatbtn,Creatpagebatbtn,nil];
    
    
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

    
    
    
    CreatmeetingView.layer.borderColor = [UIColor greenColor].CGColor;
    CreatmeetingView.layer.borderWidth = 2.0f;
    CreatmeetingView.layer.cornerRadius = 14;
    
    homebtn.layer.borderWidth = 2.0f;
    homebtn.layer.cornerRadius = 10;
    //[homebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    Savebtn.layer.borderWidth = 2.0f;
    Savebtn.layer.cornerRadius = 10;
    [Savebtn setTitle:SavebtnTitlestr forState:UIControlStateNormal];
    
    
    agendabtn.layer.borderWidth = 2.0f;
    agendabtn.layer.cornerRadius = 10;

    goalsbtn.layer.borderWidth = 2.0f;
    goalsbtn.layer.cornerRadius = 10;

    participentbtn.layer.borderWidth = 2.0f;
    participentbtn.layer.cornerRadius = 10;

    
   //-------------Picker buttons Tapped---------------------
    ProjectListbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ProjectListbtn setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    ProjectListbtn.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [ProjectListbtn addTarget:self action:@selector(ProjectListPicker) forControlEvents:UIControlEventTouchUpInside];
    Projectstxtfld.rightView = ProjectListbtn;
    Projectstxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Projectstxtfld addSubview:ProjectListbtn];
    
    
    UIButton *MeetingListbtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [MeetingListbtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    MeetingListbtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [MeetingListbtnpkr addTarget:self action:@selector(MeetingListPicker) forControlEvents:UIControlEventTouchUpInside];
    Meetingtypetxtfld.rightView = MeetingListbtnpkr;
    Meetingtypetxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Meetingtypetxtfld addSubview:MeetingListbtnpkr];
    
    UIButton *Datepickerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Datepickerbtn setImage:[UIImage imageNamed:@"datetimepicker.png"] forState:UIControlStateNormal];
    Datepickerbtn.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Datepickerbtn addTarget:self action:@selector(DatePickerSelection) forControlEvents:UIControlEventTouchUpInside];
    Meetingtimetxtfld.rightView = Datepickerbtn;
    Meetingtimetxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Meetingtimetxtfld addSubview:Datepickerbtn];
   

    
    UIButton *ConfRoomListbtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [ConfRoomListbtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    ConfRoomListbtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [ConfRoomListbtnpkr addTarget:self action:@selector(ConfRoomListPicker) forControlEvents:UIControlEventTouchUpInside];
    Confrencermtxtfld.rightView = ConfRoomListbtnpkr;
    Confrencermtxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Confrencermtxtfld addSubview:ConfRoomListbtnpkr];
    [self ConfRoomList];

    if (_MeetingId!=nil)
    {
        [ProjectListbtn setEnabled:NO];
    }
    

     [self ProjectList];
    
    
   
    [self.view setNeedsDisplay];
    

    [super viewDidLoad];

   
}
-(void)conferencermspinner:(id)conferenceroomSpinner
{
    
    NSDictionary *dict=conferenceroomSpinner;
    NSLog(@"dict is %@",dict);
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"counts are empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            ConferenceRoomIdArray     =[NSMutableArray new];
            ConferenceRoomNameArray   =[NSMutableArray new];
            resultarray=[[NSMutableArray alloc]init];
            resultarray=[dict objectForKey:@"resAL"];
            for (NSDictionary *fid in resultarray)
            {
                [ConferenceRoomIdArray addObject:[fid valueForKey:@"conferenceRoomId"]];
                [ConferenceRoomNameArray addObject:[fid valueForKey:@"conferenceRoom"]];
            }
            NSLog(@"confer rm id spnr is :%@",ConferenceRoomIdArray);
            NSLog(@"confer rm id spnr is%@",ConferenceRoomNameArray);
            
            for(int i=0; i<[ConferenceRoomNameArray count]; i++)
            {
                if([_ConferenceRoomstr isEqualToString:[ConferenceRoomNameArray objectAtIndex:i]])
                {
                    
                    Confrencermtxtfld.text = [ConferenceRoomNameArray objectAtIndex:i];
                    _ConfOwnerId = [ConferenceRoomIdArray objectAtIndex:i];
                    
                    
                }
            }

            
}

}

-(void)projectlistspinner:(id)projectlistSpinner
{
    NSDictionary *dict=projectlistSpinner;
    NSLog(@"dict is %@",dict);
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"counts are empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        PROJECT_NAMEArray      =[NSMutableArray new];
        PROJECT_IDArray        =[NSMutableArray new];
        resultarray1=[[NSMutableArray alloc]init];
        resultarray1=[dict objectForKey:@"resAL"];
        for (NSDictionary *fid in resultarray1)
        {
            [PROJECT_IDArray addObject:[fid valueForKey:@"projectId"]];
            [PROJECT_NAMEArray addObject:[fid valueForKey:@"projectName"]];
        }
        NSLog(@"project id  is :%@",PROJECT_IDArray);
        NSLog(@"project name  is%@",PROJECT_NAMEArray);

}
}

-(void)ConfRoomList
{
       NSString *ConfRoomListurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/conferenceRoomSpinner?orgId=%@",orgIdstr];
    
    NSString *encode=[ConfRoomListurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall conferencermspinrurl:encode];
    [Servicecall setDelegate:self];

}
-(void)ProjectListPicker
{
    [self ProjectList];
   
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 90, self.view.frame.size.width-410, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    [ProjectListpicker selectRow:0 inComponent:0 animated:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 1;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [CreatmeetingView addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
       [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
   UITapGestureRecognizer* myGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
    [ProjectListpicker addGestureRecognizer:myGR];
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    
    //[CreatmeetingView addSubview:questionpkr];

}

-(void)MeetingListPicker
{
    NSString *meetingtypeurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/meetingTypeSpinner?orgId=%@",orgIdstr];
    NSString *encode=[meetingtypeurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall meetingTypeUrl:meetingtypeurl];
    [Servicecall setDelegate:self];
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 180, self.view.frame.size.width-410, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 2;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [CreatmeetingView addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    
}

-(void)DatePickerSelection
{
    [ProjectListpicker removeFromSuperview];
    
    [DatePicker removeFromSuperview];
    DatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(325, 480, self.view.frame.size.width-410, 300)];
    [DatePicker addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventValueChanged];
    DatePicker.backgroundColor=[UIColor whiteColor];
    DatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    DatePicker.backgroundColor=[UIColor grayColor];
    [DatePicker setMinimumDate: [NSDate date]];
    DatePicker.backgroundColor=[UIColor grayColor];
    DatePicker.alpha = 0;
    UIToolbar* pickerTB = [[UIToolbar alloc]initWithFrame:CGRectMake(-0, -40, self.view.frame.size.width-410, 44)];
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
//    Meetingtimetxtfld.inputView = DatePicker;
//    Meetingtimetxtfld.inputAccessoryView = pickerTB;
    [DatePicker addSubview:pickerTB];
    [CreatmeetingView addSubview:DatePicker];
    
    
}

-(void)ProjectList
{
    NSString *projectListurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/projectListSpinner?usertype=%@&userId=%@&orgId=%@",Usertypestr,Useridstr,orgIdstr];
    NSString *encode=[projectListurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall projectlstspinrurl:encode];
    [Servicecall setDelegate:self];

}

-(void)ConfRoomListPicker
{
//    NSString *ConfRoomListurl = @"PickConferenceRoomListService";
//    NSDictionary *credentials = @{@"orgId":orgIdstr};
//    [Servicecall ConfRoomurl:ConfRoomListurl ConfRoomCredentilas:credentials];
//    [Servicecall setDelegate:self];
    [self ConfRoomList];
    
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 620, self.view.frame.size.width-410, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 3;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [CreatmeetingView addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
}
-(void)meetingType:(id)meetingTypeSpinner
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=meetingTypeSpinner;
    NSLog(@"welcome to %@",dict);
    if ([[dict objectForKey:@"statusMessage"] isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"meeting type list is empty" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        resultArray2=[[NSMutableArray alloc]init];
        resultArray2=[dict objectForKey:@"resAL"];
        
        MeetingVALUEArray       =[NSMutableArray new];
        MeetingCODE_IDArray     =[NSMutableArray new];
        MeetingListArray        =[NSMutableArray new];
        MeetingSplitArray       =[NSArray new];
        NSLog(@"result array is %@",resultArray2);
        
        for (NSDictionary *fid in resultArray2)
        {
            [MeetingVALUEArray addObject:[fid valueForKey:@"meetingType"]];
            [MeetingCODE_IDArray addObject:[fid valueForKey:@"meetingTypeId"]];
        }
        [ProjectListpicker reloadAllComponents];
        NSLog(@"meeting type array is %@",MeetingVALUEArray);
        NSLog(@"meeting type id is %@",MeetingCODE_IDArray);
    }
    
}


- (void)viewDidLayoutSubviews
{
    ScrolV.contentSize = CGSizeMake(320, 850);
}

- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)textEntered {
    
    // Do not check if the textField was previously blank
    if (![Meetingtitletxtfld.text length]==0)
    {
        [Meetingtitletxtfld setTintColor:[UIColor redColor]];
    }
    
    return YES;
}
-(IBAction)SaveMeetingTapped:(id)sender
{
  
    if ([Projectstxtfld.text length]==0)
    {
        [Projectstxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter ProjectList" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 220)]];
    }
    else if ([Meetingtypetxtfld.text length]==0)
    {
        [Meetingtypetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter MeetingType" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 310)]];
        
    }
    else if ([Meetingtitletxtfld.text length]==0)
    {
        [Meetingtitletxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter MeetingTitle" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 400)]];
        
    }
    else if ([Meetingdistxtfld.text length]==0)
    {
        [Meetingdistxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter MeetingDiscription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 490)]];
    }
    
    else if ([Meetingtimetxtfld.text length]==0)
    {
        [Meetingtimetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter MeetingTime" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 580)]];
    }
    
    else if ([Meetinglengthtxtfld.text length]==0)
    {
        [Meetinglengthtxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter Meetinglendth" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 670)]];
    }
   
    else if ([Confrencermtxtfld.text length]==0)
    {
        [Confrencermtxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter ConfRoom" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 760)]];
    }
    

    else
    {
    
   
    if (_locationUseBool == NO)
    {
          NSLog(@"the date array is %@ %@",[dateSplitArray objectAtIndex:0],_Starttimestr);
        NSLog(@"the date array is %@",dateSplitArray);
        
        NSLog(@"Save");
        NSLog(@"meetin type id is %@",_MeetingTypeId);
        NSString *meetDate=[dateSplitArray objectAtIndex:0];
    NSString *SaveMeetingurl= @"SaveMeetingService";
    NSDictionary *credentials = @{@"meetingTyp":_MeetingTypeId,@"meetinTitle":Meetingtitletxtfld.text,@"meetDescription":Meetingdistxtfld.text,@"startTym":_Starttimestr,@"hours":Meetinglengthtxtfld.text,@"meetOwnId":Useridstr,@"projectId":_ProjId,@"meetDate":[[meetDate componentsSeparatedByString: @" "] objectAtIndex:0],@"ConferRoomId":_ConfOwnerId};
    [Servicecall SaveMeetingurl:SaveMeetingurl SaveMeetingDetails:credentials];
    [Servicecall setDelegate:self];
   
       // _locationUseBool = YES;
         NSLog(@"save");
        
      
    
    }
        
        
    else
    {
        
        [self agendaCount];
       

        NSLog(@"dateSplitArray %@",dateSplitArray);
        //UIButton *button =(UIButton *)sender;
        NSLog(@"the label value is %@",Savebtn.titleLabel.text);
        if ([Savebtn.titleLabel.text isEqualToString:@"Update"])
        {
            
            
            //NSLog(@"the time length is %@",timeLength1);
            
            dateSplitArray = [[NSArray alloc]init];
            
            UpdateDateTime=Meetingtimetxtfld.text;
            NSLog(@"meeting time is %@",Meetingtimetxtfld.text);
            
            NSMutableArray *datetimeArray=[[NSMutableArray alloc]initWithObjects:UpdateDateTime,nil];
            datetimeArray =[UpdateDateTime componentsSeparatedByString:@" "];
            NSLog(@"the date array is %@",datetimeArray);
            dateSplitArray=datetimeArray;
            MeetingDateStr=[dateSplitArray objectAtIndex:0];
            NSLog(@"meeting date str is %@",MeetingDateStr);
            MeetingTimeStr=[[[dateSplitArray objectAtIndex:1]stringByAppendingString:@" "]stringByAppendingString:[dateSplitArray objectAtIndex:2]];
            NSLog(@"meeting time str is %@",MeetingTimeStr);
            
        
            NSString *dateString = UpdateDateTime;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            MeetingDate = [dateFormatter dateFromString:dateString];
            
//            NSString *timeString=UpdateDateTime;
//            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//            [dateFormat setDateFormat:@"dd/MM/yyyy hh:mm a"];
//            [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//            [dateFormat setDateFormat:@"hh:mm a"];
//            MeetingTime=[dateFormat dateFromString:timeString];
//            
            
//            [dateFormatter setDateFormat:@"MMMM dd, YYYY HH:mm:ss a"];
//            NSString *stringFromDate  = [dateFormatter stringFromDate:dateFromString];
            NSLog(@"meeting date is %@",MeetingDate);
             NSLog(@"meeting time is %@",MeetingTime);
            
//            NSLog(@"current date is %@",dateSplitArray);
//            _Starttimestr=[[[dateSplitArray objectAtIndex:1]stringByAppendingString:@" "]stringByAppendingString:[datetimeArray objectAtIndex:2]];
//            NSLog(@"start time is %@",_Starttimestr);
//            Currentdate=[dateSplitArray objectAtIndex:0];
//           // NSLog(@"current dates is %@",Currentdate);
//            //NSLog(@"the date is %@",date);
//            NSLog(@"the current time is %@",Currenttime);
//            //NSLog(@"existing meeting date is %@",[dateSplitArray objectAtIndex:0]);
        }    //NSLog(@"existing meeting time is %@",[dateSplitArray objectAtIndex:1]);
//
        
        
      CurrentDate =[NSDate date];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"MM/dd/yyyy hh:mm a"];
//        Currentdate = [dateFormat2 stringFromDate:date2];
        NSLog(@"current date is %@",CurrentDate);
//        
//        NSDateFormatter *datePickerFormat3 = [[NSDateFormatter alloc] init];
//        [datePickerFormat3 setDateFormat:@"hh:mm a"];
//        NSDate *date = [datePickerFormat3 dateFromString:_Starttimestr];
//        NSLog(@"the start time string is %@",_Starttimestr);
//        [datePickerFormat3 setDateFormat:@"hh:mm a"];
//        Currenttime =[datePickerFormat3 stringFromDate:date2];
//        NSLog(@"existing meeting date is %@ %@",Currenttime,_Starttimestr);
//        
//        NSLog(@"time length is %@",timeLength);
//        NSLog(@"hours Str is %d",[_Hoursstr intValue]);
//            
////            NSDate *date3=DatePicker.date;
////            NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
////            [dateformatter setDateFormat:@"dd/MM/yyyy"];
////            currentDate2=[dateformatter stringFromDate:date3];
////            NSLog(@"picker date value is %@",currentDate2);
////        
//
////         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agendaTimeValidation:) name:@"notificaiton_name" object:nil];
//        NSLog(@"date string is %@",[dateSplitArray objectAtIndex:0]);
//            
//        NSLog(@"current date string is %@",Currentdate);
//        NSLog(@"current date1 string is %@",[dateSplitArray objectAtIndex:0]);
        if ([CurrentDate earlierDate:MeetingDate]==MeetingDate)
                
            {
                
                 //NSLog(@"current date2 string is %@",currentDate2);
                
                UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Enter greater Date" message:@"" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:nil, nil];
                [alert show];
                
               
                
            }

//           else if (([Currenttime compare:_Starttimestr]==NSOrderedSame || [Currenttime compare:_Starttimestr]==NSOrderedDescending) && ([Currentdate compare:[dateSplitArray objectAtIndex:0]]==NSOrderedDescending))
//                
//            {
//                UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Enter greater time" message:@"" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//
    else if ([Meetinglengthtxtfld.text intValue]<agendaCount)
        {
            NSLog(@"meetinglength STR IS  %d",[Meetinglengthtxtfld.text intValue]);
            NSLog(@"HOURS STR IS  %d",[_Hoursstr intValue]);
            NSLog(@"agenda count is %d",agendaCount);
            
            UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Enter greater lenth than agenda goals" message:@"" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
            [alert show];

        }
        
        
        else
            {
                
                [self MeetingUpdate];
                
       
            }

        }
        
   
    }
    }

-(void)MeetingUpdate
{
    NSString *meetDate=[dateSplitArray objectAtIndex:0];
    
NSLog(@"meeting length text field 1235124is %@",Meetinglengthtxtfld.text);
NSString *updateMeetingurl=[NSString stringWithFormat:@"https//192.168.2.114:8817/_ah/api/meeting/v1/updateMeeting"];
    

    NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:_MeetingTypeId,@"meetingTyp",Meetingtitletxtfld.text,@"meetinTitle",Meetingdistxtfld.text,@"meetDescription",_Starttimestr,@"startTym",Meetinglengthtxtfld.text,@"hours",Useridstr,@"meetOwnId",_ProjId,@"projectId",[[meetDate componentsSeparatedByString: @" "]objectAtIndex:0],@"meetDate",_MeetingId,@"meetingId",_ConfOwnerId,@"ConferRoomId",nil];
    
    NSLog(@"all key values are %@",dictionary);
    
    [Servicecall meetingupdate:updateMeetingurl meetingupdatedict:dictionary];
    [Servicecall setDelegate:self];
    
}
-(void)meetingupdate:(id)meetingUpdateurl
{
    
}
//-(void)agendaTimeValidation:(NSNotification *)obj
//{
//
//   agendaLenthStr =(NSString *) [obj object];
//    
//    
//    
//   NSLog(@"hours string is %@",agendaLenthStr);
//    
//    
//
//}


-(void)doneButton
{
    dateSplitArray = [[NSArray alloc]init];
    NSDate *currentDate = [DatePicker date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    Meetingtimetxtfld.text = [formatter stringFromDate:currentDate];
    
   // Meetingtimetxtfld.inputView=DatePicker;
    
    NSString *date = [formatter stringFromDate:currentDate];
    dateSplitArray = [date componentsSeparatedByString:@" "];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"hh:mm a"];
    [dateformate setTimeStyle:NSDateFormatterShortStyle];
    
    _Starttimestr=[_Starttimestr componentsSeparatedByString:@" "];
    _Starttimestr=[NSString stringWithFormat:@"%@",[dateformate stringFromDate:DatePicker.date]];
    
    NSLog(@"start time is %@",_Starttimestr);
    
    

    
    //[DatePicker removeFromSuperview];
  [Meetingtimetxtfld resignFirstResponder];
}
-(void)userTapped
{
    [DatePicker removeFromSuperview];
    [ProjectListpicker removeFromSuperview];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==1) {
        return [PROJECT_NAMEArray count];
    }
    if (picker.tag==2) {
        return [MeetingVALUEArray count];
    }
    else{
        return [ConferenceRoomNameArray count];
        
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==1) {
        return [PROJECT_NAMEArray objectAtIndex:row];
    }
    if (picker.tag==2) {
        return [MeetingVALUEArray objectAtIndex:row];
    }
    else{
        return [ConferenceRoomNameArray objectAtIndex:row];
        
    }
    return NO;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==1)
    {
        Projectstxtfld.text=[PROJECT_NAMEArray objectAtIndex:row];
        _ProjId = [PROJECT_IDArray objectAtIndex:row];
        NSLog(@"propiid %@ %@",ProjectIdstr,_ProjId);
       [ProjectListpicker removeFromSuperview];
        
   
    }
    if (pickerView.tag==2)
    {
        Meetingtypetxtfld.text=[MeetingVALUEArray objectAtIndex:row];
        _MeetingTypeId = [MeetingCODE_IDArray objectAtIndex:row];
        NSLog(@"propiid235 %@ %@",MeetingcodeIdstr,_MeetingTypeId );
        [ProjectListpicker removeFromSuperview];
    }
    
    if (pickerView.tag==3) {
        Confrencermtxtfld.text=[ConferenceRoomNameArray objectAtIndex:row];
        _ConfOwnerId  = [ConferenceRoomIdArray objectAtIndex:row];
        NSLog(@"conference ids %@ %@",_ConferenceRoomstr,_ConfOwnerId);
        [ProjectListpicker removeFromSuperview];
        
    }
    
    else{
        
        
    }
    
    
    
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==xmlParser)
    {
        if([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            ProjectListArray       =[NSMutableArray new];
            PROJECT_NAMEArray      =[NSMutableArray new];
            PROJECT_IDArray        =[NSMutableArray new];
            ProjectlistSplitArray  =[NSArray new];
        }
    }
    if (parser==xmlParser1)
    {
        if([elementName isEqualToString:@"meetingtypeResponse"])
        {
            MeetingVALUEArray       =[NSMutableArray new];
            MeetingCODE_IDArray     =[NSMutableArray new];
            MeetingListArray        =[NSMutableArray new];
            MeetingSplitArray       =[NSArray new];
        }
    }
    if (parser==xmlParser2)
    {
        if([elementName isEqualToString:@"pickConfRoomListResponse"])
        {
            ConfRoomlIstArray         =[NSMutableArray new];
            ConferenceRoomIdArray     =[NSMutableArray new];
            ConferenceRoomNameArray   =[NSMutableArray new];
            ConfRoomSplitArray        =[NSArray new];
        }
    }
    if (parser==xmlParser3)
    {
        if([elementName isEqualToString:@"saveMeetingResponse"])
        {
            saveMeetingResponse1Array         =[NSMutableArray new];
            meetingsplitResponseArray=[NSMutableArray new];
            
        }
    }

    if (parser==xmlParser4)
    {
        if([elementName isEqualToString:@"updateMeetingResponse"])
        {
            Savemeetingrespocearray         =[NSMutableArray new];
            saveMeetingResArray=[NSMutableArray new];
        }
    }
    if (parser==xmlParser5)
    {
        if ([elementName isEqualToString:@"agendaGoalCountDataResponse"])
        {
            timelengthArray=[NSMutableArray new];
            timelengthSplitArray=[NSMutableArray new];
            timelengthSplitDisplayArray=[NSMutableArray new];
            timeLength=[NSString new];
        }
    }
    

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    
    
    if (parser == xmlParser)
    {
     if ([string isEqualToString:@"Flase"])
      {
          UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Meeting" message:@"Project list is emptymeetin" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
          
          [alert show];
       }
        else
        {
          [ProjectListArray addObject:string];
        }
        
        
    }
    if (parser == xmlParser1)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Meeting" message:@"Meeting type list is empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil,nil];
            
            [alert show];
        }
        else
        {
            [MeetingListArray addObject:string];
        }
    
    }
    if (parser == xmlParser2)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Meeting" message:@"Conference room list is empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [ConfRoomlIstArray addObject:string];
        }
    }
    
    
    
    if (parser == xmlParser3)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Meeting" message:@"Meeting Cant Saved" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
      
      
        else
        {
            NSLog(@"savemeetin response  is %@",MeetingResponseStr);
            MeetingResponseStr=string;
            [saveMeetingResponse1Array addObject:string];
            NSLog(@"savemeetin response array is %@",saveMeetingResponse1Array);
            
           
        }
                
    }
    
    if (parser == xmlParser4)
    {
        if ([string isEqualToString:@"Problem"]||[string isEqualToString:@"Weekend"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Meeting" message:@"Meeting Not Updated" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
        else{
            [Savemeetingrespocearray addObject:string];
            NSLog(@"savemeeting response array is %@",Savemeetingrespocearray);
        }
       
        
    }
    if(parser==xmlParser5)
    {
        string = [string stringByReplacingOccurrencesOfString:@"###TimeBudgeted==" withString:@""];
        agendaCount=[string intValue];
        //NSLog(@"agenda count value is %d",agendaCount);
    }



}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
    {
        if([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            for (int i = 0; i<[ProjectListArray count]; i++)
            {
                ProjectlistSplitArray=[[ProjectListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [PROJECT_IDArray addObject:[[ProjectlistSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"PROJECT_ID==" withString:@""]];
                [PROJECT_NAMEArray addObject:[[ProjectlistSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"PROJECT_NAME==" withString:@""]];
                
            }
            
            
            
                       // [ProjectListpicker reloadAllComponents];
            
            
            if ([Projectstxtfld.text length]==0)
            {
                Projectstxtfld.text=[PROJECT_NAMEArray objectAtIndex:0];
                _ProjId=[PROJECT_IDArray objectAtIndex:0];
                //[ProjectListpicker removeFromSuperview];
            }
            
        
                for (int i=0; i<[PROJECT_NAMEArray count]; i++)
                {
                    if ([_ProjectNamestr isEqualToString:[PROJECT_NAMEArray objectAtIndex:i]])
                    {
                        Projectstxtfld.text=[PROJECT_NAMEArray objectAtIndex:i];
                        _ProjId=[PROJECT_IDArray objectAtIndex:i];
                    }
                }
        
        }
    }
    
    if (parser == xmlParser1)
    {
        if([elementName isEqualToString:@"meetingtypeResponse"])
        {
            for (int i = 0; i<[MeetingListArray count]; i++)
            {
                MeetingSplitArray=[[MeetingListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                 [MeetingCODE_IDArray addObject:[[MeetingSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"CODE_ID==" withString:@""]];
                [MeetingVALUEArray addObject:[[MeetingSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"VALUE==" withString:@""]];
                
//                NSLog(@"Projects list %@",MeetingVALUEArray);
            }
            if ([Meetingtypetxtfld.text length]==0)
            {
//                Meetingtypetxtfld.text=[MeetingVALUEArray objectAtIndex:0];
//                _MeetingTypeId=[MeetingCODE_IDArray objectAtIndex:0];
//                [ProjectListpicker removeFromSuperview];
            }
            else
            {
                for (int i=0; i<[MeetingVALUEArray count]; i++)
                {
                    if ([_MeetingTypestr isEqualToString:[MeetingVALUEArray objectAtIndex:i]])
                    {
                        Meetingtypetxtfld.text=[MeetingVALUEArray objectAtIndex:i];
                        _MeetingTypeId=[MeetingCODE_IDArray objectAtIndex:i];
                    }
                }
            }

            
            [ProjectListpicker reloadAllComponents];
        }
    }
    
    if (parser == xmlParser2)
    {
        if([elementName isEqualToString:@"pickConfRoomListResponse"])
        {
            for (int i = 0; i<[ConfRoomlIstArray count]; i++)
            {
                ConfRoomSplitArray=[[ConfRoomlIstArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [ConferenceRoomIdArray addObject:[[ConfRoomSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"ConferenceRoomId==" withString:@""]];
                [ConferenceRoomNameArray addObject:[[ConfRoomSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString: @"ConferenceRoomName==" withString:@""]];
                //[ConferenceRoomNameArray addObject:_ConferenceRoomstr];
                
                NSLog(@"Conference room names are %@ %@",ConferenceRoomIdArray,ConferenceRoomNameArray );
            }
            if ([_ConferenceRoomstr length] == 0 ||[_ConferenceRoomstr isEqualToString:@"null"])
            {
                
                Confrencermtxtfld.text = @"Select room";//[ConferenceRoomNameArray objectAtIndex:0];
                _ConfOwnerId= @"0";//[ConferenceRoomIdArray objectAtIndex:0];
                
                
                
            }
          
            else
            {
                
                
                for(int i=0; i<[ConferenceRoomNameArray count]; i++)
                {
                    if([_ConferenceRoomstr isEqualToString:[ConferenceRoomNameArray objectAtIndex:i]])
                    {
                        
                        Confrencermtxtfld.text = [ConferenceRoomNameArray objectAtIndex:i];
                        _ConfOwnerId = [ConferenceRoomIdArray objectAtIndex:i];
                        
                        
                    }
                }
                
                
            }

            [ProjectListpicker reloadAllComponents];
        }
    }
    if (parser == xmlParser3)
        
        NSLog(@"meeting response str is %@",MeetingResponseStr);
    {
        if([elementName isEqualToString:@"saveMeetingResponse"])
        {
            
            if([MeetingResponseStr isEqualToString:@"AlreadyExists"])
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting" message:@"Meeting Alreeady Existed" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];

            }
       else if([MeetingResponseStr isEqualToString:@"Weekend"])
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting" message:@"Meeting Cant Saved on Weekend" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
                
            }
//      else if([MeetingResponseStr isEqualToString:@"Problem"])
//          {
//              
//              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting" message:@"Meeting Cant Saved on Weekend" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//              [alert show];
//              
//          }
//

           //[saveMeetingResponse1Array addObject:MeetingResponseStr];
            else
            {
            
                for (int i = 0; i<[saveMeetingResponse1Array count]; i++)
                {
                    meetingsplitResponseArray=[[saveMeetingResponse1Array objectAtIndex:i]componentsSeparatedByString:@","];
                    
                    conferencestr=[[meetingsplitResponseArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"confrenceRoom==" withString:@""];
                    
                    NSLog(@"save meeting response names are %@",conferencestr);
                }
                _MeetingId = [[meetingsplitResponseArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"MeetingId=" withString:@""];
                _Hoursstr = Meetinglengthtxtfld.text;
                [Savebtn setTitle:@"Update" forState:UIControlStateNormal];
                NSLog(@"meeting id is %@",_MeetingId);
                [ProjectListbtn setEnabled:NO];
                
                _locationUseBool=YES;
                
                 [self agendaCount];

            
            
            if ([conferencestr isEqualToString:@"ConfInserted"])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting Saved" message:@"Conference Room Selected" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
                
                
          }
            if ([conferencestr isEqualToString:@"RoomAlreadyBooked"])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting" message:@"Conference Room Already Booked" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
                
                
            }
            
            if ([conferencestr isEqualToString:@"No Conference Room Selected"])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Meeting Saved" message:@"No Conference Room Selected" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
                
                
            }
            

            
            }

        }
    }
    
        if (parser == xmlParser4)
        {
            if ([elementName isEqualToString:@"updateMeetingResponse"])
            {
                for (int i=0; i<[Savemeetingrespocearray count]; i++)
                {
                    saveMeetingResArray=[[Savemeetingrespocearray objectAtIndex:i]componentsSeparatedByString:@","];
                    NSLog(@"save meeting res array is %@",saveMeetingResArray);
                    savemeetingstr=[[saveMeetingResArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"confrenceRoom==" withString:@""];
                    
                    _ProjId=[[saveMeetingResArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"ProjectId=" withString:@""];
                    
                     //
                    [self agendaCount];
                }
                NSLog(@"save meeting str is %@",savemeetingstr);
                if([savemeetingstr isEqualToString:@"No Conference Room Selected"])
                {
                    
                    UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"NO Conference Room Selected" message:@"Updated succesfully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
                    [al show];
                    
                    // [self data1];
                }
                
               
                else if([savemeetingstr isEqualToString:@"RoomAlreadyBooked"])
                {
                    
                    UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"RoomAlreadyBooked" message:@"Meeting updated" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
                    [al show];
                    
                    
                }
                else if([savemeetingstr isEqualToString:@"Weekend"])
                {
                    
                    UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"Weekend" message:@"Meeting cant updated on weekend" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
                    [al show];
                    
                    
                }

                
            else if([savemeetingstr isEqualToString:@"ConfUpdated"])
                {
                    //[self data1];
                    
                    UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"Meeting Updated" message:@"Conference Room selected" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
                    [al show];
                    _Hoursstr=Meetinglengthtxtfld.text;
                    
                }
                else if([savemeetingstr isEqualToString:@"Conf Not Inserted"])
                {
                    UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"Not Updated" message:@"Not Updated succesfully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
                    [al show];
                    
                    //[self data1];
                    
                }

            }
        }

    
    if (parser==xmlParser5)
    {
        if([elementName isEqualToString:@"agendaGoalCountDataResponse"])
        {
            for (int i = 0; i<[timelengthArray count]; i++)
            {
                timelengthSplitArray=[[timelengthArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                timeLength=[[timelengthSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TimeBudgeted==" withString:@""];
                
                //[timelengthSplitDisplayArray addObject:timeLength];
                
                NSLog(@"time count value is %@",timeLength);
               // timeLength1=timelengthSplitDisplayArray;
            }
            [timelengthSplitDisplayArray addObject:timeLength];


       }
   }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == Meetinglengthtxtfld )
    {
        [self agendaCount];
        if ([Meetinglengthtxtfld.text intValue] <[timeLength intValue])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Enter Grater Time Length Than Agenda Count" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            
            
            NSLog(@"welcome to eis");
        }
       _Hoursstr=Meetinglengthtxtfld.text;
    }
    if (textField == Meetingtimetxtfld )
    {
        
        [self doneButton];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    [Meetinglengthtxtfld resignFirstResponder];
    if (textField == Meetinglengthtxtfld )
    {
        [self agendaCount];
        
        if ([Meetinglengthtxtfld.text intValue]<agendaCount)
        {
            NSLog(@"meetinglength STR IS  %d",[Meetinglengthtxtfld.text intValue]);
            NSLog(@"HOURS STR IS  %d",[_Hoursstr intValue]);
            NSLog(@"agenda count is %d",agendaCount);
            
            UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Enter greater lenth than agenda goals" message:@"" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
            [alert show];
            
        }

    }
    //[Projectstxtfld resignFirstResponder];
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == Meetingtimetxtfld )
    {
        return YES;
    }
    
    if (textField == Meetinglengthtxtfld )
    {
        return YES;
    }
    if (textField == Meetingtitletxtfld )
    {
        return YES;
    }
    if (textField == Meetingdistxtfld )
    {
        return YES;
    }
    
    
    return NO;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return NO;
}

-(void)didFinishService:(id)Userlogindetails
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
}
-(void)Serviceactiondone:(id)result
{
    xmlParser = [[NSXMLParser alloc]initWithData:result];
    xmlParser.delegate = self;
    [xmlParser parse];
}
-(void)Serviceactiondone1:(id)result
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:result];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    
    
    xmlParser5=[[NSXMLParser alloc]initWithData:result];
    xmlParser5.delegate=self;
    [xmlParser5 parse];
    
    
}
-(void)didFinishData:(id)Data
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:Data];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
}
-(void)didEndTask:(id)Taskend
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:Taskend];
    xmlParser4.delegate = self;
    [xmlParser4 parse];
}

-(void)CreatmeetingV
{
   _MeetingId= @"";
    Projectstxtfld.text = @"";
    Meetingdistxtfld.text = @"";
    Meetingtitletxtfld.text =@"";
    Meetingtypetxtfld.text = @"";
    Meetingtimetxtfld.text = @"";
    Meetinglengthtxtfld.text =@"";
    Confrencermtxtfld.text =@"Select room";
    _ConfOwnerId = @"0";
     _locationUseBool = NO;
    //meetingidstr=@"0";
    [ProjectListbtn setEnabled:YES];
    
    self.navigationItem.title = @"Creat Meeting";
    [Savebtn setTitle:@"Save" forState:UIControlStateNormal];
    
    //NSLog(@"meeting id is %@",_MeetingId);
    
}
-(void)agendaCount
{
    
    NSLog(@"meeting id is %@",_MeetingId);
    NSString *credentials1 = [NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/agendaGoalCount?meetingId=%@",_MeetingId];
    NSString *encode=[credentials1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall agendacount:encode];
    [Servicecall setDelegate:self];

}
-(void)agendaGoalcount:(id)agnedacounturl
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=agnedacounturl;
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"agendacount is zero" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    }
    else
    {
        //resultarray3=[[NSMutableArray alloc]init];
        agendaCount=[[dict valueForKey:@"agendaGoalCount"]intValue];
        NSLog(@"agenda cout is %d",agendaCount);
        
    }
}

-(void)HomePagebtnTapped
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)LogoutbtnTapped
{
    LogoutAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [LogoutAlert show];

    
}


-(IBAction)AgendBtnTapped:(id)sender
{
    if ([_MeetingId length]==0)
    {
        [self.view makeToast:@"Please Check Meeting Id Null" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 840)]];
    }
    else{

    AgendaVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaVC"];
    AgendaVC.Hours = [_Hoursstr intValue];
       
    AgendaVC.MeetingId = _MeetingId;
        NSLog(@"meeting id %@ %@",AgendaVC.MeetingId,_Hoursstr);
    [self.navigationController pushViewController:AgendaVC animated:YES];
    }
}

-(IBAction)GoalsBtnTapped:(id)sender
{
    if ([_MeetingId length]==0)
    {
        [self.view makeToast:@"Please Check Meeting Id Null" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(480, 840)]];
    }
    else{
    GoalsVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"GoalsV"];
    GoalsVC.MeetingId = _MeetingId;
    GoalsVC.Hours = [_Hoursstr intValue];

    [self.navigationController pushViewController:GoalsVC animated:YES];
    }
}

-(IBAction)ParticipantsBtnTapped:(id)sender
{
    if ([_MeetingId length]==0)
     {
    [self.view makeToast:@"Please Check Meeting Id Null" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(580, 840)]];
     }
    else {
    ParticipantVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"PaticipantsVC"];
        NSLog(@"meeting id is %@",_MeetingId);
        NSLog(@"project id is %@",projectidStr);
    ParticipantVC.MeetingId = _MeetingId;
    ParticipantVC.ProjectIdStr=_ProjId;
        
    [self.navigationController pushViewController:ParticipantVC animated:YES];
    }

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == LogoutAlert)
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
-(IBAction)homeBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.view setNeedsDisplay];

    [super viewWillAppear:animated];
    
     [self agendaCount];
}
-(void)viewDidAppear:(BOOL)animated
{
     [self agendaCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    [UIView animateWithDuration:0.2f animations:^
    {

        CGRect frame = CreatmeetingView.frame;
        frame.origin.y -= kbSize.height;
        CreatmeetingView.frame = frame;

//        frame = TextTableV.frame;
//        frame.size.height -= kbSize.height;
//        TextTableV.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    [UIView animateWithDuration:0.2f animations:^{

        CGRect frame = CreatmeetingView.frame;
        frame.origin.y += kbSize.height;
        CreatmeetingView.frame = frame;

//        frame = TextTableV.frame;
//        frame.size.height += kbSize.height;
//        TextTableV.frame = frame;
    }];
}
//-(void)pickerTapped
//{
//    [ProjectListpicker removeFromSuperview];
//}
@end
