//
//  ParticipantsViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/15/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "ParticipantsViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "Toast+UIView.h"
@interface ParticipantsViewController ()


{
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    NSXMLParser *ParticipantsListxmlParser,*ParticipantsNamexmlParser,*RolexmlParser,*SavexmlParser;
    //---------------Participants List-------------
    NSString *MeetingId,*ProjectId;
    NSMutableArray *ParticipantsListArray,*ParticipantResourceNameArray,*ParticipantResourceRoleArray,*ParticipantResourceIdArray;
    NSArray *ParticipantSplitArray;
    
    //--------------ParticipantsResource----------------
    NSMutableArray *ResourceNameArray,*ResourceIdArray,*ResourceListArray,*resourcenamearay,*resourceidarray;
    NSArray *ResourceSplitArray;
    NSString *ResourceIdstr,*ResourceNameStr;
    
    //---------RoleList------------
    NSMutableArray *RolelistArray,*RoleCodeIdaArray,*RoleValueArray;
    NSArray *RoleSplitarray,*FlagArray;
    NSString *RoleCodestr,*Flagstr;
    
    
    
}

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ParticipantsViewController
//-(void)DatafromDB
//{
//    FlagArray = [[NSArray alloc]initWithObjects:@"Y",@"N", nil];
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
//        NSLog(@"detaisl %@ %@ ",orgIdstr,Usertypestr);
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
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    

    
    //[self DatafromDB];
    FlagArray = [[NSArray alloc]initWithObjects:@"Y",@"N", nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    Servicecall = [[Webservices alloc]init];
    
    NSUserDefaults *StoredValues =[ NSUserDefaults standardUserDefaults];
    MeetingId=[StoredValues objectForKey:@"MeetingId"];
    //_ProjectIdStr=[StoredValues objectForKey:@"ProjectId"];
    //NSLog(@"ProjId %@",ProjectId);
    NSLog(@"meeeting id is %@",MeetingId);
    NSLog(@"project id is %@",_ProjectIdStr);
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
    
    
    
    
    
    
    ParticipantsDetailsView = (UIView *)[self.view viewWithTag:11];
    ParticipantsDetailsView.layer.cornerRadius = 15;
    ParticipantsDetailsView.layer.borderWidth  = 2;
    ParticipantsDetailsView.layer.borderColor  = [UIColor blackColor].CGColor;
    [self.contentView addSubview:ParticipantsDetailsView];
    
    ParticipantsNametxtfld = (UITextField *)[ParticipantsDetailsView viewWithTag:1];
    ParticipantsNametxtfld.layer.cornerRadius = 15;
    ParticipantsNametxtfld.layer.borderWidth  = 2;
    ParticipantsNametxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    UIButton *ParticipantNamebtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [ParticipantNamebtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    ParticipantNamebtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [ParticipantNamebtnpkr addTarget:self action:@selector(ParticipantNameButtonPkrTapped) forControlEvents:UIControlEventTouchUpInside];
    ParticipantsNametxtfld.rightView = ParticipantNamebtnpkr;
    ParticipantsNametxtfld.rightViewMode = UITextFieldViewModeAlways;
    [ParticipantsNametxtfld addSubview:ParticipantNamebtnpkr];
    
    
    Roletxtfld = (UITextField *)[ParticipantsDetailsView viewWithTag:2];
    Roletxtfld.layer.cornerRadius = 15;
    Roletxtfld.layer.borderWidth  = 2;
    Roletxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    UIButton *Rolebtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Rolebtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Rolebtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Rolebtnpkr addTarget:self action:@selector(RoleButtonPkrTapped) forControlEvents:UIControlEventTouchUpInside];
    Roletxtfld.rightView = Rolebtnpkr;
    Roletxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Roletxtfld addSubview:Rolebtnpkr];
    
    
    
    Flagtxtfld = (UITextField *)[ParticipantsDetailsView viewWithTag:3];
    Flagtxtfld.layer.cornerRadius = 15;
    Flagtxtfld.layer.borderWidth  = 2;
    Flagtxtfld.layer.borderColor  = [UIColor blackColor].CGColor;
    UIButton *Flagbtnpkr = [UIButton buttonWithType:UIButtonTypeCustom];
    [Flagbtnpkr setImage:[UIImage imageNamed:@"down_arrow_small.png"] forState:UIControlStateNormal];
    Flagbtnpkr.imageEdgeInsets = UIEdgeInsetsMake(20, -5, 20, 30);
    [Flagbtnpkr addTarget:self action:@selector(FlagButtonPkrTapped) forControlEvents:UIControlEventTouchUpInside];
    Flagtxtfld.rightView = Flagbtnpkr;
    Flagtxtfld.rightViewMode = UITextFieldViewModeAlways;
    [Flagtxtfld addSubview:Flagbtnpkr];

    
    
    Savebtn = (UIButton *)[self.view viewWithTag:3];
    Savebtn.layer.cornerRadius = 10;
    Savebtn.layer.borderWidth  = 2;
    
    
    Backbtn = (UIButton *)[self.view viewWithTag:4];
    Backbtn.layer.cornerRadius = 10;
    Backbtn.layer.borderWidth  = 2;
    [Backbtn addTarget:self action:@selector(BackbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    Homebtn = (UIButton *)[self.view viewWithTag:5];
    Homebtn.layer.cornerRadius = 10;
    Homebtn.layer.borderWidth  = 2;
    [Homebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    MeetingId=_MeetingId;
    
    
    [self ParticipantsList];
    
    [super viewDidLoad];
   
}

-(void)ParticipantsList
{
    
    
    NSString *ParticipantsListurl = @"ParticipantsListService";
    NSDictionary *credentials = @{@"meetingId":MeetingId};
    [Servicecall ParticipantsListurl:ParticipantsListurl ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
    
}


-(void)FlagButtonPkrTapped
{
    
    [ParticipantsPicker removeFromSuperview];
    ParticipantsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 590, self.view.frame.size.width-500, 60)];//410
    [ParticipantsPicker setShowsSelectionIndicator:YES];
    ParticipantsPicker.delegate = self;
    ParticipantsPicker.dataSource = self;
    ParticipantsPicker.tag = 3;
    ParticipantsPicker.backgroundColor=[UIColor grayColor];
    ParticipantsPicker.alpha = 0;
    [self.contentView addSubview:ParticipantsPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ParticipantsPicker.transform = transfrom;
    ParticipantsPicker.alpha = ParticipantsPicker.alpha * (-1) + 1;
    [UIView commitAnimations];
}
-(void)RoleButtonPkrTapped
{
    NSString *Rolenameturl = @"RoleListService";
    NSDictionary *credentials = @{@"orgId":orgIdstr};
    [Servicecall RoleName:Rolenameturl RoleParameters:credentials];
    [Servicecall setDelegate:self];
    
    [ParticipantsPicker removeFromSuperview];
    ParticipantsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 510, self.view.frame.size.width-358, 300)];
    [ParticipantsPicker setShowsSelectionIndicator:YES];
    ParticipantsPicker.delegate = self;
    ParticipantsPicker.dataSource = self;
    ParticipantsPicker.tag = 2;
    ParticipantsPicker.backgroundColor=[UIColor grayColor];
    ParticipantsPicker.alpha = 0;
    [self.contentView addSubview:ParticipantsPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ParticipantsPicker.transform = transfrom;
    ParticipantsPicker.alpha = ParticipantsPicker.alpha * (-1) + 1;
    [UIView commitAnimations];
}

-(void)ParticipantNameButtonPkrTapped
{NSLog(@"project id is 25145122222%@",_ProjectIdStr);
    
    NSString *ParticipantNameurl = @"ParicipantsResListService";
    NSDictionary *credentials = @{@"projectId":_ProjectIdStr};
    [Servicecall ParticipantsResourceName:ParticipantNameurl ParticipantsResourceParameters:credentials];
    [Servicecall setDelegate:self];
    
    [ParticipantsPicker reloadAllComponents];
    [ParticipantsPicker removeFromSuperview];
    ParticipantsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(260, 440, self.view.frame.size.width-358, 300)];
    [ParticipantsPicker setShowsSelectionIndicator:YES];
    ParticipantsPicker.delegate = self;
    ParticipantsPicker.dataSource = self;
    ParticipantsPicker.tag = 1;
    ParticipantsPicker.backgroundColor=[UIColor grayColor];
    ParticipantsPicker.alpha = 0;
    [self.contentView addSubview:ParticipantsPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0,5);
    ParticipantsPicker.transform = transfrom;
    ParticipantsPicker.alpha = ParticipantsPicker.alpha * (-1) + 1;
    [UIView commitAnimations];
}

