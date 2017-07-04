//
//  TaskListViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/27/14 11.54Am.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "TaskListViewController.h"
#import "MBProgressHUD.h"

@interface TaskListViewController ()
{
    NSXMLParser *TaskListXmlParser;
    //userDetails
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr,*taskidstr,*startDateStr1,*endDateStr2;
    
    //TaskList
    NSMutableArray *TasklistArray,*TaskIdArray,*DescriptionArray,*StartDateArray,*EndDateArray,*TaskEffortArray,*PriortyArray,*sercharray,*refarray,*A,*B,*C,*TaskAssgndByIdArray,*CatogeryArray,*ProjectNamearray,*ResourceNameArray,*hardDependencyArray,*hoursPerDayArray,*taskAssignedArray,*taskCreatedByArray,*taskCreatedByIdArray,*tempArray1,*tempArray2,*tempArray3,*tempArray4,*tempArray5,*tempArray6,*tempArray7,*tempArray8,*D,*E,*tempArray9,*tempArray10,*tempArray11,*tempArray12,*tempArray13,*tempArray14,*tempArray15,*tempArray16,*tempArray17,*tempArray18,*tempArray19,*tempArray20,*tempArray21,*tempArray22,*tempArray23,*tempArray24,*categorySearchArray1,*categorySearchArray2,*projectNameArray1,*projectNameArray2,*hardDependencyArray1,*hardDependencyArray2,*hoursPerDay1,*hoursPerDay2,*F,*dessearchArray,*startDateSearchArray,*enddateSearchArray,*effortSearchArray,*assignedSEarchArray,*createdBySearchArray,*TaskIdSearchArray,*projectNameSearchArray,*harddependencySearchArray,*hoursPerDaySearchArray,*categorySearchArray,*prioritySearchArray,*AssignedToSearchArray,*CreatedBySearchArray,*taskCreatedByIdSearchArray,*taskAssignedByIdSearchArray,*taskIdSearchArray,*taskHoursperdaySearchArray,*taskProjectNameSearchArray,*taskHarddependencySearchArray,*taskCategorySearchArray,*tempStatusArray,*taskStatusSearchArray,*taskCreatedByArraySearch;
    
    NSMutableArray *temptaskupdateIDArray,*temptaskcategoryArray,*tempProjectNameArray,*tempharddependencyArray,*temphoursperDayArray;
    NSMutableArray *expireTaskPriorityArray,*expireTaskDescriptionArray,*expireAssignedArray,*expireCreatedBySearchArray,*expireTaskIdArray,*expireProjectNameArray,*expireHarddependencyArray,*expireHoursPerDayArray,*expireCategoryArray,*expireAssogmedByIdArray,*expireStartDateArray,*expireEndDateArray,*expireTaskEffortArray,*expireResourceArray,*expireStatusArray;
    
    
    NSMutableArray *expireTaskPriorityArraySearch,*expireTaskDescriptionArraySearch,*expireAssignedArraySearch,*expireCreatedBySearchArray1,*expireTaskIdArraySearch,*expireProjectNameArraySearch,*expireHarddependencyArraySearch,*expireHoursPerDayArraySearch,*expireCategoryArraySearch,*expireAssogmedByIdArraySearch,*expireStartDateArraySearch,*expireEndDateArraySearch,*expireTaskEffortArraySearch,*expireResourceArraySearch,*expireStatusArraySearch;
    
     NSMutableArray *expireTaskPriorityArraySearch1,*expireTaskDescriptionArraySearch1,*expireAssignedArraySearch1,*expireCreatedBySearchArray2,*expireTaskIdArraySearch1,*expireProjectNameArraySearch1,*expireHarddependencyArraySearch1,*expireHoursPerDayArraySearch1,*expireCategoryArraySearch1,*expireAssogmedByIdArraySearch1,*expireStartDateArraySearch1,*expireEndDateArraySearch1,*expireTaskEffortArraySearch1,*expireResourceArraySearch1,*expireStatusArraySearch1;

    NSMutableArray *expireTaskPriorityArraySearch2,*expireTaskDescriptionArraySearch2,*expireAssignedArraySearch2,*expireCreatedBySearchArray3,*expireTaskIdArraySearch2,*expireProjectNameArraySearch2,*expireHarddependencyArraySearch2,*expireHoursPerDayArraySearch2,*expireCategoryArraySearch2,*expireAssogmedByIdArraySearch2,*expireStartDateArraySearch2,*expireEndDateArraySearch2,*expireTaskEffortArraySearch2,*expireResourceArraySearch2,*expireStatusArraySearch2;

    
    NSArray *TaskSplitArray,*serchfieldArray,*searchFieldArray1,*searcharray1,*refarray1,*searcharray2,*refarray2,*refarray3,*searchArray3,*refarray4;
    
    NSMutableString *createdByString,*AssignedByIdStr;
    
}
@end

@implementation TaskListViewController

- (void)viewDidLoad
{
    
    self.navigationItem.title = @"Task List";
    Servicecall =[[Webservices alloc]init];
    //serchfieldArray = [NSArray arrayWithObjects:@"High",@"Medium",@"Low",@"GenMajor",@"All",nil];
    tempArray=[[NSMutableArray alloc]init];
    searchFieldArray1=[NSArray arrayWithObjects:@"All",@"Assigned To",@"Created By",@"Other",nil];
    tempArray2=[[NSMutableArray alloc]init];
    tempArray1=[[NSMutableArray alloc]init];
    tempArray3=[[NSMutableArray alloc]init];
     tempArray4=[[NSMutableArray alloc]init];
     tempArray5=[[NSMutableArray alloc]init];
     tempArray6=[[NSMutableArray alloc]init];
     tempArray7=[[NSMutableArray alloc]init];
     tempArray8=[[NSMutableArray alloc]init];
    tempArray9=[[NSMutableArray alloc]init];
    tempArray10=[[NSMutableArray alloc]init];
    tempArray11=[[NSMutableArray alloc]init];
    tempArray12=[[NSMutableArray alloc]init];
    tempArray13=[[NSMutableArray alloc]init];
    tempArray14=[[NSMutableArray alloc]init];
    tempArray15=[[NSMutableArray alloc]init];
    tempArray16=[[NSMutableArray alloc]init];
    tempArray17=[[NSMutableArray alloc]init];
    tempArray18=[[NSMutableArray alloc]init];
    tempArray19=[[NSMutableArray alloc]init];
    tempArray20=[[NSMutableArray alloc]init];
    tempArray21=[[NSMutableArray alloc]init];
    tempArray22=[[NSMutableArray alloc]init];
    tempArray23=[[NSMutableArray alloc]init];
    tempArray24=[[NSMutableArray alloc]init];
    tempStatusArray=[[NSMutableArray alloc]init];
    categorySearchArray1=[[NSMutableArray alloc]init];
    categorySearchArray2=[[NSMutableArray alloc]init];
    projectNameArray1=[[NSMutableArray alloc]init];
    projectNameArray2=[[NSMutableArray alloc]init];
    hardDependencyArray1=[[NSMutableArray alloc]init];
    hardDependencyArray2=[[NSMutableArray alloc]init];
    hoursPerDay1=[[NSMutableArray alloc]init];
    hoursPerDay2=[[NSMutableArray alloc]init];
   equalTempArray=[[NSMutableArray alloc]init];
    equalTempArray1=[[NSMutableArray alloc]init];
    dessearchArray=[[NSMutableArray alloc]init];
    projectNameSearchArray=[[NSMutableArray alloc]init];
    startDateSearchArray=[[NSMutableArray alloc]init];
    enddateSearchArray=[[NSMutableArray alloc]init];
    TaskIdSearchArray=[[NSMutableArray alloc]init];
    effortSearchArray=[[NSMutableArray alloc]init];
    harddependencySearchArray=[[NSMutableArray alloc]init];
    hoursPerDaySearchArray=[[NSMutableArray alloc]init];
    prioritySearchArray=[[NSMutableArray alloc]init];
    AssignedToSearchArray=[[NSMutableArray alloc]init];
    createdBySearchArray=[[NSMutableArray alloc]init];
    taskCreatedByIdSearchArray=[[NSMutableArray alloc]init];
    taskAssignedByIdSearchArray=[[NSMutableArray alloc]init];
    taskIdSearchArray=[[NSMutableArray alloc]init];
    taskHoursperdaySearchArray=[[NSMutableArray alloc]init];
    taskHarddependencySearchArray=[[NSMutableArray alloc]init];
    taskCategorySearchArray=[[NSMutableArray alloc]init];
    taskProjectNameSearchArray=[[NSMutableArray alloc]init];
    taskStatusSearchArray=[[NSMutableArray alloc]init];
    taskCreatedByArraySearch=[[NSMutableArray alloc]init];
    
    dessearchArray1=[[NSMutableArray alloc]init];
    startdatesearchArray1=[[NSMutableArray alloc]init];
    enddatesearchArray1=[[NSMutableArray alloc]init];
    effortsearchArray1=[[NSMutableArray alloc]init];
    assignedsearchArray1=[[NSMutableArray alloc]init];
    createdbysearchArray1=[[NSMutableArray alloc]init];
    prioritysearchArray1=[[NSMutableArray alloc]init];
    taskCategorySearchArray1=[[NSMutableArray alloc]init];
    taskProjectNameSearchArray1=[[NSMutableArray alloc]init];
    taskHardDependencySearchArray1=[[NSMutableArray alloc]init];
    taskIdSearchArray1=[[NSMutableArray alloc]init];
    taskHoursPerdaySearchArray1=[[NSMutableArray alloc]init];
    taskStatusSearchArray1=[[NSMutableArray alloc]init];
    taskAssignedByIdSearchArray1=[[NSMutableArray alloc]init];
    taskCreatedBySearchArray1=[[NSMutableArray alloc]init];
    
    
    
    temptaskupdateIDArray=[[NSMutableArray alloc]init];
    temphoursperDayArray=[[NSMutableArray alloc]init];
    tempharddependencyArray=[[NSMutableArray alloc]init];
    tempProjectNameArray=[[NSMutableArray alloc]init];
    temptaskcategoryArray=[[NSMutableArray alloc]init];
    
    
    expireTaskDescriptionArray=[[NSMutableArray alloc]init];
    expireTaskPriorityArray=[[NSMutableArray alloc]init];
    expireTaskIdArray=[[NSMutableArray alloc]init];
    expireEndDateArray=[[NSMutableArray alloc]init];
    expireStartDateArray=[[NSMutableArray alloc]init];
    expireAssignedArray=[[NSMutableArray alloc]init];
    expireAssogmedByIdArray=[[NSMutableArray alloc]init];
    expireCategoryArray=[[NSMutableArray alloc]init];
    expireHoursPerDayArray=[[NSMutableArray alloc]init];
    expireHarddependencyArray=[[NSMutableArray alloc]init];
    expireCreatedBySearchArray=[[NSMutableArray alloc]init];
    expireProjectNameArray=[[NSMutableArray alloc]init];
    expireTaskEffortArray=[[NSMutableArray alloc]init];
    expireResourceArray=[[NSMutableArray alloc]init];
    expireStatusArray=[[NSMutableArray alloc]init];
    
    
    expireTaskDescriptionArraySearch=[[NSMutableArray alloc]init];
    expireTaskPriorityArraySearch=[[NSMutableArray alloc]init];
    expireTaskIdArraySearch=[[NSMutableArray alloc]init];
    expireEndDateArraySearch=[[NSMutableArray alloc]init];
    expireStartDateArraySearch=[[NSMutableArray alloc]init];
    expireAssignedArraySearch=[[NSMutableArray alloc]init];
    expireAssogmedByIdArraySearch=[[NSMutableArray alloc]init];
    expireCategoryArraySearch=[[NSMutableArray alloc]init];
    expireHoursPerDayArraySearch=[[NSMutableArray alloc]init];
    expireHarddependencyArraySearch=[[NSMutableArray alloc]init];
    expireCreatedBySearchArray1=[[NSMutableArray alloc]init];
    expireProjectNameArraySearch=[[NSMutableArray alloc]init];
    expireTaskEffortArraySearch=[[NSMutableArray alloc]init];
    expireResourceArraySearch=[[NSMutableArray alloc]init];
    expireStatusArraySearch=[[NSMutableArray alloc]init];
    
    expireTaskDescriptionArraySearch1=[[NSMutableArray alloc]init];
    expireTaskPriorityArraySearch1=[[NSMutableArray alloc]init];
    expireTaskIdArraySearch1=[[NSMutableArray alloc]init];
    expireEndDateArraySearch1=[[NSMutableArray alloc]init];
    expireStartDateArraySearch1=[[NSMutableArray alloc]init];
    expireAssignedArraySearch1=[[NSMutableArray alloc]init];
    expireAssogmedByIdArraySearch1=[[NSMutableArray alloc]init];
    expireCategoryArraySearch1=[[NSMutableArray alloc]init];
    expireHoursPerDayArraySearch1=[[NSMutableArray alloc]init];
    expireHarddependencyArraySearch1=[[NSMutableArray alloc]init];
    expireCreatedBySearchArray2=[[NSMutableArray alloc]init];
    expireProjectNameArraySearch1=[[NSMutableArray alloc]init];
    expireTaskEffortArraySearch1=[[NSMutableArray alloc]init];
    expireResourceArraySearch1=[[NSMutableArray alloc]init];
    expireStatusArraySearch1=[[NSMutableArray alloc]init];
    
    expireTaskDescriptionArraySearch2=[[NSMutableArray alloc]init];
    expireTaskPriorityArraySearch2=[[NSMutableArray alloc]init];
    expireTaskIdArraySearch2=[[NSMutableArray alloc]init];
    expireEndDateArraySearch2=[[NSMutableArray alloc]init];
    expireStartDateArraySearch2=[[NSMutableArray alloc]init];
    expireAssignedArraySearch2=[[NSMutableArray alloc]init];
    expireAssogmedByIdArraySearch2=[[NSMutableArray alloc]init];
    expireCategoryArraySearch2=[[NSMutableArray alloc]init];
    expireHoursPerDayArraySearch2=[[NSMutableArray alloc]init];
    expireHarddependencyArraySearch2=[[NSMutableArray alloc]init];
    expireCreatedBySearchArray3=[[NSMutableArray alloc]init];
    expireProjectNameArraySearch2=[[NSMutableArray alloc]init];
    expireTaskEffortArraySearch2=[[NSMutableArray alloc]init];
    expireResourceArraySearch2=[[NSMutableArray alloc]init];
    expireStatusArraySearch2=[[NSMutableArray alloc]init];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    [searchBar1 resignFirstResponder];
    [Serchbar resignFirstResponder];
  
    Expirelabel.text=@"All";
    
    FilterArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Expired",nil];

    NSLog(@"user details %@ %@ %@ ",Useridstr,orgIdstr,Usertypestr,Usernamestr);
    [self LoadINFO];
    
  
//    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureclicked)];
//    [self.view addGestureRecognizer:tapgesture];
   
}
-(void)LoadINFO
{

    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.52 green:0.77 blue:0.77 alpha:1.0];
