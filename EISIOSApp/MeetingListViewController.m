//
//  MeetingListViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 10/31/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "MeetingListViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
#import "Toast+UIView.h"
//#import "SWRevealViewController.h"


@interface MeetingListViewController ()
{
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
    NSString *Useridstr,*Usernamestr,*Loginownerid;
    NSXMLParser *xmlParser,*xmlParser1,*xmlParser2,*xmlParser3,*xmlParser4,*xmlParser5,*actionItemKillXmlParser;
    
    //-----------------------Meetinglist--------------
    NSMutableArray *MeetingListArray,*MeetingtitleArray,*MeetingIdArray,*ProjectIdArray,*StartTimeArray,*indexArray,*HoursArrray,*MeetingTypeArray,*ProjectNameArray,*MeetingDateArray,*ConferenceRoomNameArray,*MeetingDescriptionArray,*MeetingTypeIdArray,*OwnerIDArray,*OwnerNameArray,*uniqueMeetingDateArray,*sercharray,*A,*B,*searcharray1,*refarray1,*tempArray2,*tempArray3,*meetingdateArray,*tempArray4,*tempArray5,*tempArray6,*tempArray7,*tempArray8,*tempArray9,*resultarray,*resultarray2,*resultarray4;
    NSArray *SplitmeetingList,*AssendingDateArray;
    NSString *meetingidStr;
    BOOL isRowSelected;
    
    //----------------------Actionitems-----------
    
    NSMutableArray *Actionitemsarray,*ActitemlisttitleArray,*MeetingdesArray,*ObjeIdArray,*AgendaMeetingIdArray,*AgendaTimeBudgetedAray,*AgendaMeetingDate,*AgendaMeetingProjId,*AgendaMeetingMeetingID;
    NSArray *ActionitemsSplitarray;
    NSMutableString *agendaIdStr,*agendaMeetingIdStr;
    
    
    //---------------------NotesCountList----------------
    
    NSMutableArray *NotesListresponce,*ActionitemCountArray,*NotesCountArray,*FeedbackCountArray;
    NSArray *NotesSplitarray;
    NSMutableString *actionlistcountstr,*noteslistcountstr,*Feedbackcountstr;
    
    
    //--------------------PublicDiscription-------------
    
    NSMutableArray *PublicNoteslistarray,*PublicNote_DescriptionArray;
    NSArray *PublicNotesSplitarray;
    
    NSMutableString *publicdescString;
    
    
    //---------------ActionItmTabList-----------------
    
    NSMutableArray *ActionItemTabListArray,*ActionItemTabListSplitArray,*actionitemmeetingidarray,*actionItemStausArray,*ActionItemMeetingTitleArray,*ActionITemMeetingOwnerNameArray,*actionitemCreatedbyIdArray,*actionitemAssignedIdArray,*actionitemmeetingowneridarray,*actionitemdescarray,*actionitemidarray;
    
    NSMutableString *actionItemCreatedIdStr,*actionItemAssignedIdStr,*actionItemIdStr,*actionItemStatusStr,*actionItemMeetingTitleStr,*ActionItemOwnernameStr;
}
@end

@implementation MeetingListViewController
@synthesize bn;

- (void)viewDidLoad
{
    //    NSMutableArray *newArray = [[NSMutableArray alloc] initWithObjects:@"Off White", @"Fan", @"Off White", @"Deluxe", @"Fan", nil];
    //    NSMutableArray *countArray = [NSMutableArray new];
    //    int countInt = 1;
    //    for (int i = 0; i < newArray.count; ++i) {
    //        NSString *string = [newArray objectAtIndex:i];
    //        for (int j = i+1; j < newArray.count; ++j) {
    //            if ([string isEqualToString:[newArray objectAtIndex:j]]) {
    //                [newArray removeObjectAtIndex:j];
    //                countInt++;
    //            }
    //        }
    //        [countArray addObject:[NSNumber numberWithInt:countInt]];
    //        countInt = 1;
    //    }
    //    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithObjects:newArray, countArray, nil];
    //    NSLog(@"%@", finalArray);
    
    [MeetingListTV reloadData];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    
    
    // select meeting arrays
    
    meetingdatesArray=[[NSMutableArray alloc]initWithObjects:@"Today",@"Tomorrow",@"Next Week",nil];
    //flagstr=@"Current";
    meetingTypeLabel.text=@"Today";
    
    indexArray = [[NSMutableArray alloc]init];
    CreatMeetingtV = [[CreatMeetingViewController alloc]init];
    ActionItemsVC  = [[ActionItemsViewController alloc]init];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    Loginownerid= [defaults objectForKey:@"OrgId"];
    NSLog(@"ids is %@ %@",Useridstr,Loginownerid);
    
    
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
    Notebtn.layer.cornerRadius = 14;
    Notebtn.layer.borderWidth = 2;
    Notebtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    Actionitembtn.layer.cornerRadius = 14;
    Actionitembtn.layer.borderWidth = 2;
    Actionitembtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    Feedbackbtn.layer.cornerRadius = 14;
    Feedbackbtn.layer.borderWidth = 2;
    Feedbackbtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    PublicNotesView.layer.cornerRadius = 14;
    PublicNotesView.layer.borderColor = [UIColor blackColor].CGColor;
    PublicNotesView.layer.borderWidth = 2.0f;
    
    PublicNotestxt.layer.cornerRadius = 14;
    PublicNotestxt.layer.borderColor = [UIColor blackColor].CGColor;
    PublicNotestxt.layer.borderWidth = 2.0f;
    
    uniqueMeetingDateArray=[[NSMutableArray alloc]init];
    //[uniqueMeetingDateArray addObject:@"All"];
    
    [self meetingList];
    
    [self actionItemTab];
    
    //uniqueMeetingDateArray=[[NSMutableArray alloc]initWithObjects:@"All", nil];
    //NSLog(@"unique meeting date array is %@",uniqueMeetingDateArray);
    tempArray2=[[NSMutableArray alloc]init];
    tempArray3=[[NSMutableArray alloc]init];
    tempArray4=[[NSMutableArray alloc]init];
    tempArray5=[[NSMutableArray alloc]init];
    tempArray6=[[NSMutableArray alloc]init];
    tempArray7=[[NSMutableArray alloc]init];
    tempArray8=[[NSMutableArray alloc]init];
    tempArray9=[[NSMutableArray alloc]init];
    
    
    [super viewDidLoad];
    
    
    
    
}
-(void)CreatmeetingV
{
    CreatMeetingtV  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatView"];
    CreatMeetingtV.navigationTitlestr = @"Create New Meeting";
    CreatMeetingtV.SavebtnTitlestr = @"Save";
    CreatMeetingtV.locationUseBool = NO;
    [self.navigationController pushViewController:CreatMeetingtV animated:YES];
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
-(void)meetingList
{
    flagstr=meetingTypeLabel.text;
    
    NSString *meetingurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/meetingList?userId=%@&flag=%@",Useridstr,flagstr];
    NSString *encode=[meetingurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall meetingUrl:encode];
    [Servicecall setDelegate:self];
    
    //    NSLog(@"flagstr is %@",flagstr);
    //
    //
    //    NSLog(@"user id str is %@",Useridstr);
    //    Servicecall = [[Webservices alloc]init];
    //    NSString *marketlist = @"MeetingsListService";
    //    NSDictionary *credentials = @{@"userid":Useridstr,@"flag":flagstr};
    //    [Servicecall MeetingListurl:marketlist Listparameters:credentials];
    //    [Servicecall setDelegate:self];
}

// agenda list service

//    NSString *actionitemlisturl = @"ActionItemsService";
//    NSDictionary *credentials1 = @{@"userid":Useridstr};
//    [Servicecall ActionitemListurl:actionitemlisturl Listparameters:credentials1];
//


//-(void)actionItemList
//{
//    Servicecall = [[Webservices alloc]init];
//
//     NSDictionary *credentials = @{@"userid":Useridstr};
//
//    [Servicecall setDelegate:self];
//
//}
-(void)actionItemTab
{
    Servicecall=[[Webservices alloc]init];
    NSString *Saveactionitemsurl = [NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/actionItemHPList?userId=%@",Useridstr];
    NSString *encode=[Saveactionitemsurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Servicecall actionitemlist:encode];
    [Servicecall setDelegate:self];
    NSLog(@"user id str is %@",Useridstr);
    
}
-(void)actionitemList:(id)actionitems
{
    NSDictionary *dict=actionitems;
    NSLog(@"dict is %@",dict);
    
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Empty list" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        actionitemmeetingidarray=[NSMutableArray new];
        actionItemStausArray=[NSMutableArray new];
        actionitemdescarray=[NSMutableArray new];
        ActionItemMeetingTitleArray=[NSMutableArray new];
        ActionITemMeetingOwnerNameArray=[NSMutableArray new];
        actionitemdescarray=[NSMutableArray new];
        actionitemCreatedbyIdArray=[NSMutableArray new];
        actionitemAssignedIdArray=[NSMutableArray new];
        actionitemmeetingowneridarray=[NSMutableArray new];
        actionitemidarray=[NSMutableArray new];
        
        NSMutableArray *resultarray3=[[NSMutableArray alloc]init];
        
        resultarray3=[dict objectForKey:@"resAL"];
        NSLog(@"result array is %@",resultarray3);
        
        for (NSDictionary *fidd2 in resultarray3)
        {
            [actionitemdescarray addObject:[fidd2 valueForKey:@"description"]];
            [actionItemStausArray addObject:[fidd2 valueForKey:@"actionItemStatus"]];
            [actionitemidarray addObject:[fidd2 valueForKey:@"noteId"]];
            [actionitemmeetingowneridarray addObject:[fidd2 valueForKey:@"meetingOwnerId"]];
            [actionitemAssignedIdArray addObject:[fidd2 valueForKey:@"assignedTo"]];
            [actionitemCreatedbyIdArray addObject:[fidd2 valueForKey:@"createdBy"]];
            [actionitemmeetingidarray addObject:[fidd2 valueForKey:@"meetingId"]];
            [ActionITemMeetingOwnerNameArray addObject:[fidd2 valueForKey:@"meetingOwnerName"]];
            [ActionItemMeetingTitleArray addObject:[fidd2 valueForKey:@"meetingTitle"]];
            
        }
        [ActionItemListTV reloadData];
        
    }
}

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
//       // if([[managedObject valueForKey:@"username"] isEqualToString:user_id]
//        Usernamestr  = [managedObject valueForKey:@"username"];
//        Useridstr  = [managedObject valueForKey:@"userid"];
//        NSLog(@"hai %@ %@",Useridstr,Usernamestr);
//
//    }
//}

-(void)meetingList:(id)MeetingList
{
    NSDictionary *dict=MeetingList;
    NSLog(@"dict is %@",dict);
    
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Empty list" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //MeetingListArray   = [[NSMutableArray alloc] init];
        //SplitmeetingList   = [[NSArray alloc] init];
        MeetingIdArray     = [[NSMutableArray alloc] init];
        StartTimeArray     = [[NSMutableArray alloc] init];
        ProjectIdArray     = [[NSMutableArray alloc] init];
        MeetingtitleArray  = [NSMutableArray new];
        HoursArrray        = [NSMutableArray new];
        MeetingDescriptionArray= [NSMutableArray new];
        MeetingTypeArray   = [NSMutableArray new];
        ProjectNameArray   = [NSMutableArray new];
        MeetingDateArray   = [NSMutableArray new];
        ConferenceRoomNameArray= [[NSMutableArray alloc]init];
        MeetingTypeIdArray  = [NSMutableArray new];
        OwnerIDArray       = [NSMutableArray new];
        OwnerNameArray=[NSMutableArray new];
        meetingidStr=[NSString new];
        meetingdateArray=[NSMutableArray new];
        AssendingDateArray=[NSMutableArray new];
        
        resultarray=[[NSMutableArray alloc]init];
        resultarray = [dict objectForKey:@"resAL"];
        for (NSDictionary *fidd in resultarray)
        {
            [MeetingIdArray addObject:[fidd valueForKey:@"meetingId"]];
            [MeetingtitleArray addObject:[fidd valueForKey:@"meetingTitle"]];
            [StartTimeArray addObject:[fidd valueForKey:@"meetingStartTime"]];
            [ProjectIdArray addObject:[fidd valueForKey:@"meetingProjectId"]];
            [MeetingDescriptionArray addObject:[fidd valueForKey:@"meetingDescription"]];
            [MeetingTypeArray addObject:[fidd valueForKey:@"meetingType"]];
            [ProjectNameArray addObject:[fidd valueForKey:@"projectName"]];
            [MeetingDateArray addObject:[fidd valueForKey:@"meetingDate"]];
            [ConferenceRoomNameArray addObject:[fidd valueForKey:@"conferenceRoom"]];
            [MeetingTypeIdArray addObject:[fidd valueForKey:@"meetingTypeId"]];
            [OwnerIDArray addObject:[fidd valueForKey:@"meetingOwnerId"]];
            [HoursArrray addObject:[fidd valueForKey:@"meetingDuration"]];
            
        }
        [MeetingListTV reloadData];
        
        NSLog(@"hai %@",MeetingIdArray);
        NSLog(@"meetingtitle %@",MeetingtitleArray);
        NSLog(@"starttime %@",StartTimeArray);
        NSLog(@"Projectid %@",ProjectIdArray);
        NSLog(@"Meetingdesc %@",MeetingDescriptionArray);
        NSLog(@"Meetingtype %@",MeetingTypeArray);
        NSLog(@"hours array is %@",HoursArrray);
        
        //         NSLog(@"hai %@",MeetingIdArray);
        //         NSLog(@"hai %@",MeetingIdArray);
        
        //
    }
    
}

