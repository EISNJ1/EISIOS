//
//  CreatTaskViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/28/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "CreatTaskViewController.h"
#import "Toast+UIView.h"
#import "MBProgressHUD.h"
@interface CreatTaskViewController ()
{
    UIPickerView*  ProjectListpicker;
    UIDatePicker *DatePicker;
    //user Details
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr,*startdateee;
    NSXMLParser *CategoryxmlParse,*PriorityxmlParser,*ResourcexmlParser,*ProjectxmlParser,*HardDependencyXmlParser,*SaveNewTaskxmlParser;
    
    //ProjectList
    NSMutableArray *ProjectListArray,*PROJECT_IDArray,*PROJECT_NAMEArray;
    NSArray *ProjectlistSplitArray;
    
    
    //CategoryList
    NSMutableArray *CategoryListArray,*Category_IDArray,*Category_NAMEArray;
    NSArray *CategoryListSplitArray;
    
    
    //PriorityList
    
    NSMutableArray *PriorityListArray,*Priority_IDArray,*Priority_NAMEArray;
    NSArray *PriorityListSplitArray;
    
    
    //ResourceList
    
    NSMutableArray *ResourceListArray,*Resource_IDArray,*Resource_NAMEArray;
    NSArray *ResourceListSplitArray;
    NSString*   enddate;
    
    
    //Save&Update
    
    NSMutableArray *HardDependencylistArray,*HardDependency_IDArray,*HardDependencyDisplayNameArray,*startDateArray,*endDateArray,*hardDependencyAlldataArray;
    NSArray *HardDependencySplirtArray;
    
    NSString *taskNameStr,*taskIdStr,*taskStartDateStr,*taskEndDateStr;
    
    NSString *saveUpdateType,*taskId;
    float k,l,m;
    
    int roundedUp;
    NSString *tasktimelength;
    
    ;
    
    NSMutableArray *holidaysArray,*holidaySplitArray,*holidaystartDateArray;
    
    //holidays list service
    
    NSMutableArray *holidaysListServiceArray,*holidaysListServiceSplitArray,*holidaysListServiceIdArray,*holidayLsitServiceReasonArray,*enddatstrArray,*enddatestrSplitArray2,*enddateStrDisplayArray;
    NSMutableString *dateStr,*enddateStr;
    
    NSMutableString *hardDependencyAllDataString,*currentElement1;
    
    NSIndexPath *previousSelectedIndexPath,*currentIndex;
    
    NSMutableArray *selectedCellArray;
    
    
}

@end

@implementation CreatTaskViewController
@synthesize UpDTaskId;




- (void)viewDidLoad
{
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    [self.view addGestureRecognizer:tapGesture];
   [tapGesture setCancelsTouchesInView:NO];
    
    
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
    
    
//    Projecttxtfld.userInteractionEnabled=NO;
//    Categorytxtfld.userInteractionEnabled=NO;
//    Prioritytxtfld.userInteractionEnabled=NO;
//    Resourcetxtfld.userInteractionEnabled=NO;
//    hardDependencytxtfld.userInteractionEnabled=NO;
    
    self.navigationItem.title = _navigationTitlestr;
    Servicecall =[[Webservices alloc]init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    [self ProjectsList];
    [self CategoryList];
    [self PriorityList];
    [self holidaysList];
    
    selectedRows=[[NSArray alloc]init];
    
    //hoursPerDaytxtfld.keyboardType=UIKeyboardTypeNumberPad;
    Prioritytxtfld.text=_Prioritynamestr;
    Descriptionxtfld.text = _Descriptionstr;
    Efforttxtfld.text     = _Effortstr;
    Resourcetxtfld.text=_Resourcenamestr;
    Projecttxtfld.text=_Projectnamestr;
    hardDependencytxtfld.text=_hardDependencystr;
    
//    if ([hardDependencytxtfld.text length]>0)
//    {
//        selectedCellArray=[]
//    }
    NSLog(@"hard dependency string is%@",_hardDependencystr);
    StartDatetxtfld.text=_StartDatestr;
    NSLog(@"startdate text is %@",_StartDatestr);
    Enddatetxtfld.text=_EndDatestr;
    hoursPerDaytxtfld.text=_hoursPerdayStr;
    taskId=UpDTaskId;
    NSLog(@"updated task id is %@",UpDTaskId);
    //Savebtn.titleLabel.text=_SavebtnTitlestr;
    
    
    selectedRowArray=[[NSMutableArray alloc]init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    //[dateFormat setTimeStyle:NSDateFormatterNoStyle];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    startDate = [dateFormat dateFromString:_StartDatestr];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
    NSLog(@"date str is %@",startDate);
    
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    StartDatetxtfld.text = [dateFormat stringFromDate:startDate];
    NSLog(@"the start date is %@",StartDatetxtfld.text);
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM/dd/yyyy"];
    NSDate *Enddate = [dateFormat1 dateFromString:_EndDatestr];
    [dateFormat1 setDateFormat:@"MM/dd/yyyy"];
    
    //[self holidaysListChecking];
   //Enddatetxtfld.text = [dateFormat1 stringFromDate:Enddate];
    
    
    
    
    //tableview cell with check mark selection array
    
    cellSelectedArray=[NSMutableArray array];
    
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f]];
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    UIButton* Creatmeetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Creatmeetbtn setImage:[UIImage imageNamed:@"expenses_new_icon.png"] forState:UIControlStateNormal];
    [Creatmeetbtn addTarget:self action:@selector(CreatTaskV) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    
    CreateTaskView = (UIView *)[self.view viewWithTag:10];
    CreateTaskView.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor;
    CreateTaskView.layer.borderWidth = 2.0f;
    CreateTaskView.layer.cornerRadius = 14;
    [ScrollV addSubview:CreateTaskView];
    
    homebtn.layer.borderWidth = 2.0f;
    homebtn.layer.cornerRadius = 10;
    homebtn.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    //[homebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    Savebtn.layer.borderWidth = 2.0f;
    Savebtn.layer.cornerRadius = 10;
    Savebtn.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    [Savebtn setTitle:_SavebtnTitlestr forState:UIControlStateNormal];
    
    
    UILabel *projectslbl = (UILabel*)[CreateTaskView viewWithTag:11];
    projectslbl.textColor = [UIColor colorWithRed:(245/255.0) green:(92/255.0) blue:(51/255.0) alpha:1.0f];
    
    UILabel *categorylbl = (UILabel*)[CreateTaskView viewWithTag:12];
    categorylbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *prioritylbl = (UILabel*)[CreateTaskView viewWithTag:13];
    prioritylbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *Descriptionlbl = (UILabel*)[CreateTaskView viewWithTag:14];
    Descriptionlbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *Effortlbl = (UILabel*)[CreateTaskView viewWithTag:15];
    Effortlbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *StartDatelbl = (UILabel*)[CreateTaskView viewWithTag:16];
    StartDatelbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *EndDatelbl = (UILabel*)[CreateTaskView viewWithTag:17];
    EndDatelbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *Resourcelbl = (UILabel*)[CreateTaskView viewWithTag:18];
    Resourcelbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *Harddependencylbl = (UILabel*)[CreateTaskView viewWithTag:19];
    Harddependencylbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    UILabel *NoofDaysPerDayLbl = (UILabel*)[CreateTaskView viewWithTag:20];
    NoofDaysPerDayLbl.textColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    
    
    //-------------Picker buttons Tapped---------------------
    
    UIButton *Resourcepickerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Resourcepickerbtn setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Resourcepickerbtn.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Resourcepickerbtn addTarget:self action:@selector(ResourceListPickerTapped) forControlEvents:UIControlEventTouchUpInside];
    Resourcetxtfld.rightView = Resourcepickerbtn;
    Resourcetxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Resourcetxtfld addSubview:Resourcepickerbtn];
    
    
    ProjectListbtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [ProjectListbtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    ProjectListbtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [ProjectListbtnpkr addTarget:self action:@selector(ProjectListbtnpkrTapped) forControlEvents:UIControlEventTouchUpInside];
    Projecttxtfld.rightView = ProjectListbtnpkr;
    Projecttxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Projecttxtfld addSubview:ProjectListbtnpkr];
    
    UIButton *Datepickerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Datepickerbtn setImage:[UIImage imageNamed:@"datetimepicker.png"] forState:UIControlStateNormal];
    Datepickerbtn.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    _datePickerBtn=Datepickerbtn;
    [Datepickerbtn addTarget:self action:@selector(DatePickerSelection) forControlEvents:UIControlEventTouchUpInside];
    StartDatetxtfld.rightView = Datepickerbtn;
    StartDatetxtfld.rightViewMode = UITextFieldViewModeAlways;
    [StartDatetxtfld addSubview:Datepickerbtn];
    
    
    
    UIButton *Categorybtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Categorybtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Categorybtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Categorybtnpkr addTarget:self action:@selector(CategorybtnpkrTapped) forControlEvents:UIControlEventTouchUpInside];
    Categorytxtfld.rightView = Categorybtnpkr;
    Categorytxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Categorytxtfld addSubview:Categorybtnpkr];
    
    UIButton *Prirotybtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Prirotybtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Prirotybtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Prirotybtnpkr addTarget:self action:@selector(prioritybtnpkrTapped) forControlEvents:UIControlEventTouchUpInside];
    Prioritytxtfld.rightView = Prirotybtnpkr;
    Prioritytxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Prioritytxtfld addSubview:Prirotybtnpkr];
    
    UIButton *HardDependencyPkrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [HardDependencyPkrBtn setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    HardDependencyPkrBtn.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [HardDependencyPkrBtn addTarget:self action:@selector(HardDependencyPickerTapped) forControlEvents:UIControlEventTouchUpInside];
    _harddependencyPkrbtn=HardDependencyPkrBtn;
    hardDependencytxtfld.rightView = HardDependencyPkrBtn;
    hardDependencytxtfld.rightViewMode = UITextFieldViewModeAlways;
    [hardDependencytxtfld addSubview:HardDependencyPkrBtn];
    
    
    selectedCellArray=[[NSMutableArray alloc]init];
    
    
    holidayDateArray=[[NSMutableArray alloc]init];
    
    if (taskId!=nil)
    {
        [ProjectListbtnpkr setEnabled:NO];
    }
    
    //[super viewDidLoad];
    
    [super viewDidLoad];
}
-(void)holidaysList
{
    Servicecall=[[Webservices alloc]init];
    NSString *holidayClass=@"TaskHolidaysWeekendSkip";
    NSDictionary *holidaysDictionary=@{@"orgId":orgIdstr};
    [Servicecall HolidaysList:holidayClass HolidaysListParametersDetails:holidaysDictionary];
    [Servicecall setDelegate:self];
    
}
-(void)ProjectsList
{
    NSString *projectListurl = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"usertype":Usertypestr,@"userid":Useridstr,@"orgid":orgIdstr};
    [Servicecall ProjectspickerurlTask:projectListurl ProjectsListcredentilas:credentials];
    [Servicecall setDelegate:self];
    
    
}
-(void)CategoryList
{
    NSString *TaskListUrl = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"orgId":orgIdstr};
    [Servicecall TaskCategorySpinnerListurl:TaskListUrl Taskcategorycredentials:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)PriorityList
{
    NSString *TaskListUrl = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"orgId":orgIdstr};
    [Servicecall TaskPrioritySpinnerurl:TaskListUrl TaskPriorityparameters:credentials];
    [Servicecall setDelegate:self];
    
    
}