//    UIButton* Eisimage = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Eisimage setImage:[UIImage imageNamed:@"homeicon.png"] forState:UIControlStateNormal];
//    [Eisimage sizeToFit];
//    UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Eisimage];
   // self.navigationItem.leftBarButtonItem = eisimagebtn;
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"homeicon.png"] forState:UIControlStateNormal];
    //[button addTarget:target action:@selector(buttonAction:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 53, 101)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 250, 80)];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    NSMutableString *UserName  = [[NSMutableString alloc]initWithString:@"WelCome Mr/Ms "];
    [UserName appendString:Usernamestr];
    [label setText:UserName];
    //label.textAlignment = UITextAlignmentCenter;
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [button addSubview:label];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    

    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    UIButton* CreatTaskbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CreatTaskbtn setImage:[UIImage imageNamed:@"expenses_new_icon.png"] forState:UIControlStateNormal];
    [CreatTaskbtn addTarget:self action:@selector(CreatTaskTapped) forControlEvents:UIControlEventTouchUpInside];
    [CreatTaskbtn sizeToFit];
    UIBarButtonItem *Creatpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:CreatTaskbtn];
    
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:Logoutpagebatbtn,Homepagebatbtn,Creatpagebatbtn,nil];
    
    
//    Serchpickertxtfiled = (UITextField *)[self.view viewWithTag:11];
//    Serchpickertxtfiled.layer.cornerRadius = 15;
//    Serchpickertxtfiled.layer.borderWidth  = 2;
//    Serchpickertxtfiled.layer.borderColor  = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor;
//    //Serchpickertxtfiled.delegate = self;
//    UIButton *Prioritybtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Prioritybtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
//    Prioritybtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
//   // [Prioritybtnpkr addTarget:self action:@selector(priorityPickerTapped) forControlEvents:UIControlEventTouchUpInside];
//    Serchpickertxtfiled.rightView = Prioritybtnpkr;
//    Serchpickertxtfiled.rightViewMode = UITextFieldViewModeAlways;
//    [Serchpickertxtfiled addSubview:Prioritybtnpkr];
    
    [self TasksHPList];
    
    [Serchbar setReturnKeyType:UIReturnKeyDone];
    [Serchbar setEnablesReturnKeyAutomatically:NO];
    
    
    [super viewDidLoad];
    
}
-(void)TasksHPList
{
        NSString *TaskListUrl = @"TasksHPListService";
        NSDictionary *credentials = @{@"orgVp":orgIdstr,@"userId":Useridstr,@"userType":Usertypestr};
        [Servicecall TasksHPListServiceurl:TaskListUrl TaskListParameters:credentials];
        [Servicecall setDelegate:self];
  
}

