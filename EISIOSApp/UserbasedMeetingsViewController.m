//
//  UserbasedMeetingsViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 11/24/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "UserbasedMeetingsViewController.h"

@interface UserbasedMeetingsViewController ()
{
    
     NSString *Useridstr,*Usernamestr,*orgIdstr,*Usertypestr;
    NSArray *a,*b,*goalssplitarray,*Confsplitarray,*MeetingInfoSplitArray;
    NSXMLParser *InfoxmlParser;
    NSMutableArray *MeetingInfodataArray,*goalsArray,*participentarray,*confroomarray,*MeetingInfo,*ResourceNamearray,*Rolearray,*ObjectiveTypearray,*ObjectiveDescrptionarray,*Roomnamearray,*Datearray,*ConfTimearray,*MeetingTitleArray,*MeetingDescriptionArray,*ProjectArray,*MeetingOwnerArray,*ObjectiveTypeArray,*ObjectiveTimeArray,*ConferenceDateArray,*RoleArray,*uniqueDescriptionArray,*uniqueObjeciteTypeArray,*uniqueObjectiveTimeArry,*uniqueResourceName,*dictionaryArray,*dictionaryArray1Vaiues,*Participentsplitarray,*MeetingSplitArray;
    NSString *MeetingSplitstr,*ResourceNameStr,*RoleNameStr;
    
    NSDictionary *ResourceDitionary;
}
@end

@implementation UserbasedMeetingsViewController



- (void)viewDidLoad
{
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
  
    NSLog(@"meeting owner aray is @",MeetingOwnerArray);
    
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTappeddd) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
  
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    
    
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:Logoutpagebatbtn,Homepagebatbtn,nil];
    
    
    
    UIButton *Eisbutton =  [UIButton buttonWithType:UIButtonTypeCustom];
    //[Eisbutton setImage:[UIImage imageNamed:@"homeicon.png"] forState:UIControlStateNormal];
    
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
    Servicecall = [[Webservices alloc]init];
    NSLog(@"meeting id %@",_MeetingId);
    NSString *MeetingInfourl = @"MeetingInfoService";
    NSDictionary *credentials = @{@"meetingId":_MeetingId};
    [Servicecall MeetingInfourl:MeetingInfourl MeetingDetails:credentials];
    [Servicecall setDelegate:self];
    
    a = [[NSArray alloc ]initWithObjects:@"Meeting",@"Time",@"Issues",@"Task",@"Requirement",@"Dash Board",@"Project Expenses", nil];
    b = [[NSArray alloc ]initWithObjects:@"Meeting Details ",@"Goals&AgendaDetails",@"Conference Room",@"Participants",nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)didFinishData:(id)Data
{
    InfoxmlParser = [[NSXMLParser alloc]initWithData:Data];
    InfoxmlParser.delegate = self;
    [InfoxmlParser parse];
}