-(IBAction)SaveParticipants:(id)sender
{
    if ([ParticipantsNametxtfld.text length]==0)
    {
        [ParticipantsNametxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select Participentname" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(590, 680)]];
    }
   else if ([Roletxtfld.text length]==0)
    {
        [ParticipantsNametxtfld setBackgroundColor:[UIColor clearColor]];
        [Roletxtfld setBackgroundColor:[UIColor redColor]];
        [self.view makeToast:@"Select Role" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 780)]];
    }
   else if ([Flagtxtfld.text length]==0)
   {
       [Roletxtfld setBackgroundColor:[UIColor clearColor]];
       [Flagtxtfld setBackgroundColor:[UIColor redColor]];
       [self.view makeToast:@"Select Flag" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(600, 860)]];
   }
    
    else {
        
        NSLog(@"meeting id is %@",MeetingId);
        NSLog(@"resource id is %@",ResourceIdstr);
    NSString *ParticipantSaveurl = @"SaveParticipants";
    NSDictionary *credentials = @{@"meetingId":MeetingId,@"resourceId":ResourceIdstr,@"participantRole":RoleCodestr,@"flag":Flagstr,};
    [Servicecall SaveParticipantsurl:ParticipantSaveurl SaveParticipantsParameters:credentials];
    [Servicecall setDelegate:self];
        
    ParticipantsNametxtfld.text = nil;
    Roletxtfld.text  =nil;
        Flagtxtfld.text = nil;
    [ParticipantsNametxtfld setBackgroundColor:[UIColor clearColor]];
    [Roletxtfld setBackgroundColor:[UIColor clearColor]];
    [Flagtxtfld setBackgroundColor:[UIColor clearColor]];
        
    }
}




