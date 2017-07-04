//
//  statusTimeSheetViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/8/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "statusTimeSheetViewController.h"

@interface statusTimeSheetViewController ()

@end

@implementation statusTimeSheetViewController

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
    [self.view addGestureRecognizer:tapGesture];
    
    [statusSearch setDelegate:self];
    //[statusSearch setUserInteractionEnabled:NO];
    statusSearch.text = @"Requiremet Gathering (All)";
    
    //----------------view back ground stroke--------------------//
    searchBackGroundView.layer.cornerRadius = searchBackGroundView.frame.size.width / 2;
    searchBackGroundView.clipsToBounds = YES;
    searchBackGroundView.layer.borderWidth = 3.0f;
    searchBackGroundView.layer.borderColor = [UIColor yellowColor].CGColor;
    searchBackGroundView.layer.cornerRadius = 10.0f;
    searchBackGroundView.layer.cornerRadius=4;
    
//    statusSearch.layer.cornerRadius = statusSearch.frame.size.width / 2;
//    statusSearch.clipsToBounds = YES;
//    statusSearch.layer.borderWidth = 3.0f;
//    statusSearch.layer.borderColor = [UIColor yellowColor].CGColor;
//    statusSearch.layer.cornerRadius = 10.0f;
//    statusSearch.layer.cornerRadius=4;
    
    
   // statusResultsTbl.layer.cornerRadius = statusResultsTbl.frame.size.width / 2;
   // statusResultsTbl.clipsToBounds = YES;
   // statusResultsTbl.layer.borderWidth = 3.0f;
   // statusResultsTbl.layer.borderColor = [UIColor yellowColor].CGColor;
   // statusResultsTbl.layer.cornerRadius = 10.0f;
   // statusResultsTbl.layer.cornerRadius=4;
    
    
    //-------------------service parameters data------------------//
    //[self DatafromDB];
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Useridstr   = [defaults objectForKey:@"UserId"];
    Usernamestr = [defaults objectForKey:@"UserName"];
    UserType   =  [defaults objectForKey:@"userType"];
    
    NSLog(@"user id is %@,%@",Useridstr,UserType);
    
    

    [self tableService];
   
    //-------------------Right side pop Button---------------------//
    
    //createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"||" style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];

    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];


   // self.navigationItem.rightBarButtonItem = createTimeSheetActionBarBtn;
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];

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