-(void)ProjectListbtnpkrTapped
{
    [Projecttxtfld resignFirstResponder];
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 130, self.view.frame.size.width-400, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 1;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [self.view addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    
}

-(void)CategorybtnpkrTapped
{
    [Categorytxtfld resignFirstResponder];
    
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 220, self.view.frame.size.width-400, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 2;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [self.view addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    
}
-(void)prioritybtnpkrTapped
{
    [Prioritytxtfld resignFirstResponder];
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 320, self.view.frame.size.width-400, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 3;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [self.view addSubview:ProjectListpicker];
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
    
    //[DatePicker removeFromSuperview];
    DatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(325, 480, self.view.frame.size.width-400, 300)];
    [DatePicker addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventValueChanged];
    DatePicker.backgroundColor=[UIColor whiteColor];
    DatePicker.datePickerMode = UIDatePickerModeDate;
    DatePicker.backgroundColor=[UIColor grayColor];
    [DatePicker setMinimumDate: [NSDate date]];
    DatePicker.backgroundColor=[UIColor grayColor];
    DatePicker.alpha = 0;
    UIToolbar* pickerTB = [[UIToolbar alloc]initWithFrame:CGRectMake(-0, -40, 400, 50)];
    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton)];
    [pickerTB setItems:[NSArray arrayWithObjects:doneBtn, nil]];
    [StartDatetxtfld setInputAccessoryView:pickerTB];
    [pickerTB setTintColor:[UIColor greenColor]];
    [pickerTB setBarStyle:UIBarStyleBlack];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    DatePicker.transform = transfrom;
    DatePicker.alpha = DatePicker.alpha * (-1) + 1;
    [UIView commitAnimations];
    StartDatetxtfld.inputView = DatePicker;
    [DatePicker addSubview:pickerTB];
    
    [CreateTaskView addSubview:DatePicker];
    
    
    //StartDatetxtfld.inputAccessoryView = pickerTB;
    
}