//Tableview Delagates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [ParticipantResourceRoleArray count];
    
    
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
    
    
    UILabel *ParticipantNamelbl = (UILabel*)[cell viewWithTag:2000];
    ParticipantNamelbl.text=[ParticipantResourceNameArray objectAtIndex:indexPath.row];
    
    UILabel *ParticipantRolelbl = (UILabel*)[cell viewWithTag:2001];
    ParticipantRolelbl.text=[ParticipantResourceRoleArray objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}


//Protocal Methods

-(void)didFinishService:(id)Userlogindetails
{
    ParticipantsListxmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    ParticipantsListxmlParser.delegate = self;
    [ParticipantsListxmlParser parse];
}

-(void)Serviceactiondone:(id)result
{
    ParticipantsNamexmlParser = [[NSXMLParser alloc]initWithData:result];
    ParticipantsNamexmlParser.delegate = self;
    [ParticipantsNamexmlParser parse];

}
-(void)Serviceactiondone1:(id)result
{
    RolexmlParser = [[NSXMLParser alloc]initWithData:result];
    RolexmlParser.delegate = self;
    [RolexmlParser parse];

}
-(void)didFinishData:(id)Data
{
    SavexmlParser = [[NSXMLParser alloc]initWithData:Data];
    SavexmlParser.delegate = self;
    [SavexmlParser parse];

}