-(void)tableService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{@"userId":Useridstr};
    [Servicecall timeSheetLstAll:projectLstForTask PublicDiscredentilas:credentials];
    [Servicecall setDelegate:self];

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
    
    
    UIButton * submitBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [submitBtn setTitle:@"Submit TimeSheet" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitBtn.tag = 101;
    submitBtn.frame=CGRectMake(20, 60, 150, 40);
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    //[contentViewController.view addSubview:Cashbtn];
    [view1 addSubview:submitBtn];
    
    
    [popController presentPopoverFromBarButtonItem:createTimeSheetActionBarBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
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


-(void)Evaluate
{
    
    [popController dismissPopoverAnimated:YES];
    TimeSheetViewController *TimeSheetView = (TimeSheetViewController *)[self.navigationController.viewControllers objectAtIndex:2];
    [self.navigationController popToViewController:TimeSheetView animated:YES];

    
}
-(void)submit
{
    [popController dismissPopoverAnimated:YES];
    createTimeSheetViewController *createTimeSheetView = [[createTimeSheetViewController alloc]init];
    createTimeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTimeSheetList"];
    [self.navigationController pushViewController:createTimeSheetView animated:YES];
    
//    [popController dismissPopoverAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    NSLog(@"the project spinner data is %@",Userlogindetails);
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"timeSheetStLstFrAllResponse"])
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
        approvalAry = [[NSMutableArray alloc]init];
        TimesheetSplitArray   = [[NSArray alloc] init];
        TimesheetdataArray    = [[NSArray alloc] init];
        
        pickerAry = [[NSMutableArray alloc]init];
        
        pickerAry1 = [[NSMutableArray alloc]init];

        

        
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([string isEqualToString:@"Flase"])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        
        [alert show];
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
        
        
        if ([elementName isEqualToString:@"timeSheetStLstFrAllResponse"])
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
                        TimeSheetLineIdstr = [[TimesheetSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"TimeSheetLineID==" withString:@""];
                        Descrptonstr  = [[TimesheetSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"TimeDescription==" withString:@""];
                        SubmitionDatestr = [[TimesheetSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"SubmitionDate==" withString:@""];
                        HrsSpentstr = [[TimesheetSplitArray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"HouresSpent==" withString:@""];
                        EstHrsToCmplitedstr = [[TimesheetSplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString:@"EstimatdHrsToCmplt==" withString:@""];
                        IsTaskComplstr = [[TimesheetSplitArray objectAtIndex:6] stringByReplacingOccurrencesOfString:@"IstaskCompleted==" withString:@""];
                        Reasonstr = [[TimesheetSplitArray objectAtIndex:7] stringByReplacingOccurrencesOfString:@"Reason==" withString:@""];
                        approvalStr = [[TimesheetSplitArray objectAtIndex:8] stringByReplacingOccurrencesOfString:@"ApprovelFlag==" withString:@""];
                        
                        NSLog(@"nsdate string is %@",SubmitionDatestr);
                        
                     daetsStr1 =[SubmitionDatestr stringByReplacingOccurrencesOfString:@"00:00:00.0" withString:@""];

                    }
                    
                    
                    
                    [DescrptonArray addObject:Descrptonstr];
                    [TimeSheetLineIdArray addObject:TimeSheetLineIdstr];
                    [SubmitionDateArray addObject:daetsStr1];
                    [HrsSpentArray addObject:HrsSpentstr];
                    [EstHrsToCmplitedArray addObject:EstHrsToCmplitedstr];
                    [ReasonArray addObject:Reasonstr];
                    [IsTaskComplArray addObject:IsTaskComplstr];
                    [approvalAry addObject:approvalStr];
                    
                    //[pickerAry addObject:Descrptonstr];
                    [pickerAry1 addObject:Descrptonstr];

                    
                   
                    
                    tableAry = [[NSMutableArray alloc] init];
                    searchAry = [[NSMutableArray alloc] init];
                    tempAry = [[NSMutableArray alloc] initWithArray:DescrptonArray];
                    tableAry = DescrptonArray;
                }
                [statusResultsTbl reloadData];
                
                for (id obj in pickerAry1)
                {
                    if (![pickerAry containsObject:obj])
                    {
                        [pickerAry addObject: obj];
                    }
                }
                NSLog(@"new array is %@",pickerAry);

                [pickerAry addObject:@"Requiremet Gathering (All)"];
            }
            
        }
        
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;//[TimeSheetLineIdArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [tableAry count];
    
    //return [TimeSheetLineIdArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewStyleGrouped reuseIdentifier:nil];
        // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;

    
        UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
        nameLbl.font=[UIFont systemFontOfSize:25];
        nameLbl.text= [TimeSheetLineIdArray objectAtIndex:indexPath.row];
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    nameLbl2.text= [HrsSpentArray objectAtIndex:indexPath.row];

    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:25];
    nameLbl3.text= [EstHrsToCmplitedArray objectAtIndex:indexPath.row];

    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
    nameLbl4.font=[UIFont systemFontOfSize:25];
    nameLbl4.text= [IsTaskComplArray objectAtIndex:indexPath.row];

    UILabel *nameLbl5 = (UILabel*)[cell viewWithTag:5];
    nameLbl5.font=[UIFont systemFontOfSize:25];
    nameLbl5.text= [approvalAry objectAtIndex:indexPath.row];
    
    UILabel *nameLbl6 = (UILabel*)[cell viewWithTag:6];
    nameLbl6.font=[UIFont systemFontOfSize:25];
    nameLbl6.text= [SubmitionDateArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl7 = (UILabel*)[cell viewWithTag:7];
    nameLbl7.font=[UIFont systemFontOfSize:25];
    nameLbl7.text= [ReasonArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl8 = (UILabel*)[cell viewWithTag:8];
    nameLbl8.font=[UIFont systemFontOfSize:25];
    nameLbl8.text= [DescrptonArray objectAtIndex:indexPath.row];

    return cell;

    


}



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

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
    [statusSearch resignFirstResponder];

    
	if(search)
        return;
    
	search = YES;
    [statusSearch setShowsCancelButton:NO animated:YES];
    
    
}
//Users/rapid/Downloads/Quotes 19-02-13 OFC/Quotes.xcodeproj
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    [statusSearch resignFirstResponder];

    if([searchText length] > 0)
    {
        search = YES;
        [self search];
        
        NSLog(@"is it >1");
    }
    else
    {
        search = NO;
        [statusSearch resignFirstResponder];
        
        tableAry = [[NSMutableArray alloc]initWithArray:tempAry];
    }
    [statusResultsTbl reloadData];

}




- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
/* same as search method */
    
    [tableAry removeAllObjects];
	NSString *searchText = statusSearch.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if ([searchAry count] > 0) {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [statusResultsTbl reloadData];

/* same as search method */
    
    
 //    tableAry = tempAry;
//    [statusSearch resignFirstResponder];
    
    NSLog(@"search button clicked");
    
}

- (void) search {
	[tableAry removeAllObjects];
	NSString *searchText = statusSearch.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
    if ([searchAry count] > 0) {
        [tableAry addObjectsFromArray:searchAry];
    }
    
    search=YES;
    [statusResultsTbl reloadData];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [pickerAry count];
    }
    
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [pickerAry objectAtIndex:row];
    }
    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        
        statusSearch.text=[pickerAry objectAtIndex:row];
        NSLog(@"the project id isssssssss  %@ ",[pickerAry objectAtIndex:row]);
//        [questionpkr removeFromSuperview];
        [statusSearch resignFirstResponder];
        
        
        
        if ([statusSearch.text isEqualToString:@"Requiremet Gathering (All)"])
        {
            statusSearch.text = nil;
            
            [self tableService];
            NSLog(@"the akljdfkasdjfkfj ");
            
            statusSearch.text = @"Requiremet Gathering (All)";
        }
        
            /* same as search method */
            [tableAry removeAllObjects];
            NSString *searchText = statusSearch.text;
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
            searchAry=(NSMutableArray*)[tempAry filteredArrayUsingPredicate:predicate];
            if ([searchAry count] > 0)
            {
                [tableAry addObjectsFromArray:searchAry];
            }
            
            search=YES;
            [statusResultsTbl reloadData];
        
        
        
    }
   
    
    
}
-(IBAction)btnClk:(id)sender
{
       
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 168, self.view.frame.size.width-40, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
}
-(IBAction)pkrDoneClk:(id)sender
{
   // [questionpkr removeFromSuperview];

}

-(void)userTapped
{
    [questionpkr removeFromSuperview];
    

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