-(void)doneButton
{
    NSDate *currentDate1 ;
    
    l=[hoursPerDaytxtfld.text floatValue];
    
    
    if (l==0)
    {
        m=8;
        NSLog(@"m value is %f",m);
    }
    else
    {
        m=l;
        NSLog(@"m value 1 is %f",m);
    }
    

    tasktimelength =Efforttxtfld.text;
    k =[tasktimelength floatValue];
    currentDate1=DatePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    StartDatetxtfld.text = [formatter stringFromDate:currentDate1];
    NSLog(@"start date text field is %@",StartDatetxtfld.text);
    [StartDatetxtfld resignFirstResponder];
    [DatePicker removeFromSuperview];

    roundedUp = ceilf(k/m);

    if (roundedUp==1)
        
    {
        
        Enddatetxtfld.text = StartDatetxtfld.text;
    }
    

    else
    {
        
            currentDate1=DatePicker.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [formatter setDateFormat:@"MM/dd/yyyy"];
            StartDatetxtfld.text = [formatter stringFromDate:currentDate1];
            NSLog(@"start date text field is %@",StartDatetxtfld.text);
            [StartDatetxtfld resignFirstResponder];
            [DatePicker removeFromSuperview];
        
        NSDate *holidayDate=[[NSDate alloc]init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [formatter setDateFormat:@"MM/dd/yyyy"];
        
            NSLog(@"holidays list service date arrray is %@",holidaysListServiceDateArray);
        
              datesare1=[[NSMutableArray alloc]init];
            NSLog(@"holiday date is %@",holidayCheckedArray);
        
            for (int i=0; i<[holidaysListServiceDateArray count]; i++)
            {
                convertedate=[holidaysListServiceDateArray objectAtIndex:i];
                NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
                [dateformat setDateFormat:@"yyyy-MM-dd"];
                NSDate *date1=[dateformat dateFromString:convertedate];
                [dateformat setDateFormat:@"MM/dd/yyyy"];
                datesare=[dateformat stringFromDate:date1];
                 [datesare1 addObject:datesare];
            }
          


    }
  
        if ([_datePickerBtn isSelected]==YES)
        {
            currentDate1=DatePicker.date;
        }
            
    //    if ([_SavebtnTitlestr isEqualToString:@"Update"] &&(_datePickerBtn.isSelected))
//    {
//        currentDate1=DatePicker.date;
//        NSLog(@"update and date picker");
//    }
   
   

    
//    if ([_SavebtnTitlestr isEqualToString:@"Update"])
//    {
//        currentDate1 = startDate;
//        //[self holidaysListChecking];
//        
//        NSLog(@"welcome top eis");
//    }
//     else
//    {
//        currentDate1=DatePicker.date;
//    }
//    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateStyle:NSDateFormatterShortStyle];
    [formatter1 setTimeStyle:NSDateFormatterNoStyle];
    [formatter1 setDateFormat:@"MM/dd/yyyy"];
    StartDatetxtfld.text = [formatter stringFromDate:currentDate1];
    NSLog(@"start date text field is %@",StartDatetxtfld.text);
    [StartDatetxtfld resignFirstResponder];
    [DatePicker removeFromSuperview];
   
    roundedUp = ceilf(k/m);
    
    if (roundedUp==1)
        
    {
        
        Enddatetxtfld.text = StartDatetxtfld.text;
    }
    else
    {
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
        [formatter1 setDateStyle:NSDateFormatterShortStyle];
        [formatter1 setTimeStyle:NSDateFormatterNoStyle];
        [formatter1 setDateFormat:@"MM/dd/yyyy"];
        StartDatetxtfld.text = [formatter stringFromDate:currentDate1];
        NSLog(@"start date text field is %@",StartDatetxtfld.text);
        [StartDatetxtfld resignFirstResponder];
        [DatePicker removeFromSuperview];
        
    }
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar]components:NSWeekdayCalendarUnit fromDate:currentDate1];
    
    int j = [dateComponents weekday];
    
    if (j==1||j==7)
    {
        [StartDatetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select only Weekdays" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 640)]];
        StartDatetxtfld.text=@"";
        Enddatetxtfld.text=@"";
        //NSLog(@"holiday list date str is %@",holidaysListServiceDateArray);
        
    }
  else if ([datesare1 containsObject:StartDatetxtfld.text])
    {
        [StartDatetxtfld setBackgroundColor:[UIColor redColor]];
        
        [self.view makeToast:@"This day is Holiday" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 640)]];
        StartDatetxtfld.text=@"";
        Enddatetxtfld.text=@"";
    }
  else
  {
    
    [self holidaysListChecking];
  }
    //Enddatetxtfld.text=endDateStr;
    NSLog(@"end date is %@",endDateStr);
    
//    roundedUp = ceilf(k/m);
//    if (roundedUp==1)
//    {
//        Enddatetxtfld.text = StartDatetxtfld.text;
//    }
//    else
//    {
////        if ([StartDatetxtfld.text length]!=0 && Efforttxtfld.text!=0)
////        {
////           
////        }
////        else
////        {
////            [self.view makeToast:@"Please select start datet And Enter Effort Value" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 600)]];
////            Enddatetxtfld.text=@" ";
////        }
//       
//        NSLog(@"the rounded date is %d",roundedUp);
//        NSDate *now ;
//        if ([_SavebtnTitlestr isEqualToString:@"Update"])
//        {
//            now =DatePicker.date;
//            
//        }
////        else
////        {
////            now=DatePicker.date;
////        }
////        
//        NSLog(@"current IS %@",now);
//        NSDateFormatter *enddateformate = [[NSDateFormatter alloc]init];
//        
//        NSDate *newDate1 = [now dateByAddingTimeInterval:(roundedUp-1)*60*60*24];
//        // [enddateformate setDateFormat:@"yyyy-MM-dd"];
//        // NSString * enddate = [enddateformate stringFromDate:newDate1];
//        
//        
//        
//        NSInteger count = 0;
//        NSInteger friday =6;
//        
//        // Set the incremental interval for each interaction.
//        NSDateComponents *oneDay = [[NSDateComponents alloc]init];
//        [oneDay setDay:1];
//        
//        // Using a Gregorian calendar.
//        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//        
//        NSDate *currentDate = now;
//        
//        // Iterate from fromDate until toDate
//        while ([currentDate compare:newDate1] == NSOrderedAscending)
//        {
//            NSDateComponents *dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:currentDate];
//            
//            
//            if (dateComponents.weekday == friday)
//            {
//                count =  count+2;
//                NSLog(@"count %d", count);
//                // NSDateComponents *oneDay = [[NSDateComponents alloc] init];
//                // [oneDay setDay:2];
//                newDate1 = [newDate1 dateByAddingTimeInterval:2*60*60*24];
//                // [oneDay setDay:2];
//                
//            }
//            //NSDateComponents *oneDay = [[NSDateComponents alloc] init];
//            //[oneDay setDay:(count*2)];
//            // "Increment" currentDate by one day.
//            //[oneDay setDay:(count*2)];
//            NSString *holidayDate=dateStr;
//            NSLog(@"holiday date str is %@",holidaysListServiceDateArray);
//            
//            currentDate = [calendar dateByAddingComponents:oneDay
//                                                    toDate: currentDate
//                                                   options:0];
//            NSDateFormatter *enddateformate1 = [[NSDateFormatter alloc] init];
//            
//            
//            [enddateformate1 setDateFormat:@"dd/MM/yyyy"];
//            enddate = [enddateformate1 stringFromDate:currentDate];
//            NSLog(@"FLOA IS %@",enddate);
//            enddate=holidayEnddate;
//            //NSLog(@"holiday end date is %@",holidayEnddate);
//        }
//        [self holidaysListChecking];
//        Enddatetxtfld.text = enddate;
//    }
//    [hardDependencytxtfld setEnabled:YES];
//    [_harddependencyPkrbtn setEnabled:YES];
//    //hardDependencytxtfld.text=@"";
//    
//    [StartDatetxtfld resignFirstResponder];
}
-(void)holidaysListChecking
{
           Servicecall=[[Webservices alloc]init];
        NSString *effortdays=[NSString stringWithFormat:@"%d",roundedUp];
        NSLog(@"the effort days is %@",effortdays);
        
        NSLog(@"hours per day text field text is %@",hoursPerDaytxtfld.text);
        NSString *HolidaysListClass=@"TaskHolidaysWeekendSkip";
        
        NSDictionary *HolidayslistParameters=@{@"orgId":orgIdstr,@"planedStartDate":StartDatetxtfld.text,@"effortDays":effortdays};
        
        [Servicecall HolidaysListForTask:HolidaysListClass HolidaysListParameters:HolidayslistParameters];
        [Servicecall setDelegate:self];

  
    
}

-(void)ResourceListPickerTapped
{
    [Resourcetxtfld resignFirstResponder];
    [ProjectListpicker removeFromSuperview];
    ProjectListpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(325, 520, self.view.frame.size.width-400, 300)];
    [ProjectListpicker setShowsSelectionIndicator:YES];
    ProjectListpicker.delegate = self;
    ProjectListpicker.dataSource = self;
    ProjectListpicker.tag = 4;
    ProjectListpicker.backgroundColor=[UIColor grayColor];
    ProjectListpicker.alpha = 0;
    [self.view addSubview:ProjectListpicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ProjectListpicker.transform = transfrom;
    ProjectListpicker.alpha = ProjectListpicker.alpha * (-1) + 1;
    [UIView commitAnimations];
  }