-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"meetingInfoResponse"])
    {
        
        MeetingSplitstr         = [[NSString alloc] init];
        //serverdataarray         = [[NSArray alloc] init];
        //serverdataarray1        = [[NSArray alloc] init];
        MeetingDescriptionArray=[[NSMutableArray alloc]init];
        ProjectArray=[[NSMutableArray alloc]init];
        MeetingOwnerArray=[[NSMutableArray alloc]init];
        MeetingInfodataArray    = [[NSMutableArray alloc] init];
        confroomarray           = [[NSMutableArray alloc] init];
        participentarray        = [[NSMutableArray alloc] init];
        MeetingInfo             = [[NSMutableArray alloc] init];
        goalsArray              = [[NSMutableArray alloc] init];
        ObjectiveTypearray = [[NSMutableArray alloc] init];
        ObjectiveDescrptionarray =[[NSMutableArray alloc] init];
        goalssplitarray =[[NSArray alloc] init];
        Participentsplitarray =[[NSArray alloc] init];
        Confsplitarray =[[NSArray alloc] init];
        Roomnamearray = [[NSMutableArray alloc] init];
        Datearray = [[NSMutableArray alloc] init];
        ResourceNamearray = [[NSMutableArray alloc] init];
        Rolearray = [[NSMutableArray alloc] init];
        ConfTimearray = [[NSMutableArray alloc] init];
        MeetingTitleArray = [[NSMutableArray alloc] init];
        MeetingInfoSplitArray = [[NSArray alloc]init];
        ObjectiveTypeArray=[[NSMutableArray alloc]init];
        ObjectiveTimeArray=[[NSMutableArray alloc]init];
        ConferenceDateArray=[[NSMutableArray alloc]init];
        RoleArray=[[NSMutableArray alloc]init];
        //uniqueDescriptionArray=[[NSMutableArray alloc]init];
        
        
        
        
        
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([string isEqualToString:@"False"])
    {
        
        
    }
    else
    {
        [MeetingInfodataArray addObject:string];
        
        //NSLog(@"sheik kahajvali");
        //NSLog(@"meeting info data %@",MeetingInfodataArray);
        
        
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"meetingInfoResponse"])
    {
        for (int i=0; i<[MeetingInfodataArray count]; i++)
        {
            
MeetingSplitArray=[[MeetingInfodataArray objectAtIndex:i]componentsSeparatedByString:@"###"];
            NSLog(@"meeting split array is %@",MeetingSplitArray);
            
            
                if ([[MeetingSplitArray objectAtIndex:0] isEqualToString:@"MeetingInfo"])
                {
                    [MeetingTitleArray addObject:[[MeetingSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"MeetingTitle==" withString:@""]];
                    
                    [MeetingDescriptionArray addObject:[[MeetingSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"MeetingDescrption==" withString:@""]];
                    
                    
                    [ProjectArray addObject:[[MeetingSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString:@"ProjectName==" withString:@""]];
                }
            if ([[MeetingSplitArray objectAtIndex:0] isEqualToString:@"GoalsAndAgendaInfo"])
            {
                [ObjectiveDescrptionarray addObject:[[MeetingSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"ObjectiveDescrption==" withString:@""]];
                [ObjectiveTypeArray addObject:[[MeetingSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"ObjectiveType==" withString:@""]];
                [ObjectiveTimeArray addObject:[[MeetingSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
            }
           
            if ([[MeetingSplitArray objectAtIndex:0] isEqualToString:@"ConferenceRoomInfo"])
            {
                [confroomarray addObject:[[MeetingSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"RoomName==" withString:@""]];
                [ConferenceDateArray addObject:[[MeetingSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"Date==" withString:@""]];
                [ConfTimearray addObject:[[MeetingSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
                
            }
            //            MeetingSplitstr=[MeetingInfodataArray objectAtIndex:i];
////            str1 = [str1 stringByAppendingString:serverdataarray];
//             NSLog(@"meeting split string is %@",MeetingSplitstr);
            
            if ([[MeetingSplitArray objectAtIndex:0]isEqualToString:@"ParticipantsInfo"])
            {
                
                [ResourceNamearray addObject:[[MeetingSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""]];
                [RoleArray addObject:[[MeetingSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"Role==" withString:@""]];
            }
            
//            {
//                
//                [goalsArray addObject:MeetingSplitstr];
//                for (int j=0; j<[goalsArray count]; j++)
//                {
//                 
//                goalssplitarray = [[goalsArray objectAtIndex:j]componentsSeparatedByString:@"###"];
//                [ObjectiveDescrptionarray addObject:[[goalssplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ObjectiveDescrption==" withString:@""]];
//                [ObjectiveTypearray addObject:[[goalssplitarray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"ObjectiveType==" withString:@""]];
//                
//                    [ObjectiveTimeArray addObject:[[goalssplitarray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
//                    
//                    NSLog(@"agenda description array is %@",ObjectiveDescrptionarray);
//                    NSLog(@"agenda type array is %@",ObjectiveTypearray);
//                    NSLog(@"agenda type array is %@",ObjectiveTimeArray);
//                    
//                    
//                    uniqueDescriptionArray = [[NSMutableArray alloc]init];
//                    
//                    [uniqueDescriptionArray addObjectsFromArray:[[NSSet setWithArray:ObjectiveDescrptionarray] allObjects]];
//                    uniqueObjeciteTypeArray = [[NSMutableArray alloc]init];
//                    
//                    [uniqueObjeciteTypeArray addObjectsFromArray:[[NSSet setWithArray:ObjectiveTypearray] allObjects]];
//                    uniqueObjectiveTimeArry = [[NSMutableArray alloc]init];
//                    
//                    [uniqueObjectiveTimeArry addObjectsFromArray:[[NSSet setWithArray:ObjectiveTimeArray] allObjects]];
//                    NSLog(@"unique array is %@",uniqueDescriptionArray);
//                     NSLog(@"unique array is %@",uniqueObjectiveTimeArry);
//                    
//                }
//                
//
//                
//            }
//            if ([MeetingSplitstr rangeOfString:@"ConferenceRoomInfo"].location == !NSNotFound)
//            {
//                
//                [confroomarray addObject:MeetingSplitstr];
//                for (int j=0; j<[confroomarray count]; j++)
//            
//                {
//                
//               Confsplitarray = [[confroomarray objectAtIndex:j] componentsSeparatedByString:@"###"];
//               [Roomnamearray addObject:[[Confsplitarray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"RoomName==" withString:@""]];
//               [ConferenceDateArray addObject:[[Confsplitarray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"Date==" withString:@""]];
//               [ConfTimearray addObject:[[Confsplitarray objectAtIndex:5]  stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
//                    NSLog(@"room is %@",Roomnamearray);
//
//                }
//            }
//            
//            if ([MeetingSplitstr rangeOfString:@"ParticipantsInfo"].location == !NSNotFound)
//            {
//                
//                [participentarray addObject:MeetingSplitstr];
//                for (int j=0; j<[participentarray count]; j++)
//                {
//                           
//                Participentsplitarray = [[participentarray objectAtIndex:j]componentsSeparatedByString:@"###"];
//                    [Participentsplitarray removeObjectAtIndex:0];
//                    // NSLog(@"split participants is %@",Participentsplitarray);
//                    
//                ResourceNameStr=[[Participentsplitarray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""];
//               RoleNameStr=[[Participentsplitarray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"Role==" withString:@""];
//                
//                    
//                    [ResourceNamearray addObject:ResourceNameStr];
//                    [Rolearray addObject:RoleNameStr];
//               // NSLog(@"goals is %@",Rolearray);
//                    
//                    //NSLog(@"Resource Name array %@",ResourceNamearray);
//                    uniqueResourceName = [[NSMutableArray alloc]init];
//                    
//                    [uniqueResourceName addObjectsFromArray:[[NSSet setWithArray:ResourceNamearray] allObjects]];
//                    
//                    ResourceDitionary=[[NSDictionary alloc]initWithObjects:Rolearray  forKeys:ResourceNamearray];
//                    
//                    dictionaryArray=[[NSMutableArray alloc]initWithArray:[ResourceDitionary allKeys]];
//                    NSLog(@"dictionary keys are %@",dictionaryArray);
//                    dictionaryArray1Vaiues=[[NSMutableArray alloc]initWithArray:[ResourceDitionary allValues]];
//                    NSLog(@"dicitionary values are %@",dictionaryArray1Vaiues);
//                 }
                [UserbasedMeetingTV reloadData];
//            }
//            NSLog(@"resource dictionary is %@",ResourceDitionary);
//        }
            //            NSLog(@"meeting description array is %@",MeetingDescriptionArray);
          
            //NSLog(@"meeting title array is %@",MeetingTitleArray);
            
        }
        NSLog(@"meeting title array is %@",MeetingTitleArray);
        NSLog(@"meeting description array is %@",MeetingDescriptionArray);
        NSLog(@"project name array is %@",ProjectArray);
        NSLog(@"objective description title array is %@",ObjectiveDescrptionarray);
        NSLog(@"objective  type array is %@",ObjectiveTypeArray);
        NSLog(@"objective time array is %@",ObjectiveTimeArray);
        NSLog(@"confrence room array is %@",confroomarray);
        NSLog(@"conference  date array is %@",ConferenceDateArray);
        NSLog(@"conferen time array is %@",ConfTimearray);
    NSLog(@"resource name array is %@",ResourceNamearray);
    NSLog(@"role array is %@",RoleArray);
    
        
//        for (int j=0; j<[goalsmeetingarray count]; j++)
//        {
//            // [goalssplitarray addObject:[goalsmeetingarray objectAtIndex:1]];
//            goalssplitarray = [[goalsmeetingarray objectAtIndex:j] componentsSeparatedByString:@"###"];
//            
//            NSLog(@"log split is %@",goalssplitarray);
//            
//            
//            for (int k=1; k<[goalssplitarray count]; k++)
//                
//            {
//                
//                ObjectiveDescrption = [goalssplitarray objectAtIndex:2];
//                ObjectiveType = [goalssplitarray objectAtIndex:3];
//                
//                goalsagTimestr = [goalssplitarray objectAtIndex:4];
//                
//            }
//            
//            
//            [ObjectiveDescrptionarray addObject:[ObjectiveDescrption stringByReplacingOccurrencesOfString:@"ObjectiveDescrption==" withString:@""]];
//            [ObjectiveTypearray addObject:[ObjectiveType stringByReplacingOccurrencesOfString:@"ObjectiveType==" withString:@""]];
//            [goalsagTimearray addObject:[goalsagTimestr stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
//            NSLog(@"ObjectiveDescrptionarray is chandu %@",ObjectiveDescrptionarray);
//        }
//        [goalsAgendaDetailsTable reloadData];
//                }
//        
//        for (int j=0; j<[confroomarray count]; j++)
//            
//        {
//            // [goalssplitarray addObject:[goalsmeetingarray objectAtIndex:1]];
//            Confsplitarray = [[confroomarray objectAtIndex:j] componentsSeparatedByString:@"###"];
//            NSLog(@"log split is %@",Confsplitarray);
//            
//            
//            for (int k=1; k<[Confsplitarray count]; k++)
//                
//            {
//                
//                RoomNamestr = [Confsplitarray objectAtIndex:3];
//                Datestr = [Confsplitarray objectAtIndex:4];
//                Conftimestr = [Confsplitarray objectAtIndex:5];
//                
//            }
//            
//            
//            [Roomnamearray addObject:[RoomNamestr stringByReplacingOccurrencesOfString:@"RoomName==" withString:@""]];
//            [Datearray addObject:[Datestr stringByReplacingOccurrencesOfString:@"Date==" withString:@""]];
//            [ConfTimearray addObject:[Conftimestr stringByReplacingOccurrencesOfString:@"Time==" withString:@""]];
//            //NSLog(@"ObjectiveDescrptionarray is chandu %@",ObjectiveDescrptionarray);
//        }
//        
//        [conferenceRoomTable reloadData];
//        
//        
//        for (int j=0; j<[participentarray count]; j++)
//        {
//            // [goalssplitarray addObject:[goalsmeetingarray objectAtIndex:1]];
//            Participentsplitarray = [[participentarray objectAtIndex:j] componentsSeparatedByString:@"###"];
//            NSLog(@"log split is %@",Participentsplitarray);
//            
//            
//            for (int k=1; k<[Participentsplitarray count]; k++)
//                
//            {
//                
//                ResourceNamestr = [Participentsplitarray objectAtIndex:3];
//                Rolestr = [Participentsplitarray objectAtIndex:4];
//                
//                
//            }
//            
//            
//            [ResourceNamearray addObject:[ResourceNamestr stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""]];
//            [Rolearray addObject:[Rolestr stringByReplacingOccurrencesOfString:@"Role==" withString:@""]];
//            NSLog(@"ObjectiveDescrptionarray is chandu %@",ObjectiveDescrptionarray);
        }
//        [participantsTable reloadData];
//        
    //      NSLog(@"meeting title array is %@",MeetingTitleArray);
    
//    
//    
//    
//    


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0)
    {
        return [MeetingTitleArray count];
    }
   else if (section ==1)
    {
        return [ObjectiveTimeArray count];
    }
   else if(section ==2)
    {
        return [confroomarray count];
    }
    else
    {
        return [ResourceNamearray count];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    //UILabel *ActionitemsDislbl;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView.layer setBorderColor:[UIColor blackColor].CGColor];
    [tableView.layer setBorderWidth:2.0f];
    tableView.layer.cornerRadius = 12;
    
    tableView.clipsToBounds = YES;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:MyIdentifier];
        
       
        
    }
    
    
    if ([indexPath section]==0)
    {
    //    ActionitemsDislbl = [[UILabel alloc]initWithFrame:CGRectMake(311, 0, 457, 44)];
       
       // cell.textLabel.text =[MeetingTitleArray objectAtIndex:indexPath.row];
        UILabel *meetingtitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 30)];
        meetingtitleLabel.text=@"Meeting Title:";
        meetingtitleLabel.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:meetingtitleLabel];
        NSLog(@"nslogggg");
        
        UILabel *meetingDescription=[[UILabel alloc]initWithFrame:CGRectMake(10, meetingtitleLabel.frame.origin.y+40, 180, 30)];
        meetingDescription.text=@"Meeting Description:";
        meetingDescription.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:meetingDescription];
        NSLog(@"nslogggg1");
        UILabel *projectName=[[UILabel alloc]initWithFrame:CGRectMake(10, meetingDescription.frame.origin.y+40, 180, 30)];
        projectName.text=@"Project Name:";
        projectName.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:projectName];
        NSLog(@"nslogggg2");
        
        UILabel *meetingOwnerName=[[UILabel alloc]initWithFrame:CGRectMake(10, projectName.frame.origin.y+40, 220, 30)];
        meetingOwnerName.text=@"Metting Owner Name:";
        meetingOwnerName.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:meetingOwnerName];
        NSLog(@"nslogggg3");
        
        NSLog(@"owner name is %@",_ownerName);
        UILabel *meetingtitleText=[[UILabel alloc]initWithFrame:CGRectMake(meetingtitleLabel.frame.origin.x+300, 10, 180, 30)];
        meetingtitleText.text=[MeetingTitleArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:meetingtitleText];
        
        UILabel *meetingDescriptionText=[[UILabel alloc]initWithFrame:CGRectMake(meetingDescription.frame.origin.x+300, meetingtitleText.frame.origin.y+40, 180, 30)];
        meetingDescriptionText.text=[MeetingDescriptionArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:meetingDescriptionText];
        NSLog(@"nslogggg5");

        UILabel *projectText=[[UILabel alloc]initWithFrame:CGRectMake(projectName.frame.origin.x+300, meetingDescriptionText.frame.origin.y+40, 200, 30)];
        projectText.text=[ProjectArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:projectText];
        NSLog(@"nslogggg6");
        
        UILabel *meetingOwnerText=[[UILabel alloc]initWithFrame:CGRectMake(meetingOwnerName.frame.origin.x+300, projectText.frame.origin.y+40, 180, 30)];
        meetingOwnerText.text=_ownerName;
        [cell.contentView addSubview:meetingOwnerText];
        NSLog(@"nslogggg7");

        
        


//
//        UILabel *meetingDescriptionText=[[UILabel alloc]initWithFrame:CGRectMake(50, meetingtitleText.frame.origin.y+30, 180, 30)];
//        meetingDescription.text=[MeetingDescriptionArray objectAtIndex:indexPath.row];
//        [cell.contentView addSubview:meetingDescriptionText];
//        
//        UILabel *ProjectText=[[UILabel alloc]initWithFrame:CGRectMake(50, meetingDescriptionText.frame.origin.y+30, 180, 30)];
//        ProjectText.text=[ProjectArray objectAtIndex:indexPath.row];
//        [cell.contentView addSubview:ProjectText];

        
        
        //return cell;

    }
   else if ([indexPath section]==1)
    {
        
        UILabel *ObjectiveDescriptionLabelText=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 30)];
        ObjectiveDescriptionLabelText.text=[ObjectiveDescrptionarray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ObjectiveDescriptionLabelText];
        NSLog(@"hee");
        
        UILabel *ObjectiveTypeLabelText=[[UILabel alloc]initWithFrame:CGRectMake(ObjectiveDescriptionLabelText.frame.origin.x+300,10, 180, 30)];
        ObjectiveTypeLabelText.text=[ObjectiveTypeArray objectAtIndex:indexPath.row];
       [cell.contentView addSubview:ObjectiveTypeLabelText];
         NSLog(@"hee1");

        UILabel *TimeLabelText=[[UILabel alloc]initWithFrame:CGRectMake(ObjectiveTypeLabelText.frame.origin.x+300,10, 180, 30)];
        TimeLabelText.text=[ObjectiveTimeArray objectAtIndex:indexPath.row];
        TimeLabelText.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:TimeLabelText];
         NSLog(@"hee2");

    }
else if ([indexPath section]==2)
    {
        
        UILabel *ConferenceNmaeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 30)];
        ConferenceNmaeLabel.text=[confroomarray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ConferenceNmaeLabel];
        
        UILabel *ConferenceDate=[[UILabel alloc]initWithFrame:CGRectMake(ConferenceNmaeLabel.frame.origin.x+
                                                                         300,10, 180, 30)];
        ConferenceDate.text=[ConferenceDateArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ConferenceDate];
        
        UILabel *ConferenceTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(ConferenceDate.frame.origin.x+300,10, 180, 30)];
        ConferenceTimeLabel.text=[ConfTimearray objectAtIndex:indexPath.row];
        ConferenceTimeLabel.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:ConferenceTimeLabel];
        

    }
   else
    {
        UILabel *ResourceNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 30)];
        ResourceNameLabel.text=[ResourceNamearray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ResourceNameLabel];
        
        UILabel *RoleNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ResourceNameLabel.frame.origin.x+300,10, 180, 30)];
        RoleNameLabel.text=[RoleArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:RoleNameLabel];
        

    }
    
        return cell;

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 200;
    }
    else if (indexPath.section==1)
    {
    return  50;
    }
    else if (indexPath.section==2)
    {
        return 50;
    }
    else
    {
        150;
    }
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40; //play around with this value
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1){
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 120, 120)] ;
//        [headerView.layer setBorderColor:[UIColor blackColor].CGColor];
//        [headerView.layer setBorderWidth:2.0f];
//        headerView.layer.cornerRadius = 12;
//        headerView.clipsToBounds = YES;
//
//        
//        return @"Meetings";
//       
//    }
//    if (section == 0){
//    
//        return @"headts";
//        
//    }
//    return @"";
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    [headerView.layer setBorderColor:[UIColor blackColor].CGColor];
    [headerView.layer setBorderWidth:2.0f];
    headerView.layer.cornerRadius = 12;
    headerView.clipsToBounds = YES;

    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 28)];
    [label setFont:[UIFont boldSystemFontOfSize:25]];
    NSString *string =[b objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [headerView addSubview:label];
    [headerView setBackgroundColor:[UIColor grayColor]]; //your background color...
    return headerView;
}


-(void)HomePagebtnTappeddd
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
      NSLog(@"homw button clicked");
}

-(IBAction)HomeBtnclicked:(id)sender
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
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

@end
