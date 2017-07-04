//
//  GoalViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/14/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "GoalViewController.h"
#define LEAGELNUM @"0123456789"
#import "Toast+UIView.h"
@interface GoalViewController ()
{
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    NSXMLParser *GoalsListxmlParser,*GoalsSaveXmlParser,*AgendaGoalsCountXmlParser;
    
    
    //-------------GoalsList---------------------
    NSString *_MeetingId;
    NSMutableArray *GoalsListArray,*GoalsDisArray,*GoalsTimeBudgetArray;
    NSArray *GoalsSplitArray;
    int agendagoalstimebudgetint;
}
@end

@implementation GoalViewController


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
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    
    
    
    
    
    
    
    
    Servicecall = [[Webservices alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
        
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f]];
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped3) forControlEvents:UIControlEventTouchUpInside];
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

    
    
    
    GoalsCount          = (UIButton *)[self.view viewWithTag:1];
    GoalsCount.layer.cornerRadius = 15;
    GoalsCount.layer.borderWidth  = 2;
    GoalsCount.layer.borderColor  = [UIColor blackColor].CGColor;
    
    GoalsDetailsView = (UIView *)[self.view viewWithTag:11];
    GoalsDetailsView.layer.cornerRadius = 15;
    GoalsDetailsView.layer.borderWidth  = 2;
    GoalsDetailsView.layer.borderColor  = [UIColor blackColor].CGColor;
    [self.view addSubview:ScrollV];
    
    Goalstimetxtfld = (UITextField *)[GoalsDetailsView viewWithTag:2];
    Goalstimetxtfld.layer.cornerRadius = 15;
    Goalstimetxtfld.layer.borderWidth  = 2;
    Goalstimetxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    Goalstimetxtfld.delegate = self;
    
    GoalsDistextView = (UITextView *)[GoalsDetailsView viewWithTag:1];
    GoalsDistextView.layer.cornerRadius = 15;
    GoalsDistextView.layer.borderWidth  = 2;
    GoalsDistextView.layer.borderColor  = [UIColor blackColor].CGColor;
    GoalsDistextView.delegate = self;
    
    Savebtn = (UIButton *)[self.view viewWithTag:3];
    Savebtn.layer.cornerRadius = 10;
    Savebtn.layer.borderWidth  = 2;
    
    
//    Backbtn = (UIButton *)[self.view viewWithTag:4];
//    Backbtn.layer.cornerRadius = 10;
//    Backbtn.layer.borderWidth  = 2;
//    [Backbtn addTarget:self action:@selector(BackbtnTapped) forControlEvents:UIControlEventTouchUpInside];
//    
    Homebtn = (UIButton *)[self.view viewWithTag:5];
    Homebtn.layer.cornerRadius = 10;
    Homebtn.layer.borderWidth  = 2;
    [Homebtn addTarget:self action:@selector(HomePagebtnTapped4) forControlEvents:UIControlEventTouchUpInside];
    
    [self GolasList];

    [super viewDidLoad];
}
-(void)HomePagebtnTapped3
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)HomePagebtnTapped4
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
}

-(void)GolasList
{
    NSString *GoalsListurl = @"GoalsListDataService";
     NSDictionary *credentials = @{@"meetingId":_MeetingId};
    [Servicecall GoalsListurl:GoalsListurl GoalsListParameters:credentials];
    NSString *AgendaGoalscounturl = @"AgendaGoalCountService";
    [Servicecall AgendaGoalsCounturl:AgendaGoalscounturl AgendaGoalParameters:credentials];
    [Servicecall setDelegate:self];
    [Servicecall setDelegate:self];
}
-(IBAction)SaveGoalsTapped:(id)sender
{
    if ([GoalsDistextView.text length]==0)
    {
        [GoalsDistextView setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter Goalsdiscription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 660)]];
    }
   else if ([Goalstimetxtfld.text length]==0)
    {
        [GoalsDistextView setBackgroundColor:[UIColor clearColor]];

        [Goalstimetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter TimeLength" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 760)]];
    }
   else if(_Hours<[Goalstimetxtfld.text intValue]+agendagoalstimebudgetint)
   {
       [GoalsDistextView setBackgroundColor:[UIColor clearColor]];
       [Goalstimetxtfld setBackgroundColor:[UIColor redColor]];
       [self.view makeToast:@"Enter LessthanTimeLength" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 760)]];
   }

    else {
    NSString *GoalsSavedurl = @"SaveGoalsService";
    NSDictionary *credentials = @{@"meetingId":_MeetingId,@"objectDesc":GoalsDistextView.text,@"budgetedTym":Goalstimetxtfld.text};
    [Servicecall GoalsSavedurl:GoalsSavedurl GoalsSavedParameters:credentials];
    [Servicecall setDelegate:self];
    
        
    NSDictionary *credentials1 = @{@"meetingId":_MeetingId};
    NSString *AgendaGoalscounturl = @"AgendaGoalCountService";
    [Servicecall AgendaGoalsCounturl:AgendaGoalscounturl AgendaGoalParameters:credentials1];
    [Servicecall setDelegate:self];
        
    GoalsDistextView.text = nil;
    Goalstimetxtfld.text  =nil;
    [Goalstimetxtfld setBackgroundColor:[UIColor clearColor]];
    [GoalsDistextView setBackgroundColor:[UIColor clearColor]];
}
    
}


