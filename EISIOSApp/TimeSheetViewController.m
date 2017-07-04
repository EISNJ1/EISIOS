//
//  TimeSheetViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "TimeSheetViewController.h"

@interface TimeSheetViewController ()

@end

@implementation TimeSheetViewController

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
    
        
    
    loans = [[NSMutableArray alloc]init];
   
    if ([loans count] == 0)
    {
    
        
    }
    
    

    //-------------------Right side pop Button---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];
    
    //-------------------service parameters data------------------//
   // [self DatafromDB];

    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Useridstr   = [defaults objectForKey:@"UserId"];
    Usernamestr = [defaults objectForKey:@"UserName"];
   Usertypestr = [defaults objectForKey:@"UserType"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    
    NSLog(@"user type %@",Usertypestr);
    NSLog(@"user id %@",Useridstr);

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
    [EvaluateBtn setTitle:@"Submit TimeSheet" forState:UIControlStateNormal];
    EvaluateBtn.tag= 102;
    //[Chequebtn setBackgroundColor:[UIColor grayColor]];
    [EvaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    EvaluateBtn.frame=CGRectMake(20, 10, 150, 40);
    [EvaluateBtn addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchDown];
    // [contentViewController.view addSubview:Chequebtn];
    [view1 addSubview:EvaluateBtn];
    
    
    UIButton * statusBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [statusBtn setTitle:@"Status" forState:UIControlStateNormal];
    [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    statusBtn.tag = 101;
    statusBtn.frame=CGRectMake(20, 60, 60, 40);
    [statusBtn addTarget:self action:@selector(status) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:statusBtn];
    
    
    [popController presentPopoverFromBarButtonItem:createTimeSheetActionBarBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)Submit
{
    
    [popController dismissPopoverAnimated:YES];
    
    createTimeSheetViewController *createTimeSheetView = [[createTimeSheetViewController alloc]init];
    createTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTimeSheetList"];
    [self.navigationController pushViewController:createTimeSheetView animated:YES];
    
}
-(void)status
{
    [popController dismissPopoverAnimated:YES];
    statusTimeSheetViewController *statusTimeSheetView = [[statusTimeSheetViewController alloc]init];
    statusTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"statusTimeSheet"];
    [self.navigationController pushViewController:statusTimeSheetView animated:YES];
    
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
        
        Useridstr  = [managedObject valueForKey:@"userid"];
        //Usertypestr =[managedObject valueForKey:@"userType"];
       
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self tableServiceCall];
}

-(void)tableServiceCall
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"userId":Useridstr,@"userType":Usertypestr,@"orgId":orgIdstr};
    [Servicecall timeSheetLst:projectLstForTask PublicDiscredentilas:credentials];
    [Servicecall setDelegate:self];
    //[self sendNextview];

}
-(void)viewDidAppear:(BOOL)animated
{
    if ([TimeSheetLineIdArray count] == 0)
    {
        createTimeSheetViewController *createTimeSheetView = [[createTimeSheetViewController alloc]init];
        createTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTimeSheetList"];
        [self.navigationController pushViewController:createTimeSheetView animated:YES];
    }
    
  

    
}