-(void)agendaList:(id)AgendaList;
{
    NSDictionary *dict=AgendaList;
    NSLog(@"dict is %@",dict);
    
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Empty list" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //Actionitemsarray= [NSMutableArray new];
        //ActionitemsSplitarray   = [NSArray new];
        ActitemlisttitleArray   = [NSMutableArray new];
        MeetingdesArray         = [NSMutableArray new];
        //ObjeIdArray             = [NSMutableArray new];
        AgendaMeetingIdArray    = [NSMutableArray new];
        agendaMeetingIdStr      =[NSMutableString new];
        AgendaTimeBudgetedAray    =[NSMutableArray new];
        AgendaMeetingDate=[NSMutableArray new];
        AgendaMeetingProjId=[NSMutableArray new];
        AgendaMeetingMeetingID=[NSMutableArray new];
        ActionItemMeetingTitleArray=[NSMutableArray new];
        resultarray2=[[NSMutableArray alloc]init];
        resultarray2=[dict objectForKey:@"resAL"];
        
        for (NSDictionary *fid in resultarray2)
        {
            [MeetingdesArray addObject:[fid valueForKey:@"agendaDescription"]];
            [AgendaMeetingIdArray addObject:[fid valueForKey:@"agendaId"]];
            [AgendaTimeBudgetedAray addObject:[fid valueForKey:@"agendaTime"]];
            [AgendaMeetingDate addObject:[fid valueForKey:@"meetingDate"]];
            [AgendaMeetingMeetingID addObject:[fid valueForKey:@"meetingId"]];
            [ActionItemMeetingTitleArray addObject:[fid valueForKey:@"meetingTitle"]];
            [ProjectIdArray addObject:[fid valueForKey:@"projectId"]];
        }
        
        [AgendaListTv reloadData];
        NSLog(@"meetind id str is %@",MeetingdesArray);
        NSLog(@"agenda descr is :%@",ActionItemMeetingTitleArray);
        NSLog(@"project id is :%@",ProjectIdArray);
    }
}
-(void)notesactionfbcount:(id)notesactionfbCount
{
    NSDictionary *dict=notesactionfbCount;
    NSLog(@"dict is %@",dict);
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"counts are empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //                NotesListresponce      = [NSMutableArray new];
        //                ActionitemCountArray   = [NSMutableArray new];
        //                FeedbackCountArray     = [NSMutableArray new];
        //                NotesListresponce      = [NSMutableArray new];
        //                NotesSplitarray        = [NSArray new];
        actionlistcountstr     = [[NSMutableString alloc] init];
        noteslistcountstr      = [[NSMutableString alloc] init];
        Feedbackcountstr       = [[NSMutableString alloc] init];
        actionlistcountstr=[dict valueForKey:@"actionItemCount"];
        noteslistcountstr=[dict valueForKey:@"notesCount"];
        Feedbackcountstr=[dict valueForKey:@"feedbackCount"];
        
        Feedbacklbl.text=Feedbackcountstr;
        Actionitemlbl.text=actionlistcountstr;
        Notescountlbl.text=noteslistcountstr;
    }
}