-(void)didFinishService:(id)Userlogindetails
{
    GoalsListxmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    GoalsListxmlParser.delegate = self;
    [GoalsListxmlParser parse];
}
-(void)Serviceactiondone:(id)result
{
    GoalsSaveXmlParser = [[NSXMLParser alloc]initWithData:result];
    GoalsSaveXmlParser.delegate = self;
    [GoalsSaveXmlParser parse];
}

-(void)Serviceactiondone1:(id)result
{
    AgendaGoalsCountXmlParser = [[NSXMLParser alloc]initWithData:result];
    AgendaGoalsCountXmlParser.delegate = self;
    [AgendaGoalsCountXmlParser parse];
}



-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==GoalsListxmlParser)
    {
        if([elementName isEqualToString:@"goalsListDataResponse"])
        {
            GoalsListArray        =[NSMutableArray new];
            GoalsTimeBudgetArray  =[NSMutableArray new];
            GoalsDisArray         =[NSMutableArray new];
            GoalsSplitArray       =[NSArray new];
        }
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (parser == GoalsListxmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Goals" message:@"Goals List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [GoalsListArray addObject:string];
            //NSLog(@"Agenda List %@",string);
            
        }
        
        
    }
    if (parser == GoalsSaveXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Agenda" message:@"Agenda Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        if ([string isEqualToString:@"Inserted"])
            
            
        {
            
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Goals" message:@"Successfully Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
            
        }
        
        
    }
    if (parser == AgendaGoalsCountXmlParser)
    {
        string = [string stringByReplacingOccurrencesOfString:@"###TimeBudgeted==" withString:@""];
        if ([string isEqualToString:@"null"])
        {
            agendagoalstimebudgetint = [string intValue];

            NSLog(@"str %d",agendagoalstimebudgetint);
            
            
        }
        else
        {
            agendagoalstimebudgetint = [string intValue];
            NSLog(@"count %d",agendagoalstimebudgetint);
        }
    }

    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == GoalsListxmlParser)
    {
        if([elementName isEqualToString:@"goalsListDataResponse"])
        {
            for (int i = 0; i<[GoalsListArray count]; i++)
            {
                GoalsSplitArray=[[GoalsListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [GoalsDisArray addObject:[[GoalsSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"ObjectiveDescription==" withString:@""]];
                [GoalsTimeBudgetArray addObject:[[GoalsSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"TimeBudgeted==" withString:@""]];
                
            }
            [GoalsTV reloadData];
        }
    }
    if (parser == GoalsSaveXmlParser)
    {
        if([elementName isEqualToString:@"saveGoalsResponse"])
        {
            [self GolasList];
        }
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [GoalsDisArray count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *MyIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.contentView.layer setBorderWidth:2.0f];
    cell.contentView.layer.cornerRadius = 12;
    cell.contentView.clipsToBounds = YES;
    
    
    UILabel *AgendaDislbl = (UILabel*)[cell viewWithTag:2000];
    AgendaDislbl.text=[GoalsDisArray objectAtIndex:indexPath.row];
    
    //UILabel *AgendaTimebudgetlbl = (UILabel*)[cell viewWithTag:2001];
    //AgendaTimebudgetlbl.text=[AgendaTimeBudgetArray objectAtIndex:indexPath.row];
    
    UILabel *AgendaTopicsCount  = (UILabel *)[self.view viewWithTag:10];
    AgendaTopicsCount.text      = [NSString stringWithFormat:@"%d",[GoalsDisArray count]];
    
    
    return cell;
}




- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    if (textField == Goalstimetxtfld ) {
       
        NSLog(@"textViewDidBeginEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y =frame.origin.y -100;
        //[self.view setFrame:frame];
        [UIView commitAnimations];
        // [Goalstimetxtfld resignFirstResponder];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
        if (textField == Goalstimetxtfld ) {
            [Goalstimetxtfld resignFirstResponder];

        NSLog(@"textViewDidEndEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = frame.origin.y + 100;
//        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == Goalstimetxtfld)
    {
        [Goalstimetxtfld resignFirstResponder];
        
        [self SaveGoalsTapped:nil];
        
    }
   
    return YES;
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if( [text isEqualToString:[text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]] ) {
        return YES;
    } else {
        [textView resignFirstResponder];
        [Goalstimetxtfld becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:LEAGELNUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]     componentsJoinedByString:@""];
    BOOL lengthresult = [string isEqualToString:filtered];
    // NSLog(@"bool is %d",basicTest);
    return lengthresult;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
//-(void)HomePagebtnTapped
//{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//}
//-(void)BackbtnTapped
//{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
//}
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


@end