-(void)didFinishService:(id)Userlogindetails
{
    TaskListXmlParser= [[NSXMLParser alloc]initWithData:Userlogindetails];
    TaskListXmlParser.delegate=self;
    [TaskListXmlParser parse];
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==TaskListXmlParser)
    {
        if([elementName isEqualToString:@"userTasksListResponse"])
        {
            TaskIdArray                =[NSMutableArray new];
            DescriptionArray           =[NSMutableArray new];
            StartDateArray             =[NSMutableArray new];
            EndDateArray               =[NSMutableArray new];
            PriortyArray               =[NSMutableArray new];
            TaskEffortArray            =[NSMutableArray new];
            TasklistArray              =[NSMutableArray new];
            TaskAssgndByIdArray        =[NSMutableArray new];
            TaskSplitArray             =[NSArray new];
            CatogeryArray              =[NSMutableArray new];
            ResourceNameArray          =[NSMutableArray new];
            ProjectNamearray           =[NSMutableArray new];
            hardDependencyArray        =[NSMutableArray new];
            taskCreatedByIdArray       =[NSMutableArray new];
            taskAssignedArray          =[NSMutableArray new];
            taskCreatedByArray         =[NSMutableArray new];
            hoursPerDayArray           =[NSMutableArray new];
            createdByString            =[NSMutableString new];
            AssignedByIdStr            =[NSMutableString new];
            taskStatusArray            =[NSMutableArray new];
           
        }
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == TaskListXmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [TasklistArray addObject:string];
            
            
        }
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == TaskListXmlParser)
    {
        if([elementName isEqualToString:@"userTasksListResponse"])
        {
            for (int i = 0; i<[TasklistArray count]; i++)
            {
                TaskSplitArray=[[TasklistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                //NSLog(@"hai boss %@",TaskSplitArray);
                
                [TaskIdArray addObject:[[TaskSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TaskId==" withString:@""]];
                
                [DescriptionArray addObject:[[TaskSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Description==" withString:@""]];
                
                startDateStr1 =[[TaskSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"StartDate==" withString:@""];
                
                
                endDateStr2 =[[TaskSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"EndDate=" withString:@""];
                
                [TaskEffortArray addObject:[[TaskSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString: @"TaskEffort=" withString:@""]];
                
                [PriortyArray addObject:[[TaskSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString: @"Priorty=" withString:@""]];
                
                createdByString=[[TaskSplitArray objectAtIndex:11]stringByReplacingOccurrencesOfString: @"TaskAssgndById=" withString:@""];
                
                [CatogeryArray addObject:[[TaskSplitArray objectAtIndex:8]stringByReplacingOccurrencesOfString: @"Catogery=" withString:@""]];
                
                [ResourceNameArray addObject:[[TaskSplitArray objectAtIndex:10]stringByReplacingOccurrencesOfString: @"ResourceName=" withString:@""]];
                
                [ProjectNamearray addObject:[[TaskSplitArray objectAtIndex:9]stringByReplacingOccurrencesOfString: @"ProjectName=" withString:@""]];
                
                [hardDependencyArray addObject:[[TaskSplitArray objectAtIndex:12]stringByReplacingOccurrencesOfString:@"taskHardDependency==" withString:@""]];
                
                [hoursPerDayArray addObject:[[TaskSplitArray objectAtIndex:13]stringByReplacingOccurrencesOfString:@"hourPerDay==" withString:@""]];
                
                [taskAssignedArray addObject:[[TaskSplitArray objectAtIndex:14]stringByReplacingOccurrencesOfString:@"assignedTo==" withString:@""]];
                
                AssignedByIdStr=[[TaskSplitArray objectAtIndex:15]stringByReplacingOccurrencesOfString:@"createdBy==" withString:@""];
                [taskStatusArray addObject:[[TaskSplitArray objectAtIndex:16]stringByReplacingOccurrencesOfString:@"taskStatus==" withString:@""]];
                
                
//                
//                NSLog(@"hard dependecy array is %@",hardDependencyArray);
//                NSLog(@"start date str is %@",startDateStr1);
//                NSLog(@"end date str is %@",endDateStr2);
               
//                NSDateFormatter *format = [[NSDateFormatter alloc] init];
//                [format setDateFormat:@"dd/MM/yyyy"];
//                NSDate *date = [format dateFromString:startDateStr1];
//                [format setDateFormat:@"yyyy-MM-dd"];
//                NSString* finalDateString = [format stringFromDate:date];
//                NSLog(@"the changed date is %@",finalDateString);//                //[dateFormat setDateFormat:@"yyyy-MM-dd"];
////                NSString *startdate1=[dateFormat stringFromDate:startdate];
//                
//                
//                NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
//                [format1 setDateFormat:@"dd/MM/yyyy"];
//                NSDate *date1 = [format1 dateFromString:endDateStr2];
//                [format1 setDateFormat:@"yyyy-MM-dd"];
//                NSString* finalDateString2 = [format1 stringFromDate:date1];
//                NSLog(@"the changed date is %@",finalDateString2);
               
                [StartDateArray addObject:startDateStr1];
                [EndDateArray addObject:endDateStr2];
                [TaskAssgndByIdArray addObject:createdByString];
                [taskCreatedByArray addObject:AssignedByIdStr];
                
//                
//                NSLog(@"task created by array %@",taskCreatedByArray);
//                
//                NSLog(@"the start is %@",StartDateArray);
//                NSLog(@"the end id %@",EndDateArray);
//                NSLog(@"task assigned id is %@",taskAssignedArray);
//                NSLog(@"task status array is %@",taskStatusArray);
                
            }
            
            
            
            uniqueDescriptionArray=[[NSMutableArray alloc]init];
            [uniqueDescriptionArray addObjectsFromArray:[[NSSet setWithArray:PriortyArray]allObjects]];
            //NSLog(@"unique array is %@",uniqueDescriptionArray);
            [uniqueDescriptionArray addObject:@"PriorityAll"];
            
            
                A=[[NSMutableArray alloc]init];
            
                refarray1=[[NSMutableArray alloc]initWithArray:PriortyArray];
                A=PriortyArray;
            
            B=[[NSMutableArray alloc]init];
            
               // NSLog(@"the ref1 array is %@",A);
            
            
            
            if ([searchBar1.text isEqualToString:@"Created By"])
            {
                searcharray1=[[NSMutableArray alloc]init];
                refarray3=[[NSMutableArray alloc]initWithArray:taskCreatedByArray];
                C=[[NSMutableArray alloc]init];
                D=[[NSMutableArray alloc]init];
                //tempArray=taskCreatedByArray;
                
            }
            searcharray2=[[NSMutableArray alloc]init];
            refarray4=[[NSMutableArray alloc]initWithArray:ResourceNameArray];
             E=[[NSMutableArray alloc]init];
            F=[[NSMutableArray alloc]init];
            E=ResourceNameArray;
           // NSLog(@"ref 4 array is %@",refarray4);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [TaskListTV reloadData];
            });
          
            //[TaskListTV reloadData];
        }
    }
    int total =[TaskEffortArray count];
    
    NSString *totalTaskValue=[NSString stringWithFormat:@"%d",total];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = [@"Total Tasks is " stringByAppendingString:totalTaskValue];
    //hud.tintColor=[UIColor blueColor];
    hud.detailsLabel.font=[UIFont fontWithName:@"Roboto-Black" size:22];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.textColor=[UIColor blueColor];
    hud.margin = 12.f;
    [hud hideAnimated:YES afterDelay:2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        return [A count];
        NSLog(@"knjhbmhjnkml");
    }
    
  if (![searchBar1.text isEqualToString:@"All"]&&[Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
      return [createdBySearchArray count];
        NSLog(@" created by values are");
        
    }
 if (![searchBar1.text isEqualToString:@"All"]&&![Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        return [dessearchArray1 count];
        NSLog(@" assigned to array ");
    }
   if (![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        return [expireStatusArray count];
        NSLog(@" assigned to array ");
    }
 if (![searchBar1.text isEqualToString:@"All"]&&[Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        return [expireStatusArraySearch count];
        NSLog(@" created by values are");
        
    }
    if (![searchBar1.text isEqualToString:@"All"] &&![Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])    {
        return [expireStatusArraySearch1 count];
        NSLog(@" assigned to array ");
    }
  if ([searchBar1.text isEqualToString:@"All"] &&[Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])
   {
       return [expireStatusArraySearch2 count];
       NSLog(@" assigned to array ");
   }

    else
    {
       return [PriortyArray count];
        NSLog(@"asdfdsfdsfdfdssfdsafsfsafdsf");

    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {

//        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
//                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        spinner.center = CGPointMake(160, 240);
//        spinner.hidesWhenStopped = YES;
//        [self.view addSubview:spinner];
//        [spinner startAnimating];
        
        static NSString *CellIdentifier = @"EIS";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [tempArray2 objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [tempArray3 objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [tempArray4 objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [tempArray5 objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [A objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[tempArray7 objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[tempArray6 objectAtIndex:indexPath.row];
        
        
        int total=[A count];
        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
        NSLog(@"total count of priority search is %@",totaltask);
        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                       title:@"Total Tasks"];
    
        UILongPressGestureRecognizer *longPressGesture =
[[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;

    }
   
   if (![searchBar1.text isEqualToString:@"All"]&& [Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        
    
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [dessearchArray objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [startDateSearchArray objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [enddateSearchArray objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [effortSearchArray objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [prioritySearchArray objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[createdBySearchArray objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[AssignedToSearchArray objectAtIndex:indexPath.row];
        
        
       // int total=[tempArray8 count];
//        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
//        NSLog(@"total count of task created by search is %@",totaltask);
//        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
//                       title:@"Total Tasks"];
        //
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
    }
    if(![searchBar1.text isEqualToString:@"All"]&&![Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [dessearchArray1 objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [startdatesearchArray1 objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [enddatesearchArray1 objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [effortsearchArray1 objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [prioritysearchArray1 objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[createdbysearchArray1 objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[assignedsearchArray1 objectAtIndex:indexPath.row];
        
        
        int total=[tempArray8 count];
        //        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
        //        NSLog(@"total count of task created by search is %@",totaltask);
        //        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
        //                       title:@"Total Tasks"];
        //
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
        
    }
    if(![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&[Expirelabel.text isEqualToString:@"Expired"])
   {
       static NSString *CellIdentifier = @"EIS";
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (cell == nil)
       {
           
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       }
       //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
       tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
       [tableView.layer setBorderWidth:2.0f];
       tableView.layer.cornerRadius = 12;
       tableView.clipsToBounds = YES;
       [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
       [cell.contentView.layer setBorderWidth:1.0f];
       cell.contentView.layer.cornerRadius = 8;
       cell.contentView.clipsToBounds = YES;
       
       
       //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
       //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
       
       
       
       UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
       DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
       
       DiscriptionDataLbl.text = [expireTaskDescriptionArray objectAtIndex:indexPath.row];
       
       
       //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
       //StartTimelbl.font=[UIFont systemFontOfSize:15];
       
       UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
       StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
       StartTimeDatalbl.text= [expireStartDateArray objectAtIndex:indexPath.row];
       
       //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
       // EndTimeLbl.font=[UIFont systemFontOfSize:15];
       
       UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
       EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
       EndTimeDataLbl.text= [expireEndDateArray objectAtIndex:indexPath.row];
       
       // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
       //EffortLbl.font=[UIFont systemFontOfSize:15];
       
       UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
       EffortDataLbl.font=[UIFont systemFontOfSize:15];
       EffortDataLbl.text= [expireTaskEffortArray objectAtIndex:indexPath.row];
       
       // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
       //PriorityLbl.font=[UIFont systemFontOfSize:15];
       
       UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
       PriorityDataLbl.font=[UIFont systemFontOfSize:15];
       PriorityDataLbl.text= [expireTaskPriorityArray objectAtIndex:indexPath.row];
       
       
       UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
       AssignedLbl.font=[UIFont systemFontOfSize:15];
       AssignedLbl.text=[expireAssignedArray objectAtIndex:indexPath.row];
       
       UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
       CreatedByLbl.font=[UIFont systemFontOfSize:15];
       CreatedByLbl.text=[expireResourceArray objectAtIndex:indexPath.row];
       
       
       int total=[expireStatusArray count];
               NSString *totaltask=[NSString stringWithFormat:@"%d",total];
               NSLog(@"total count of task created by search is %@",totaltask);
               [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                              title:@"Total Tasks"];
       
       UILongPressGestureRecognizer *longPressGesture =
       [[UILongPressGestureRecognizer alloc]
        initWithTarget:self action:@selector(longPress:)];
       [cell addGestureRecognizer:longPressGesture];
       
       return cell;
   }
     if ([Expirelabel.text isEqualToString:@"Expired"]&&![searchBar1.text isEqualToString:@"All"] && [Serchbar.text isEqualToString:@"PriorityAll"])
    {
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [expireTaskDescriptionArraySearch objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [expireStartDateArraySearch objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [expireEndDateArraySearch objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [expireTaskEffortArraySearch objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [expireTaskPriorityArraySearch objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[expireResourceArraySearch objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[expireAssignedArraySearch objectAtIndex:indexPath.row];
        
        
        int total=[expireStatusArraySearch count];
        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
        NSLog(@"total count of task created by search is %@",totaltask);
        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                       title:@"Total Tasks"];
        
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
    }
    if ([Expirelabel.text isEqualToString:@"Expired"]&&![searchBar1.text isEqualToString:@"All"] &&![Serchbar.text isEqualToString:@"PriorityAll"])
    {
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [expireTaskDescriptionArraySearch1 objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [expireStartDateArraySearch1 objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [expireEndDateArraySearch1 objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [expireTaskEffortArraySearch1 objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [expireTaskPriorityArraySearch1 objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[expireCreatedBySearchArray2 objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[expireAssignedArraySearch1 objectAtIndex:indexPath.row];
        
        
        int total=[expireStatusArraySearch1 count];
        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
        NSLog(@"total count of task created by search is %@",totaltask);
        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                       title:@"Total Tasks"];
        
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
        
    }
     if ([Expirelabel.text isEqualToString:@"Expired"]&&[searchBar1.text isEqualToString:@"All"] &&[Serchbar.text isEqualToString:@"PriorityAll"])
    {
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [expireTaskDescriptionArraySearch2 objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [expireStartDateArraySearch2 objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [expireEndDateArraySearch2 objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [expireTaskEffortArraySearch2 objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [expireTaskPriorityArraySearch2 objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[expireAssignedArraySearch2 objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[expireCreatedBySearchArray3 objectAtIndex:indexPath.row];
        
        
        int total=[expireStatusArraySearch2 count];
        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
        NSLog(@"total count of task created by search is %@",totaltask);
        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
                       title:@"Total Tasks"];
        
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
        
    }
    else
    {
        static NSString *CellIdentifier = @"EIS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [tableView.layer setBorderWidth:2.0f];
        tableView.layer.cornerRadius = 12;
        tableView.clipsToBounds = YES;
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        //UILabel *DiscriptionLbl = (UILabel*)[cell viewWithTag:1];
        //DiscriptionLbl.font=[UIFont systemFontOfSize:15];
        
        
        
        UILabel *DiscriptionDataLbl = (UILabel*)[cell viewWithTag:6];
        DiscriptionDataLbl.font=[UIFont systemFontOfSize:15];
        
        DiscriptionDataLbl.text = [DescriptionArray objectAtIndex:indexPath.row];
        
        
        //UILabel *StartTimelbl = (UILabel*)[cell viewWithTag:2];
        //StartTimelbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *StartTimeDatalbl = (UILabel*)[cell viewWithTag:7];
        StartTimeDatalbl.font=[UIFont systemFontOfSize:15];
        StartTimeDatalbl.text= [StartDateArray objectAtIndex:indexPath.row];
        
        //UILabel *EndTimeLbl = (UILabel*)[cell viewWithTag:3];
        // EndTimeLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EndTimeDataLbl = (UILabel*)[cell viewWithTag:8];
        EndTimeDataLbl.font=[UIFont systemFontOfSize:15];
        EndTimeDataLbl.text= [EndDateArray objectAtIndex:indexPath.row];
        
        // UILabel *EffortLbl = (UILabel*)[cell viewWithTag:4];
        //EffortLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *EffortDataLbl = (UILabel*)[cell viewWithTag:9];
        EffortDataLbl.font=[UIFont systemFontOfSize:15];
        EffortDataLbl.text= [TaskEffortArray objectAtIndex:indexPath.row];
        
        // UILabel *PriorityLbl = (UILabel*)[cell viewWithTag:5];
        //PriorityLbl.font=[UIFont systemFontOfSize:15];
        
        UILabel *PriorityDataLbl = (UILabel*)[cell viewWithTag:10];
        PriorityDataLbl.font=[UIFont systemFontOfSize:15];
        PriorityDataLbl.text= [PriortyArray objectAtIndex:indexPath.row];
        
        
        UILabel *AssignedLbl=(UILabel *)[cell viewWithTag:13];
        AssignedLbl.font=[UIFont systemFontOfSize:15];
        AssignedLbl.text=[ResourceNameArray objectAtIndex:indexPath.row];
        
        UILabel *CreatedByLbl=(UILabel *)[cell viewWithTag:14];
        CreatedByLbl.font=[UIFont systemFontOfSize:15];
        CreatedByLbl.text=[taskAssignedArray objectAtIndex:indexPath.row];
        
        
        int total=[TaskEffortArray count];
//        NSString *totaltask=[NSString stringWithFormat:@"%d",total];
//        [self.view makeToast:totaltask duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(450, 450)]
//                       title:@"Total Tasks"];
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
        //asdfdsfdsfdfdssfdsafsfsafdsf
        NSLog(@"asdfdsfdsfdfdssfdsafsfsafdsf");
    }
    
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
	
    
  
    if (![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&![Expirelabel.text isEqualToString:@"Expired"])

    {
        
        
        
    CGPoint p = [gesture locationInView:TaskListTV];
    UITableViewCell *cell = (UITableViewCell *)[gesture view];
    NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
    taskidstr = [tempArray17 objectAtIndex:indexPath.row];
        
          NSLog(@" task1 are %@",taskidstr);
    if (indexPath == nil) {
       //cell.backgroundColor = [UIColor clearColor];
    }  else
    {
       
         if (gesture.state == UIGestureRecognizerStateBegan)
         {
            cell.backgroundColor = [UIColor redColor];
            NSLog(@"UIGestureRecognizerStateBegan.");
            
             self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
             
             UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
             [Done setTitle:@"DONE" forState:UIControlStateNormal];
             [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
             [Done sizeToFit];
             UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
             self.navigationItem.leftBarButtonItem = eisimagebtn;
             
             
             UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
             [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
             [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
             [UPLOADAUDIO sizeToFit];
             UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
             
             UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
             [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
             [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
             [UPLOADVIDEO sizeToFit];
             UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
             
             UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
             [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
             [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
             [UPLOADFILE sizeToFit];
             UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
             
             UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
             //TEXTUPLOAD.layer.borderWidth = 2.0f;
             
             //TEXTUPLOAD.layer.cornerRadius = 10;
             //TEXTUPLOAD.backgroundColor = [UIColor grayColor];

             [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
             
             [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
             [TEXTUPLOAD sizeToFit];
             UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
             
             self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
            NSLog(@"long press on table view at row %d", indexPath.row);
            //[TaskListTV reloadData];
        
        }
       else if (gesture.state == UIGestureRecognizerStateEnded)
       {
            NSLog(@"UIGestureRecognizerStateEnded");
            cell.backgroundColor = [UIColor clearColor];
            //Do Whatever You want on End of Gesture
        }
    }
    //	if (gesture.state == UIGestureRecognizerStateBegan)
//	{
//		// get affected cell
//		UITableViewCell *cell = (UITableViewCell *)[gesture view];
//        
//		// get indexPath of cell
//		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
//       //cell.backgroundColor = [UIColor redColor];
//    }
//    
    [TaskListTV reloadData];
    }
 else if (![searchBar1.text isEqualToString:@"All"]&& [Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        CGPoint p = [gesture locationInView:TaskListTV];
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
        taskidstr = [taskIdSearchArray objectAtIndex:indexPath.row];
        
        NSLog(@"   task id values are %@",taskidstr);
        if (indexPath == nil) {
            //cell.backgroundColor = [UIColor clearColor];
        }  else
        {
            
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                cell.backgroundColor = [UIColor redColor];
                NSLog(@"UIGestureRecognizerStateBegan.");
                
                self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                
                UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                [Done setTitle:@"DONE" forState:UIControlStateNormal];
                [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                [Done sizeToFit];
                UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                self.navigationItem.leftBarButtonItem = eisimagebtn;
                
                
                UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADAUDIO sizeToFit];
                UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                
                UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADVIDEO sizeToFit];
                UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                
                UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADFILE sizeToFit];
                UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                
                UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                //TEXTUPLOAD.layer.borderWidth = 2.0f;
                
                //TEXTUPLOAD.layer.cornerRadius = 10;
                //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                
                [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                
                [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [TEXTUPLOAD sizeToFit];
                UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                
                self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                NSLog(@"long press on table view at row %d", indexPath.row);
                //[TaskListTV reloadData];
                
            }
            else if (gesture.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                cell.backgroundColor = [UIColor clearColor];
                //Do Whatever You want on End of Gesture
            }
        }
        //	if (gesture.state == UIGestureRecognizerStateBegan)
        //	{
        //		// get affected cell
        //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
        //        
        //		// get indexPath of cell
        //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
        //       //cell.backgroundColor = [UIColor redColor];
        //    }
        //    
        [TaskListTV reloadData];

        
    }
  else  if(![searchBar1.text isEqualToString:@"All"]&&![Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        CGPoint p = [gesture locationInView:TaskListTV];
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
        taskidstr = [taskIdSearchArray1 objectAtIndex:indexPath.row];
        if (indexPath == nil) {
            //cell.backgroundColor = [UIColor clearColor];
        }  else
        {
            
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                cell.backgroundColor = [UIColor redColor];
                NSLog(@"UIGestureRecognizerStateBegan.");
                
                self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                
                UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                [Done setTitle:@"DONE" forState:UIControlStateNormal];
                [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                [Done sizeToFit];
                UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                self.navigationItem.leftBarButtonItem = eisimagebtn;
                
                
                UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADAUDIO sizeToFit];
                UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                
                UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADVIDEO sizeToFit];
                UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                
                UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADFILE sizeToFit];
                UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                
                UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                //TEXTUPLOAD.layer.borderWidth = 2.0f;
                
                //TEXTUPLOAD.layer.cornerRadius = 10;
                //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                
                [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                
                [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [TEXTUPLOAD sizeToFit];
                UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                
                self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                NSLog(@"long press on table view at row %d", indexPath.row);
                //[TaskListTV reloadData];
                
            }
            else if (gesture.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                cell.backgroundColor = [UIColor clearColor];
                //Do Whatever You want on End of Gesture
            }
        }
        //	if (gesture.state == UIGestureRecognizerStateBegan)
        //	{
        //		// get affected cell
        //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
        //
        //		// get indexPath of cell
        //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
        //       //cell.backgroundColor = [UIColor redColor];
        //    }
        //
        [TaskListTV reloadData];
        
        
    }
   else if(![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&[Expirelabel.text isEqualToString:@"Expired"])
   {
       CGPoint p = [gesture locationInView:TaskListTV];
       UITableViewCell *cell = (UITableViewCell *)[gesture view];
       NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
       taskidstr = [expireTaskIdArray objectAtIndex:indexPath.row];
       if (indexPath == nil) {
           //cell.backgroundColor = [UIColor clearColor];
       }  else
       {
           
           if (gesture.state == UIGestureRecognizerStateBegan)
           {
               cell.backgroundColor = [UIColor redColor];
               NSLog(@"UIGestureRecognizerStateBegan.");
               
               self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
               
               UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
               [Done setTitle:@"DONE" forState:UIControlStateNormal];
               [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
               [Done sizeToFit];
               UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
               self.navigationItem.leftBarButtonItem = eisimagebtn;
               
               
               UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
               [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
               [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
               [UPLOADAUDIO sizeToFit];
               UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
               
               UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
               [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
               [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
               [UPLOADVIDEO sizeToFit];
               UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
               
               UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
               [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
               [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
               [UPLOADFILE sizeToFit];
               UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
               
               UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
               //TEXTUPLOAD.layer.borderWidth = 2.0f;
               
               //TEXTUPLOAD.layer.cornerRadius = 10;
               //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
               
               [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
               
               [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
               [TEXTUPLOAD sizeToFit];
               UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
               
               self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
               NSLog(@"long press on table view at row %d", indexPath.row);
               //[TaskListTV reloadData];
               
           }
           else if (gesture.state == UIGestureRecognizerStateEnded)
           {
               NSLog(@"UIGestureRecognizerStateEnded");
               cell.backgroundColor = [UIColor clearColor];
               //Do Whatever You want on End of Gesture
           }
       }
       //	if (gesture.state == UIGestureRecognizerStateBegan)
       //	{
       //		// get affected cell
       //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
       //
       //		// get indexPath of cell
       //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
       //       //cell.backgroundColor = [UIColor redColor];
       //    }
       //
       [TaskListTV reloadData];
   }
    else if ([Expirelabel.text isEqualToString:@"Expired"]&&![searchBar1.text isEqualToString:@"All"] && [Serchbar.text isEqualToString:@"PriorityAll"])
     {
         CGPoint p = [gesture locationInView:TaskListTV];
         UITableViewCell *cell = (UITableViewCell *)[gesture view];
         NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
         taskidstr = [expireTaskIdArraySearch objectAtIndex:indexPath.row];
         if (indexPath == nil) {
             //cell.backgroundColor = [UIColor clearColor];
         }  else
         {
             
             if (gesture.state == UIGestureRecognizerStateBegan)
             {
                 cell.backgroundColor = [UIColor redColor];
                 NSLog(@"UIGestureRecognizerStateBegan.");
                 
                 self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                 
                 UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                 [Done setTitle:@"DONE" forState:UIControlStateNormal];
                 [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                 [Done sizeToFit];
                 UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                 self.navigationItem.leftBarButtonItem = eisimagebtn;
                 
                 
                 UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                 [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                 [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                 [UPLOADAUDIO sizeToFit];
                 UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                 
                 UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                 [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                 [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                 [UPLOADVIDEO sizeToFit];
                 UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                 
                 UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                 [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                 [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                 [UPLOADFILE sizeToFit];
                 UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                 
                 UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                 //TEXTUPLOAD.layer.borderWidth = 2.0f;
                 
                 //TEXTUPLOAD.layer.cornerRadius = 10;
                 //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                 
                 [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                 
                 [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                 [TEXTUPLOAD sizeToFit];
                 UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                 
                 self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                 NSLog(@"long press on table view at row %d", indexPath.row);
                 //[TaskListTV reloadData];
                 
             }
             else if (gesture.state == UIGestureRecognizerStateEnded)
             {
                 NSLog(@"UIGestureRecognizerStateEnded");
                 cell.backgroundColor = [UIColor clearColor];
                 //Do Whatever You want on End of Gesture
             }
         }
         //	if (gesture.state == UIGestureRecognizerStateBegan)
         //	{
         //		// get affected cell
         //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
         //
         //		// get indexPath of cell
         //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
         //       //cell.backgroundColor = [UIColor redColor];
         //    }
         //
         [TaskListTV reloadData];
     }
    else  if ([Expirelabel.text isEqualToString:@"Expired"]&&![searchBar1.text isEqualToString:@"All"] &&![Serchbar.text isEqualToString:@"PriorityAll"])
    {
        CGPoint p = [gesture locationInView:TaskListTV];
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
        taskidstr = [expireTaskIdArraySearch1 objectAtIndex:indexPath.row];
        if (indexPath == nil) {
            //cell.backgroundColor = [UIColor clearColor];
        }  else
        {
            
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                cell.backgroundColor = [UIColor redColor];
                NSLog(@"UIGestureRecognizerStateBegan.");
                
                self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                
                UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                [Done setTitle:@"DONE" forState:UIControlStateNormal];
                [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                [Done sizeToFit];
                UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                self.navigationItem.leftBarButtonItem = eisimagebtn;
                
                
                UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADAUDIO sizeToFit];
                UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                
                UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADVIDEO sizeToFit];
                UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                
                UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADFILE sizeToFit];
                UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                
                UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                //TEXTUPLOAD.layer.borderWidth = 2.0f;
                
                //TEXTUPLOAD.layer.cornerRadius = 10;
                //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                
                [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                
                [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [TEXTUPLOAD sizeToFit];
                UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                
                self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                NSLog(@"long press on table view at row %d", indexPath.row);
                //[TaskListTV reloadData];
                
            }
            else if (gesture.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                cell.backgroundColor = [UIColor clearColor];
                //Do Whatever You want on End of Gesture
            }
        }
        //	if (gesture.state == UIGestureRecognizerStateBegan)
        //	{
        //		// get affected cell
        //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
        //
        //		// get indexPath of cell
        //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
        //       //cell.backgroundColor = [UIColor redColor];
        //    }
        //
        [TaskListTV reloadData];
    }
   else if ([Expirelabel.text isEqualToString:@"Expired"]&&[searchBar1.text isEqualToString:@"All"] &&[Serchbar.text isEqualToString:@"PriorityAll"])
    {
        CGPoint p = [gesture locationInView:TaskListTV];
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
        taskidstr = [expireTaskIdArraySearch2 objectAtIndex:indexPath.row];
        if (indexPath == nil) {
            //cell.backgroundColor = [UIColor clearColor];
        }  else
        {
            
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                cell.backgroundColor = [UIColor redColor];
                NSLog(@"UIGestureRecognizerStateBegan.");
                
                self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                
                UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                [Done setTitle:@"DONE" forState:UIControlStateNormal];
                [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                [Done sizeToFit];
                UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                self.navigationItem.leftBarButtonItem = eisimagebtn;
                
                
                UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADAUDIO sizeToFit];
                UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                
                UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADVIDEO sizeToFit];
                UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                
                UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADFILE sizeToFit];
                UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                
                UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                //TEXTUPLOAD.layer.borderWidth = 2.0f;
                
                //TEXTUPLOAD.layer.cornerRadius = 10;
                //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                
                [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                
                [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [TEXTUPLOAD sizeToFit];
                UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                
                self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                NSLog(@"long press on table view at row %d", indexPath.row);
                //[TaskListTV reloadData];
                
            }
            else if (gesture.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                cell.backgroundColor = [UIColor clearColor];
                //Do Whatever You want on End of Gesture
            }
        }
        //	if (gesture.state == UIGestureRecognizerStateBegan)
        //	{
        //		// get affected cell
        //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
        //
        //		// get indexPath of cell
        //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
        //       //cell.backgroundColor = [UIColor redColor];
        //    }
        //
        [TaskListTV reloadData];

    }
    else
    {
        CGPoint p = [gesture locationInView:TaskListTV];
        UITableViewCell *cell = (UITableViewCell *)[gesture view];
        NSIndexPath *indexPath = [TaskListTV indexPathForRowAtPoint:p];
        taskidstr = [TaskIdArray objectAtIndex:indexPath.row];
        if (indexPath == nil) {
            //cell.backgroundColor = [UIColor clearColor];
        }  else
        {
            
            if (gesture.state == UIGestureRecognizerStateBegan)
            {
                cell.backgroundColor = [UIColor redColor];
                NSLog(@"UIGestureRecognizerStateBegan.");
                
                self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
                
                UIButton* Done = [UIButton buttonWithType:UIButtonTypeCustom];
                [Done setTitle:@"DONE" forState:UIControlStateNormal];
                [Done addTarget:self action:@selector(DoneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
                [Done sizeToFit];
                UIBarButtonItem *eisimagebtn = [[UIBarButtonItem alloc] initWithCustomView:Done];
                self.navigationItem.leftBarButtonItem = eisimagebtn;
                
                
                UIButton* UPLOADAUDIO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADAUDIO setTitle:@"UploadAudio" forState:UIControlStateNormal];
                [UPLOADAUDIO addTarget:self action:@selector(AudioBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADAUDIO sizeToFit];
                UIBarButtonItem *audio = [[UIBarButtonItem alloc] initWithCustomView:UPLOADAUDIO];
                
                UIButton* UPLOADVIDEO = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADVIDEO setTitle:@"UploadVideo" forState:UIControlStateNormal];
                [UPLOADVIDEO addTarget:self action:@selector(VideoBtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADVIDEO sizeToFit];
                UIBarButtonItem *video = [[UIBarButtonItem alloc] initWithCustomView:UPLOADVIDEO];
                
                UIButton* UPLOADFILE = [UIButton buttonWithType:UIButtonTypeCustom];
                [UPLOADFILE setTitle:@"UploadFile" forState:UIControlStateNormal];
                [UPLOADFILE addTarget:self action:@selector(FileUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [UPLOADFILE sizeToFit];
                UIBarButtonItem *file = [[UIBarButtonItem alloc] initWithCustomView:UPLOADFILE];
                
                UIButton* TEXTUPLOAD = [UIButton buttonWithType:UIButtonTypeCustom];
                //TEXTUPLOAD.layer.borderWidth = 2.0f;
                
                //TEXTUPLOAD.layer.cornerRadius = 10;
                //TEXTUPLOAD.backgroundColor = [UIColor grayColor];
                
                [TEXTUPLOAD setTitle:@"UplaodText" forState:UIControlStateNormal];
                
                [TEXTUPLOAD addTarget:self action:@selector(TextUploadbtnTapped) forControlEvents:UIControlEventTouchUpInside];
                [TEXTUPLOAD sizeToFit];
                UIBarButtonItem *text = [[UIBarButtonItem alloc] initWithCustomView:TEXTUPLOAD];
                
                self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:text,file,video,audio,nil];
                NSLog(@"long press on table view at row %d", indexPath.row);
                //[TaskListTV reloadData];
                
            }
            else if (gesture.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                cell.backgroundColor = [UIColor clearColor];
                //Do Whatever You want on End of Gesture
            }
        }
        //	if (gesture.state == UIGestureRecognizerStateBegan)
        //	{
        //		// get affected cell
        //		UITableViewCell *cell = (UITableViewCell *)[gesture view];
        //
        //		// get indexPath of cell
        //		NSIndexPath *indexPath = [TaskListTV indexPathForCell:cell];
        //       //cell.backgroundColor = [UIColor redColor];
        //    }
        //
        [TaskListTV reloadData];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
    [PrirotyPickerview removeFromSuperview];
    //Serchbar.text=[uniqueDescriptionArray objectAtIndex:indexPath.row];
    CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
    CreatTaskVC.navigationTitlestr        = @"Modify Task";
    CreatTaskVC.SavebtnTitlestr           = @"Update";
    CreatTaskVC.locationUseBool           = YES;
    CreatTaskVC.Descriptionstr  =[tempArray2 objectAtIndex:indexPath.row];
    CreatTaskVC.Effortstr       =[tempArray5 objectAtIndex:indexPath.row];
    CreatTaskVC.EndDatestr      =[tempArray4 objectAtIndex:indexPath.row];
    CreatTaskVC.StartDatestr    =[tempArray3 objectAtIndex:indexPath.row];
    CreatTaskVC.UpDTaskId       =[tempArray17 objectAtIndex:indexPath.row];
    CreatTaskVC.categorynamestr =[categorySearchArray1 objectAtIndex:indexPath.row];
    CreatTaskVC.Projectnamestr  = [projectNameArray1 objectAtIndex:indexPath.row];
    CreatTaskVC.Resourcenamestr =[tempArray7 objectAtIndex:indexPath.row];
        
    CreatTaskVC.Prioritynamestr  =[A objectAtIndex:indexPath.row];
    CreatTaskVC.hardDependencystr=[hardDependencyArray1 objectAtIndex:indexPath.row];
    CreatTaskVC.hoursPerdayStr=[hoursPerDay1 objectAtIndex:indexPath.row];
    [CreatTaskVC.datePickerBtn setEnabled:NO];
        
    
    NSLog(@"task is %@",taskidstr);
    
    
    [self.navigationController pushViewController:CreatTaskVC animated:YES];
    
       // [TaskListTV reloadData];
    }
else  if (![searchBar1.text isEqualToString:@"All"]&&[Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
   {
        [PrirotyPickerview removeFromSuperview];
        //Serchbar.text=[uniqueDescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr            =[dessearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr                 =[effortSearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr                =[enddateSearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr              =[startDateSearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId                 =[taskIdSearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr           =[categorySearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr            =[taskProjectNameSearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr           =[createdBySearchArray objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr           =[prioritySearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr         =[taskHarddependencySearchArray objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr            =[taskHoursperdaySearchArray objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        
        
        NSLog(@"task is %@",taskidstr);
        
        
        [self.navigationController pushViewController:CreatTaskVC animated:YES];
    }
 else if (![searchBar1.text isEqualToString:@"All"]&&![Serchbar.text isEqualToString:@"PriorityAll"]&&![Expirelabel.text isEqualToString:@"Expired"])
    {
        [PrirotyPickerview removeFromSuperview];
        //Serchbar.text=[uniqueDescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr            =[dessearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr                 =[effortsearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr                =[enddatesearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr              =[startdatesearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId                 =[taskIdSearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr           =[categorySearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr            =[taskProjectNameSearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr           =[createdbysearchArray1 objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr           =[prioritysearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr         =[taskHardDependencySearchArray1 objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr            =[taskHoursPerdaySearchArray1 objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        
       [self.navigationController pushViewController:CreatTaskVC animated:YES];
    }
    else if (![Serchbar.text isEqualToString:@"PriorityAll"]&&[searchBar1.text isEqualToString:@"All"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        //[PrirotyPickerview removeFromSuperview];
        //Serchbar.text=[uniqueDescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr  =[expireTaskDescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr       =[expireTaskEffortArray objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr      =[expireEndDateArray objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr    =[expireStartDateArray objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId       =[expireTaskIdArray objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr =[expireCategoryArray objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr  = [expireProjectNameArray objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr =[expireResourceArray objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr  =[expireTaskPriorityArray objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr=[expireHarddependencyArray objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr=[expireHoursPerDayArray objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        NSLog(@"task is %@",taskidstr);
        [self.navigationController pushViewController:CreatTaskVC animated:YES];

   
    }

else if(![searchBar1.text isEqualToString:@"All"]&&[Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr  =[expireTaskDescriptionArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr       =[expireTaskEffortArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr      =[expireEndDateArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr    =[expireStartDateArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId       =[expireTaskIdArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr =[expireCategoryArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr  = [expireProjectNameArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr =[expireResourceArraySearch objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr  =[expireTaskPriorityArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr=[expireHarddependencyArraySearch objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr=[expireHoursPerDayArraySearch objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        NSLog(@"task is %@",taskidstr);
        [self.navigationController pushViewController:CreatTaskVC animated:YES];
        

    }
   else if (![searchBar1.text isEqualToString:@"All"] &&![Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr  =[expireTaskDescriptionArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr       =[expireTaskEffortArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr      =[expireEndDateArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr    =[expireStartDateArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId       =[expireTaskIdArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr =[expireCategoryArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr  = [expireProjectNameArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr =[expireCreatedBySearchArray2 objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr  =[expireTaskPriorityArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr=[expireHarddependencyArraySearch1 objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr=[expireHoursPerDayArraySearch1 objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        NSLog(@"task is %@",taskidstr);
        [self.navigationController pushViewController:CreatTaskVC animated:YES];
    }
   else if ([searchBar1.text isEqualToString:@"All"] &&[Serchbar.text isEqualToString:@"PriorityAll"]&&[Expirelabel.text isEqualToString:@"Expired"])
    {
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr  =[expireTaskDescriptionArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr       =[expireTaskEffortArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr      =[expireEndDateArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr    =[expireStartDateArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId       =[expireTaskIdArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr =[expireCategoryArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr  = [expireProjectNameArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr =[expireCreatedBySearchArray3 objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr  =[expireTaskPriorityArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr=[expireHarddependencyArraySearch2 objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr=[expireHoursPerDayArraySearch2 objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        NSLog(@"task is %@",taskidstr);
        [self.navigationController pushViewController:CreatTaskVC animated:YES];
    }
    else
    {
        [PrirotyPickerview removeFromSuperview];
        //Serchbar.text=[uniqueDescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
        CreatTaskVC.navigationTitlestr        = @"Modify Task";
        CreatTaskVC.SavebtnTitlestr           = @"Update";
        CreatTaskVC.locationUseBool           = YES;
        CreatTaskVC.Descriptionstr  =[DescriptionArray objectAtIndex:indexPath.row];
        CreatTaskVC.Effortstr       =[TaskEffortArray objectAtIndex:indexPath.row];
        CreatTaskVC.EndDatestr      =[EndDateArray objectAtIndex:indexPath.row];
        CreatTaskVC.StartDatestr    =[StartDateArray objectAtIndex:indexPath.row];
        CreatTaskVC.UpDTaskId       =[TaskIdArray objectAtIndex:indexPath.row];
        CreatTaskVC.categorynamestr =[CatogeryArray objectAtIndex:indexPath.row];
        CreatTaskVC.Projectnamestr  = [ProjectNamearray objectAtIndex:indexPath.row];
        CreatTaskVC.Resourcenamestr =[ResourceNameArray objectAtIndex:indexPath.row];
        
        CreatTaskVC.Prioritynamestr  =[PriortyArray objectAtIndex:indexPath.row];
        CreatTaskVC.hardDependencystr=[hardDependencyArray objectAtIndex:indexPath.row];
        CreatTaskVC.hoursPerdayStr=[hoursPerDayArray objectAtIndex:indexPath.row];
        [CreatTaskVC.datePickerBtn setEnabled:NO];
        NSLog(@"task is %@",taskidstr);
        [self.navigationController pushViewController:CreatTaskVC animated:YES];
    }

    
}
//filter for expired tasks
-(IBAction)filterBtnClicked:(id)sender
{
    [ExpiredTaskPickerView removeFromSuperview];
    ExpiredTaskPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-210,100, 150,200)];
    [ExpiredTaskPickerView setShowsSelectionIndicator:YES];
    ExpiredTaskPickerView.delegate = self;
    ExpiredTaskPickerView.dataSource = self;
    ExpiredTaskPickerView.tag = 102;
    ExpiredTaskPickerView.backgroundColor=[UIColor grayColor];
    
    //  [self.view endEditing:YES];
    //[Serchbar setShowsCancelButton:NO animated:YES];
    [self.view addSubview:ExpiredTaskPickerView];
    //NSLog(@"welcome tp searchbar");
}
//filter for task priority based and assigned to and created by search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar==Serchbar)
    {
        [Serchbar resignFirstResponder];
        //Serchbar.userInteractionEnabled=NO;
        [PrirotyPickerview removeFromSuperview];
        PrirotyPickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(20,130, self.view.frame.size.width-40,250)];
        [PrirotyPickerview setShowsSelectionIndicator:YES];
        PrirotyPickerview.delegate = self;
        PrirotyPickerview.dataSource = self;
        PrirotyPickerview.tag = 100;
        PrirotyPickerview.backgroundColor=[UIColor grayColor];
        [tempArray2 removeAllObjects];
        [self.view endEditing:YES];
        //[Serchbar setShowsCancelButton:NO animated:YES];
        [self.view addSubview:PrirotyPickerview];
        NSLog(@"welcome tp searchbar");
    }
    else
    {
        [searchBar1 resignFirstResponder];
        searchBar1.userInteractionEnabled=NO;
        [ResourcePickerview removeFromSuperview];
        ResourcePickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(250,110,200,250)];
        [ResourcePickerview setShowsSelectionIndicator:YES];
        ResourcePickerview.delegate = self;
        ResourcePickerview.dataSource = self;
        ResourcePickerview.tag = 101;
        ResourcePickerview.backgroundColor=[UIColor grayColor];
        searchBar1.userInteractionEnabled=NO;
        searchBar1.delegate=self;
        [searchBar1 resignFirstResponder];
        [self.view endEditing:YES];
        [self.view addSubview:ResourcePickerview];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar==Serchbar)
    {
        [Serchbar resignFirstResponder];
        //[self.view endEditing:YES];
    }
    if (searchBar==searchBar1)
    {
        [searchBar1 resignFirstResponder];
        
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if(searchBar==Serchbar)
    {
        [Serchbar resignFirstResponder];
    }
    if(searchBar==searchBar1)
    {
        [searchBar1 resignFirstResponder];
    }

    return NO;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (searchBar==Serchbar)
    {
        [Serchbar resignFirstResponder];
        [self.view endEditing:YES];
    }
    if (searchBar==searchBar1)
    {
        [searchBar1 resignFirstResponder];
       
    }

}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
//{
//    
//}
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchTerm
{
   
    if (searchBar==Serchbar)
    {
        [Serchbar resignFirstResponder];
        
        
        [PrirotyPickerview removeFromSuperview];
        PrirotyPickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(10,130, self.view.frame.size.width-420, 300)];
        [PrirotyPickerview setShowsSelectionIndicator:YES];
        PrirotyPickerview.delegate = self;
        PrirotyPickerview.dataSource = self;
        PrirotyPickerview.tag = 100;
        PrirotyPickerview.backgroundColor=[UIColor grayColor];
        [self.view addSubview:PrirotyPickerview];
        Serchbar.delegate=self;
       // [Serchbar resignFirstResponder];
        [self.view endEditing:YES];
        searchBar1.text=@"All";
        return;
    
    }
    else
    {
        [ResourcePickerview removeFromSuperview];
        ResourcePickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(searchBar.frame.size.width+160,100, 200, 300)];
        [ResourcePickerview setShowsSelectionIndicator:YES];
        ResourcePickerview.delegate = self;
        ResourcePickerview.dataSource = self;
        ResourcePickerview.tag = 101;
        ResourcePickerview.backgroundColor=[UIColor grayColor];
        [self.view addSubview:ResourcePickerview];
        Serchbar.delegate=self;
        [searchBar1 resignFirstResponder];
         [self.view endEditing:YES];
         return;

        
        
    }
    
    
}

- (void)search
{
        [B removeAllObjects];
    //[equalTempArray1 removeAllObjects];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",Serchbar.text];
        sercharray=(NSMutableArray*)[refarray1 filteredArrayUsingPredicate:predicate];
        NSLog(@"search text is %@",Serchbar.text);
        NSLog(@"habgfhfhfh %@",sercharray);
        if ([sercharray count] > 0)
        {
            [B addObjectsFromArray:sercharray];
            A=B;
            
            NSLog(@"a is %@",B);
            
             NSLog(@"%d",[A count]);
            
        }
        
        [TaskListTV reloadData];
    
}
//-(void)search1
//{
//    if ([searchBar1.text isEqualToString:@"Created By"])
//    {
//       [C removeAllObjects];
//       NSLog(@"welcome to eis");
//    NSLog(@"ref array 3 is %@",refarray3);
//       
//       //NSLog(@"task created array is %@",C);
//       
//       NSPredicate *pedicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",Useridstr];
//       searcharray1=(NSMutableArray *)[refarray3 filteredArrayUsingPredicate:pedicate];
//       
//       if ([searcharray1 count]>0)
//       {
//           [D addObjectsFromArray:searcharray1];
//           C=D;
//           //[equalTempArray addObjectsFromArray:C];
//       }
//       NSLog(@"task created search array is %@",C);
//       NSLog(@"cout is %d",C.count);
//        [ResourcePickerview removeFromSuperview];
//        [TaskListTV reloadData];
//        
//    }
//  if ([searchBar1.text isEqualToString:@"Assigned To"])
//    {
//        [E removeAllObjects];
//        NSLog(@"welcome to eis sheik1223");
//        NSLog(@"ref array 3 is %@",refarray4);
//        
//        
//        NSPredicate *pedicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",Usernamestr];
//        searcharray2=(NSMutableArray *)[refarray4 filteredArrayUsingPredicate:pedicate];
//        
//        if ([searcharray2 count]>0)
//        {
//            [F addObjectsFromArray:searcharray2];
//            E=F;
//           
//        }
//        NSLog(@"task asigned to search array is %@",E);
//        NSLog(@"cout is %d",E.count);
//        [ResourcePickerview removeFromSuperview];
//        [TaskListTV reloadData];
//
//    }
//    
//}
-(void)didFinishData:(id)Data
{
    TaskListXmlParser = [[NSXMLParser alloc]initWithData:Data];
    TaskListXmlParser.delegate = self;
    [TaskListXmlParser parse];
}
-(void)CreatTaskTapped
{
    CreatTaskVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatTaskVC"];
    CreatTaskVC.navigationTitlestr = @"Create New Task";
    CreatTaskVC.SavebtnTitlestr = @"Save";
    CreatTaskVC.locationUseBool = NO;
    [self.navigationController pushViewController:CreatTaskVC animated:YES];
    
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
        else
        {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    if (pickerView==PrirotyPickerview)
    {
         return 1;
    }
    else if(pickerView==ResourcePickerview)
    {
        return 1;
    }
    else
    {
        return 1;
    }
   
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker==PrirotyPickerview)
    {
        return [uniqueDescriptionArray count];
    }
    else if(picker==ResourcePickerview)
    {
        return [searchFieldArray1 count];
    }
    else
    {
        return [FilterArray count];
    }
    
    
}
-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker==PrirotyPickerview)
    {
        return [uniqueDescriptionArray objectAtIndex:row];
    }
    else if(picker==ResourcePickerview)
    {
        return [searchFieldArray1 objectAtIndex:row];
    }
    else
    {
      return  [FilterArray objectAtIndex:row];
    }
   
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
 
if (pickerView==PrirotyPickerview)
    {
        [tempArray2 removeAllObjects];
         [tempArray1 removeAllObjects];
        [tempArray3 removeAllObjects];
        
        [tempArray4 removeAllObjects];
        
        [tempArray5 removeAllObjects];
        
        [tempArray6 removeAllObjects];
        
        [tempArray7 removeAllObjects];
        
        [tempArray15 removeAllObjects];
        
        [tempArray16 removeAllObjects];
        [tempArray17 removeAllObjects];
        [categorySearchArray1 removeAllObjects];
        [projectNameArray1 removeAllObjects];
        [hardDependencyArray1 removeAllObjects];
        [hoursPerDay1 removeAllObjects];
        [tempStatusArray removeAllObjects];

        
        Serchbar.text=[uniqueDescriptionArray objectAtIndex:row];
        Expirelabel.text=@"All";
        [self search];
        for (int i=0;i<[PriortyArray count];i++)
        {
            if([Serchbar.text isEqualToString:[PriortyArray objectAtIndex:i]])
            {
                
                NSLog(@"asdfffff");
               // NSLog(@"task created  by array is %@",PriortyArray);
                
                [tempArray1 addObject:[PriortyArray objectAtIndex:i]];
                [tempArray2 addObject:[DescriptionArray objectAtIndex:i]];
                [tempArray3 addObject:[StartDateArray objectAtIndex:i]];
                [tempArray4 addObject:[EndDateArray objectAtIndex:i]];
                [tempArray5 addObject:[TaskEffortArray objectAtIndex:i]];
                [tempArray6 addObject:[taskAssignedArray objectAtIndex:i]];
                [tempArray7 addObject:[ResourceNameArray objectAtIndex:i]];
                [tempArray15 addObject:[TaskAssgndByIdArray objectAtIndex:i]];
                [tempArray16 addObject:[taskCreatedByArray objectAtIndex:i]];
                [tempArray17 addObject:[TaskIdArray objectAtIndex:i]];
                [categorySearchArray1 addObject:[CatogeryArray objectAtIndex:i]];
                [projectNameArray1 addObject:[ProjectNamearray objectAtIndex:i]];
                [hardDependencyArray1 addObject:[hardDependencyArray objectAtIndex:i]];
                [hoursPerDay1 addObject:[hoursPerDayArray objectAtIndex:i]];
                [tempStatusArray addObject:[taskStatusArray objectAtIndex:i]];
                
            

            }
            
            
        }
        
//        
//        NSLog(@"temp array2 %@",tempArray2);
//        NSLog(@"start date is 123%@",tempArray3);
//        NSLog(@"temp array2 %@",tempArray15);
//        NSLog(@"start date is 123%@",tempArray16);
//        NSLog(@"temp array 1 %@",tempArray1);
//        NSLog(@"status array is %@",tempStatusArray);
        [PrirotyPickerview removeFromSuperview];
        NSLog(@"temp array %@",C);
       
  }
    if (pickerView==ResourcePickerview)
    {
        [dessearchArray removeAllObjects];
        [startDateSearchArray removeAllObjects];
        [enddateSearchArray removeAllObjects];
        
        [effortSearchArray removeAllObjects];
        
        [AssignedToSearchArray removeAllObjects];
        
        [createdBySearchArray removeAllObjects];
        
        [prioritySearchArray removeAllObjects];
        
        [dessearchArray1 removeAllObjects];
        [startdatesearchArray1 removeAllObjects];
        [enddatesearchArray1 removeAllObjects];
        
        [effortsearchArray1 removeAllObjects];
        
        [assignedsearchArray1 removeAllObjects];
        
        [createdbysearchArray1 removeAllObjects];
        
        [prioritysearchArray1 removeAllObjects];
        [taskStatusSearchArray removeAllObjects];

        
        //[tempArray15 removeAllObjects];
        
        
        searchBar1.text=[searchFieldArray1 objectAtIndex:row];
        Expirelabel.text=@"All";
        
        if ([searchBar1.text isEqualToString:@"All"])
        {
            //[self TasksHPList];
            [ResourcePickerview removeFromSuperview];
            [TaskListTV reloadData];
        }
      if([searchBar1.text isEqualToString:@"Created By"])
        {
            for(int i=0; i<[TaskAssgndByIdArray count];i++)
            {
                if ([Useridstr isEqualToString:[TaskAssgndByIdArray objectAtIndex:i]])
                {
                    [dessearchArray addObject:[DescriptionArray objectAtIndex:i]];
                    [startDateSearchArray addObject:[StartDateArray objectAtIndex:i]];
                    [enddateSearchArray addObject:[EndDateArray objectAtIndex:i]];
                    [effortSearchArray addObject:[TaskEffortArray objectAtIndex:i]];
                    [AssignedToSearchArray addObject:[taskAssignedArray objectAtIndex:i]];
                    [createdBySearchArray addObject:[ResourceNameArray objectAtIndex:i]];
                    [prioritySearchArray addObject:[PriortyArray objectAtIndex:i]];
                    [taskIdSearchArray addObject:[TaskIdArray objectAtIndex:i]];
                    [taskProjectNameSearchArray addObject:[ProjectNamearray objectAtIndex:i]];
                    [taskHarddependencySearchArray addObject:[hardDependencyArray objectAtIndex:i]];
                    [taskHoursperdaySearchArray addObject:[hoursPerDayArray objectAtIndex:i]];
                    [taskCategorySearchArray addObject:[CatogeryArray objectAtIndex:i]];
                    [taskStatusSearchArray addObject:[taskStatusArray objectAtIndex:i]];
                    [taskAssignedByIdSearchArray addObject:[TaskAssgndByIdArray objectAtIndex:i]];
                    [taskCreatedByArraySearch addObject:[taskCreatedByArray objectAtIndex:i]];
                    
                    [ExpiredTaskPickerView removeFromSuperview];
                }
                [TaskListTV reloadData];

            }
            
            [ResourcePickerview removeFromSuperview];
//            NSLog(@"description array is %@",dessearchArray);
//            NSLog(@"start date array is %@",startDateSearchArray);
//            NSLog(@"end date array is %@",enddateSearchArray);
//            NSLog(@"effort  array is %@",effortSearchArray);
//            NSLog(@"assigned to array is %@",AssignedToSearchArray);
//            NSLog(@"created by array is %@",createdBySearchArray);
//            NSLog(@"priority array is %@",prioritySearchArray);
        
            for (int i=0; i<[tempArray15 count];i++)
            {
                if ([Useridstr isEqualToString:[tempArray15 objectAtIndex:i]])
                {
                    [dessearchArray1 addObject:[tempArray2 objectAtIndex:i]];
                    [startdatesearchArray1 addObject:[tempArray3 objectAtIndex:i]];
                    [enddatesearchArray1 addObject:[tempArray4 objectAtIndex:i]];
                    [effortsearchArray1 addObject:[tempArray5 objectAtIndex:i]];
                    [assignedsearchArray1 addObject:[tempArray6 objectAtIndex:i]];
                    [createdbysearchArray1 addObject:[tempArray7 objectAtIndex:i]];
                    [prioritysearchArray1 addObject:[tempArray1 objectAtIndex:i]];
                    [taskIdSearchArray1 addObject:[tempArray17 objectAtIndex:i]];
                    [taskProjectNameSearchArray1 addObject:[projectNameArray1 objectAtIndex:i]];
                    [taskCategorySearchArray1 addObject:[categorySearchArray1 objectAtIndex:i]];
                    [taskHardDependencySearchArray1 addObject:[hardDependencyArray1 objectAtIndex:i]];
                    [taskHoursPerdaySearchArray1 addObject:[hoursPerDay1 objectAtIndex:i]];
                    [taskStatusSearchArray1 addObject:[tempStatusArray objectAtIndex:i]];
                    [ExpiredTaskPickerView removeFromSuperview];

                    
                }
            }
            [TaskListTV reloadData];
//             NSLog(@"description array is1245 %@",dessearchArray1);
//            NSLog(@"start date array is %@",startdatesearchArray1);
//            NSLog(@"end date array is %@",enddatesearchArray1);
//            NSLog(@"effort  array is %@",effortsearchArray1);
//            NSLog(@"assigned to array is %@",assignedsearchArray1);
//            NSLog(@"created by array is %@",createdbysearchArray1);
//            NSLog(@"priority array is %@",prioritysearchArray1);
        }
        
     if([searchBar1.text isEqualToString:@"Assigned To"])
          {
              NSLog(@"Resource name array is %@",TaskAssgndByIdArray);
            for (int i=0;i<[taskCreatedByArray count];i++)
               {
                    if ([Useridstr isEqualToString:[taskCreatedByArray objectAtIndex:i]])
                    {
                        [dessearchArray addObject:[DescriptionArray objectAtIndex:i]];
                        [startDateSearchArray addObject:[StartDateArray objectAtIndex:i]];
                        [enddateSearchArray addObject:[EndDateArray objectAtIndex:i]];
                        [effortSearchArray addObject:[TaskEffortArray objectAtIndex:i]];
                        [AssignedToSearchArray addObject:[taskAssignedArray objectAtIndex:i]];
                        [createdBySearchArray addObject:[ResourceNameArray objectAtIndex:i]];
                        [prioritySearchArray addObject:[PriortyArray objectAtIndex:i]];
                        [taskIdSearchArray addObject:[TaskIdArray objectAtIndex:i]];
                        [taskProjectNameSearchArray addObject:[ProjectNamearray objectAtIndex:i]];
                        [taskHarddependencySearchArray addObject:[hardDependencyArray objectAtIndex:i]];
                        [taskHoursperdaySearchArray addObject:[hoursPerDayArray objectAtIndex:i]];
                        [taskCategorySearchArray addObject:[CatogeryArray objectAtIndex:i]];
                        [taskStatusSearchArray addObject:[taskStatusArray objectAtIndex:i]];
                        
                        [ExpiredTaskPickerView removeFromSuperview];

                       [ResourcePickerview removeFromSuperview];
                  }
                  

                }
               [TaskListTV reloadData];
          
        
              for (int i=0; i<[tempArray16 count];i++)
              {
                  if ([Useridstr isEqualToString:[tempArray16 objectAtIndex:i]])
                  {
                      [dessearchArray1 addObject:[tempArray2 objectAtIndex:i]];
                      [startdatesearchArray1 addObject:[tempArray3 objectAtIndex:i]];
                      [enddatesearchArray1 addObject:[tempArray4 objectAtIndex:i]];
                      [effortsearchArray1 addObject:[tempArray5 objectAtIndex:i]];
                      [assignedsearchArray1 addObject:[tempArray6 objectAtIndex:i]];
                      [createdbysearchArray1 addObject:[tempArray7 objectAtIndex:i]];
                      [prioritysearchArray1 addObject:[tempArray1 objectAtIndex:i]];
                      [taskIdSearchArray1 addObject:[tempArray17 objectAtIndex:i]];
                      [taskProjectNameSearchArray1 addObject:[projectNameArray1 objectAtIndex:i]];
                      [taskCategorySearchArray1 addObject:[categorySearchArray1 objectAtIndex:i]];
                      [taskHardDependencySearchArray1 addObject:[hardDependencyArray1 objectAtIndex:i]];
                      [taskHoursPerdaySearchArray1 addObject:[hoursPerDay1 objectAtIndex:i]];
                      [taskStatusSearchArray1 addObject:[tempStatusArray objectAtIndex:i]];
                      [ResourcePickerview removeFromSuperview];
                  }
                  
              }
                 [TaskListTV reloadData];

               [ResourcePickerview removeFromSuperview];
                NSLog(@"Hello %@",tempArray15);
             
              
            }
        else
        {
             [TaskListTV reloadData];
            
            [ResourcePickerview removeFromSuperview];
            [ExpiredTaskPickerView removeFromSuperview];
           
            
        }

//        for (int i=0; i<[tempArray7 count];i++)
//        {
//            if ([use isEqualToString:[tempArray7 objectAtIndex:i]])
//            {
//                [dessearchArray1 addObject:[tempArray2 objectAtIndex:i]];
//                [startdatesearchArray1 addObject:[tempArray3 objectAtIndex:i]];
//                [enddatesearchArray1 addObject:[tempArray4 objectAtIndex:i]];
//                [effortsearchArray1 addObject:[tempArray5 objectAtIndex:i]];
//                [assignedsearchArray1 addObject:[tempArray6 objectAtIndex:i]];
//                [createdbysearchArray1 addObject:[tempArray7 objectAtIndex:i]];
//                [prioritysearchArray1 addObject:[tempArray1 objectAtIndex:i]];
//            }
//        }
     //[TaskListTV reloadData];
       
    }
    
    if (pickerView==ExpiredTaskPickerView)
    {
        [expireStatusArray removeAllObjects];
        [expireResourceArray removeAllObjects];
        [expireAssignedArray removeAllObjects];
        
        [expireTaskPriorityArray removeAllObjects];
        
        [expireTaskEffortArray removeAllObjects];
        
        [expireEndDateArray removeAllObjects];
        
        [expireStartDateArray removeAllObjects];
        
        [expireTaskDescriptionArray removeAllObjects];
        
        [expireCategoryArray removeAllObjects];
        [expireProjectNameArray removeAllObjects];
        [expireTaskIdArray removeAllObjects];
        [expireAssogmedByIdArray removeAllObjects];
        [expireHarddependencyArray removeAllObjects];
        [expireHoursPerDayArray removeAllObjects];
        [expireCreatedBySearchArray removeAllObjects];
        
        
        [expireStatusArraySearch removeAllObjects];
        [expireResourceArraySearch removeAllObjects];
        [expireAssignedArraySearch removeAllObjects];
        
        [expireTaskPriorityArraySearch removeAllObjects];
        
        [expireTaskEffortArraySearch removeAllObjects];
        
        [expireEndDateArraySearch removeAllObjects];
        
        [expireStartDateArraySearch removeAllObjects];
        
        [expireTaskDescriptionArraySearch removeAllObjects];
        
        [expireCategoryArraySearch removeAllObjects];
        [expireProjectNameArraySearch removeAllObjects];
        [expireTaskIdArraySearch removeAllObjects];
        [expireAssogmedByIdArraySearch removeAllObjects];
        [expireHarddependencyArraySearch removeAllObjects];
        [expireHoursPerDayArraySearch removeAllObjects];
        [expireCreatedBySearchArray1 removeAllObjects];
        
        [expireStatusArraySearch1 removeAllObjects];
        [expireResourceArraySearch1 removeAllObjects];
        [expireAssignedArraySearch1 removeAllObjects];
        
        [expireTaskPriorityArraySearch1 removeAllObjects];
        
        [expireTaskEffortArraySearch1 removeAllObjects];
        
        [expireEndDateArraySearch1 removeAllObjects];
        
        [expireStartDateArraySearch1 removeAllObjects];
        
        [expireTaskDescriptionArraySearch1 removeAllObjects];
        
        [expireCategoryArraySearch1 removeAllObjects];
        [expireProjectNameArraySearch1 removeAllObjects];
        [expireTaskIdArraySearch1 removeAllObjects];
        [expireAssogmedByIdArraySearch1 removeAllObjects];
        [expireHarddependencyArraySearch1 removeAllObjects];
        [expireHoursPerDayArraySearch1 removeAllObjects];
        [expireCreatedBySearchArray2 removeAllObjects];
        

        


        
       Expirelabel=[[UILabel alloc]init];
        Expirelabel.text=[FilterArray objectAtIndex:row];
        NSLog(@"label text is %@",Expirelabel.text);
        [ExpiredTaskPickerView removeFromSuperview];
        
        for (int i=0; i<[tempStatusArray count];i++)
        {
            
           
                if (![Serchbar.text isEqualToString:@"PriorityAll"])
                {
                    if ([Expirelabel.text isEqualToString:[tempStatusArray objectAtIndex:i]] )
                    {
                [expireTaskPriorityArray addObject:[tempArray1 objectAtIndex:i]];
                [expireTaskDescriptionArray addObject:[tempArray2 objectAtIndex:i]];
              
                [expireStartDateArray addObject:[tempArray3 objectAtIndex:i]];
                
                    [expireEndDateArray addObject:[tempArray4 objectAtIndex:i]];
                    [expireTaskEffortArray addObject:[tempArray5 objectAtIndex:i]];
                    [expireAssignedArray addObject:[tempArray6 objectAtIndex:i]];
                    [expireResourceArray addObject:[tempArray7 objectAtIndex:i]];
                    [expireAssogmedByIdArray addObject:[tempArray15 objectAtIndex:i]];
                    [expireCreatedBySearchArray addObject:[tempArray16 objectAtIndex:i]];
                    [expireTaskIdArray addObject:[tempArray17 objectAtIndex:i]];
                    [expireCategoryArray addObject:[CatogeryArray objectAtIndex:i]];
                    [expireProjectNameArray addObject:[ProjectNamearray objectAtIndex:i]];
                    [expireHarddependencyArray addObject:[hardDependencyArray objectAtIndex:i]];
                    [expireHoursPerDayArray addObject:[hoursPerDayArray objectAtIndex:i]];
                    [expireStatusArray addObject:[tempStatusArray objectAtIndex:i]];


                [ExpiredTaskPickerView removeFromSuperview];
            }
             
        }
           [TaskListTV reloadData];
    }
    
    
//        NSLog(@"priority array is %@",expireTaskPriorityArray);
//        NSLog(@"expire task description array is %@",expireTaskDescriptionArray);
//        NSLog(@"priority array is %@",expireStatusArray);
//        NSLog(@"expire task description array is %@",expireHoursPerDayArray);
//        NSLog(@"priority array is %@",expireHarddependencyArray);
//        NSLog(@"expire task description array is %@",expireProjectNameArray);
//        NSLog(@"priority array is %@",expireCategoryArray);
//        NSLog(@"expire task description array is %@",expireTaskIdArray);
//        NSLog(@"priority array is %@",expireAssogmedByIdArray);
//        NSLog(@"expire task description array is %@",expireAssignedArray);
//        NSLog(@"priority array is %@",expireProjectNameArray);
//        NSLog(@"expire task description array is %@",expireResourceArray);
//        NSLog(@"priority array is %@",expireTaskEffortArray);
//        NSLog(@"expire task description array is %@",expireStartDateArray);
//        NSLog(@"expire task description array is %@",expireEndDateArray);
//        
        if ([searchBar1.text isEqualToString:@"All"])
        {
            //[self TasksHPList];
            [ResourcePickerview removeFromSuperview];
            [TaskListTV reloadData];
        }

        if ([searchBar1.text isEqualToString:@"Created By"])
        {
       
            for (int i=0; i<[taskStatusSearchArray count];i++)
           {
                 if ([Expirelabel.text isEqualToString:[taskStatusSearchArray objectAtIndex:i]])
                   {
               
                    [expireTaskPriorityArraySearch addObject:[prioritySearchArray objectAtIndex:i]];
                    [expireTaskDescriptionArraySearch addObject:[dessearchArray objectAtIndex:i]];
                    
                    [expireStartDateArraySearch addObject:[startDateSearchArray objectAtIndex:i]];
                    
                    [expireEndDateArraySearch addObject:[enddateSearchArray objectAtIndex:i]];
                    [expireTaskEffortArraySearch addObject:[effortSearchArray objectAtIndex:i]];
                    [expireAssignedArraySearch addObject:[AssignedToSearchArray objectAtIndex:i]];
                    [expireResourceArraySearch addObject:[createdBySearchArray objectAtIndex:i]];
                    [expireAssogmedByIdArraySearch addObject:[taskAssignedByIdSearchArray objectAtIndex:i]];
                    [expireCreatedBySearchArray1 addObject:[createdBySearchArray objectAtIndex:i]];
                    [expireTaskIdArraySearch addObject:[taskIdSearchArray objectAtIndex:i]];
                    [expireCategoryArraySearch addObject:[taskCategorySearchArray objectAtIndex:i]];
                    [expireProjectNameArraySearch addObject:[taskProjectNameSearchArray objectAtIndex:i]];
                    [expireHarddependencyArraySearch addObject:[taskHarddependencySearchArray objectAtIndex:i]];
                    [expireHoursPerDayArraySearch addObject:[taskHoursperdaySearchArray objectAtIndex:i]];
                    [expireStatusArraySearch addObject:[taskStatusSearchArray objectAtIndex:i]];
                    
                    
                    [ExpiredTaskPickerView removeFromSuperview];

                }
            }
        
         [TaskListTV reloadData];
        
        for (int i=0; i<[taskStatusSearchArray1 count];i++)
        {
            if ([Expirelabel.text isEqualToString:[taskStatusSearchArray1 objectAtIndex:i]])
            {
                [expireTaskDescriptionArraySearch1 addObject:[dessearchArray1 objectAtIndex:i]];
                [expireStartDateArraySearch1 addObject:[startdatesearchArray1 objectAtIndex:i]];
                [expireEndDateArraySearch1 addObject:[enddatesearchArray1 objectAtIndex:i]];
                [expireTaskEffortArraySearch1 addObject:[effortsearchArray1 objectAtIndex:i]];
                [expireAssignedArraySearch1 addObject:[assignedsearchArray1 objectAtIndex:i]];
                [expireCreatedBySearchArray2 addObject:[createdbysearchArray1 objectAtIndex:i]];
                [expireTaskPriorityArraySearch1 addObject:[prioritysearchArray1 objectAtIndex:i]];
                [expireTaskIdArraySearch1 addObject:[taskIdSearchArray1 objectAtIndex:i]];
                [expireProjectNameArraySearch1 addObject:[taskProjectNameSearchArray1 objectAtIndex:i]];
                [expireCategoryArraySearch1 addObject:[taskCategorySearchArray1 objectAtIndex:i]];
                [expireHarddependencyArraySearch1 addObject:[taskHardDependencySearchArray1 objectAtIndex:i]];
                [expireHoursPerDayArraySearch1 addObject:[taskHoursPerdaySearchArray1 objectAtIndex:i]];
                [expireStatusArraySearch1 addObject:[taskStatusSearchArray1 objectAtIndex:i]];
                
            }
                    }
            [TaskListTV reloadData];
 
    }
      else if ([searchBar1.text isEqualToString:@"Assigned To"])
        {
            for (int i=0; i<[taskStatusSearchArray count]; i++)
            {
                if ([Expirelabel.text isEqualToString:[taskStatusSearchArray objectAtIndex:i]])
                {
                    
                    [expireTaskPriorityArray addObject:[prioritySearchArray objectAtIndex:i]];
                    [expireTaskDescriptionArray addObject:[dessearchArray objectAtIndex:i]];
                    
                    [expireStartDateArray addObject:[startDateSearchArray objectAtIndex:i]];
                    
                    [expireEndDateArraySearch addObject:[enddateSearchArray objectAtIndex:i]];
                    [expireTaskEffortArraySearch addObject:[effortSearchArray objectAtIndex:i]];
                    [expireAssignedArraySearch addObject:[AssignedToSearchArray objectAtIndex:i]];
                    [expireResourceArraySearch addObject:[CreatedBySearchArray objectAtIndex:i]];
                    [expireAssogmedByIdArraySearch addObject:[taskAssignedByIdSearchArray objectAtIndex:i]];
                    [expireCreatedBySearchArray1 addObject:[createdBySearchArray objectAtIndex:i]];
                    [expireTaskIdArraySearch addObject:[taskIdSearchArray objectAtIndex:i]];
                    [expireCategoryArraySearch addObject:[taskCategorySearchArray objectAtIndex:i]];
                    [expireProjectNameArraySearch addObject:[taskProjectNameSearchArray objectAtIndex:i]];
                    [expireHarddependencyArraySearch addObject:[taskHarddependencySearchArray objectAtIndex:i]];
                    [expireHoursPerDayArraySearch addObject:[taskHoursperdaySearchArray objectAtIndex:i]];
                    [expireStatusArraySearch addObject:[tempStatusArray objectAtIndex:i]];
                    
                    
                    [ExpiredTaskPickerView removeFromSuperview];
                    
                }
            }
            
            [TaskListTV reloadData];
            
            for (int i=0; i<[taskStatusSearchArray1 count];i++)
            {
                if ([Expirelabel.text isEqualToString:[taskStatusSearchArray1 objectAtIndex:i]])
                {
                    [expireTaskDescriptionArraySearch1 addObject:[dessearchArray1 objectAtIndex:i]];
                    [expireStartDateArraySearch1 addObject:[startdatesearchArray1 objectAtIndex:i]];
                    [expireEndDateArraySearch1 addObject:[enddatesearchArray1 objectAtIndex:i]];
                    [expireTaskEffortArraySearch1 addObject:[effortsearchArray1 objectAtIndex:i]];
                    [expireAssignedArraySearch1 addObject:[assignedsearchArray1 objectAtIndex:i]];
                    [expireCreatedBySearchArray2 addObject:[createdbysearchArray1 objectAtIndex:i]];
                    [expireTaskPriorityArraySearch1 addObject:[prioritysearchArray1 objectAtIndex:i]];
                    [expireTaskIdArraySearch1 addObject:[taskIdSearchArray1 objectAtIndex:i]];
                    [expireProjectNameArraySearch1 addObject:[taskProjectNameSearchArray1 objectAtIndex:i]];
                    [expireCategoryArraySearch1 addObject:[taskCategorySearchArray1 objectAtIndex:i]];
                    [expireHarddependencyArraySearch1 addObject:[taskHardDependencySearchArray1 objectAtIndex:i]];
                    [expireHoursPerDayArraySearch1 addObject:[taskHoursPerdaySearchArray1 objectAtIndex:i]];
                    [expireStatusArraySearch1 addObject:[taskStatusSearchArray1 objectAtIndex:i]];
                    
                }
            }
            [TaskListTV reloadData];
        }
        else
        {
            for (int i=0; i<[taskStatusArray count]; i++)
            {
                if ([Expirelabel.text isEqualToString:[taskStatusArray objectAtIndex:i]])
                {
                    [expireTaskDescriptionArraySearch2 addObject:[DescriptionArray objectAtIndex:i]];
                    [expireStartDateArraySearch2 addObject:[StartDateArray objectAtIndex:i]];
                    [expireEndDateArraySearch2 addObject:[EndDateArray objectAtIndex:i]];
                    [expireTaskEffortArraySearch2 addObject:[TaskEffortArray objectAtIndex:i]];
                    [expireAssignedArraySearch2 addObject:[ResourceNameArray objectAtIndex:i]];
                    [expireCreatedBySearchArray3 addObject:[taskAssignedArray objectAtIndex:i]];
                    [expireTaskPriorityArraySearch2 addObject:[PriortyArray objectAtIndex:i]];
                    [expireTaskIdArraySearch2 addObject:[TaskIdArray objectAtIndex:i]];
                    [expireProjectNameArraySearch2 addObject:[ProjectNamearray objectAtIndex:i]];
                    [expireCategoryArraySearch2 addObject:[CatogeryArray objectAtIndex:i]];
                    [expireHarddependencyArraySearch2 addObject:[hardDependencyArray objectAtIndex:i]];
                    [expireHoursPerDayArraySearch2 addObject:[hoursPerDayArray objectAtIndex:i]];
                    [expireStatusArraySearch2 addObject:[taskStatusArray objectAtIndex:i]];
                }
            }
            [TaskListTV reloadData];
//            NSLog(@"description array is1245 %@",expireTaskDescriptionArraySearch2);
//            NSLog(@"start date array is %@",expireStatusArraySearch2);
//            NSLog(@"end date array is %@",expireEndDateArraySearch2);
//            NSLog(@"effort  array is %@",expireTaskEffortArraySearch2);
//            

        }


    }
    [TaskListTV reloadData];
}


-(void)AudioBtnTapped
{
    AudioVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"AudioVC"];
    AudioVC.TaskIdstr = taskidstr;
    [self.navigationController pushViewController:AudioVC animated:YES];
    
}
-(void)VideoBtnTapped
{
    VideoVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoVC"];
    VideoVC.TaskIdstr = taskidstr;
    [self.navigationController pushViewController:VideoVC animated:YES];
}
-(void)TextUploadbtnTapped
{
    TextVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"TextUpload"];
    TextVC.taskIdstr =taskidstr;
    NSLog(@"Task id %@",TextVC.taskIdstr);
    [self.navigationController pushViewController:TextVC animated:YES];
}
-(void)FileUploadbtnTapped
{
    FileVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"FileVC"];
    FileVC.Taskidstr =taskidstr;
    NSLog(@"Task id %@",TextVC.taskIdstr);
    [self.navigationController pushViewController:FileVC animated:YES];
}

-(void)DoneButtonTapped
{
    [self LoadINFO];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [TaskListTV reloadData];
    [Serchbar resignFirstResponder];
    [self.view endEditing:YES];
    [searchBar1 resignFirstResponder];
    [PrirotyPickerview removeFromSuperview];
    [ResourcePickerview removeFromSuperview];
    Serchbar.text=@"PriorityAll";
    searchBar1.text=@"All";
        [self viewDidLoad];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
    
}
-(void)gestureclicked
{
    [PrirotyPickerview removeFromSuperview];
    [ResourcePickerview removeFromSuperview];
}

@end