-(void)publicnotesdec:(id)publicnoteDec
{
    
    NSDictionary *dict=publicnoteDec;
    NSLog(@"dict is %@",dict);
    
    if ([[dict objectForKey:@"statusMessage"]isEqualToString:@"No Data"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"counts are empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        PublicNote_DescriptionArray  = [NSMutableArray new];
        resultarray4=[[NSMutableArray alloc]init];
        resultarray4 = [dict objectForKey:@"resAL"];
        for (NSDictionary *fid in resultarray4)
        {
            [PublicNote_DescriptionArray addObject:[fid valueForKey:@"notesDescription"]];
            
        }
        NSLog(@"note des is %@:",PublicNote_DescriptionArray);
        [PublicCountTV reloadData];
        
    }
}
//-(void)didFinishService:(id)Userlogindetails
//{
//
//    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
//    xmlParser.delegate = self;
//    [xmlParser parse];
//
//    actionItemKillXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
//    actionItemKillXmlParser.delegate=self;
//    [actionItemKillXmlParser parse];
//
//    xmlParser1 = [[NSXMLParser alloc]initWithData:Userlogindetails];
//    xmlParser1.delegate = self;
//    [xmlParser1 parse];
//
//
//}
////-(void)didfinishactionitemlist:(id)actionitemlist
////{
////    }
//-(void)didNotesCountFinished:(id)Notescountlist
//{
//    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
//    xmlParser2.delegate = self;
//    [xmlParser2 parse];
//
//}
//
//-(void)Serviceactiondone:(id)result
//{
//    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
//    xmlParser3.delegate = self;
//    [xmlParser3 parse];
//}
//-(void)Serviceactiondone1:(id)result
//{
//    xmlParser4 =[[NSXMLParser alloc]initWithData:result];
//    xmlParser4.delegate = self;
//    [xmlParser4 parse];
//
//    xmlParser5=[[NSXMLParser alloc]initWithData:result];
//    xmlParser5.delegate=self;
//    [xmlParser5 parse];
//}
//
//-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
//  namespaceURI:(NSString *)namespaceURI qualifiedName:
//(NSString *)qName attributes:(NSDictionary *)attributeDict
//{
//    if (parser==xmlParser)
//    {
//        if([elementName isEqualToString:@"userMeetingsListResponse"])
//        {
//
//            MeetingListArray   = [[NSMutableArray alloc] init];
//            SplitmeetingList   = [[NSArray alloc] init];
//            MeetingIdArray     = [[NSMutableArray alloc] init];
//            StartTimeArray     = [[NSMutableArray alloc] init];
//            ProjectIdArray     = [[NSMutableArray alloc] init];
//            MeetingtitleArray  = [NSMutableArray new];
//            HoursArrray        = [NSMutableArray new];
//            MeetingDescriptionArray= [NSMutableArray new];
//            MeetingTypeArray   = [NSMutableArray new];
//            ProjectNameArray   = [NSMutableArray new];
//            MeetingDateArray   = [NSMutableArray new];
//            ConferenceRoomNameArray= [NSMutableArray new];
//            MeetingTypeIdArray  = [NSMutableArray new];
//            OwnerIDArray       = [NSMutableArray new];
//            OwnerNameArray=[NSMutableArray new];
//            meetingidStr=[NSString new];
//            meetingdateArray=[NSMutableArray new];
//            AssendingDateArray=[NSMutableArray new];
//
//
//
//        }
//    }
//
//    if (parser==xmlParser1)
//    {
//        if([elementName isEqualToString:@"agendaListDataResponse"])
//        {
//
//            Actionitemsarray        = [NSMutableArray new];
//            ActionitemsSplitarray   = [NSArray new];
//            ActitemlisttitleArray   = [NSMutableArray new];
//            MeetingdesArray         = [NSMutableArray new];
//            ObjeIdArray             = [NSMutableArray new];
//            AgendaMeetingIdArray    = [NSMutableArray new];
//            agendaMeetingIdStr      =[NSMutableString new];
//            AgendaTimeBudgetedAray    =[NSMutableArray new];
//            AgendaMeetingDate=[NSMutableArray new];
//            AgendaMeetingProjId=[NSMutableArray new];
//            AgendaMeetingMeetingID=[NSMutableArray new];
//        }
//    }
//    if (parser == xmlParser2)
//    {
//        if([elementName isEqualToString:@"countListResponse"])
//        {
//            NotesListresponce      = [NSMutableArray new];
//            ActionitemCountArray   = [NSMutableArray new];
//            FeedbackCountArray     = [NSMutableArray new];
//            NotesListresponce      = [NSMutableArray new];
//            NotesSplitarray        = [NSArray new];
//            actionlistcountstr     = [[NSMutableString alloc] init];
//            noteslistcountstr      = [[NSMutableString alloc] init];
//            Feedbackcountstr       = [[NSMutableString alloc] init];
//        }
//    }
//    if (parser == xmlParser4)
//    {
//        if([elementName isEqualToString:@"descriptionResponse"])
//        {
//            PublicNoteslistarray         = [NSMutableArray new];
//            PublicNote_DescriptionArray  = [NSMutableArray new];
//            PublicNotesSplitarray        =[NSArray new];
//            publicdescString=[[NSMutableString alloc]init];
//        }
//    }
//    else
//    {
//        if ([elementName isEqualToString:@"actionItemBasedOnUserIdResponse"])
//        {
//            ActionItemTabListArray=[NSMutableArray new];
//            ActionItemTabListSplitArray=[NSMutableArray new];
//            ActionItemTabListDisplayArray=[NSMutableArray new];
//            actionItemCreatedIdStr=[NSMutableString new];
//            actionItemAssignedIdStr=[NSMutableString new];
//            actionItemIdStr=[NSMutableString new];
//            actionItemStatusStr=[NSMutableString new];
//            actionItemStausArray=[NSMutableArray new];
//            actionItemMeetingTitleStr=[NSMutableString new];
//            ActionItemOwnernameStr=[NSMutableString new];
//            ActionItemMeetingTitleArray=[NSMutableArray new];
//            ActionITemMeetingOwnerNameArray=[NSMutableArray new];
//        }
//    }
//
//
//}
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
//{
//    if (parser == xmlParser)
//    {
//        if ([string isEqualToString:@"Flase"])
//
//        {
////            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"List Empty" message:@"Meeting List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
////
////            [alert show];
//
//        }
//
//        else
//        {
//
//            [MeetingListArray addObject:string];
//        }
//
//
//    }
//   else if (parser == xmlParser1)
//    {
//        if ([string isEqualToString:@"Flase"])
//
//        {
//            UIAlertView *alert3=[[UIAlertView alloc] initWithTitle:@"" message:@"Agenda List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//
//            [alert3 show];
//            NSLog(@"action items list is");
//
//        }
//
//        else
//        {
//
//            [Actionitemsarray addObject:string];
//
//        }
//    }
//
//    if (parser == xmlParser2)
//    {
//        [NotesListresponce addObject:string];
//        // NSLog(@"notescount LIST %@" ,NotesListresponce);
//
//    }
//    if (parser == xmlParser3)
//    {
//        //[NotesListresponce addObject:string];
//        // NSLog(@"publiccount LIST %@" ,string);
//        PublicCountlbl.text = [string stringByReplacingOccurrencesOfString:@"###COUNT=" withString:@""];
//    }
//    if (parser == xmlParser4)
//    {
//        if ([string isEqualToString:@"Flase"])
//        {
//            //            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"List Empty" message:@"Public List Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            //
//            //            [alert show];
//        }
//        else
//        {
//            [PublicNoteslistarray addObject:string];
//            NSLog(@"publicdis LIST %@" ,PublicNoteslistarray);
//        }
//
//    }
//    if(parser==xmlParser5)
//    {
//        if ([string isEqualToString:@"Flase"])
//        {
//            NSLog(@"response is Flase");
//
//        }
//        else
//        {
//            [ActionItemTabListArray addObject:string];
//        }
//    }
//    else
//    {
//        if ([string isEqualToString:@"Inserted"])
//        {
//            [self actionItemTab];
//            [ActionItemListTV reloadData];
//            NSLog(@"welcome to action item list kill service");
//        }
//        else
//        {
//
//        }
//
//
//    }
//}
//
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
//  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    if (parser == xmlParser)
//    {
//        if([elementName isEqualToString:@"userMeetingsListResponse"])
//        {
//            for (int i = 0; i<[MeetingListArray count]; i++)
//            {
//                SplitmeetingList=[[MeetingListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
//
//
//                [MeetingtitleArray addObject:[[SplitmeetingList objectAtIndex:2] stringByReplacingOccurrencesOfString: @"MeetingTitle==" withString:@""]];
//                meetingidStr =[[SplitmeetingList objectAtIndex:1] stringByReplacingOccurrencesOfString: @"MeetingId==" withString:@""];
//                [StartTimeArray addObject:[[SplitmeetingList objectAtIndex:3] stringByReplacingOccurrencesOfString: @"StartTime==" withString:@""]];
//                [ProjectIdArray addObject:[[SplitmeetingList objectAtIndex:8] stringByReplacingOccurrencesOfString: @"ProjectId=" withString:@""]];
//                [HoursArrray addObject:[[SplitmeetingList objectAtIndex:4] stringByReplacingOccurrencesOfString: @"Hours=" withString:@""]];
//                [MeetingTypeArray addObject:[[SplitmeetingList objectAtIndex:5] stringByReplacingOccurrencesOfString: @"MeetingType=" withString:@""]];
//                [ProjectNameArray addObject:[[SplitmeetingList objectAtIndex:6] stringByReplacingOccurrencesOfString: @"ProjectName=" withString:@""]];
//                [MeetingDateArray addObject:[[SplitmeetingList objectAtIndex:7] stringByReplacingOccurrencesOfString: @"MeetingDate=" withString:@""]];
//                [ConferenceRoomNameArray addObject:[[SplitmeetingList objectAtIndex:9] stringByReplacingOccurrencesOfString: @"ConferenceRoom=" withString:@""]];
//
//                [MeetingDescriptionArray addObject:[[SplitmeetingList objectAtIndex:14] stringByReplacingOccurrencesOfString: @"MeetingDescription=" withString:@""]];
//
//                [MeetingTypeIdArray addObject:[[SplitmeetingList objectAtIndex:13]
//                                               stringByReplacingOccurrencesOfString: @"MeetingTypeId=" withString:@""]];
//
//                [OwnerIDArray addObject:[[SplitmeetingList objectAtIndex:10] stringByReplacingOccurrencesOfString: @"OwnerId=" withString:@""]];
//                [OwnerNameArray addObject:[[SplitmeetingList objectAtIndex:15]stringByReplacingOccurrencesOfString:@"meetingOwnerName==" withString:@""]];
//
//
//                [MeetingIdArray addObject:meetingidStr];
//                NSLog(@"date array is %@",MeetingDateArray);
//                NSLog(@"start time array is %@",StartTimeArray);
//                NSLog(@"hours array is %@",HoursArrray);
//                NSLog(@"meeting owner array is %@",OwnerNameArray);
//                NSLog(@"meeting type id are %@",MeetingTypeIdArray);
//                NSLog(@"meeting description array is %@",MeetingDescriptionArray);
//                NSLog(@"meeting id developing array is %@",meetingidStr);
//
//            }
//
//            NSLog(@"meeing idstrrrrr12222 %@",meetingidStr);
//            int totalList=[MeetingTypeIdArray count];
//
//            NSString *meetingList=[NSString stringWithFormat:@"%d",totalList];
//
//            totalListLabel.text=meetingList;
//
//
//
//
//            uniqueMeetingDateArray = [[NSMutableArray alloc]init];
//
//            [uniqueMeetingDateArray addObjectsFromArray:[[NSSet setWithArray:MeetingDateArray] allObjects]];
//            [uniqueMeetingDateArray insertObject:@"All" atIndex:0];
//
//
//
//            NSLog(@"unique meeting date array %@",uniqueMeetingDateArray);
//
//
//
//
//            A=[[NSMutableArray alloc]init];
//            searcharray1=[[NSMutableArray alloc]init];
//            refarray1=[[NSMutableArray alloc]initWithArray:MeetingDateArray];
//            A=MeetingDateArray;
//
//            B=[[NSMutableArray alloc]init];
//
//            [MeetingListTV reloadData];
//
//
//        }
//
//
//    }
//
//    if (parser == xmlParser1)
//    {
//        if([elementName isEqualToString:@"agendaListDataResponse"])
//        {
//            for (int i = 0; i<[Actionitemsarray count]; i++)
//            {
//                ActionitemsSplitarray=[[Actionitemsarray objectAtIndex:i] componentsSeparatedByString:@"###"];
//
//                //[ActitemlisttitleArray addObject:[[ActionitemsSplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"MeetingTitle==" withString:@""]];
//
//                [MeetingdesArray addObject:[[ActionitemsSplitarray objectAtIndex:2]stringByReplacingOccurrencesOfString: @"ObjectiveDescription==" withString:@""]];
//
//                agendaIdStr=[[ActionitemsSplitarray objectAtIndex:1]stringByReplacingOccurrencesOfString: @"ObjectiveId==" withString:@""];
//
//                agendaMeetingIdStr=[[ActionitemsSplitarray objectAtIndex:4] stringByReplacingOccurrencesOfString: @"meetingOwnerId==" withString:@""];
//
//                [AgendaTimeBudgetedAray addObject:[[ActionitemsSplitarray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"TimeBudgeted==" withString:@""]];
//
//                [AgendaMeetingDate addObject:[[ActionitemsSplitarray objectAtIndex:5]stringByReplacingOccurrencesOfString:@"meetingDate==" withString:@""]];
//                [AgendaMeetingMeetingID addObject:[[ActionitemsSplitarray objectAtIndex:8]stringByReplacingOccurrencesOfString:@"meetingId==" withString:@""]];
//                [AgendaMeetingProjId addObject:[[ActionitemsSplitarray objectAtIndex:7]stringByReplacingOccurrencesOfString:@"meetingProjectid==" withString:@""]];
//                NSLog(@"data %@" ,MeetingIdArray);
//
//                [ObjeIdArray addObject:agendaIdStr];
//                [AgendaMeetingIdArray addObject:agendaMeetingIdStr];
//                NSLog(@"object id str is %@",ObjeIdArray);
//                NSLog(@"agenda meeting array %@",AgendaMeetingIdArray);
//                NSLog(@"object description is %@",MeetingdesArray);
//                NSLog(@"agenda project id array is %@",AgendaTimeBudgetedAray);
//                NSLog(@"agenda meeting date is %@",AgendaMeetingDate);
//
//
//
//            }
//            NSLog(@"the object id str is 1111111%@",agendaIdStr);
//
//
//            [AgendaListTv reloadData];
//
//
//
//        }
//
//
//    }
//    if (parser == xmlParser2)
//    {
//        if([elementName isEqualToString:@"countListResponse"])
//        {
//            Feedbacklbl.text = @"0";
//            Notescountlbl.text = @"0";
//            Actionitemlbl.text = @"0";
//
//            NSString *splitcountstr;
//            for (int i = 0; i<[NotesListresponce count]; i++)
//            {
//
//                // NotesSplitarray = [[NotesListresponce objectAtIndex:i]componentsSeparatedByString:@"###"];
//                //NSLog(@"notes data %@",NotesSplitarray);
//                splitcountstr =[NotesListresponce objectAtIndex:i];
//                if ([splitcountstr rangeOfString:@"###actionItem"].location != NSNotFound)
//                {
//
//
//                    [actionlistcountstr  appendString:splitcountstr];
//                    if ([actionlistcountstr length]==0)
//                    {
//                        [actionlistcountstr appendString:@"0"];
//                        //NSLog(@"action is ddd%@",actionlistcountstr);
//                        Actionitemlbl.text = actionlistcountstr;
//                    }
//                    else
//                    {
//
//
//                        actionlistcountstr = [actionlistcountstr stringByReplacingOccurrencesOfString:@"###actionItem==" withString:@""];
//                        // NSLog(@"avtion is the %@",actionlistcountstr);
//                        Actionitemlbl.text =actionlistcountstr;
//                    }
//                }
//                else if ([splitcountstr rangeOfString:@"###addNotes"].location != NSNotFound)
//                {
//                    [noteslistcountstr appendString:splitcountstr];
//                    if ([noteslistcountstr length]==0)
//                    {
//                        [noteslistcountstr appendString:@"0"];
//
//
//                        Notescountlbl.text = noteslistcountstr;
//                    }
//                    else
//                    {
//                        noteslistcountstr = [noteslistcountstr stringByReplacingOccurrencesOfString:@"###addNotes==" withString:@""];
//                        //NSLog(@"action is ddd %@",noteslistcountstr);
//                        Notescountlbl.text = noteslistcountstr ;
//                    }
//
//
//
//
//
//
//                }
//
//
//                else if ([splitcountstr rangeOfString:@"###feedback"].location != NSNotFound)
//                {
//                    [Feedbackcountstr appendString:splitcountstr];
//                    if ([Feedbackcountstr length]==0)
//                    {
//                        [Feedbackcountstr appendString:@"0"];
//                        NSLog(@"action is ddd%@",Feedbackcountstr);
//
//                        Feedbacklbl.text = Feedbackcountstr;
//                    }
//                    else
//                    {
//                        Feedbackcountstr = [Feedbackcountstr stringByReplacingOccurrencesOfString:@"###feedback==" withString:@""];
//                        NSLog(@"feedback is the %@",Feedbackcountstr);
//                        Feedbacklbl.text = Feedbackcountstr;
//                    }
//
//                }
//            }
//
//        }
//    }
//
//    if (parser == xmlParser4)
//    {
//        if([elementName isEqualToString:@"descriptionResponse"])
//        {
//            for (int i = 0; i<[PublicNoteslistarray count]; i++)
//            {
//                PublicNotesSplitarray=[[PublicNoteslistarray objectAtIndex:i]componentsSeparatedByString:@"###"];
//
//                NSLog(@"the%@",PublicNotesSplitarray);
//                publicdescString=[[PublicNotesSplitarray objectAtIndex:1]stringByReplacingOccurrencesOfString: @"Note_Description=" withString:@""];
//
//                [PublicNote_DescriptionArray addObject:publicdescString];
//                NSLog(@"public description array is %@",PublicNote_DescriptionArray);
//            }
//
//            [PublicCountTV reloadData];
//
//        }
//
//    }
//    if (parser==xmlParser5)
//    {
//        if ([elementName isEqualToString:@"actionItemBasedOnUserIdResponse"])
//        {
//            for (int i=0; i<[ActionItemTabListArray count]; i++)
//            {
//                ActionItemTabListSplitArray=[[ActionItemTabListArray objectAtIndex:i]componentsSeparatedByString:@"###"];
//                [ActionItemTabListDisplayArray addObject:[[ActionItemTabListSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"Description==" withString:@""]];
//
//                actionItemCreatedIdStr=[[ActionItemTabListSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"createdBy==" withString:@""];
//
//                actionItemAssignedIdStr=[[ActionItemTabListSplitArray objectAtIndex:5]stringByReplacingOccurrencesOfString:@"assignedTo==" withString:@""];
//
//                actionItemIdStr=[[ActionItemTabListSplitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"ActionItemId==" withString:@""];
//
//                actionItemStatusStr=[[ActionItemTabListSplitArray objectAtIndex:4]stringByReplacingOccurrencesOfString:@"actionItemStatus==" withString:@""];
//                [actionItemStausArray addObject:actionItemStatusStr];
//
//                actionItemMeetingTitleStr=[[ActionItemTabListSplitArray objectAtIndex:8]stringByReplacingOccurrencesOfString:@"meetingTitle==" withString:@""];
//                [ActionItemMeetingTitleArray addObject:actionItemMeetingTitleStr];
//
//                ActionItemOwnernameStr=[[ActionItemTabListSplitArray objectAtIndex:10]stringByReplacingOccurrencesOfString:@"meetingOwnerName==" withString:@""];
//
//                [ActionITemMeetingOwnerNameArray addObject:ActionItemOwnernameStr];
//            }
//            NSLog(@"action item description array is %@",ActionItemTabListDisplayArray);
//            NSLog(@"action item status array is %@",actionItemStausArray);
//
//
//
//
//            [ActionItemListTV reloadData];
//        }
//
//
//
//    }
//}


- (IBAction)meetingselectTypeButton:(id)sender
{
    [MeetingSearchPickerView removeFromSuperview];
    MeetingSearchPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(meetingTypeLabel.frame.size.width+150,130, 200,200)];
    [MeetingSearchPickerView setShowsSelectionIndicator:YES];
    MeetingSearchPickerView.delegate = self;
    MeetingSearchPickerView.dataSource = self;
    MeetingSearchPickerView.tag = 100;
    MeetingSearchPickerView.backgroundColor=[UIColor grayColor];
    [MeetingSearchBar resignFirstResponder];
    [self.view addSubview:MeetingSearchPickerView];
    //MeetingSearchBar.text=@"All";
    
    
}
//- (void)searchBar:(UISearchBar *)searchBar
//    textDidChange:(NSString *)searchTerm
//{
//
//    [MeetingSearchPickerView removeFromSuperview];
//    MeetingSearchPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(550,130, 200,200)];
//    [MeetingSearchPickerView setShowsSelectionIndicator:YES];
//    MeetingSearchPickerView.delegate = self;
//    MeetingSearchPickerView.dataSource = self;
//    MeetingSearchPickerView.tag = 100;
//    MeetingSearchPickerView.backgroundColor=[UIColor grayColor];
//    //[tempArray2 removeAllObjects];
//    [MeetingSearchBar resignFirstResponder];
//    [self.view addSubview:MeetingSearchPickerView];
//    //MeetingSearchBar.text=@"All";
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [MeetingSearchPickerView removeFromSuperview];
//  MeetingSearchPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(550,130, 200,200)];
//
//    [MeetingSearchPickerView setShowsSelectionIndicator:YES];
//    MeetingSearchPickerView.delegate = self;
//    MeetingSearchPickerView.dataSource = self;
//    MeetingSearchPickerView.tag = 100;
//    MeetingSearchPickerView.backgroundColor=[UIColor grayColor];
//    //[tempArray2 removeAllObjects];
//    [MeetingSearchBar resignFirstResponder];
//    [self.view addSubview:MeetingSearchPickerView];
//    //MeetingSearchBar.text=@"All";
//
//}
//- (void)search
//{
//    [B removeAllObjects];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",MeetingSearchBar.text];
//    sercharray=(NSMutableArray*)[refarray1 filteredArrayUsingPredicate:predicate];
//    NSLog(@"search text is %@",MeetingSearchBar.text);
//    NSLog(@"habgfhfhfh %@",sercharray);
//    if ([sercharray count] > 0)
//    {
//        [B addObjectsFromArray:sercharray];
//         A=B;
//
//        NSLog(@"%d",[A count]);
//         //[MeetingListTV reloadData];
//    }
//    else
//    {
//        [self meetingList];
//        NSLog(@"welcome tppppppp");
//
//
//    }
//
//   [MeetingListTV reloadData];
//
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    
    meetingTypeLabel.text=@"Today";
    // [self agendaBtnClicked];
    
    [ActionItemListTV reloadData];
    [AgendaListTv reloadData];
    
    [MeetingListTV reloadData];
    [self viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == MeetingListTV)
    {
        return  [MeetingtitleArray count];
    }
    else if (tableView == AgendaListTv)
    {
        return [MeetingdesArray count];
    }
    else if (tableView==ActionItemListTV)
    {
        return [actionitemidarray count];
    }
    
    return [PublicNote_DescriptionArray count];
    //NSLog(@"public note description array is %@",PublicNote_DescriptionArray);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == MeetingListTV)
    {
        
        static NSString *MyIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
            agendaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            agendaBtn.frame = CGRectMake(700, 10.0f, 75.0f, 30.0f);
            [agendaBtn setTitle:@"A" forState:UIControlStateNormal];
            agendaBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:30];
            [agendaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            agendaBtn.tag=indexPath.row;
            [cell addSubview:agendaBtn];
            [agendaBtn addTarget:self
                          action:@selector(agendaBtnClicked:)
                forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [MeetingtitleArray objectAtIndex:indexPath.row];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        //[cell resignFirstResponder];
        
        UITextField *timefield = (UITextField*)[cell viewWithTag:1000];
        timefield=[[UITextField alloc] initWithFrame:CGRectMake(410, 10, 120, 30)];
        [[timefield layer] setBorderWidth:2.0f];
        [[timefield layer] setBorderColor:[UIColor blackColor].CGColor];
        timefield.layer.cornerRadius = 8;
        timefield.clipsToBounds = YES;
        timefield.borderStyle=UITextBorderStyleLine;
        timefield.textAlignment=NSTextAlignmentCenter;
        timefield.font=[UIFont systemFontOfSize:20];
        timefield.text=[StartTimeArray objectAtIndex:indexPath.row];
        timefield.userInteractionEnabled=NO;
        [cell.contentView addSubview:timefield];
        
        
        UITextField *confroomtxtfld = (UITextField*)[cell viewWithTag:2000];
        confroomtxtfld=[[UITextField alloc] initWithFrame:CGRectMake(timefield.frame.origin.x+140, timefield.frame.origin.y, 150, 30)];
        [[confroomtxtfld layer] setBorderWidth:2.0f];
        [[confroomtxtfld layer] setBorderColor:[UIColor blackColor].CGColor];
        confroomtxtfld.layer.cornerRadius = 8;
        confroomtxtfld.clipsToBounds = YES;
        confroomtxtfld.font=[UIFont systemFontOfSize:20];
        confroomtxtfld.borderStyle=UITextBorderStyleLine;
        confroomtxtfld.userInteractionEnabled=NO;
        confroomtxtfld.textAlignment=NSTextAlignmentCenter;
        meetingDesTxtFld=confroomtxtfld;
        confroomtxtfld.text=[MeetingDateArray objectAtIndex:indexPath.row];
        [cell addSubview:confroomtxtfld];
        [confroomtxtfld resignFirstResponder];
        
        if ([confroomtxtfld.text isEqualToString:@"null"])
        {
            confroomtxtfld.text = @"-";
        }
        
        //      arrowsImg1 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        arrowsImg1.frame = CGRectMake(680, 15, 88, 20);
        //        // rightButton.backgroundColor = [UIColor greenColor];
        //        [arrowsImg1 setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        //        //[rightButton setTitle:@"R" forState:UIControlStateNormal];
        //        arrowsImg1.tag = indexPath.row;
        //        [arrowsImg1 addTarget:self action:@selector(ArrowbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.contentView addSubview:arrowsImg1];
        
        //arrowsImg = (UIButton *)[cell viewWithTag:10];
        //[arrowsImg addTarget:self action:@selector(ArrowbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        //[arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        // arrowsImg.tag = indexPath.row;
        
        // [cell.contentView addSubview:arrowsImg];
        
        UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
        
        
        
        UIButton *checkUncheckButton = (UIButton *)[cell viewWithTag:10];
        // mailLable.frame = CGRectMake(80, 27, 250, 25);
        [checkUncheckButton setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        checkUncheckButton.backgroundColor = [UIColor clearColor];
        [checkUncheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        checkUncheckButton.userInteractionEnabled = YES;
        [checkUncheckButton addTarget:self action:@selector(checkUncheckButton:) forControlEvents:UIControlEventTouchUpInside];
        checkUncheckButton.tag = indexPath.row;
        [cell.contentView addSubview:checkUncheckButton];
        //        if ([indexArray containsObject:indexPath])
        //        {
        //
        //            [arrowsImg setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal];
        //            //[arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        //
        //        }
        //        else
        //        {
        //
        //            [arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        //            //[arrowsImg setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal];
        //        }
        
        NSLog(@"tag is %d",indexPath.row);
        
        
        return cell;
    }
    //        else
    //        {
    //            static NSString *MyIdentifier = @"cell";
    //            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    //            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //            if (cell == nil)
    //            {
    //                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
    //                                              reuseIdentifier:MyIdentifier];
    //            }
    //
    //            cell.backgroundColor = [UIColor whiteColor];
    //            cell.textLabel.text = [tempArray2 objectAtIndex:indexPath.row];
    //            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //            [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    //            [cell.contentView.layer setBorderWidth:1.0f];
    //            cell.contentView.layer.cornerRadius = 8;
    //            cell.contentView.clipsToBounds = YES;
    //            //[cell resignFirstResponder];
    //
    //            UITextField *timefield = (UITextField*)[cell viewWithTag:1000];
    //            timefield=[[UITextField alloc] initWithFrame:CGRectMake(320, 10, 120, 30)];
    //            [[timefield layer] setBorderWidth:2.0f];
    //            [[timefield layer] setBorderColor:[UIColor blackColor].CGColor];
    //            timefield.layer.cornerRadius = 8;
    //            timefield.clipsToBounds = YES;
    //            timefield.borderStyle=UITextBorderStyleLine;
    //            timefield.textAlignment=NSTextAlignmentCenter;
    //            timefield.font=[UIFont systemFontOfSize:20];
    //            timefield.text=[tempArray3 objectAtIndex:indexPath.row];
    //            timefield.userInteractionEnabled=NO;
    //            [cell.contentView addSubview:timefield];
    //
    //
    //            UITextField *confroomtxtfld = (UITextField*)[cell viewWithTag:2000];
    //            confroomtxtfld=[[UITextField alloc] initWithFrame:CGRectMake(timefield.frame.origin.x+250, timefield.frame.origin.y, 150, 30)];
    //            [[confroomtxtfld layer] setBorderWidth:2.0f];
    //            [[confroomtxtfld layer] setBorderColor:[UIColor blackColor].CGColor];
    //            confroomtxtfld.layer.cornerRadius = 8;
    //            confroomtxtfld.clipsToBounds = YES;
    //            confroomtxtfld.font=[UIFont systemFontOfSize:20];
    //            confroomtxtfld.borderStyle=UITextBorderStyleLine;
    //            confroomtxtfld.userInteractionEnabled=NO;
    //            confroomtxtfld.textAlignment=NSTextAlignmentCenter;
    //            meetingDesTxtFld=confroomtxtfld;
    //            confroomtxtfld.text=[A objectAtIndex:indexPath.row];
    //            [cell addSubview:confroomtxtfld];
    //            [confroomtxtfld resignFirstResponder];
    //
    //            if ([confroomtxtfld.text isEqualToString:@"null"])
    //            {
    //                confroomtxtfld.text = @"-";
    //            }
    //
    //            //      arrowsImg1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //            //        arrowsImg1.frame = CGRectMake(680, 15, 88, 20);
    //            //        // rightButton.backgroundColor = [UIColor greenColor];
    //            //        [arrowsImg1 setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    //            //        //[rightButton setTitle:@"R" forState:UIControlStateNormal];
    //            //        arrowsImg1.tag = indexPath.row;
    //            //        [arrowsImg1 addTarget:self action:@selector(ArrowbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //            //        [cell.contentView addSubview:arrowsImg1];
    //
    //            //arrowsImg = (UIButton *)[cell viewWithTag:10];
    //            //[arrowsImg addTarget:self action:@selector(ArrowbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //            //[arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    //            // arrowsImg.tag = indexPath.row;
    //
    //            // [cell.contentView addSubview:arrowsImg];
    //
    //            UILongPressGestureRecognizer *longPressGesture =
    //            [[UILongPressGestureRecognizer alloc]
    //             initWithTarget:self action:@selector(longPress:)];
    //            [cell addGestureRecognizer:longPressGesture];
    //
    //
    //
    //            UIButton *checkUncheckButton = (UIButton *)[cell viewWithTag:10];
    //            // mailLable.frame = CGRectMake(80, 27, 250, 25);
    //            [checkUncheckButton setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    //            checkUncheckButton.backgroundColor = [UIColor clearColor];
    //            [checkUncheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //            checkUncheckButton.userInteractionEnabled = YES;
    //            [checkUncheckButton addTarget:self action:@selector(checkUncheckButton:) forControlEvents:UIControlEventTouchUpInside];
    //            checkUncheckButton.tag = indexPath.row;
    //            [cell.contentView addSubview:checkUncheckButton];
    //            //        if ([indexArray containsObject:indexPath])
    //            //        {
    //            //
    //            //            [arrowsImg setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal];
    //            //            //[arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    //            //
    //            //        }
    //            //        else
    //            //        {
    //            //
    //            //            [arrowsImg setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    //            //            //[arrowsImg setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal];
    //            //        }
    //
    //            NSLog(@"tag is %d",indexPath.row);
    //
    //
    //            return cell;
    //
    //        }
    //}
    
    else if(tableView == AgendaListTv)
    {
        
        static NSString *MyIdentifier = @"Cell1";
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        }
        cell.backgroundColor = [UIColor grayColor];
        cell.textLabel.text = [MeetingdesArray objectAtIndex:indexPath.row];
        NSLog(@"the list of the action item list is %@",ActitemlisttitleArray);
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.contentView.layer setBorderWidth:2.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        //        cell.contentView.backgroundColor = [UIColor whiteColor];
        //        cell.textLabel.text = [ActitemlisttitleArray objectAtIndex:indexPath.row];
        //
        //        [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
        //        [cell.contentView.layer setBorderWidth:1.0f];
        //        cell.contentView.layer.cornerRadius = 8;
        //        cell.contentView.clipsToBounds = YES;
        
        
        /*UITextField *descriptiontxtfiled = (UITextField*)[cell viewWithTag:2005];
         descriptiontxtfiled.textColor = [UIColor blackColor];
         descriptiontxtfiled=[[UITextField alloc] initWithFrame:CGRectMake(400, 200, 80, 30)];
         [[descriptiontxtfiled layer] setBorderWidth:2.0f];
         [[descriptiontxtfiled layer] setBorderColor:[UIColor blackColor].CGColor];
         descriptiontxtfiled.layer.cornerRadius = 8;
         descriptiontxtfiled.clipsToBounds = YES;
         descriptiontxtfiled.font=[UIFont systemFontOfSize:15];
         
         descriptiontxtfiled.text=[MeetingdesArray objectAtIndex:indexPath.row];
         //[cell addSubview:descriptiontxtfiled];
         [cell.contentView addSubview:descriptiontxtfiled];*/
        
        
        CGFloat desWidth = 150;
        CGFloat desHeight = 20;
        CGFloat padding = 20;
        
        UITextField *descriptiontxtfiled = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - desWidth - padding, 5, desWidth, desHeight)];
        descriptiontxtfiled = (UITextField*)[cell viewWithTag:2005];
        descriptiontxtfiled.textColor = [UIColor blackColor];
        [descriptiontxtfiled setBackgroundColor:[UIColor clearColor]];
        descriptiontxtfiled.font = [UIFont systemFontOfSize:18];
        descriptiontxtfiled.userInteractionEnabled=NO;
        descriptiontxtfiled.text = [ActionItemMeetingTitleArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:descriptiontxtfiled];
        
        
        
        return cell;
    }
    
    else if(tableView == ActionItemListTV)
    {
        static NSString *TableIdentifier1=@"ActionCell";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableIdentifier1];
        tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        
        if (cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:TableIdentifier1];
        }
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [actionitemdescarray objectAtIndex:indexPath.row];
        
        [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        
        if ([[actionItemStausArray objectAtIndex:indexPath.row]isEqualToString:@"C"])
        {
            statusStr=@"Created";
        }
        
        UITextField *statusTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(280,300,30,30)];
        statusTxtFld = (UITextField*)[cell viewWithTag:2010];
        statusTxtFld.textColor = [UIColor blackColor];
        [statusTxtFld setBackgroundColor:[UIColor clearColor]];
        statusTxtFld.font = [UIFont systemFontOfSize:18];
        statusTxtFld.userInteractionEnabled=NO;
        statusTxtFld.text =statusStr;
        [cell.contentView addSubview:statusTxtFld];
        
        UITextField *meetingTitleTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(220,300,50,30)];
        meetingTitleTxtFld = (UITextField*)[cell viewWithTag:2011];
        meetingTitleTxtFld.textColor = [UIColor blackColor];
        //[meetingTitleTxtFld setBackgroundColor:[UIColor blueColor]];
        meetingTitleTxtFld.font = [UIFont systemFontOfSize:18];
        meetingTitleTxtFld.userInteractionEnabled=NO;
        meetingTitleTxtFld.text = [ActionItemMeetingTitleArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:meetingTitleTxtFld];
        
        UITextField *ownernameTxtfld = [[UITextField alloc] initWithFrame:CGRectMake(260,300,50,30)];
        ownernameTxtfld = (UITextField*)[cell viewWithTag:2012];
        ownernameTxtfld.textColor = [UIColor blackColor];
        //[ownernameTxtfld setBackgroundColor:[UIColor blueColor]];
        ownernameTxtfld.font = [UIFont systemFontOfSize:18];
        ownernameTxtfld.userInteractionEnabled=NO;
        ownernameTxtfld.text = [ActionITemMeetingOwnerNameArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ownernameTxtfld];
        
        return  cell;
        
        //[ActionItemListTV reloadData];
    }
    
    else
    {
        static NSString *MyIdentifier = @"PublicCount";
        NSLog(@"111111111111");
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [PublicNote_DescriptionArray objectAtIndex:indexPath.row];
        
        [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius = 8;
        cell.contentView.clipsToBounds = YES;
        
        return cell;
        
    }
    
    
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    
    
    
    CGPoint p = [gesture locationInView:MeetingListTV];
    UITableViewCell *cell = (UITableViewCell *)[gesture view];
    NSIndexPath *indexPath = [MeetingListTV indexPathForRowAtPoint:p];
    NSString *MeetingId = [MeetingIdArray objectAtIndex:indexPath.row];
    NSLog(@"arow tag is %@",MeetingId);
    //[sender setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateSelected];
    //[sender setSelected:YES];
    NSString *notesactionfb=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/notesActionItemFbCount?meetingId=%@&userId=%@",MeetingId,Useridstr];
    NSString *encode=[notesactionfb stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall notesactionfbcountUrl:encode];
    [Servicecall setDelegate:self];
    
    NSString *publicnotesdec =[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/publicNotesDescription?meetingId=%@",MeetingId];
    NSString *encode1=[publicnotesdec stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall publicnotesdecurl:encode1];
    [Servicecall setDelegate:self];
    
    
    
    //    NSString *Notescountservice = @"NotesActionItemsCountService";
    //    NSDictionary *Notescountcredentials = @{@"meetingId":MeetingId,@"userId":Useridstr};
    //    [Servicecall NotesCountlisturl:Notescountservice CountListparameters:Notescountcredentials];
    //    [Servicecall setDelegate:self];
    //    NSLog(@"meeting count is");
    
    //    NSString *publiccountdisurl = @"PublicCountDescriptionService";
    //    NSDictionary *Publiccountcredentials =@{@"meetingId":MeetingId};
    //    [Servicecall PublicCountlisturl:publiccountdisurl Publiccountcredentilas:Publiccountcredentials];
    //    [Servicecall setDelegate:self];
    //    NSLog(@"meeting count2 is");
    //
    //
    //    NSLog(@"meeting id str is sheikkkkk %@",meetingidStr);
    //    Servicecall=[[Webservices alloc]init];
    //    NSString *publicnotesList=@"PublicCountDescriptionService";
    //    NSDictionary *publicNotesDictionary=@{@"meetingId":MeetingId};
    //    [Servicecall PublicDislisturl:publicnotesList PublicDiscredentilas:publicNotesDictionary];
    //    [Servicecall setDelegate:self];
}
//    else
//    {
//        CGPoint p = [gesture locationInView:MeetingListTV];
//        UITableViewCell *cell = (UITableViewCell *)[gesture view];
//        NSIndexPath *indexPath = [MeetingListTV indexPathForRowAtPoint:p];
//        NSString *MeetingId = [tempArray5 objectAtIndex:indexPath.row];
//        NSLog(@"arow tag is %@",MeetingId);
//        //[sender setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateSelected];
//        //[sender setSelected:YES];
//        NSString *Notescountservice = @"NotesActionItemsCountService";
//        NSDictionary *Notescountcredentials = @{@"meetingId":MeetingId,@"userid":Useridstr};
//        [Servicecall NotesCountlisturl:Notescountservice CountListparameters	:Notescountcredentials];
//        [Servicecall setDelegate:self];
//        NSLog(@"meeting count is");
//
//        NSString *publiccountdisurl = @"PublicCountDescriptionService";
//        NSDictionary *Publiccountcredentials =@{@"meetingId":MeetingId};
//        [Servicecall PublicCountlisturl:publiccountdisurl Publiccountcredentilas:Publiccountcredentials];
//        [Servicecall setDelegate:self];
//        NSLog(@"meeting count2 is");
//
//
//        NSLog(@"meeting id str is sheikkkkk %@",meetingidStr);
//        Servicecall=[[Webservices alloc]init];
//        NSString *publicnotesList=@"PublicCountDescriptionService";
//        NSDictionary *publicNotesDictionary=@{@"meetingId":MeetingId};
//        [Servicecall PublicDislisturl:publicnotesList PublicDiscredentilas:publicNotesDictionary];
//        [Servicecall setDelegate:self];
//
//    }
//}

-(void)agendaBtnClicked:(UIButton*)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:MeetingListTV];
    NSIndexPath *indexPath = [MeetingListTV indexPathForRowAtPoint:buttonPosition];
    NSString *meetingidstr=[MeetingIdArray objectAtIndex:indexPath.row];
    NSLog(@"meetind id str is : %@",meetingidstr);
    
    NSString *agendaurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/meeting/v1/agendaList?meetingId=%@",meetingidstr];
    
    NSString *encode=[agendaurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
    [Servicecall agendaUrl:encode];
    [Servicecall setDelegate:self];
    
}

