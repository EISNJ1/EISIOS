//
//  AgendaViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/14/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "AgendaViewController.h"
#import "Toast+UIView.h"
#define LEAGELNUM @"0123456789"
@interface AgendaViewController ()
{
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr,*agendatimestr;
    NSXMLParser *AgendaListxmlParser,*AgendaSaveXmlParser,*AgendaGoalsCountXmlParser,*xmlParser3,*xmlParser4;
    //-------------Agenda List--------------
    
    
    NSMutableArray *AgendaListArray,*AgendaDisArray,*AgendaTimeBudgetArray;
    NSArray *AgendaSplitArray;
    int agendagoalstimebudgetint;
}
@end

@implementation AgendaViewController
@synthesize agendatimeTxtFld;



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
    
    //self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    agendatimestr=[[NSString alloc]init];
    
    //agendatimeTxtFld=Agendtimetxtfld;
    
    Servicecall = [[Webservices alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
        
    
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
    

    
    
    
    AgendaCount          = (UIButton *)[self.view viewWithTag:1];
    AgendaCount.layer.cornerRadius = 15;
    AgendaCount.layer.borderWidth  = 2;
    AgendaCount.layer.borderColor  = [UIColor blackColor].CGColor;
    
    Agenddetailsview = (UIView *)[self.view viewWithTag:11];
    Agenddetailsview.layer.cornerRadius = 15;
    Agenddetailsview.layer.borderWidth  = 2;
    Agenddetailsview.layer.borderColor  = [UIColor blackColor].CGColor;
    [self.view addSubview:ScrollV];
    
    Agendtimetxtfld = (UITextField *)[Agenddetailsview viewWithTag:2];
    Agendtimetxtfld.layer.cornerRadius = 15;
    Agendtimetxtfld.layer.borderWidth  = 2;
    Agendtimetxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    
    AgendaDistextView = (UITextView *)[Agenddetailsview viewWithTag:1];
    AgendaDistextView.layer.cornerRadius = 15;
    AgendaDistextView.layer.borderWidth  = 2;
    AgendaDistextView.layer.borderColor  = [UIColor blackColor].CGColor;
    AgendaDistextView.delegate = self;
    Savebtn = (UIButton *)[self.view viewWithTag:3];
    Savebtn.layer.cornerRadius = 10;
    Savebtn.layer.borderWidth  = 2;
    
    
//    Backbtn = (UIButton *)[self.view viewWithTag:4];
//    Backbtn.layer.cornerRadius = 10;
//    Backbtn.layer.borderWidth  = 2;
//    [Backbtn addTarget:self action:@selector(BackbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    Homebtn = (UIButton *)[self.view viewWithTag:5];
    Homebtn.layer.cornerRadius = 10;
    Homebtn.layer.borderWidth  = 2;
    [Homebtn addTarget:self action:@selector(HomePagebtnTapped2) forControlEvents:UIControlEventTouchUpInside];
    
    [self AgendaList];
    [super viewDidLoad];
    
}
-(void)AgendaList
{
    NSLog(@"meeting id is %@",_MeetingId);
    NSString *AgendaListurl = @"AgendaListDataService";
    NSDictionary *credentials = @{@"meetingId":_MeetingId};
    [Servicecall AgendaListurl:AgendaListurl AgendaListParameters:credentials];
    NSString *AgendaGoalscounturl = @"AgendaGoalCountService";
    [Servicecall AgendaGoalsCounturl:AgendaGoalscounturl AgendaGoalParameters:credentials];
    [Servicecall setDelegate:self];
    [Servicecall setDelegate:self];
}

-(IBAction)SaveAgendaTapped:(id)sender{
    
    if ([_MeetingId length]==0)
    {
        [self.view makeToast:@"Please Check Meeting Id Null" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 840)]];
    }
    else if ([AgendaDistextView.text length]==0)
    {
        [AgendaDistextView setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter AgendaDiscription" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 660)]];
    }
   else if   ([Agendtimetxtfld.text length]==0)
    {
        NSLog(@"hai %d %d",[Agendtimetxtfld.text intValue]+agendagoalstimebudgetint,_Hours);
        [AgendaDistextView setBackgroundColor:[UIColor clearColor]];
        [Agendtimetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter TimeLength" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 760)]];
    }
    else if(_Hours<[Agendtimetxtfld.text intValue]+agendagoalstimebudgetint)
    {
        [AgendaDistextView setBackgroundColor:[UIColor clearColor]];
        [Agendtimetxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Enter LessthanTimeLength" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 760)]];
    }
    else
    {
        
        NSLog(@"the agenda time length is %@",Agendtimetxtfld.text);
        
        
        
        agendatimestr=Agendtimetxtfld.text;
        NSString *AgendaSaveurl = @"SaveAgendaListSerivece";
     NSDictionary *credentials = @{@"meetingId":_MeetingId,@"objectDesc":AgendaDistextView.text,@"budgetedTym":Agendtimetxtfld.text};
    [Servicecall agendaSavedurl:AgendaSaveurl AgendaSavedParameters:credentials];
    [Servicecall setDelegate:self];
    
        
    
    NSDictionary *credentials1 = @{@"meetingId":_MeetingId};
    NSString *AgendaGoalscounturl = @"AgendaGoalCountService";
    [Servicecall AgendaGoalsCounturl:AgendaGoalscounturl AgendaGoalParameters:credentials1];
    [Servicecall setDelegate:self];
    NSLog(@"ahendagosl %d",agendagoalstimebudgetint);
    AgendaDistextView.text = nil;
    Agendtimetxtfld.text   = nil;
    [Agendtimetxtfld setBackgroundColor:[UIColor clearColor]];
    [AgendaDistextView setBackgroundColor:[UIColor clearColor]];
      
        
    }
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==AgendaListxmlParser)
    {
        if([elementName isEqualToString:@"agendaListDataResponse"])
        {
            AgendaListArray        =[NSMutableArray new];
            AgendaTimeBudgetArray  =[NSMutableArray new];
            AgendaDisArray         =[NSMutableArray new];
            AgendaSplitArray       =[NSArray new];
        }
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (parser == AgendaListxmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Agenda" message:@"Agenda List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [AgendaListArray addObject:string];
           // NSLog(@"Agenda List %@",string);
            
        }
        
        
    }
    if (parser == AgendaSaveXmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Agenda" message:@"Agenda Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        if ([string isEqualToString:@"Inserted"])
            
        
       {
           
           
           UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Agenda" message:@"Successfully Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
           
           [alert show];
           
           
           
       }
        
        
    }
    if (parser == AgendaGoalsCountXmlParser)
    {
        string = [string stringByReplacingOccurrencesOfString:@"###TimeBudgeted==" withString:@""];
        if ([string isEqualToString:@"null"])
        {
            agendagoalstimebudgetint = [string intValue];
            NSLog(@"fststr %d",agendagoalstimebudgetint);

            
        }
        else
        {
            agendagoalstimebudgetint = [string intValue];
            
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == AgendaListxmlParser)
    {
        if([elementName isEqualToString:@"agendaListDataResponse"])
        {
            for (int i = 0; i<[AgendaListArray count]; i++)
            {
                AgendaSplitArray=[[AgendaListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [AgendaDisArray addObject:[[AgendaSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"ObjectiveDescription==" withString:@""]];
               
                _agendaTimeBugstr=[[AgendaSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"TimeBudgeted==" withString:@""];
                
                [AgendaTimeBudgetArray addObject:_agendaTimeBugstr];
                
                NSLog(@"secondstr %@",AgendaTimeBudgetArray);
                
            }
            [AgendaTV reloadData];
        }
    }
    if (parser == AgendaSaveXmlParser)
    {
        if([elementName isEqualToString:@"saveAgendaResponse"])
        {
            [self AgendaList];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



-(void)didFinishService:(id)Userlogindetails
{
    AgendaListxmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    AgendaListxmlParser.delegate = self;
    [AgendaListxmlParser parse];
}
-(void)Serviceactiondone:(id)result
{
    AgendaSaveXmlParser = [[NSXMLParser alloc]initWithData:result];
    AgendaSaveXmlParser.delegate = self;
    [AgendaSaveXmlParser parse];
}
-(void)Serviceactiondone1:(id)result
{
    AgendaGoalsCountXmlParser = [[NSXMLParser alloc]initWithData:result];
    AgendaGoalsCountXmlParser.delegate = self;
    [AgendaGoalsCountXmlParser parse];
}

-(void)HomePagebtnTapped
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)HomePagebtnTapped2
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
}

-(void)LogoutbtnTapped
{
    LogoutAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [LogoutAlert show];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //if (tableView == AgendaTV)
    //{
        return [AgendaDisArray count];
        
   // }
//    else if (tableView == ActionitemlistTV)
//    {
//        return [ActitemlisttitleArray count];
//    }
//    else{
//        return [PublicNote_DescriptionArray count];
//    }
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
        AgendaDislbl.userInteractionEnabled=NO;
        AgendaDislbl.text=[AgendaDisArray objectAtIndex:indexPath.row];
        
        UILabel *AgendaTimebudgetlbl = (UILabel*)[cell viewWithTag:2001];
        AgendaTimebudgetlbl.text=[AgendaTimeBudgetArray objectAtIndex:indexPath.row];
    
        UILabel *AgendaTopicsCount  = (UILabel *)[self.view viewWithTag:10];
        AgendaTopicsCount.text      = [NSString stringWithFormat:@"%d",[AgendaTimeBudgetArray count]];
       UILabel *AgendaTotaltimecountlbl  = (UILabel *)[self.view viewWithTag:13];
      NSInteger timecount = 0;
    for (int i = 0; i<[AgendaTimeBudgetArray count]; i++)
    {
        NSString * time = [AgendaTimeBudgetArray objectAtIndex:i];
        timecount = timecount+[time intValue];
    }
    AgendaTotaltimecountlbl.text =[NSString stringWithFormat:@"%d",timecount];
    
    
    //}
    return cell;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == Agendtimetxtfld ) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = ContentView.frame;
        frame.origin.y =frame.origin.y -180;
        [ContentView setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [Agendtimetxtfld resignFirstResponder];
    if (textField == Agendtimetxtfld ) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = ContentView.frame;
        frame.origin.y = frame.origin.y + 180;
        [ContentView setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if( [text isEqualToString:[text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]] ) {
        return YES;
    } else {
        [textView resignFirstResponder];
        [Agendtimetxtfld becomeFirstResponder];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    
    if (textField == Agendtimetxtfld)
    {
        [Agendtimetxtfld resignFirstResponder];
        
        [self SaveAgendaTapped:nil];
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificaiton_name" object:agendatimestr];
    NSLog(@"the agenda time str is %@",agendatimestr);

    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