// parser DataSource Methods


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==ParticipantsListxmlParser)
    {
        if([elementName isEqualToString:@"participantsListDataResponse"])
        {
            ParticipantsListArray         =[NSMutableArray new];
            ParticipantResourceNameArray  =[NSMutableArray new];
            ParticipantResourceIdArray    =[NSMutableArray new];
            ParticipantResourceRoleArray  =[NSMutableArray new];
            ParticipantSplitArray         =[NSArray new];
        }
    }
    if (parser==ParticipantsNamexmlParser)
    {
        if([elementName isEqualToString:@"pariResListResponse"])
        {
            ResourceIdArray         =[[NSMutableArray alloc]init];
            ResourceListArray       =[[NSMutableArray alloc]init];
            ResourceNameArray       =[[NSMutableArray alloc]init];
            ResourceSplitArray      =[[NSArray alloc]init];
        }
    }
    
    if (parser==RolexmlParser)
    {
        if([elementName isEqualToString:@"rolesListDataResponse"])
        {
            RoleValueArray      =[NSMutableArray new];
            RolelistArray       =[NSMutableArray new];
            RoleCodeIdaArray    =[NSMutableArray new];
            RoleSplitarray      =[NSArray new];
        }
    }


}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == ParticipantsListxmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Goals" message:@"No Participant Assigned" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [ParticipantsListArray addObject:string];
            NSLog(@"Agenda List %@",ParticipantsListArray);
            
        }
        
        
    }
    if (parser == ParticipantsNamexmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Participants" message:@"Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            [ResourceListArray addObject:string];
            
        }
        
        
    }
    if (parser == RolexmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Agenda" message:@"Agenda Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            [RolelistArray addObject:string];
            
        }
        
        
    }
    
    if (parser == SavexmlParser)
    {
        
        if ([string isEqualToString:@"Inserted"])
        {
                       UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Succesfully" message:@"Participant Saved" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            [self ParticipantsList];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Problem" message:@"Not Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];

            
        }
        
        
    }


    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == ParticipantsListxmlParser)
    {
        if([elementName isEqualToString:@"participantsListDataResponse"])
        {
            for (int i = 0; i<[ParticipantsListArray count]; i++)
            {
                ParticipantSplitArray=[[ParticipantsListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [ParticipantResourceIdArray addObject:[[ParticipantSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"MeetingResourceId==" withString:@""]];
                [ParticipantResourceNameArray addObject:[[ParticipantSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"ResourceName==" withString:@""]];
                [ParticipantResourceRoleArray addObject:[[ParticipantSplitArray objectAtIndex:3] stringByReplacingOccurrencesOfString: @"ResourceRole==" withString:@""]];
                NSLog(@"paricipantes");
                
            }
            [ParticipantTV reloadData];

        }
           }
    if (parser == ParticipantsNamexmlParser)
    {
        if([elementName isEqualToString:@"pariResListResponse"])
        {
            for (int i = 0; i<[ResourceListArray count]; i++)
            {
                ResourceSplitArray=[[ResourceListArray objectAtIndex:i]componentsSeparatedByString:@"###"];
                
                NSLog(@"resource split array is %@",ResourceSplitArray);
               ResourceIdstr=[[ResourceSplitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"ResourceId==" withString:@""];
                
                ResourceNameStr=[[ResourceSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString: @"ResourceName==" withString:@""];
                
                [ResourceNameArray addObject:ResourceNameStr];
                [ResourceIdArray  addObject:ResourceIdstr];
                
            }
            
           
            [ParticipantsPicker reloadAllComponents];
            resourcenamearay=[NSMutableArray arrayWithArray:ResourceNameArray];
            resourceidarray=[NSMutableArray arrayWithArray:ResourceIdArray];
            NSLog(@"resource id array is %@",resourceidarray);
            NSLog(@"Resiurce name %@",resourcenamearay);

            
        }
    }
    
    if (parser == RolexmlParser)
    {
        if([elementName isEqualToString:@"rolesListDataResponse"])
        {
            for (int i = 0; i<[RolelistArray count]; i++)
            {
                RoleSplitarray=[[RolelistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                [RoleCodeIdaArray addObject:[[RoleSplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"CodeId ==" withString:@""]];
                [RoleValueArray addObject:[[RoleSplitarray objectAtIndex:2]stringByReplacingOccurrencesOfString: @"Value1==" withString:@""]];
                NSLog(@"role name %@",RoleCodeIdaArray);
            }
            
            [ParticipantsPicker reloadAllComponents];
            
            
        }
    }
    
}



//-----Picker Delegates------------

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
        
        return [RoleValueArray count];
    }
    else{
        return [FlagArray count];
        
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==1) {
        return [ResourceNameArray objectAtIndex:row];
    }
    if (picker.tag==2) {
        return [RoleValueArray objectAtIndex:row];
    }
    else{
        return [FlagArray objectAtIndex:row];
        
    }
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==1) {
        ParticipantsNametxtfld.text=[ResourceNameArray objectAtIndex:row];
        ResourceIdstr = [ResourceIdArray objectAtIndex:row];
        [ParticipantsPicker removeFromSuperview];
    }
    if (pickerView.tag==2) {
        Roletxtfld.text=[RoleValueArray objectAtIndex:row];
        RoleCodestr = [RoleCodeIdaArray objectAtIndex:row];
        
        [ParticipantsPicker removeFromSuperview];
    }

    if (pickerView.tag==3) {
        Flagtxtfld.text=[FlagArray objectAtIndex:row];
        [ParticipantsPicker removeFromSuperview];
        Flagstr = [FlagArray objectAtIndex:row];
    }
    
    
    
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
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