//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:MeetingListTV];
//    NSIndexPath *indexPath = [MeetingListTV indexPathForRowAtPoint:buttonPosition];
//    NSString *meetingidstr=[MeetingIdArray objectAtIndex:indexPath.row];
//
//    if (indexPath != nil)
//    {
//        NSLog(@"meeting id str is %@",meetingidStr);
//        Servicecall=[[Webservices alloc]init];
//        NSString *AgendaListurl = @"AgendaListDataService";
//        NSDictionary *credentials = @{@"meetingId":meetingidstr};
//        [Servicecall AgendaListurl:AgendaListurl AgendaListParameters:credentials];
//
//        [Servicecall setDelegate:self];
//
//
//        //[agendaBtn setBackgroundColor:[UIColor blueColor]];
//
//    }
//    if (sender.selected)
//    {
//
//    }


-(void)checkUncheckButton:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"%i",button.tag);
    
    if([button.currentImage isEqual:@"btn.png"])
    {
        [button setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateNormal ];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == MeetingListTV)
    {
        
        if ([Useridstr isEqualToString:[OwnerIDArray objectAtIndex:indexPath.row]])
        {
            //        if (([MeetingSearchBar.text length]==0)||[MeetingSearchBar.text isEqualToString:@"All"])
            //        {
            
            CreatMeetingtV  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatView"];
            CreatMeetingtV.navigationTitlestr        = @"Modify Meeting";
            CreatMeetingtV.SavebtnTitlestr           = @"Update";
            CreatMeetingtV.locationUseBool           = YES;
            CreatMeetingtV.MeetingDescriptionstr     =[MeetingDescriptionArray objectAtIndex:indexPath.row];
            CreatMeetingtV.Hoursstr                  =[HoursArrray objectAtIndex:indexPath.row];
            CreatMeetingtV.MeetingTypestr            =[MeetingTypeArray objectAtIndex:indexPath.row];
            CreatMeetingtV.ProjectNamestr            =[ProjectNameArray objectAtIndex:indexPath.row];
            CreatMeetingtV.MeetingDatestr            =[MeetingDateArray objectAtIndex:indexPath.row];
            CreatMeetingtV.ConferenceRoomstr         =[ConferenceRoomNameArray objectAtIndex:indexPath.row];
            CreatMeetingtV.MeetingTitlestr           =[MeetingtitleArray objectAtIndex:indexPath.row];
            CreatMeetingtV.Starttimestr              =[StartTimeArray objectAtIndex:indexPath.row];
            CreatMeetingtV.ProjId                    =[ProjectIdArray objectAtIndex:indexPath.row];
            CreatMeetingtV.MeetingTypeId             =[MeetingTypeIdArray objectAtIndex:indexPath.row];
            //CreatMeetingtV.ConfOwnerId               =[OwnerIDArray objectAtIndex:indexPath.row];
            CreatMeetingtV.MeetingId                 =[MeetingIdArray objectAtIndex:indexPath.row];
            
            
            NSUserDefaults *defaul =[ NSUserDefaults standardUserDefaults];
            [defaul setObject:[MeetingIdArray objectAtIndex:indexPath.row] forKey:@"MeetingId"];
            [defaul setObject:[ProjectIdArray objectAtIndex:indexPath.row] forKey:@"ProjectId"];
            //        [defaul setObject:[HoursArrray objectAtIndex:indexPath.row] forKey:@"Hours"];
            //        [defaul setObject:[MeetingTypeArray objectAtIndex:indexPath.row] forKey:@"MeetingType"];
            //        [defaul setObject:[ProjectNameArray objectAtIndex:indexPath.row] forKey:@"ProjectName"];
            //        [defaul setObject:[MeetingDateArray objectAtIndex:indexPath.row] forKey:@"MeetingDate"];
            //        [defaul setObject:[ConferenceRoomNameArray objectAtIndex:indexPath.row] forKey:@"ConferenceRoom"];
            //        [defaul setObject:[MeetingDescriptionArray objectAtIndex:indexPath.row] forKey:@"MeetingDescription"];
            
            [defaul synchronize];
            [self.navigationController pushViewController:CreatMeetingtV animated:YES];
            //[MeetingListTV resignFirstResponder];
        }
        //        else
        //        {
        //            CreatMeetingtV  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatView"];
        //            CreatMeetingtV.navigationTitlestr        = @"Modify Meeting";
        //            CreatMeetingtV.SavebtnTitlestr           = @"Update";
        //            CreatMeetingtV.locationUseBool           = YES;
        //            CreatMeetingtV.MeetingDescriptionstr     =[tempArray4 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.Hoursstr                  =[tempArray6 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.MeetingTypestr            =[tempArray7 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.ProjectNamestr            =[ProjectNameArray objectAtIndex:indexPath.row];
        //            CreatMeetingtV.MeetingDatestr            =[A objectAtIndex:indexPath.row];
        //            CreatMeetingtV.ConferenceRoomstr         =[tempArray8 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.MeetingTitlestr           =[tempArray2 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.Starttimestr              =[tempArray3 objectAtIndex:indexPath.row];
        //            CreatMeetingtV.ProjId                    =[ProjectIdArray objectAtIndex:indexPath.row];
        //            CreatMeetingtV.MeetingTypeId             =[MeetingTypeIdArray objectAtIndex:indexPath.row];
        //            //CreatMeetingtV.ConfOwnerId               =[OwnerIDArray objectAtIndex:indexPath.row];
        //            CreatMeetingtV.MeetingId                 =[tempArray5 objectAtIndex:indexPath.row];
        //
        //
        //
        //
        //
        //            NSUserDefaults *defaul =[ NSUserDefaults standardUserDefaults];
        //            [defaul setObject:[tempArray5 objectAtIndex:indexPath.row] forKey:@"MeetingId"];
        //            [defaul setObject:[ProjectIdArray objectAtIndex:indexPath.row] forKey:@"ProjectId"];
        //            //        [defaul setObject:[HoursArrray objectAtIndex:indexPath.row] forKey:@"Hours"];
        //            //        [defaul setObject:[MeetingTypeArray objectAtIndex:indexPath.row] forKey:@"MeetingType"];
        //            //        [defaul setObject:[ProjectNameArray objectAtIndex:indexPath.row] forKey:@"ProjectName"];
        //            //        [defaul setObject:[MeetingDateArray objectAtIndex:indexPath.row] forKey:@"MeetingDate"];
        //            //        [defaul setObject:[ConferenceRoomNameArray objectAtIndex:indexPath.row] forKey:@"ConferenceRoom"];
        //            //        [defaul setObject:[MeetingDescriptionArray objectAtIndex:indexPath.row] forKey:@"MeetingDescription"];
        //
        //            [defaul synchronize];
        //            [self.navigationController pushViewController:CreatMeetingtV animated:YES];
        //
        //        }
        //}
        
        else
        {
            UserbasedMeetings = [self.storyboard instantiateViewControllerWithIdentifier:@"UserbasedMeetings"];
            UserbasedMeetings.MeetingId =[MeetingIdArray objectAtIndex:indexPath.row];
            UserbasedMeetings.ownerName=[OwnerNameArray objectAtIndex:indexPath.row];
            NSLog(@"meetin owner name aray is %@",OwnerNameArray);
            [self.navigationController pushViewController:UserbasedMeetings animated:YES];
            
        }
        
    }
    
    
    
    if (tableView == AgendaListTv)
    {
        NSLog(@"agendameeting id str is %@",agendaMeetingIdStr);
        
        NSLog(@"agenda meeting id str is %@",agendaMeetingIdStr);
        ActionItemsVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"ActionitemView"];
        ActionItemsVC.ObjDistr                = [MeetingdesArray objectAtIndex:indexPath.row];
        ActionItemsVC.ObjIdstr                =[ObjeIdArray objectAtIndex:indexPath.row];
        ActionItemsVC.AgendaBasedMeetingIdstr =[AgendaMeetingMeetingID objectAtIndex:indexPath.row];
        ActionItemsVC.projectId=[AgendaMeetingProjId objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:ActionItemsVC animated:YES];
    }
    if (tableView==ActionItemListTV)
    {
        if ([Useridstr isEqualToString:actionItemCreatedIdStr])
        {
            alertView1=[[UIAlertView alloc]initWithTitle:@"" message:@"if you want to kill the action item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Close", nil];
            [alertView1 show];
            statusStr=@"Kill";
            
        }
        else
        {
            alertView2=[[UIAlertView alloc]initWithTitle:@"" message:@"if you want to close the action item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"CLOSE", nil];
            [alertView2 show];
            statusStr=@"Close";
        }
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    return [meetingdatesArray count];
    
}
-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [meetingdatesArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    
    meetingTypeLabel.text=[meetingdatesArray objectAtIndex:row];
    
    flagstr=meetingTypeLabel.text;
    [self meetingList];
    [MeetingSearchPickerView removeFromSuperview];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==MeetingListTV)
    {
        return 50;
    }
    return 50;
}