-(void)didFinishService:(id)Userlogindetails
{
    

    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    NSLog(@"the project spinner data is %@",Userlogindetails);
    
}
-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
    NSLog(@"the project spinner data is %@",actionitemlist);
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"timeSheetListfrManagerResponse"])
    {
        Timesheetstr          = [[NSString alloc] init];
        TaskFalseString       = [[NSMutableString alloc] init];
        DescrptonArray        = [[NSMutableArray alloc] init];
        TimeSheetLineIdArray  = [[NSMutableArray alloc] init];
        SubmitionDateArray    = [[NSMutableArray alloc] init];
        HrsSpentArray         = [[NSMutableArray alloc] init];
        EstHrsToCmplitedArray     = [[NSMutableArray alloc] init];
        IsTaskComplArray      = [[NSMutableArray alloc] init];
        ReasonArray           = [[NSMutableArray alloc] init];
        TimesheetSplitArray   = [[NSArray alloc] init];
        TimesheetdataArray    = [[NSArray alloc] init];
        
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([string isEqualToString:@"Flase"])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];

    }
    else{
        NSString *chandu = @"*********";
        Timesheetstr= [Timesheetstr stringByAppendingString:chandu];
        Timesheetstr= [Timesheetstr stringByAppendingString:string];
        NSLog(@"agenda details are test %@",Timesheetstr);
        TimesheetdataArray =[Timesheetstr componentsSeparatedByString:@"*********"];
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
    {
        if ([elementName isEqualToString:@"Flase"])
        {
            //        createTimeSheetViewController *createTimeSheetView = [[createTimeSheetViewController alloc]init];
            //        createTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTimeSheetList"];
            //        [self.navigationController pushViewController:createTimeSheetView animated:YES];
            
            NSLog(@"false string is working");
            
            
        }
        else
        
        if ([elementName isEqualToString:@"timeSheetListfrManagerResponse"])
        {
            if ([Timesheetstr isEqualToString:@"Flase"])
            {
               
            }
            else
            {
                for (int i=1; i<[TimesheetdataArray count]; i++)
                {
                    
                    TimesheetSplitArray=[[TimesheetdataArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                    
                    NSLog(@"split  is %@",TimesheetSplitArray);
                    
                    for (int j=1; j<[TimesheetSplitArray count]; j++)
                    {
                        TimeSheetLineIdstr = [[TimesheetSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"TimeSheetLineId==" withString:@""];
                        Descrptonstr  = [[TimesheetSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Descrpton==" withString:@""];
                        SubmitionDatestr = [[TimesheetSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"SubmitionDate==" withString:@""];
                        
                        submissionDateStr1=[SubmitionDatestr stringByReplacingOccurrencesOfString:@"00:00:00.0" withString:@""];
                        
                        HrsSpentstr = [[TimesheetSplitArray objectAtIndex:4]
                                       stringByReplacingOccurrencesOfString:@"HrsSpent==" withString:@""];
                        EstHrsToCmplitedstr = [[TimesheetSplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString:@"EstHrsToCmplited==" withString:@""];
                        IsTaskComplstr = [[TimesheetSplitArray objectAtIndex:6] stringByReplacingOccurrencesOfString:@"IsTaskCompl==" withString:@""];
                        Reasonstr = [[TimesheetSplitArray objectAtIndex:7] stringByReplacingOccurrencesOfString:@"Reason==" withString:@""];
                        NSLog(@"is task complete str is %@",IsTaskComplstr);
                        
                    }
                    
                    
                    
                    [DescrptonArray addObject:Descrptonstr];
                    [TimeSheetLineIdArray addObject:TimeSheetLineIdstr];
                    [SubmitionDateArray addObject:submissionDateStr1];
                    [HrsSpentArray addObject:HrsSpentstr];
                    [EstHrsToCmplitedArray addObject:EstHrsToCmplitedstr];
                    [ReasonArray addObject:Reasonstr];
                    [IsTaskComplArray addObject:IsTaskComplstr];
                    
                    
                }
                
                [timeSheetTbl reloadData];
                //Alert View
                NSLog(@"the array count is %d",[TimeSheetLineIdArray count]);
               
                    


            }
         }
        
    }
    
}

//Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == logoutalertView)
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
    else if (alertView == disApproveAlert)
    {
       
            if(buttonIndex == 0)
            {
                
                NSString * alertReason = [[alertView textFieldAtIndex:0] text];
                NSLog(@"%@",alertReason);
                if ([alertReason length] ==  0)
                {
                    NSLog(@"hai");
                    disApproveAlert = [[UIAlertView alloc]initWithTitle:@"please Enter The Textfiled" message:@"Submit Status" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel", nil];
                    [disApproveAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                    // [[startingAlert textFieldAtIndex:1 ]setDelegate:self];
                    [disApproveAlert show];
                  
                    
                }else{
                    NSLog(@"Its not working");
                    
                    Servicecall = [[Webservices alloc]init];
                    NSString *projectLstForTask = @"SaveAndUpdateTaskService";
                    NSDictionary *credentials = @{@"timeSheetLineId":selectedLineId,@"approvedFlag":@"N",@"approvedBy":Useridstr,@"reason":alertReason};
                    [Servicecall approveTimeshhet:projectLstForTask PublicDiscredentilas:credentials];
                    [Servicecall setDelegate:self];
                    [self tableServiceCall];
                }
                
//                Servicecall = [[Webservices alloc]init];
//                NSString *projectLstForTask = @"SaveAndUpdateTaskService";
//                NSDictionary *credentials = @{@"timeSheetLineId":selectedLineId,@"approvedFlag":@"N",@"approvedBy":Useridstr,@"reason":alertReason};
//                [Servicecall approveTimeshhet:projectLstForTask PublicDiscredentilas:credentials];
//                [Servicecall setDelegate:self];
//                [self tableServiceCall];
                
            }
            else
            {
            }

       
        
    }
    
    else if(alertView == alertView1)
    {
        if(buttonIndex == 0)
        {
        NSLog(@"clickedButtonAtIndex and button index is %d",buttonIndex);
        
        Servicecall = [[Webservices alloc]init];
        NSString *projectLstForTask = @"SaveAndUpdateTaskService";
        
        //timeSheetLineId, approvedFlag, approvedBy, reason

        NSDictionary *credentials = @{@"timeSheetLineId":selectedLineId,@"approvedFlag":@"Y",@"approvedBy":Useridstr,@"reason":@""};
        [Servicecall approveTimeshhet:projectLstForTask PublicDiscredentilas:credentials];
        [Servicecall setDelegate:self];
        
        [self tableServiceCall];

       }
    else  if(buttonIndex == 1){
        
        
        disApproveAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Submit Status" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel", nil];
        [disApproveAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        // [[startingAlert textFieldAtIndex:1 ]setDelegate:self];
        [disApproveAlert show];
        
        

//        Servicecall = [[Webservices alloc]init];
//        NSString *projectLstForTask = @"SaveAndUpdateTaskService";
//        
//        //timeSheetLineId, approvedFlag, approvedBy, reason
//        
//        NSDictionary *credentials = @{@"timeSheetLineId":selectedLineId,@"approvedFlag":@"N",@"approvedBy":Useridstr,@"reason":selectedReason};
//        [Servicecall approveTimeshhet:projectLstForTask PublicDiscredentilas:credentials];
//        [Servicecall setDelegate:self];
//        
//        [self tableServiceCall];
//        
//
//        NSLog(@"clickedButtonAtIndex and button index is %d",buttonIndex);
         }
    else{
        
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
    return [TimeSheetLineIdArray count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    
    // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
    nameLbl.font=[UIFont systemFontOfSize:25];
    nameLbl.text = [TimeSheetLineIdArray objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"WELCOME";
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    nameLbl2.text= [SubmitionDateArray objectAtIndex:indexPath.row];
   
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:25];
    nameLbl3.text= [HrsSpentArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
    nameLbl4.font=[UIFont systemFontOfSize:25];
    nameLbl4.text= [EstHrsToCmplitedArray objectAtIndex:indexPath.row];
   
    UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
    nameLbl5.font=[UIFont systemFontOfSize:25];
    nameLbl5.text= [ReasonArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
    nameLbl6.font=[UIFont systemFontOfSize:25];
    nameLbl6.text= [IsTaskComplArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl7 = (UILabel*)[cell viewWithTag:7];
    nameLbl7.font=[UIFont systemFontOfSize:25];
    nameLbl7.text= [DescrptonArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedLineId = [TimeSheetLineIdArray objectAtIndex:indexPath.row];
    selectedReason = [ReasonArray objectAtIndex:indexPath.row];
    if ([[IsTaskComplArray objectAtIndex:indexPath.row] isEqualToString:@"Y"])
    {
     alertView1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Submit Status" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Approprove",@"DisApprove",@"Cancel",nil];
    [alertView1 show];

    
    NSLog(@"the time sheet line id is %@",selectedLineId);
    }
    else
    {
      UIAlertView  *alertView2 = [[UIAlertView alloc] initWithTitle:@"u cant approve" message:@"Submit Status" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",nil];
        [alertView2 show];

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