-(void)HardDependencyPickerTapped
{
    [StartDatetxtfld setEnabled:NO];
    [_datePickerBtn setEnabled:NO];
    
    CGFloat x = 10;
    CGFloat y = 500;
    CGFloat width = 650;
    CGFloat height = 250;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    hardDependencyTableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    hardDependencyTableView.rowHeight = 35;
    hardDependencyTableView.layer.borderWidth=2.0;
    hardDependencyTableView.layer.borderColor=[UIColor grayColor].CGColor;
    hardDependencyTableView.tag=2;
    hardDependencyTableView.sectionFooterHeight = 0;
    hardDependencyTableView.sectionHeaderHeight = 10;
    hardDependencyTableView.scrollEnabled = YES;
    hardDependencyTableView.showsVerticalScrollIndicator = YES;
    hardDependencyTableView.userInteractionEnabled = YES;
    hardDependencyTableView.bounces = YES;
    hardDependencyTableView.delegate = self;
    hardDependencyTableView.dataSource = self;
    hardDependencyTableView.allowsMultipleSelection=YES;
    hardDependencyTableView.backgroundColor=[UIColor whiteColor];
   [hardDependencyTableView setAllowsMultipleSelectionDuringEditing:YES];
    NSLog(@"welcome to eis");
    //[hardDependencyTableView setEditing:YES animated:YES];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10,10, 150, 50);
    //[btn setTitle:@"Submit" forState:UIControlStateNormal];//
    [btn setImage:[UIImage imageNamed:@"submit"] forState: UIControlStateNormal];
    btn.center=CGPointMake(x+300, 10);
    //btn.backgroundColor=[UIColor purpleColor];
    
    [btn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    hardDependencyTableView.tableFooterView = headerView;
    [headerView addSubview:btn];
    [hardDependencyTableView addSubview:headerView];
    [CreateTaskView addSubview:hardDependencyTableView];
    [UIView commitAnimations];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hardDependencyAlldataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text=[hardDependencyAlldataArray objectAtIndex:indexPath.row];
    
    if ([[cellSelectedArray objectAtIndex:indexPath.row] boolValue] == YES)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"welcome to eis");
    NSArray *selectedRows=[hardDependencyTableView indexPathsForSelectedRows];
    
    NSLog(@"selected rows %@",selectedRows);
    
    
    
    NSMutableArray *rownumberArray=[[NSMutableArray alloc]init];
    NSMutableArray *dateArray=[[NSMutableArray alloc]init];
    
    
    
    for (int i=0; i<selectedRows.count; i++)
    {
        NSIndexPath *indexPath = [selectedRows objectAtIndex:i];
        //[tableView reloadData];
        
        //[tableView selectRowAtIndexPath:selectedRows[i] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        NSInteger row = indexPath.row;
        NSNumber *number = [NSNumber numberWithInteger:row];
        [rownumberArray addObject:[HardDependency_IDArray objectAtIndex:indexPath.row]];
        [dateArray addObject:[endDateArray objectAtIndex:indexPath.row]];
        
        
        selectedRowArray=[[NSMutableArray alloc]init];
        dateArray2=[[NSMutableArray alloc]init];
        selectedRowArray=rownumberArray;
        dateArray2=dateArray;
        NSLog(@"enddate array is %@ 25412",dateArray2);
        
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [cellSelectedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cellSelectedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}
-(void)submitBtnClicked
{
    l=[hoursPerDaytxtfld.text floatValue];
    
    
    if (l==0)
    {
        m=8;
    }
    else
    {
        m=l;
    }
    tasktimelength =Efforttxtfld.text;
    k =[tasktimelength floatValue];
    
    NSLog(@"the array value is %@",selectedRowArray);
    
    NSMutableString *joinedComponents = [selectedRowArray componentsJoinedByString:@","];
    NSLog(@"the selected string is %@",joinedComponents);
    
    hardDependencyText=[[NSMutableString alloc]init];
    hardDependencyText=[joinedComponents stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    hardDependencytxtfld.text=hardDependencyText;
    [hardDependencyTableView setHidden:YES];
    
    
    NSMutableArray *arrDates = [[NSMutableArray alloc]init];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MM/yyyy"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    for (int i =0; i<[dateArray2 count]; i++)
    {
        [arrDates addObject:[df dateFromString:dateArray2[i]]];
    }
    NSLog(@"selected dates are %@",arrDates);
    NSDate *maxDate=[arrDates valueForKeyPath:@"@max.self"];
    NSLog(@"max date is %@",maxDate);
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *newmaxDate = [theCalendar dateByAddingComponents:dayComponent toDate:maxDate options:0];
    
    maxDate1=[[NSMutableString alloc]init];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    maxDate1=[dateFormatter stringFromDate:newmaxDate];
    StartDatetxtfld.text=maxDate1;
    
    roundedUp = ceilf(k/m);
    if (roundedUp==1)
    {
        Enddatetxtfld.text = StartDatetxtfld.text;
    }
    else
    {
        if ([Efforttxtfld.text length]!=0)
        {
            [self holidaysListChecking];
        }
        NSDateFormatter *df1=[[NSDateFormatter alloc]init];
        NSDate *now = maxDate;
        NSLog(@"current IS %@",now);
        NSDateFormatter *enddateformate =[[NSDateFormatter alloc]init];
        
        NSDate *newDate1 = [now dateByAddingTimeInterval:(roundedUp-1)*60*60*24];
        // [enddateformate setDateFormat:@"yyyy-MM-dd"];
        // NSString * enddate = [enddateformate stringFromDate:newDate1];
        
        
        
        NSInteger count = 0;
        NSInteger friday =6;
        
        // Set the incremental interval for each interaction.
        NSDateComponents *oneDay = [[NSDateComponents alloc]init];
        [oneDay setDay:1];
        
        // Using a Gregorian calendar.
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *currentDate = now;
        
        // Iterate from fromDate until toDate
        while ([currentDate compare:newDate1] == NSOrderedAscending)
        {
            NSDateComponents *dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:currentDate];
            
            
            if (dateComponents.weekday == friday) {
                count =  count+2;
                NSLog(@"count %d", count);
                // NSDateComponents *oneDay = [[NSDateComponents alloc] init];
                // [oneDay setDay:2];
                newDate1 = [newDate1 dateByAddingTimeInterval:2*60*60*24];
                // [oneDay setDay:2];
                
            }
            //NSDateComponents *oneDay = [[NSDateComponents alloc] init];
            //[oneDay setDay:(count*2)];
            // "Increment" currentDate by one day.
            //[oneDay setDay:(count*2)];
            
            currentDate = [calendar dateByAddingComponents:oneDay
                                                    toDate: currentDate
                                                   options:0];
            NSDateFormatter *enddateformate1 = [[NSDateFormatter alloc] init];
            
            
            [enddateformate1 setDateFormat:@"dd/MM/yyyy"];
            enddate = [enddateformate1 stringFromDate:currentDate];
            NSLog(@"FLOA IS %@",enddate);
            
        }
        Enddatetxtfld.text = enddate;
    }
    [hardDependencyTableView reloadData];
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    //    [self.view addGestureRecognizer:tapGesture];
}

-(IBAction)SaveTask:(id)sender
{
    if ([Projecttxtfld.text length]==0)
    {
        [Projecttxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select ProjectList" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 220)]];
    }
    else if ([Categorytxtfld.text length]==0)
    {
        [Projecttxtfld setBackgroundColor:[UIColor whiteColor]];
        [Categorytxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select CategoryList" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 310)]];
        
    }
    else if ([Prioritytxtfld.text length]==0)
    {
        [Categorytxtfld setBackgroundColor:[UIColor whiteColor]];
        [Prioritytxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select PriorityList" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 400)]];
        
    }
    else if ([Descriptionxtfld.text length]==0)
    {
        [Prioritytxtfld setBackgroundColor:[UIColor whiteColor]];
        [Descriptionxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter TaskDiscription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 490)]];
    }
    
    else if ([Efforttxtfld.text length]==0)
    {
        [Descriptionxtfld setBackgroundColor:[UIColor whiteColor]];
        [Efforttxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter  Effort" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 560)]];
    }
    
    else if([StartDatetxtfld.text length]==0)
    {
        [Efforttxtfld setBackgroundColor:[UIColor whiteColor]];
        [StartDatetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select StartDate" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 640)]];
    }
    
    else if([Resourcetxtfld.text length]==0)
    {
        [StartDatetxtfld setBackgroundColor:[UIColor whiteColor]];
        [Resourcetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select ResourceList" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 750)]];
    }
    else if ([hoursPerDaytxtfld.text length]==0)
    {
        [Efforttxtfld setBackgroundColor:[UIColor whiteColor]];
        [hoursPerDaytxtfld setBackgroundColor:[UIColor redColor]];
    [self.view makeToast:@"Please enter hours perday text field" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 750)]];
    }
    else
    {
        if(_locationUseBool== NO&&[Savebtn.titleLabel.text isEqualToString:@"Save"])
        {
            taskId= @"0";
            saveUpdateType = @"SaveTask";
            hardDependencyText=hardDependencytxtfld.text;
        }
        else
        {
            taskId = UpDTaskId;
            saveUpdateType = @"UpdateTask";
            hardDependencyText=hardDependencytxtfld.text;
        }
        NSLog(@"start date text field text is %@",StartDatetxtfld.text);
        NSLog(@"End Date text field text is %@",Enddatetxtfld.text);
        NSLog(@"resource id id %@",_ResourceIdstr);
        NSString *TaskSaveUrl = @"SaveAndUpdateTaskService";
        NSDictionary *credentials = @{@"orgId":orgIdstr,@"taskcat":_CategoryIdstr,
@"tskPriority":_PriorityIdstr,@"taskDescription":Descriptionxtfld.text,@"taskEffort":Efforttxtfld.text,@"plStartDate":StartDatetxtfld.text,@"plEndDate":Enddatetxtfld.text,@"tskAssinTo":_ResourceIdstr,@"tskAssinBy":Useridstr,@"projectId":_ProjectIdstr,@"taskId":taskId,@"saveUpdateType":saveUpdateType,@"hardDependcyId":hardDependencyText,@"hourPerDay":hoursPerDaytxtfld.text};
        [Servicecall SaveNewTaskurl:TaskSaveUrl NewTaskSaveParameters:credentials];
        [Servicecall setDelegate:self];
   }
}



-(void)CreatTaskV
{
    Descriptionxtfld.text = @"";
    Efforttxtfld.text     = @"";
    StartDatetxtfld.text  = @"";
    Enddatetxtfld.text    =@"";
    Projecttxtfld.text = @"";
    Categorytxtfld.text=@"";
    Prioritytxtfld.text =@"";
    Resourcetxtfld.text=@"";
    hardDependencytxtfld.text=@"";
    _locationUseBool=NO;
    hoursPerDaytxtfld.text=@"";
    self.navigationItem.title = @"Create New    Task";
    //selectedRows=nil;
    [Savebtn setTitle:@"Save" forState:UIControlStateNormal];
    [_datePickerBtn setEnabled:YES];
    [self HardDependency];
    //[self holidaysList];
    [hardDependencyTableView reloadData];
}


-(void)HardDependency
{
    if (_locationUseBool == NO)
    {
        
        taskId = @"0";
        saveUpdateType = @"SaveTask";
        
        //_locationUseBool = YES;
    }
    else
    {
        saveUpdateType = @"UpdateTask";
        taskId = UpDTaskId;
        NSLog(@"strings is %@ %@ ",saveUpdateType,taskId);
        
    }
    
    Servicecall=[[Webservices alloc]init];
    
    NSString *HardDependencyClass=@"TaskHardDependency";
    
    NSDictionary *HardDependencyParameters=@{@"projId":_ProjectIdstr,@"taskId":taskId};
    
    [Servicecall HardDependency:HardDependencyClass HardDependencyParameters:HardDependencyParameters];
    [Servicecall setDelegate:self];
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
-(void)didfinishactionitemlist:(id)actionitemlist
{
    holidaysListXmlParser=[[NSXMLParser alloc]initWithData:actionitemlist];
    holidaysListXmlParser.delegate=self;
    [holidaysListXmlParser parse];
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==ProjectxmlParser)
    {
        if([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            ProjectListArray       =[NSMutableArray new];
            PROJECT_NAMEArray      =[NSMutableArray new];
            PROJECT_IDArray        =[NSMutableArray new];
            ProjectlistSplitArray  =[NSArray new];
        }
    }
    if (parser==CategoryxmlParse)
    {
        if([elementName isEqualToString:@"taskCategoryListResponse"])
        {
            CategoryListArray         =[NSMutableArray new];
            Category_IDArray          =[NSMutableArray new];
            Category_NAMEArray        =[NSMutableArray new];
            CategoryListSplitArray    =[NSArray new];
        }
    }
    if (parser==PriorityxmlParser)
    {
        if([elementName isEqualToString:@"taskPriorityListResponse"])
        {
            PriorityListArray         =[NSMutableArray new];
            Priority_IDArray          =[NSMutableArray new];
            Priority_NAMEArray        =[NSMutableArray new];
            PriorityListSplitArray    =[NSArray new];
        }
    }
    if (parser==ResourcexmlParser)
    {
        if([elementName isEqualToString:@"resListFrProjectResponse"])
        {
            ResourceListArray         =[NSMutableArray new];
            Resource_NAMEArray        =[NSMutableArray new];
            Resource_IDArray          =[NSMutableArray new];
            ResourceListSplitArray    =[NSArray new];
        }
        
    }
    
    if (parser==HardDependencyXmlParser)
    {
        if ([elementName isEqualToString:@"hardDependencyListResponse"])
        {
            HardDependencylistArray=[NSMutableArray new];
            HardDependency_IDArray=[NSMutableArray new];
            HardDependencyDisplayNameArray=[NSMutableArray new];
            startDateArray=[NSMutableArray new];
            endDateArray=[NSMutableArray new];
            HardDependencySplirtArray=[NSArray new];
            hardDependencyAlldataArray=[NSMutableArray new];
            
            taskIdStr=[NSString new];
            taskNameStr=[NSString new];
            taskStartDateStr=[NSString new];
            taskEndDateStr=[NSString new];
            
            //hardDependencyAllDataArray=[NSMutableArray new];
        }
    }
    if (parser==holidaysListXmlParser)
    {
        if ([elementName isEqualToString:@"taskPlannedEnDateResponse"])
        {
            endDateArray=[NSMutableArray new];
            enddatestrSplitArray2=[NSMutableArray new];
            enddateStrDisplayArray=[NSMutableArray new];
            endDateStr=[NSMutableString new];
        }
    }
    if (parser==HolidaysXmlPArser)
    {
        if ([elementName isEqualToString:@"holidaysListResponse"])
        {
            holidaysListServiceArray=[NSMutableArray new];
            holidaysListServiceSplitArray=[NSMutableArray new];
            holidaysListServiceIdArray=[NSMutableArray new];
            holidaysListServiceDateArray=[NSMutableArray new];
            holidayLsitServiceReasonArray=[NSMutableArray new];
            holidayCheckedArray=[NSMutableArray new];
            dateStr=[NSMutableString new];
            
        }
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser==ProjectxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
            
        }
        else{
            
            [ProjectListArray addObject:string];
            
        }
    }
    
     if (parser == CategoryxmlParse)
        
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
            
        }
        else
        {
            [CategoryListArray addObject:string];
        }
        
    }
    if (parser == PriorityxmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
            
        }
        else
        {
             [PriorityListArray addObject:string];
        }

        
      
        //NSLog(@"Confroom List %@",PriorityListArray);
    }
    
     if(parser==ResourcexmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TaskList1223333" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
//            Enddatetxtfld.text=@"";
            //Resourcetxtfld.text=@"null";
            
        }
        else{
            
            [ResourceListArray addObject:string];
            
        }
    }
    
   else if (parser==HardDependencyXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil  message:@"Harddependency list is empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else
        {
            [HardDependencylistArray addObject:string];
        }
    }
    
    
    
   else if (parser == SaveNewTaskxmlParser)
    {
        if ([string isEqualToString:@"Flase"]||[string isEqualToString:@"Problem"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Task" message:@"Task Not Inserted/Updated" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil,nil];
            
            [alert show];
        }
        else if ([string isEqualToString:@"TaskUpdated"])
        {
            NSLog(@"task updated successfully");
            [Savebtn setTitle:@"Update" forState:UIControlStateNormal];
            taskId=UpDTaskId;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.text = @"Task Updated Successfully";
            //hud.tintColor=[UIColor blueColor];
            hud.detailsLabel.font=[UIFont fontWithName:@"Bold" size:22];
            hud.removeFromSuperViewOnHide = YES;
            hud.detailsLabel.textColor=[UIColor blueColor];
            hud.margin = 12.f;
            [hud hideAnimated:YES afterDelay:2];
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.text = @"Task Saved Successfully";
            //hud.tintColor=[UIColor blueColor];
            hud.detailsLabel.font=[UIFont fontWithName:@"Bold" size:20];
            hud.removeFromSuperViewOnHide = YES;
            hud.detailsLabel.textColor=[UIColor blueColor];
            hud.margin = 12.f;
            [hud hideAnimated:YES afterDelay:2];
            [Savebtn setTitle:@"Update" forState:UIControlStateNormal];
            UpDTaskId=string;
            NSLog(@"saved data %@",UpDTaskId);
        }
    }
    else if (parser==holidaysListXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TaskListasdfdf" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else
        {
            [endDateArray addObject:string];
        }

    }
   else if (parser==HolidaysXmlPArser)
   {
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                                                           message:@"This is an alert."
//                                                                    preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {}];
//            
//            [alert addAction:defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [holidaysListServiceArray addObject:string];
            //NSLog(@"holidays list array is %@",holidaysListServiceArray);
        }
    }
    
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == ProjectxmlParser)
    {
        if([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            for (int i = 0; i<[ProjectListArray count]; i++)
            {
                ProjectlistSplitArray=[[ProjectListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [PROJECT_IDArray addObject:[[ProjectlistSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"PROJECT_ID==" withString:@""]];
                [PROJECT_NAMEArray addObject:[[ProjectlistSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"PROJECT_NAME==" withString:@""]];
                
                NSLog(@"the project name array values are %@",PROJECT_NAMEArray);
                
            }
            
            if ([_Projectnamestr length]==0 || [_Projectnamestr isEqualToString:@"null"])
            {
                
                [ProjectListpicker removeFromSuperview];
                Projecttxtfld.text = [PROJECT_NAMEArray objectAtIndex:0];
                _ProjectIdstr= [PROJECT_IDArray objectAtIndex:0];
                [self HardDependency];
                [self ResourceList];
            }
          
                for(int i=0; i<[PROJECT_IDArray count]; i++)
                {
                    if([Projecttxtfld.text isEqualToString:[PROJECT_NAMEArray objectAtIndex:i]])
                    {
                        
                        Projecttxtfld.text = [PROJECT_NAMEArray objectAtIndex:i];
                        _ProjectIdstr = [PROJECT_IDArray objectAtIndex:i];
                        [self HardDependency];
                        [self ResourceList];
                        
                        
                    }
                
                
                
            }
            
            
            
            
            [ProjectListpicker reloadAllComponents];
            
        }
        
    }
    
    if (parser == CategoryxmlParse)
    {
        if([elementName isEqualToString:@"taskCategoryListResponse"])
        {
            for (int i = 0; i<[CategoryListArray count]; i++)
            {
                CategoryListSplitArray=[[CategoryListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [Category_IDArray addObject:[[CategoryListSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"CATEGORY_ID==" withString:@""]];
                [Category_NAMEArray addObject:[[CategoryListSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"CATEGORY_NAME==" withString:@""]];
                
                
            }
            
            if ([Category_NAMEArray count]==0)
            {
                
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"empty category array values" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//                
//                [alert show];
                
            }
            
            
            else if ([Categorytxtfld.text length] == 0)
            {
                
                Categorytxtfld.text=[Category_NAMEArray objectAtIndex:0];
                _CategoryIdstr=[Category_IDArray objectAtIndex:0];
                
                
                
            }
            
            else
            {
                
                
                for(int i=0; i<[Category_NAMEArray count]; i++)
                {
                    if([_categorynamestr isEqualToString:[Category_NAMEArray objectAtIndex:i]])
                    {
                        
                        Categorytxtfld.text = [Category_NAMEArray objectAtIndex:i];
                        _CategoryIdstr = [Category_IDArray objectAtIndex:i];
                        
                    }
                }
                
                
            }
            
            
            
            [ProjectListpicker reloadAllComponents];
        }
    }
    
    else if (parser == PriorityxmlParser)
    {
        if([elementName isEqualToString:@"taskPriorityListResponse"])
        {
            for (int i = 0; i<[PriorityListArray count]; i++)
            {
                PriorityListSplitArray=[[PriorityListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [Priority_IDArray addObject:[[PriorityListSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"PRIORITY_ID==" withString:@""]];
                [Priority_NAMEArray addObject:[[PriorityListSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"PRIORITY_NAME==" withString:@""]];
                
                
            }
            if ([PriorityListArray count]==0)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"empty priority array values" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
            
            else if ([Prioritytxtfld.text length] == 0)
            {
                
                Prioritytxtfld.text = [Priority_NAMEArray objectAtIndex:0];
                _PriorityIdstr= [Priority_IDArray objectAtIndex:0];
                
                
                
            }
            else
            {
                
                
                for(int i=0; i<[Priority_NAMEArray count]; i++)
                {
                    if([_Prioritynamestr isEqualToString:[Priority_NAMEArray objectAtIndex:i]])
                    {
                        
                        Prioritytxtfld.text = [Priority_NAMEArray objectAtIndex:i];
                        _PriorityIdstr = [Priority_IDArray objectAtIndex:i];
                        
                    }
                }
                
                
            }
            
            
            [ProjectListpicker reloadAllComponents];
        }
    }
    else if (parser == ResourcexmlParser)
    {
        if([elementName isEqualToString:@"resListFrProjectResponse"])
        {
            for (int i = 0; i<[ResourceListArray count]; i++)
            {
                ResourceListSplitArray=[[ResourceListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [Resource_IDArray addObject:[[ResourceListSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"RESOURCE_ID==" withString:@""]];
                [Resource_NAMEArray addObject:[[ResourceListSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"RESOURCE_NAME==" withString:@""]];
                NSLog(@"res name %@",Resource_NAMEArray);
                
            }
//            if ([ResourceListArray count]==0)
//            {
//                Resourcetxtfld.text=@"null";
//            }
//            
//            if ([_Resourcenamestr length]==0 ||[_Projectnamestr isEqualToString:@"null"])
//            {
//                Resourcetxtfld.text = [Resource_NAMEArray objectAtIndex:0];
//                _ResourceIdstr = [Resource_IDArray objectAtIndex:0];
//            }
//            
            
            for(int i=0; i<[Resource_IDArray count]; i++)
            {
                if([_Resourcenamestr isEqualToString:[Resource_NAMEArray objectAtIndex:i]])
                {
                    
                    Resourcetxtfld.text = [Resource_NAMEArray objectAtIndex:i];
                    _ResourceIdstr = [Resource_IDArray objectAtIndex:i];
                    
                }
            }
            
            
            [ProjectListpicker reloadAllComponents];
        }
        //        else
        //        {
        //            [Resourcetxtfld setHidden:YES];
        //
        //        }
        
    }
    if(parser==HardDependencyXmlParser)
    {
        if([elementName isEqualToString:@"hardDependencyListResponse"])
        {
            for (int i = 0; i<[HardDependencylistArray count]; i++)
            {
                HardDependencySplirtArray=[[HardDependencylistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                taskIdStr=[[HardDependencySplirtArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"taskId==" withString:@""];
                
                taskNameStr=[[HardDependencySplirtArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"taskName==" withString:@""];
                
                taskStartDateStr=[[HardDependencySplirtArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"taskStartDate==" withString:@""];
                
                taskEndDateStr=[[HardDependencySplirtArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"taskEndDate==" withString:@" "];
                
                //                [HardDependency_IDArray addObject:[[HardDependencySplirtArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"taskId==" withString:@" "]];
                
                [HardDependency_IDArray addObject:taskIdStr];
                [HardDependencyDisplayNameArray addObject:taskNameStr];
                [startDateArray addObject:taskStartDateStr];
                [endDateArray addObject:taskEndDateStr];
                
                NSMutableString *addString=[[[[taskNameStr stringByAppendingString:@","]stringByAppendingString:taskStartDateStr]stringByAppendingString:@","]stringByAppendingString:taskEndDateStr];
                
                hardDependencyAllDataString=addString;
                
                NSLog(@"all string data is %@",hardDependencyAllDataString);
                
                
                NSLog(@"task id array %@",HardDependency_IDArray);
                NSLog(@"task name array %@",HardDependencyDisplayNameArray);
                NSLog(@"task start date array %@",startDateArray);
                NSLog(@"end date array %@",endDateArray);
                
                [hardDependencyAlldataArray addObject:hardDependencyAllDataString];
                
                
                cellSelectedArray=[[NSMutableArray alloc]init];
                for (int i=0; i<hardDependencyAlldataArray.count; i++)
                {
                    [cellSelectedArray addObject:[NSNumber numberWithBool:NO]];
                }
//
                // NSLog(@"all hard dependency array value %@",hardDependencyAllDataArray);
                
                
                
            }
            //            if ([_hardDependencystr length]==0 || [_hardDependencystr isEqualToString:@"null"])
            //            {
            //
            //                [ProjectListpicker removeFromSuperview];
            //                hardDependencytxtfld.text = [hardDependencyAlldataArray objectAtIndex:0];
            //                //_ProjectIdstr= [PROJECT_IDArray objectAtIndex:0];
            //                //[self HardDependency];
            //                //[self ResourceList];
            //            }
            //            else
            //            {
            //                for(int i=0; i<[hardDependencyAlldataArray count]; i++)
            //                {
            //                    if([_hardDependencystr isEqualToString:[hardDependencyAlldataArray objectAtIndex:i]])
            //                    {
            //
            //                        hardDependencytxtfld.text = [hardDependencyAlldataArray objectAtIndex:i];
            ////                        _ProjectIdstr = [PROJECT_IDArray objectAtIndex:i];
            ////                        [self HardDependency];
            ////                        [self ResourceList];
            //
            //
            //                    }
            //                }
            //
            //
            //            }
            
                     [ProjectListpicker reloadAllComponents];
        }
        //        else
        //        {
        //            [Resourcetxtfld setHidden:YES];
        //
        //        }
        
    }
    if (parser==holidaysListXmlParser)
    {
        if ([elementName isEqualToString:@"taskPlannedEnDateResponse"])
        {
            for (int i=0; i<[endDateArray count]; i++)
            {
                enddatestrSplitArray2=[[endDateArray objectAtIndex:i]componentsSeparatedByString:@"###"];
                endDateStr=[[enddatestrSplitArray2 objectAtIndex:2]stringByReplacingOccurrencesOfString:@"plannedEnDate==" withString:@""];
                
            }
            NSLog(@"enddate str is %@",endDateStr);
            Enddatetxtfld.text=endDateStr;
        }
    }
    if (parser==HolidaysXmlPArser)
    {
        if ([elementName isEqualToString:@"holidaysListResponse"])
        {
            for (int i=0; i<[holidaysListServiceArray count];i++)
            {
                holidaysListServiceSplitArray=[[holidaysListServiceArray objectAtIndex:i]componentsSeparatedByString:@"###"];
                [holidaysListServiceIdArray addObject:[[holidaysListServiceSplitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"holidayId==" withString:@""]];
                dateStr=[[holidaysListServiceSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"holidayDate==" withString:@""];
                [holidayLsitServiceReasonArray addObject:[[holidaysListServiceSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"reasonForHoliday==" withString:@""]];
                [holidaysListServiceDateArray addObject:dateStr];
            }
        }
        
        NSLog(@"holidays id array is %@",holidaysListServiceIdArray);
         NSLog(@"holidays date array is %@",holidaysListServiceDateArray);
         NSLog(@"holidays reason  array is %@",holidayLsitServiceReasonArray);
    }
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [hardDependencyTableView reloadData];
    [super viewWillAppear:animated];
    
}
//- (void) viewWillDisappear:(BOOL)animated
//{
//    [hardDependencyTableView deselectRowAtIndexPath:[hardDependencyTableView indexPathForSelectedRow] animated:animated];
//    [super viewWillDisappear:animated];
//}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==1)
    {
        return [PROJECT_NAMEArray count];
    }
    else if (picker.tag==2)
    {
        return [Category_NAMEArray count];
    }
    else if (picker.tag==3)
    {
        return [Priority_NAMEArray count];
        
    }
    //if (picker.tag==4)
    else if (picker.tag==4)
    {
        return [Resource_NAMEArray count];
    }
    else
    {
        return [hardDependencyAlldataArray count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==1)
    {
        return [PROJECT_NAMEArray objectAtIndex:row];
    }
    else if (picker.tag==2)
    {
        return [Category_NAMEArray objectAtIndex:row];
    }
    else if (picker.tag==3) {
        return [Priority_NAMEArray objectAtIndex:row];
        
    }
    //if (picker.tag==4)
    else if(picker.tag==4)
    {
        //NSLog(@"rsess %@ %@",_ResourceIdstr,Resourcetxtfld.text);
        return [Resource_NAMEArray objectAtIndex:row];
    }
    else
    {
        return [hardDependencyAlldataArray objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==1)
    {
        Projecttxtfld.text=[PROJECT_NAMEArray objectAtIndex:row];
        _ProjectIdstr = [PROJECT_IDArray objectAtIndex:row];
        NSLog(@"project id %@",_ProjectIdstr);
        [self HardDependency];
        [self ResourceList];
        [ProjectListpicker removeFromSuperview];
    }
    else if (pickerView.tag==2)
    {
        Categorytxtfld.text=[Category_NAMEArray objectAtIndex:row];
        _CategoryIdstr = [Category_IDArray objectAtIndex:row];
        [ProjectListpicker removeFromSuperview];
    }
    
    else if (pickerView.tag==3)
    {
        Prioritytxtfld.text=[Priority_NAMEArray objectAtIndex:row];
        _PriorityIdstr  = [Priority_IDArray objectAtIndex:row];
        [ProjectListpicker removeFromSuperview];
        
    }
    
    
    else if(pickerView.tag==4)
    {
        
        Resourcetxtfld.text=[Resource_NAMEArray objectAtIndex:row];
        _ResourceIdstr  = [Resource_IDArray objectAtIndex:row];
        NSLog(@"rsess %@ %@",_ResourceIdstr,Resourcetxtfld.text);
        [ProjectListpicker removeFromSuperview];
        
        
    }
    else
    {
        
        hardDependencytxtfld.text=[HardDependency_IDArray objectAtIndex:row];
        [ProjectListpicker removeFromSuperview];
    }
    
    
    
}


-(void)ResourceList
{
    
    NSString *TaskListUrl = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"projectId":_ProjectIdstr};
    [Servicecall TaskResourceurl:TaskListUrl ResourceParameters:credentials];
    [Servicecall setDelegate:self];
    
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField==hoursPerDaytxtfld)
//    {
//        [hoursPerDaytxtfld resignFirstResponder];
//    
//    }
//    
//    if (textField==Efforttxtfld)
//    {
//        [Efforttxtfld resignFirstResponder];
//       
//    }
//    
//    return YES;
//}

//
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    if (textField == Descriptionxtfld )
//    {
//        return YES;
//    }
//
//    if (textField==hoursPerDaytxtfld)
//    {
//        if ([hoursPerDaytxtfld.text length]==0)
//        {
//            [self.view makeToast:@"Please enter HoursPerday Value" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 500)]];
//        }
////        else
////        {
////            l=[hoursPerDaytxtfld.text floatValue];
////            if (l<25 )
////            {
////                if (l==0)
////                {
////                    m=8;
////                }
////                else
////                {
////                    m=l;
////                }
////                //[self doneButton];
////                NSLog(@"done button clicked");
////                
////            }
////            else
////            {
////                UIAlertView *alertt=[[UIAlertView alloc]initWithTitle:@"Please Enter value with in 24" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
////                [alertt show];
////                hoursPerDaytxtfld.text=nil;
////            }
////            
////
////        }
////        return YES;
////        //[self holidaysListChecking];
////    }
////    if (textField == Efforttxtfld )
////    {
////        
////        
////        if ([Efforttxtfld.text length]==0 && Efforttxtfld.text!=0)
////        {
////            [self.view makeToast:@"Please enter Effort Value Grater than 0" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 500)]];
////            
////            Enddatetxtfld.text=@"";
////        }
////        else
////        {
////            
////            // [_datePickerBtn setEnabled:YES];
////            //[self holidaysListChecking];
////            //[self doneButton];
////        }
////        return YES;
////        
////    }
////
////    if (textField==hardDependencytxtfld)
////    {
////                return YES;
////        //[self submitBtnClicked];
////    }
////    return NO;
////    
////}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField==hoursPerDaytxtfld)
//    {
//        l=[hoursPerDaytxtfld.text floatValue];
//        if (l<25)
//        {
//            if (l==0)
//            {
//                m=8;
//            }
//            else
//            {
//                m=l;
//            }
//            //[self doneButton];
//            NSLog(@"done button clicked");
//            
//        }
//        else
//        {
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.detailsLabel.text = @"Please enter hours per day with in 24";
//            //hud.tintColor=[UIColor blueColor];
//            hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:22];
//            hud.removeFromSuperViewOnHide = YES;
//            hud.detailsLabel.textColor=[UIColor blackColor];
//            hud.margin = 12.f;
//            [hud hideAnimated:YES afterDelay:2];
//            hoursPerDaytxtfld.text=@"";
//
//        }
//        
//    }
//    if (textField==Efforttxtfld)
//    {
//        if ([Efforttxtfld.text length]==0 && Efforttxtfld.text==0)
//        {
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.detailsLabel.text = @"Please enter effort grater than 0";
//            //hud.tintColor=[UIColor blueColor];
//            hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:22];
//            hud.removeFromSuperViewOnHide = YES;
//            hud.detailsLabel.textColor=[UIColor blackColor];
//            hud.margin = 12.f;
//            [hud hideAnimated:YES afterDelay:2];
//            //hoursPerDaytxtfld.text=@"";
//            [_datePickerBtn setEnabled:NO];
//        }
//        else
//        {
//            
//            [_datePickerBtn setEnabled:YES];
//           
//        }
//
//    }
//    if (textField==hardDependencytxtfld)
//    {
//        if (!([hardDependencytxtfld.text length]==0))
//        {
//            Enddatetxtfld.text=@"";
//            [self submitBtnClicked];
//            Enddatetxtfld.text=enddate;
//            
//            NSLog(@"text field holiday list called");
//        }
//        
//        else
//        {
//            [self.view makeToast:@"please enter effort value" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 500)]];
//        }
//        
//    }
//
//}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==hoursPerDaytxtfld)
    {
        
    }
    if (textField==Efforttxtfld)
    {
        
    }

    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==Projecttxtfld)
    {
         [Projecttxtfld resignFirstResponder];
    }
    if (textField==Categorytxtfld)
    {
        [Categorytxtfld resignFirstResponder];
    }

    if (textField==Prioritytxtfld)
    {
        [Prioritytxtfld resignFirstResponder];
    }

   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == Efforttxtfld)
    {
        NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered ;
        filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return [string isEqualToString:filtered];
        
    }

    if (textField == hoursPerDaytxtfld)
    {
        NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered ;
        filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
      
       
//        NSString *currentString = [hoursPerDaytxtfld.text stringByReplacingCharactersInRange:range withString:string];
//        int length = [currentString length];
//        NSLog(@"current string value is %d",length);
      
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return [string isEqualToString:filtered];
        
    }

    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField
{
    l=[hoursPerDaytxtfld.text floatValue];
    if (theTextField==hoursPerDaytxtfld)
    {
     if (l<25)
     {
         [self doneButton];
     }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = @"Please enter hours per day with in 24";
        //hud.tintColor=[UIColor blueColor];
        hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:22];
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.textColor=[UIColor blackColor];
        hud.margin = 12.f;
        [hud hideAnimated:YES afterDelay:2];
        hoursPerDaytxtfld.text=@"";
    }
}
    if (theTextField==Efforttxtfld)
    {

    if (![Efforttxtfld.text isEqualToString:@"0"] &&(!([Efforttxtfld.text length]==0)))
    {
        [self doneButton];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = @"Please enter effort value grater than 0";
        //hud.tintColor=[UIColor blueColor];
        hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:20];
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.textColor=[UIColor blackColor];
        hud.margin = 12.f;
        [hud hideAnimated:YES afterDelay:2];
        //Efforttxtfld.text=@"";
    }
}
    if (theTextField==StartDatetxtfld)
    {

    if (!([StartDatetxtfld.text length]==0))
    {
        [self doneButton];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = @"Please enter effort value grater than 0";
        //hud.tintColor=[UIColor blueColor];
        hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:15];
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.textColor=[UIColor blackColor];
        hud.margin = 12.f;
        [hud hideAnimated:YES afterDelay:2];
        
    }
    }
    

    
}

-(void)didFinishService:(id)Userlogindetails
{
    ResourcexmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    ResourcexmlParser.delegate = self;
    [ResourcexmlParser parse];
    
    HolidaysXmlPArser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    HolidaysXmlPArser.delegate=self;
    [HolidaysXmlPArser parse];
    
    
}

-(void)didFinishData:(id)Data
{
    PriorityxmlParser = [[NSXMLParser alloc]initWithData:Data];
    PriorityxmlParser.delegate = self;
    [PriorityxmlParser parse];
}
-(void)didEndTask:(id)Taskend
{
    CategoryxmlParse = [[NSXMLParser alloc]initWithData:Taskend];
    CategoryxmlParse.delegate = self;
    [CategoryxmlParse parse];
    
}
-(void)Serviceactiondone:(id)result
{
    ProjectxmlParser = [[NSXMLParser alloc]initWithData:result];
    ProjectxmlParser.delegate = self;
    [ProjectxmlParser parse];
}
-(void)serviceCal:(id)ServerData
{
    SaveNewTaskxmlParser = [[NSXMLParser alloc]initWithData:ServerData];
    SaveNewTaskxmlParser.delegate = self;
    [SaveNewTaskxmlParser parse];
    
}
-(void)ServiceCalls1:(id)ServiceCal1
{
    HardDependencyXmlParser=[[NSXMLParser alloc]initWithData:ServiceCal1];
    HardDependencyXmlParser.delegate=self;
    [HardDependencyXmlParser parse];
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}
-(IBAction)homebtntapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)userTapped
{
    //[hardDependencyTableView removeFromSuperview];
    [DatePicker removeFromSuperview];
    
}
@end