-(void)ArrowbuttonTapped:(UIButton *)sender
{
    
    
    
    
    if ([sender isSelected])
    {
        [sender setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }
    else
    {
        //        NSString *MeetingId = [MeetingIdArray objectAtIndex:sender.tag];
        //        NSLog(@"arow tag is %@",MeetingId);
        //        [sender setImage:[UIImage imageNamed:@"btnclick.png"] forState:UIControlStateSelected];
        //        [sender setSelected:YES];
        //        NSString *Notescountservice = @"NotesActionItemsCountService";
        //        NSString *publiccountdisurl = @"PublicCountDescriptionService";
        //
        //        NSDictionary *Publiccountcredentials =@{@"meetingId":MeetingId};
        //        NSDictionary *Notescountcredentials = @{@"meetingId":MeetingId,@"userid":Useridstr};
        //        [Servicecall NotesCountlisturl:Notescountservice CountListparameters:Notescountcredentials];
        //        [Servicecall PublicCountlisturl:publiccountdisurl Publiccountcredentilas:Publiccountcredentials];
        //
        //        [Servicecall setDelegate:self];
        //
        
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
    if (alertView ==alertView1 )
    {
        if(buttonIndex == 0)
        {
            
            
            
        }
        else {
            
            
            [self actionItemListKill];
            //[ActionItemListTV reloadData];
        }
        
    }
    if (alertView ==alertView2)
    {
        if(buttonIndex == 0)
        {
            
            
            
        }
        else {
            
            
            
            [self actionItemListKill];
            //[ActionItemListTV reloadData];
        }
        
    }
    
    
}

-(void)actionItemListKill
{
    
    NSLog(@"status str is %@",statusStr);
    Servicecall=[[Webservices alloc]init];
    
    NSString *ActionItemKillClassName=@"SaveNotesTabService";
    
    NSDictionary *ActionItemKillParametersList=@{@"noteLineId":actionItemIdStr,@"actionItemStatus":statusStr};
    
    
    [Servicecall ActionItemListKill:ActionItemKillClassName ActionItemListKillParameters:ActionItemKillParametersList];
    [Servicecall setDelegate:self];
    
    NSLog(@"welcome");
    [self actionItemTab];
}


-(void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews)
    {
        if ([objects isKindOfClass:[UITextField class]])
        {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder])
            {
                [meetingDesTxtFld resignFirstResponder];
            }
        }
    }
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField==meetingDesTxtFld)
//    {
//        [meetingDesTxtFld resignFirstResponder];
//    }
//    return YES;
//}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==2000)
    {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
