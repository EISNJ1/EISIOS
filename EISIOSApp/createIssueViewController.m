//
//  createIssueViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 18/11/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "createIssueViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "MBProgressHUD.h"
#import "Toast+UIView.h"
#import "Base64.h"

@interface createIssueViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation createIssueViewController
@synthesize  issueIdTblStr,issueNoTblStr,projectIdTblStr,projectTblStr,issueStatusTblStr,issueTypeTblStr,assignToTblStr, teamSubmittedTblStr,severityTblStr,descriptionTblStr,isueHistoryTblStr;


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
    //save the data to defaults
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setObject:@"" forKey:@"issueEntry"];
    [defaults1 synchronize];
    
    //Tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    [self.view addGestureRecognizer:tapGesture];
     tapGesture.cancelsTouchesInView = false;
    
    
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
    saveAttatchmentStr=[[NSString alloc]init];
    
    
    
    [self.scrollView setContentSize:CGSizeMake(320,1000)];
    
    
    //----------------view back ground stroke--------------------//
    createIssueView.layer.cornerRadius = createIssueView.frame.size.width / 2;
    createIssueView.clipsToBounds = YES;
    createIssueView.layer.borderWidth = 3.0f;
    createIssueView.layer.borderColor = [UIColor purpleColor].CGColor;
    createIssueView.layer.cornerRadius = 10.0f;
    createIssueView.layer.cornerRadius=4;
    
    
    issueHistoryTextView.layer.cornerRadius = issueHistoryTextView.frame.size.width / 2;
    issueHistoryTextView.clipsToBounds = YES;
    issueHistoryTextView.layer.borderWidth = 3.0f;
    issueHistoryTextView.layer.borderColor = [UIColor purpleColor].CGColor;
    issueHistoryTextView.layer.cornerRadius = 10.0f;
    issueHistoryTextView.layer.cornerRadius=4;
    //issueHistoryTextView.editable=YES;
    issueHistoryTextView.scrollEnabled=YES;
    issueHistoryTextView.showsVerticalScrollIndicator=YES;
    issueHistoryTextView.userInteractionEnabled=YES;
    
    
    //------------Bar Buttons----------------------//
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createIssueBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,createTimeSheetActionBarBtn,nil];
    
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    //[self DatafromDB];
    NSLog(@"%@",UserTypestr);

    NSLog(@"%@",Useridstr);
    NSLog(@"%@",OrgIdStr);

    
    //------------Project Spinner  Calling-------------//
    
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"usertype":UserTypestr,@"userID":Useridstr,@"orgId":OrgIdStr};
    [Servicecall createIssueProjectSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
    
    projectTfd.text = projectTblStr;
    NSLog(@"project name is 456178945123%@",projectTblStr);
    statusTfd.text = issueStatusTblStr;
    typeTfd.text = issueTypeTblStr;
    assignToTfd.text = assignToTblStr;

    NSLog(@"the assign to idddddd is %@",assignToTblStr);
    //teamSubmittedTfd.text = teamSubmittedTblStr;
    severityTfd.text = severityTblStr;
    descriptionTfd.text = descriptionTblStr;
    issueHistoryTextView.text = isueHistoryTblStr;
    issueHistoryTextView.text = [isueHistoryTblStr stringByConvertingHTMLToPlainText];
    
    NSLog(@"issue history str is %@",issueHistoryTextView.text);
    
    if ([issueHistoryTextView.text isEqualToString:@"null"])
    {
        issueHistoryTextView.text=@"";
    }
    saveissueNumStr=issueHistoryTextView.text;
    
    
    NSLog(@"issueid =%@, isuueno =%@, projectid= %@, projectname= %@, issuestatus= %@, issuetype= %@, TeamName= %@, assignto= %@,  Description= %@, LongDescription= %@ ",issueIdTblStr,issueNoTblStr,projectIdTblStr,projectTblStr,issueStatusTblStr,issueTypeTblStr,teamSubmittedTblStr,assignToTblStr,descriptionTblStr,isueHistoryTblStr);
    
    [updateBtn setHidden:YES];
    [titleLabel setText:@"Create Issue"];

    if ([projectTblStr length]>0)
    {
        [saveBtn setHidden:YES];
        [updateBtn setHidden:NO];
        [titleLabel setText:@"Update Issue Details"];
        [projectListBtn setEnabled:NO];
        
        
        UIButton *uploadButton=[[UIButton alloc]initWithFrame:CGRectMake(issueHistoryTextView.frame.origin.x+400,issueHistoryTextView.frame.origin.y+220,80,40)];
        
        [uploadButton setTitle:@"Uplaod" forState:UIControlStateNormal];
        [uploadButton addTarget:self action:@selector(uploadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [uploadButton setBackgroundColor:[UIColor grayColor]];
        [createIssueView addSubview:uploadButton];
        
        UILabel *attatchmentsLabel=[[UILabel alloc]initWithFrame:CGRectMake(issueHistoryTextView.frame.origin.x-200, issueHistoryTextView.frame.origin.y+200, 150, 40)];
        
        attatchmentsLabel.text=@"Attatchments";
        attatchmentsLabel.tag=155;
        [createIssueView addSubview:attatchmentsLabel];
        [self AttatchmentList];
        
        
        attatchmentTableView=[[UITableView alloc]initWithFrame:CGRectMake(attatchmentsLabel.frame.origin.x+200, attatchmentsLabel.frame.origin.y-20, issueHistoryTextView.frame.size.width, 100) ];
        
        
        attatchmentTableView.scrollEnabled=YES;
        attatchmentTableView.userInteractionEnabled=true;
        attatchmentTableView.layer.borderColor = [UIColor purpleColor].CGColor;
        attatchmentTableView.allowsSelectionDuringEditing=YES;
        attatchmentTableView.layer.cornerRadius = 10.0f;
        attatchmentTableView.allowsSelection=YES;
        attatchmentTableView.layer.cornerRadius=4;
        attatchmentTableView.layer.borderWidth=3.0f;
        attatchmentTableView.delegate=self;
        attatchmentTableView.dataSource=self;
       [createIssueView addSubview:attatchmentTableView];
        
        TitlesArray=[[NSMutableArray alloc]init];
    }

    
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
- (void)viewDidLayoutSubviews
{
    _scrollView.contentSize = CGSizeMake(320, 1300);
}



-(void)viewWillAppear:(BOOL)animated
{
    //Getting data
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    issueEntryTfd.text = [defaults2 objectForKey:@"issueEntry"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardhidden) name:UIKeyboardDidHideNotification object:Nil];
    [attatchmentTableView reloadData];
    
    //[self AttatchmentList];
    //[super viewWillAppear:animated];
}
-(void)keyboardhidden
{
    [issueEntryTfd resignFirstResponder];
    [descriptionTfd resignFirstResponder];
    

}

-(void)AttatchmentList
{
    Servicecall=[[Webservices alloc]init];
    NSString *IssueAttatchmentClass=@"IssuesAttachment";
    NSDictionary *IssueAttatchmentDictionary=@{@"issueId":issueIdTblStr};
    [Servicecall IssueAttatchmentsList:IssueAttatchmentClass IssueAttatchmentsListDictionary:IssueAttatchmentDictionary];
    [Servicecall setDelegate:self];

}
-(void)statusService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"orgId":OrgIdStr};
    [Servicecall createIssueStatusSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
}
-(void)typeService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"orgId":OrgIdStr};
    [Servicecall createIssueIssueTypeSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];

}
-(void)assignToService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"prjctId":projectIdStr};
    [Servicecall createIssueAssighToeSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)teamSubmittedService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"prjctId":projectIdStr};
    [Servicecall createIssueTeamSubmittedeSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
}


-(void)severityService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"orgId":OrgIdStr};
    [Servicecall createIssueSeveritySpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];

}

-(IBAction)uploadButtonClicked:(id)sender

{
    selectionView = [[UIView alloc] initWithFrame:CGRectMake(87, 523, 606, 241)];
    selectionView.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor;
    selectionView.layer.borderWidth = 2.0f;
    selectionView.layer.cornerRadius = 14;
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:1];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[selectionView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    [self.view addSubview:selectionView];
    
    UIButton *Musicbtn = [[UIButton alloc]initWithFrame:CGRectMake(125, 96, 107, 85)];
    [Musicbtn setImage:[UIImage imageNamed:@"gallery.png"] forState:UIControlStateNormal];
    [Musicbtn addTarget:self action:@selector(ChooseFromGallery:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:Musicbtn];
    
    UIButton *SoundRecordbtn = [[UIButton alloc]initWithFrame:CGRectMake(445, 95 , 107, 85)];
    [SoundRecordbtn setImage:[UIImage imageNamed:@"Camera-icon.png"] forState:UIControlStateNormal];
    [SoundRecordbtn addTarget:self action:@selector(atachmentsGalaryBtnClk:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:SoundRecordbtn];
  }
-(IBAction)atachmentsGalaryBtnClk:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
    [selectionView removeFromSuperview];
    camImagePickerController = [[UIImagePickerController alloc] init];
    camImagePickerController.delegate=self;
    camImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camImagePickerController  animated:YES completion:nil];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = @"Please Attatch Camera Device";
        //hud.tintColor=[UIColor blueColor];
        hud.detailsLabel.font=[UIFont fontWithName:@"Bold" size:22];
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.textColor=[UIColor blackColor];
        hud.margin = 12.f;
        [hud hideAnimated:YES afterDelay:2];
        
    }
}

- (IBAction)ChooseFromGallery:(id)sender
{
    [selectionView removeFromSuperview];
    GalleryImage = [[UIImagePickerController alloc] init];
    GalleryImage.delegate = self;
    GalleryImage.allowsEditing = YES;
    GalleryImage.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:GalleryImage animated:YES completion:nil];
}
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary*) info

{
    
    
    if (picker == camImagePickerController)
    {
        ImageforUpload=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        ImageforUpload = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(ImageforUpload, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    else if (picker == GalleryImage)
    {
        ImageforUpload = [info valueForKey:UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSData* imageData = UIImageJPEGRepresentation(ImageforUpload, 1.0);
    fileBytes = [imageData base64Encoding];
    //NSLog(@"bytes %@",imageData);
    
    int len = [imageData length];
    byteLenth = [NSString stringWithFormat:@"%d",len];
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    datestr = [formatter stringFromDate:date];
    
    
    
    //Or you can get the image url from AssetsLibrary
    //NSString *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename]:%@", [imageRep filename]);
    };
    
    fileName = [[NSMutableString alloc]initWithString:issueIdTblStr];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyyMMdd_HHmmss"];
    imagedatestr = [formatter1 stringFromDate:date];
    [fileName appendString:@"_"];
    [fileName appendString:imagedatestr];
    [fileName appendString:@"image.jpg"];
    
    Servicecall=[[Webservices alloc]init];
    
    NSLog(@"nslog file name is %@",fileName);
    NSLog(@"issue id str is %@",issueIdTblStr);
    NSLog(@"attatchemnt id str is %@",fileBytes);
    NSString *SAveAttatchmentClassName=@"IssuesAttachment";
    NSDictionary *SaveAttachmentParameters=@{@"issueId":issueIdTblStr,@"attachmentName":fileName,@"attachmentBytes":fileBytes};
[Servicecall SaveAttatchmentInIssue:SAveAttatchmentClassName SaveAttatchmentIssuesDictionary:SaveAttachmentParameters];
[Servicecall setDelegate:self];
    
    }

//-(void)DatafromDB
//{
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
//        Useridstr  = [managedObject valueForKey:@"userid"];
//        UserTypestr = [managedObject valueForKey:@"userType"];
//        OrgIdStr = [managedObject valueForKey:@"orgId"];
//    }
//}

-(void)didFinishService:(id)Userlogindetails
{
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    NSLog(@"the project spinner data is %@",Userlogindetails);
    
    
    saveAttatchmentXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    saveAttatchmentXmlParser.delegate=self;
    [saveAttatchmentXmlParser parse];
    
    
    attatchmentListXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    attatchmentListXmlParser.delegate=self;
    [attatchmentListXmlParser parse];
    
}

-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];
   // NSLog(@"the project spinner data is %@",actionitemlist);
}
-(void)didNotesCountFinished :(id)Notescountlist
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    //NSLog(@"the project spinner data is %@",Notescountlist);

}
-(void)Serviceactiondone : (id)result
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
   // NSLog(@"the project spinner data is %@",result);

}
-(void)Serviceactiondone1 : (id)result
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:result];
    xmlParser4.delegate = self;
    [xmlParser4 parse];
    //NSLog(@"the project spinner data is %@",result);

    
}
-(void)didFinishData :(id)Data
{
    xmlParser5 = [[NSXMLParser alloc]initWithData:Data];
    xmlParser5.delegate = self;
    [xmlParser5 parse];
   // NSLog(@"the project spinner data is %@",Data);

    
}

-(void)didEndTask :(id)Taskend
{
    xmlParser6 = [[NSXMLParser alloc]initWithData:Taskend];
    xmlParser6.delegate = self;
    [xmlParser6 parse];
    //NSLog(@"the project spinner data is %@",Taskend);
}

-(void)serviceCal :(id)ServerData;
{
    xmlParser7 = [[NSXMLParser alloc]initWithData:ServerData];
    xmlParser7.delegate = self;
    [xmlParser7 parse];
    //NSLog(@"the project spinner data is %@",ServerData);
}
-(void)createIssueBtnClk
{
    NSLog(@"welcome to ios");
    
    projectTblStr = nil;
    projectTblStr = nil;
    issueStatusTblStr = nil;
    issueTypeTblStr = nil;
    assignToTblStr = nil;
    teamSubmittedTblStr = nil;
    severityTblStr = nil;
    descriptionTblStr = nil;
    isueHistoryTblStr = nil;

    
    projectTfd.text = nil;
    statusTfd.text = nil;
    typeTfd.text = nil;
    assignToTfd.text = nil;
    teamSubmittedTfd.text = nil;
    severityTfd.text = nil;
    descriptionTfd.text = nil;
    issueHistoryTextView.text = nil;
    
    //------------Project Spinner  Calling-------------//
    Servicecall = [[Webservices alloc]init];
    NSLog(@"user type str is %@",UserTypestr);
    NSString *projectLstForTask = @"TasksSpinnersListsService";
    NSDictionary *credentials = @{ @"usertype":UserTypestr,@"userID":Useridstr,@"orgId":OrgIdStr};
    [Servicecall createIssueProjectSpinner:projectLstForTask ParticipantsListParameters:credentials];
    [Servicecall setDelegate:self];
    
    
    NSLog(@"issueid =%@, isuueno =%@, projectid= %@, projectname= %@, issuestatus= %@, issuetype= %@, TeamName= %@, assignto= %@,  Description= %@, LongDescription= %@ ",issueIdTblStr,issueNoTblStr,projectIdTblStr,projectTblStr,issueStatusTblStr,issueTypeTblStr,teamSubmittedTblStr,assignToTblStr,descriptionTblStr,isueHistoryTblStr);
    
    [updateBtn setHidden:YES];
    [saveBtn setHidden:NO];

  

}
-(void)homeBtnClk
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)logOutBtnClk
{
    UIAlertView *logOutAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [logOutAlertView show];
    
}

-(IBAction)projectBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 170, self.view.frame.size.width-388, 300)];//300//380
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];

}
-(IBAction)statusBtnClk:(id)sender
{
    
   
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 250, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
    
    
}
-(IBAction)typeBtnClk:(id)sender
{
        
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 325, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 102;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
    
    
}
-(IBAction)assignToBtnClk:(id)sender
{
    
    
    
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 405, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 103;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];

    
   
    
}
-(IBAction)teamSubmittedBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 495, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 104;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
    
    
}
-(IBAction)severityBtnClk:(id)sender
{
        
    [questionpkr removeFromSuperview];
     questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, 585, self.view.frame.size.width-388, 300)];
//    CGRect firstLabelRect = severityTfd.frame;
//    CGFloat y = firstLabelRect.origin.y;
    NSLog(@"%f",self.scrollView.frame.origin.y);
    
   // questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(300, self.scrollView.frame.origin.y+585, self.view.frame.size.width-388, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 105;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
    
   
}


-(IBAction)issueSaveBtnClk:(id)sender
{
    if ( ([projectTfd.text length] == 0) || ([statusTfd.text length] == 0) || ([typeTfd.text length] == 0)||([assignToTfd.text length] == 0) ||([teamSubmittedTfd.text length] == 0)||([severityTfd.text length] == 0)||([descriptionTfd.text length] == 0)|| ([issueEntryTfd.text length] == 0)  )
        
    {
    //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Issue Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
  
                    
    
   
  
    
    
        
    }
    else{
        
        NSDate *aDate = [NSDate date];
        //converting Date to String
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *dateStr  = [formatter stringFromDate:aDate];
        
        NSMutableString *str = [[NSMutableString alloc]initWithString:Usernamestr];
        [str appendString:@"###"];
        [str appendString:dateStr];//[formatter stringFromDate:aDate]];
        [str appendString:@"###"];
        [str appendString:issueEntryTfd.text];
        
        NSLog(@"the str is %@",str);
        
        Servicecall = [[Webservices alloc]init];
        
        NSString *projectLstForTask = @"SaveAndUpdateTaskService";
        NSDictionary *credentials = @{ @"issueNo":@"0",@"issueStatus":issueNoStr,@"description":descriptionTfd.text,@"businessPriorty":businessPriortyStr,@"issueType":issueTypeStr,@"projectId":projectIdStr,@"teamImpact":teamImpactStr,@"resourceId":resourceIdStr,@"saveUpdateType":@"SaveIssues",@"orgId":OrgIdStr,@"userId":Useridstr,@"issueId":@"0",@"logDescription":str};
        [Servicecall saveIssue:projectLstForTask ParticipantsListParameters:credentials];
        [Servicecall setDelegate:self];
        
        
        NSLog(@"%@ ,%@ ,%@ , %@, %@ ,%@ ,%@ , %@, %@ ,%@ ,%@ , %@, %@",@"0",issueNoStr,descriptionTfd.text,businessPriortyStr,issueTypeStr,projectIdStr,teamImpactStr,resourceIdStr,@"SaveIssues",OrgIdStr,Useridstr,@"0",issueEntryTfd.text);
        
        //[issueHistoryTextView setText:str];
        issueEntryTfd.text = nil;
        
       
    }
    

    
    
   }
-(IBAction)issueHomeBtnClk:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];

}


-(IBAction)issueUpdateClk:(id)sender
{
    
    if ( ([projectTfd.text length] == 0) || ([statusTfd.text length] == 0) || ([typeTfd.text length] == 0)||([assignToTfd.text length] == 0) ||([teamSubmittedTfd.text length] == 0)||([severityTfd.text length] == 0)||([descriptionTfd.text length] == 0)/*|| ([issueEntryTfd.text length] == 0) */  )
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Issue Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        
        [alertView show];
        
        
        
    }
    else
    {
        NSLog(@"welcome to eis");
        
    if ([projectTblStr length]>0)
    {
        NSMutableString *str1 = [[NSMutableString alloc]init];
        [str1 setString:issueHistoryTextView.text];
        if ([issueEntryTfd.text length]>0)
        {
            [str1 appendString:@" "];
            
            NSDate *aDate = [NSDate date];
            //converting Date to String
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            NSString *dateStr  = [formatter stringFromDate:aDate];
            
            [str1 appendString:Usernamestr];
            [str1 appendString:@"###"];
            [str1 appendString:dateStr];//[formatter stringFromDate:aDate]];
            [str1 appendString:@"###"];
            [str1 appendString:issueEntryTfd.text];
            
            //[str1 appendString:issueEntryTfd.text];
            //issueHistoryTextView.text = str1;

        }
        else
        {
            str1=@"null";
        }
        
        
        NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",issueNoTblStr,issueNoStr,descriptionTfd.text,businessPriortyStr,issueTypeStr,projectIdStr,teamImpactStr,assignToTblStr,OrgIdStr,Useridstr,issueIdTblStr,issueEntryTfd.text);
        NSLog(@"assign id issssssss %@",resourceIdStr);
        Servicecall = [[Webservices alloc]init];
        
        NSString *projectLstForTask = @"SaveAndUpdateTaskService";
        NSDictionary *credentials = @{ @"issueNo":issueNoTblStr,@"issueStatus":issueNoStr,@"description":descriptionTfd.text,@"businessPriorty":businessPriortyStr,@"issueType":issueTypeStr,@"projectId":projectIdStr,@"teamImpact":teamImpactStr,@"resourceId":resourceIdStr,@"saveUpdateType":@"UpdateIssue",@"orgId":OrgIdStr,@"userId":Useridstr,@"issueId":issueIdTblStr,@"logDescription":str1/*issueEntryTfd.text*/};
        [Servicecall updateIssue:projectLstForTask ParticipantsListParameters:credentials];
        [Servicecall setDelegate:self];
        
        issueEntryTfd.text = nil;

        //
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@" successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//        [alertView show];
//        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    else
    {
        NSMutableString *str1 = [[NSMutableString alloc]init];
        //[str1 setString:issueHistoryTextView.text];
        if ([issueEntryTfd.text length]>0)
        {
            [str1 appendString:@" "];
            
            
            NSDate *aDate = [NSDate date];
            //converting Date to String
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            NSString *dateStr  = [formatter stringFromDate:aDate];
            
            [str1 appendString:Usernamestr];
            [str1 appendString:@":"];
            [str1 appendString:dateStr];//[formatter stringFromDate:aDate]];
            [str1 appendString:@"::"];
            [str1 appendString:issueEntryTfd.text];
            
            //[str1 appendString:issueEntryTfd.text];
            //issueHistoryTextView.text = str1;
            issueHistoryTextView.editable=YES;
        }
        
        NSLog(@"assign id isisisisisisi %@",resourceIdStr);
        Servicecall = [[Webservices alloc]init];
        NSString *projectLstForTask = @"SaveAndUpdateTaskService";
        NSDictionary *credentials = @{ @"issueNo":saveissueNumStr,@"issueStatus":issueNoStr,@"description":descriptionTfd.text,@"businessPriorty":businessPriortyStr,@"issueType":issueTypeStr,@"projectId":projectIdStr,@"teamImpact":teamImpactStr,@"resourceId":resourceIdStr,@"saveUpdateType":@"UpdateIssue",@"orgId":OrgIdStr,@"userId":Useridstr,@"issueId":saveissueIDStr,@"logDescription":str1/*issueEntryTfd.text*/};
        [Servicecall updateIssue:projectLstForTask ParticipantsListParameters:credentials];
        [Servicecall setDelegate:self];
        
        issueEntryTfd.text = nil;
    }

    }
    
}



//picker deligate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [projectnameArray count];
    }
    else if (picker.tag==101) {
        return [statusnameArray count];
    }
    else if (picker.tag==102) {
        return [statustypeArray count];
    }
    else if (picker.tag==103) {
        return [resourcenamearray count];
    }
    else if (picker.tag==104) {
        return [TeamnameArray count];
    }
    else if (picker.tag==105) {
        return [businessnameArray count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [projectnameArray objectAtIndex:row];
    }
    else if (picker.tag==101) {
        return [statusnameArray objectAtIndex:row];
    }
    else if (picker.tag==102) {
        return [statustypeArray objectAtIndex:row];
    }
    else if (picker.tag==103) {
        return [resourcenamearray objectAtIndex:row];
    }
    else if (picker.tag==104) {
        return [TeamnameArray objectAtIndex:row];
    }
    else if (picker.tag==105) {
        return [businessnameArray objectAtIndex:row];
    }

    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        projectTfd.text=[projectnameArray objectAtIndex:row];
        projectIdStr = [newprojectidstrArray objectAtIndex:row];
       //assignToTfd.text=[resourcenamearray objectAtIndex:row];
        //[self assignToService];
        //[questionpkr removeFromSuperview];

        
        NSLog(@"the project id isssssssss  %@ %@",[newprojectidstrArray objectAtIndex:row],[projectnameArray objectAtIndex:row]);
        
//        pkrSelectionProjectId = [PROJECT_IDArray objectAtIndex:row];
//        NSString *projectLstForTask = @"TasksSpinnersListsService";
//        NSDictionary *credentials1 = @{@"userType":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr,@"projectId":[PROJECT_IDArray objectAtIndex:row]};
//        [Servicecall createTimeSheetTask:projectLstForTask PublicDiscredentilas:credentials1];
//        [Servicecall setDelegate:self];
        
        
        
        [self statusService];
        [self typeService];
        [self assignToService];
        [self teamSubmittedService];
        [self severityService];
        
        
        
    }
    
    else if (pickerView.tag == 101) {
        statusTfd.text=[statusnameArray objectAtIndex:row];
        issueNoStr = [STATUS_IDArray objectAtIndex:row];
        issueStatusStr = [statusnameArray objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        
    }
    else if (pickerView.tag == 102) {
        typeTfd.text=[statustypeArray objectAtIndex:row];
        issueTypeStr = [TypESTATUS_IDArray objectAtIndex:row];
       //[questionpkr removeFromSuperview];
        
    }
    else if (pickerView.tag == 103)
    {
        assignToTfd.text=[resourcenamearray objectAtIndex:row];
        resourceIdStr = [ResourceIdArray objectAtIndex:row];
        
        NSLog(@"the resource id is %@ %@",resourceIdStr,assignToTfd.text);
        //[questionpkr removeFromSuperview];
        
    }
    else if (pickerView.tag == 104) {
        teamSubmittedTfd.text=[TeamnameArray objectAtIndex:row];
        teamImpactStr = [TeamIdArray objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        
    }
    else if (pickerView.tag == 105) {
        severityTfd.text=[businessnameArray objectAtIndex:row];
        businessPriortyStr = [BUSINESS_PRIORITY_IDArray objectAtIndex:row];
        //[questionpkr removeFromSuperview];
        
    }
    
    
    
    
    
}




//parsing Deligate methods

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser == xmlParser)
    {
        if ([elementName isEqualToString:@"projectLstForTaskResponse"])
        {
            TaskDetailsstr1        = [[NSString alloc] init];
            Taskdataarray1   = [[NSArray alloc]init];
            projectnameArray   = [[NSMutableArray alloc]init];
            newprojectidstrArray  = [[NSMutableArray alloc]init];
        }
    }
    
    if (parser == xmlParser1)
        
    {
        if ([elementName isEqualToString:@"issueStatusListResponse"])
        {
            TaskDetailsstr2        = [[NSString alloc] init];
            Taskdataarray2   = [[NSArray alloc]init];
            statusnameArray   = [[NSMutableArray alloc]init];
            STATUS_IDArray =  [[NSMutableArray alloc]init];
        }
    }

    if (parser == xmlParser2)
    {
        if ([elementName isEqualToString:@"issueTypeListResponse"])
        {
            TaskDetailsstr3  = [[NSString alloc] init];
            Taskdataarray3   = [[NSArray alloc]init];
            statustypeArray   = [[NSMutableArray alloc]init];
            TypESTATUS_IDArray   = [[NSMutableArray alloc]init];
            
        }
        
    }
    if (parser == xmlParser3)
    {
        if ([elementName isEqualToString:@"assignResFrIsses1Response"])
        {
            TaskDetailsstr5  = [[NSString alloc] init];
            Taskdataarray5   = [[NSArray alloc]init];
            resourcenamearray = [[NSMutableArray alloc]init];
            ResourceIdArray   = [[NSMutableArray alloc]init];
            
        }
        
    }

    if (parser == xmlParser4)
    {
        if ([elementName isEqualToString:@"teamSubFrIssesResponse"])
        {
            TaskDetailsstr6  = [[NSString alloc] init];
            Taskdataarray6   = [[NSArray alloc]init];
            TeamnameArray    = [[NSMutableArray alloc]init];
            TeamIdArray      = [[NSMutableArray alloc]init];
        }

        
    }
    
    
    if (parser == xmlParser5)
    {
        if ([elementName isEqualToString:@"issueBusinessPriorityListResponse"])
        {
            TaskDetailsstr4  = [[NSString alloc] init];
            Taskdataarray4   = [[NSArray alloc]init];
            businessnameArray    = [[NSMutableArray alloc]init];
            BUSINESS_PRIORITY_IDArray      = [[NSMutableArray alloc]init];
        }
        
    }
    if (parser == xmlParser6)
    {
        if ([elementName isEqualToString:@"saveAndUpdateIssuesResponse"])
        {
            TaskDetailsstr7  = [[NSString alloc] init];
           Taskdataarray7   = [[NSMutableArray alloc]init];
            Taskdataarray8=[[NSMutableArray alloc]init];
//            businessnameArray    = [[NSMutableArray alloc]init];
//            BUSINESS_PRIORITY_IDArray      = [[NSMutableArray alloc]init];
        }
        
    }
    if (parser == xmlParser7)
    {
        if ([elementName isEqualToString:@"saveAndUpdateIssuesResponse"])
        {
           
        }
        
    }
    if (parser == saveAttatchmentXmlParser)
    {
        if ([elementName isEqualToString:@"saveIssueAttachmentResponse"])
        {
            saveAttatchmentStr=[[NSString alloc]init];
        }
        
    }
    
    if (parser==attatchmentListXmlParser)
    {
        if ([elementName isEqualToString:@"issueAttachmentListResponse"])
        {
            AttatchmentListArray=[NSArray new];
            AttatchmentListSplitArray=[NSArray new];
            AttatchmentListArray1=[NSMutableArray new];
            AttatchmentFileNameArray=[NSMutableArray new];
            AttatchmentFileUrlArray=[NSMutableArray new];
            AttatchmentName=[NSString new];
            AttachmentUrl=[NSString new];
            
        }
    }

    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (parser == xmlParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            //projectTfd.text = nil;//[projectnameArray objectAtIndex:0];

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
        NSString *chandu = @"*********";
        TaskDetailsstr1= [TaskDetailsstr1 stringByAppendingString:chandu];
        TaskDetailsstr1= [TaskDetailsstr1 stringByAppendingString:string];
        //NSLog(@"agenda details are test2 is  %@",TaskDetailsstr1);
        Taskdataarray1 =[TaskDetailsstr1 componentsSeparatedByString:@"*********"];
        }
    }
    if (parser == xmlParser1)
    {
        if ([string isEqualToString:@"Flase"])
        {
            statusTfd.text = nil;//[projectnameArray objectAtIndex:0];

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
        NSString *chandu = @"*********";
        TaskDetailsstr2= [TaskDetailsstr2 stringByAppendingString:chandu];
        TaskDetailsstr2= [TaskDetailsstr2 stringByAppendingString:string];
        //NSLog(@"agenda details are test2 is  %@",TaskDetailsstr2);
        Taskdataarray2 =[TaskDetailsstr2 componentsSeparatedByString:@"*********"];
        }
    }
    if (parser == xmlParser2)
    {
        if ([string isEqualToString:@"Flase"])
        {
            typeTfd.text = nil;//[projectnameArray objectAtIndex:0];

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
        NSString *chandu = @"*********";
        TaskDetailsstr3= [TaskDetailsstr3 stringByAppendingString:chandu];
        TaskDetailsstr3= [TaskDetailsstr3 stringByAppendingString:string];
        //NSLog(@"agenda details are test2 is  %@",TaskDetailsstr3);
        Taskdataarray3 =[TaskDetailsstr3 componentsSeparatedByString:@"*********"];
        }
    }
    
    
    if (parser == xmlParser3)
    {
        if ([string isEqualToString:@"Flase"])
        {
            assignToTfd.text = nil;//[projectnameArray objectAtIndex:0];

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
        NSString *chandu = @"*********";
        TaskDetailsstr5 = [TaskDetailsstr5 stringByAppendingString:chandu];
        TaskDetailsstr5 = [TaskDetailsstr5 stringByAppendingString:string];
        NSLog(@"agenda details are test2 is  %@",TaskDetailsstr5);
        Taskdataarray5 =[TaskDetailsstr5 componentsSeparatedByString:@"*********"];
        }
    }
    
    if (parser == xmlParser4)
    {
    if ([string isEqualToString:@"Flase"])
    {
        teamSubmittedTfd.text = nil;//[projectnameArray objectAtIndex:0];

//        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//        
//        [alert show];
    }
    else{
        NSString *chandu = @"*********";
        TaskDetailsstr6 = [TaskDetailsstr6 stringByAppendingString:chandu];
        TaskDetailsstr6= [TaskDetailsstr6 stringByAppendingString:string];
        NSLog(@"agenda details are test2 is  %@",TaskDetailsstr6);
        Taskdataarray6 =[TaskDetailsstr6 componentsSeparatedByString:@"*********"];
    }
        
       
    }
    if (parser == xmlParser5)
    {
        if ([string isEqualToString:@"Flase"])
        {
            severityTfd.text = nil;//[projectnameArray objectAtIndex:0];

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }else{
            NSString *chandu = @"*********";
            TaskDetailsstr4 = [TaskDetailsstr4 stringByAppendingString:chandu];
            TaskDetailsstr4= [TaskDetailsstr4 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",TaskDetailsstr4);
            Taskdataarray4 =[TaskDetailsstr4 componentsSeparatedByString:@"*********"];
        }
        
    }
    
    
    if (parser == xmlParser6)
    {
        if ([string isEqualToString:@"Problem"])
        {

//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }else{
            
            TaskDetailsstr7 = [TaskDetailsstr7 stringByAppendingString:string];
            NSLog(@"agenda details are test2 is  %@",TaskDetailsstr7);
            
            issuehistryStr=[self convertHTML:TaskDetailsstr7];
            
            NSLog(@"issue history str is %@",issuehistryStr);
            
            //issuehistryStr1 = [issuehistryStr componentsSeparatedByString:@"116===116===IssueSaved"];
          
            [Taskdataarray7 addObject:issuehistryStr];
            
            for (int i=0; i<[Taskdataarray7 count]; i++)
            {
                Taskdataarray8=[[Taskdataarray7 objectAtIndex:i]componentsSeparatedByString:@"==="];
                saveissueIDStr=[Taskdataarray8 objectAtIndex:0];
                saveissueNumStr=[Taskdataarray8 objectAtIndex:3];
        
            }
            issueHistoryTextView.text=saveissueNumStr;
            
           
            
            NSLog(@"the save num str is %@",saveissueNumStr);
            
            NSLog(@"save issue save id is %@",saveissueIDStr);
            
            //NSString *saveisueIdStr1=[saveissueIDStr stringByReplacingOccurrencesOfString:@"===" withString:@""];
            
            
           // NSLog(@"save issue number str is %@",saveissueNumStr);
            NSLog(@"the task id is %@",saveissueIDStr);
            NSLog(@"the task no is %@",saveissueNumStr);
            
            issueIdTblStr=saveissueIDStr;
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [saveBtn setHidden:YES];
            [updateBtn setHidden:NO];
            [projectListBtn setEnabled:NO];
            
            
            UIButton *uploadButton=[[UIButton alloc]initWithFrame:CGRectMake(issueHistoryTextView.frame.origin.x+400,issueHistoryTextView.frame.origin.y+220,80,40)];
            
            [uploadButton setTitle:@"Uplaod" forState:UIControlStateNormal];
            [uploadButton addTarget:self action:@selector(uploadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [uploadButton setBackgroundColor:[UIColor grayColor]];
            [createIssueView addSubview:uploadButton];
            
            UILabel *attatchmentsLabel=[[UILabel alloc]initWithFrame:CGRectMake(issueHistoryTextView.frame.origin.x-200, issueHistoryTextView.frame.origin.y+200, 150, 40)];
            
            attatchmentsLabel.text=@"Attatchments";
            attatchmentsLabel.tag=155;
            [createIssueView addSubview:attatchmentsLabel];
            [self AttatchmentList];
            
            
            attatchmentTableView=[[UITableView alloc]initWithFrame:CGRectMake(attatchmentsLabel.frame.origin.x+200, attatchmentsLabel.frame.origin.y-20, issueHistoryTextView.frame.size.width, 100) ];
            
            
            attatchmentTableView.scrollEnabled=YES;
            attatchmentTableView.userInteractionEnabled=true;
            attatchmentTableView.layer.borderColor = [UIColor purpleColor].CGColor;
            attatchmentTableView.allowsSelectionDuringEditing=YES;
            attatchmentTableView.layer.cornerRadius = 10.0f;
            attatchmentTableView.allowsSelection=YES;
            attatchmentTableView.layer.cornerRadius=4;
            attatchmentTableView.layer.borderWidth=3.0f;
            attatchmentTableView.delegate=self;
            attatchmentTableView.dataSource=self;
            [createIssueView addSubview:attatchmentTableView];
        }
        
    }

    
    if (parser == xmlParser7)
    {
        
        NSLog(@"hai");
        
        
        if ([string isEqualToString:@"Problem"])
        {
            

        }else
        {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"successfully updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [issueDescStr stringByAppendingString:string];
            
            NSLog(@"hellllllo shaik %@",issueDescStr);
            
            issuehistryStr1=[self convertHTML:issueDescStr];
            
            NSLog(@"issue history str 1 %@",issuehistryStr1);
            
            
        }
        
    }
    
    if (parser == saveAttatchmentXmlParser)
    {
        
        if ([string isEqualToString:@"Problem"]||[string isEqualToString:@"Fasle"])
        {
            
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@" not iserted image" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [alertView show];
//            [alertView dismissWithClickedButtonIndex:0 animated:YES];

       }
        else
        {
            saveAttatchmentStr=string;
        }
        
    }
    if (parser == attatchmentListXmlParser)
    {
        
        NSLog(@"hai");
        
        
        if ([string isEqualToString:@"Problem"]||[string isEqualToString:@"Flase"])
        {
            
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@" Issues Attatchment Lsit is Empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [alertView show];
//            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
        else
        {
            [AttatchmentListArray1 addObject:string];
            
            
        }
        
    }

    

    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == xmlParser)
    {
        if ([elementName isEqualToString:@"projectLstForTaskResponse"])
            
        {
            for (int i=1; i<[Taskdataarray1 count]; i++)
            {
                
                TasksplitArray1 = [[Taskdataarray1 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray1 count]; j++)
                {
                    projectname = [[TasksplitArray1 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                    newprojectidstr = [[TasksplitArray1 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"PROJECT_ID==" withString:@""];
                    
                }
                
                [projectnameArray addObject:projectname];
                [newprojectidstrArray addObject:newprojectidstr];
                NSLog(@"project name is %@",projectnameArray);

               
                if ([projectTblStr length] == 0)
                {

                    projectTfd.text = [projectnameArray objectAtIndex:0];
                    projectIdStr = [newprojectidstrArray objectAtIndex:0];
                    
                    [self statusService];
                    [self typeService];
                    [self assignToService];
                    [self teamSubmittedService];
                    [self severityService];
                }
               



                NSString *tempString = projectTblStr;
                for(int i=0; i<[projectnameArray count]; i++)
                {
                    if([tempString isEqualToString:[projectnameArray objectAtIndex:i]])
                    {
                        
                        projectIdStr = [newprojectidstrArray objectAtIndex:i];
                        projectTfd.text=[projectnameArray objectAtIndex:i];
                        
                        [self statusService];
                        [self typeService];
                        [self assignToService];
                        [self teamSubmittedService];
                        [self severityService];
                        
                    }
                }

               
                
                
            }
            
        }
        
    }
    
    
    if (parser == xmlParser1)
    {
        if ([elementName isEqualToString:@"issueStatusListResponse"])
            
        {
            for (int i=1; i<[Taskdataarray2 count]; i++)
            {
                
                TasksplitArray2 = [[Taskdataarray2 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray2 count]; j++)
                {
                    statusname = [[TasksplitArray2 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"STATUS_NAME==" withString:@""];
                    STATUS_IDStr = [[TasksplitArray2 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"STATUS_ID==" withString:@""];
                }
                
                [statusnameArray addObject:statusname];
                [STATUS_IDArray addObject:STATUS_IDStr];
                NSLog(@"status id  array is %@",STATUS_IDArray);
                NSLog(@"status  name is %@",statusnameArray);
                
                if ([issueStatusTblStr length] == 0)
                {

                statusTfd.text = [statusnameArray objectAtIndex:0];
                issueNoStr = [STATUS_IDArray objectAtIndex:0];
                issueStatusStr = [statusnameArray objectAtIndex:0];
                }

                NSString *tempString = issueStatusTblStr;
                for(int i=0; i<[statusnameArray count]; i++)
                {
                    if([tempString isEqualToString:[statusnameArray objectAtIndex:i]])
                    {
                        
                        issueNoStr = [STATUS_IDArray objectAtIndex:i];
                        issueStatusStr = [statusnameArray objectAtIndex:i];

                    }
                }
                
                
            }
            
            
        }
        
    }

    if (parser == xmlParser2)
    {
        if ([elementName isEqualToString:@"issueTypeListResponse"])
            
        {
            
            
            for (int i=1; i<[Taskdataarray3 count]; i++)
            {
                
                TasksplitArray3 = [[Taskdataarray3 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray3 count]; j++)
                {
                    statustype = [[TasksplitArray3 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"STATUS_NAME==" withString:@""];
                    TypESTATUS_IDStr = [[TasksplitArray3 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"STATUS_ID==" withString:@""];
                    
                }
                
                [statustypeArray addObject:statustype];
                [TypESTATUS_IDArray addObject:TypESTATUS_IDStr];
                NSLog(@"the type is %@ %@",statustypeArray,STATUS_IDArray);
                
                if ([issueTypeTblStr length] == 0)
                {

                typeTfd.text = [statustypeArray objectAtIndex:0];
                issueTypeStr = [TypESTATUS_IDArray objectAtIndex:0];
                }

                NSString *tempString = issueTypeTblStr;
                for(int i=0; i<[statustypeArray count]; i++)
                {
                    if([tempString isEqualToString:[statustypeArray objectAtIndex:i]])
                    {
                        
                        issueTypeStr = [TypESTATUS_IDArray objectAtIndex:i];
                        
                    }
                }
                

                
                
            }
          
            
        }
        
    }
    
    if (parser == xmlParser3)
    {
        if ([elementName isEqualToString:@"assignResFrIsses1Response"])
            
        {
            for (int i=1; i<[Taskdataarray5 count]; i++)
            {
                
                TasksplitArray5 = [[Taskdataarray5 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray5 count]; j++)
                {
                    resourcename = [[TasksplitArray5 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ResourceName==" withString:@""];
                    
                    ResourceIdStr = [[TasksplitArray5 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"ResourceId==" withString:@""];
                }
                
                [resourcenamearray addObject:resourcename];
                
                [ResourceIdArray addObject:ResourceIdStr];
                NSLog(@"resource name is %@ %@",resourcenamearray,ResourceIdArray);
                
                if ([assignToTblStr length] == 0)
                {
                    
                    assignToTfd.text = [resourcenamearray objectAtIndex:0];
                    resourceIdStr = [ResourceIdArray objectAtIndex:0];
                    
                    
                }
                NSString *tempString = assignToTblStr;
                for(int i=0; i<[resourcenamearray count]; i++)
                {
                    if([tempString isEqualToString:[resourcenamearray objectAtIndex:i]])
                    {
                        
                        resourceIdStr = [ResourceIdArray objectAtIndex:i];
                        
                    }
                }

                
                //resourceIdStr = [ResourceIdArray objectAtIndex:0];
                
                //assignToTfd.text=[resourcenamearray objectAtIndex:0];

//                NSString *tempString = assignToTblStr;
//                for(int i=0; i<[resourcenamearray count]; i++)
//                {
//                    if([tempString isEqualToString:[resourcenamearray objectAtIndex:i]])
//                    {
//                        
//                        resourceIdStr = [ResourceIdArray objectAtIndex:i];
//                        
//                    }
//                }

                
                
            }
            
            
        }
        
    }
    
    if (parser == xmlParser4)
    {
        if ([elementName isEqualToString:@"teamSubFrIssesResponse"])
            
        {
            
            
            for (int i=1; i<[Taskdataarray6 count]; i++)
            {
                
                TasksplitArray6 = [[Taskdataarray6 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                 NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray6 count]; j++)
                {
                    teamsubmittedname = [[TasksplitArray6 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"TeamName==" withString:@""];
                    TeamIdStr  = [[TasksplitArray6 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"TeamId==" withString:@""];
                }
                
                [TeamnameArray addObject:teamsubmittedname];
                [TeamIdArray addObject:TeamIdStr];
                NSLog(@"team submitted name is %@ %@",TeamnameArray,TeamIdArray);
                

                teamImpactStr = [TeamIdArray objectAtIndex:0];
                
                teamSubmittedTfd.text=[TeamnameArray objectAtIndex:0];


//                NSString *tempString = teamSubmittedTblStr;
//                for(int i=0; i<[TeamnameArray count]; i++)
//                {
//                    if([tempString isEqualToString:[TeamnameArray objectAtIndex:i]])
//                    {
//                        
//                        teamImpactStr = [TeamIdArray objectAtIndex:i];
//                        
//                    }
//                }
                
                
                
                
            }
            
            
        }
        
    }

    if (parser == xmlParser5)
    {
        if ([elementName isEqualToString:@"issueBusinessPriorityListResponse"])
            
        {
            for (int i=1; i<[Taskdataarray4 count]; i++)
            {
                
                TasksplitArray4 = [[Taskdataarray4 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=1; j<[TasksplitArray4 count]; j++)
                {
                    businessname = [[TasksplitArray4 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"BUSINESS_PRIORITY_NAME==" withString:@""];
                    BUSINESS_PRIORITY_IDStr  = [[TasksplitArray4 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"BUSINESS_PRIORITY_ID==" withString:@""];
                }
                
                [businessnameArray addObject:businessname];
                [BUSINESS_PRIORITY_IDArray addObject:BUSINESS_PRIORITY_IDStr];
                NSLog(@"team submitted name is %@ %@",businessnameArray,BUSINESS_PRIORITY_IDArray);
                
                if ([severityTblStr length] == 0)
                {

                severityTfd.text = [businessnameArray objectAtIndex:0];
                businessPriortyStr = [BUSINESS_PRIORITY_IDArray objectAtIndex:0];


                }
                
                NSString *tempString = severityTblStr;
                for(int i=0; i<[businessnameArray count]; i++)
                {
                    if([tempString isEqualToString:[businessnameArray objectAtIndex:i]])
                    {
                        
                        businessPriortyStr = [BUSINESS_PRIORITY_IDArray objectAtIndex:i];
                        
                    }
                }
                
            }
            
            
        }
        
    }
    
    
    if(parser==saveAttatchmentXmlParser)
    {
        if ([elementName isEqualToString:@"saveIssueAttachmentResponse"])
       {
           if ([saveAttatchmentStr isEqualToString:@"Inserted"])
           {
                [self.view makeToast:@"Attatchment successfully uploaded" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(400, 500)] ];
               [self AttatchmentList];
           }
          
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ISsue Attatchment" message:@"Attatchment is not inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    }
    if (parser == attatchmentListXmlParser)
    {
        if ([elementName isEqualToString:@"issueAttachmentListResponse"])
            
        {
            for (int i=0; i<[AttatchmentListArray1 count]; i++)
            {
                
                AttatchmentListArray = [[AttatchmentListArray1 objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",TasksplitArray1);
                
                for (int j=0; j<[AttatchmentListArray count]; j++)
                {
                    AttatchmentName = [[AttatchmentListArray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"fileName==" withString:@""];
                    AttachmentUrl  = [[AttatchmentListArray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"attachmentUrl==" withString:@""];
                    
                    
                }
                [AttatchmentFileNameArray addObject:AttatchmentName];
                [AttatchmentFileUrlArray addObject:AttachmentUrl];
                
                NSLog(@"file name array is %@",AttatchmentFileNameArray);
                NSLog(@"url array is %@",AttatchmentFileUrlArray);
//                }
            }
            
          [attatchmentTableView reloadData];
        }
        
        
    }

}


-(NSString *)convertHTML:(NSString *)html
{
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //issuehistryStr1=[html stringByReplacingOccurrencesOfString:@"116" withString:@""];
    
    //[Taskdataarray7 addObject:html];
    
    
    
    NSLog(@" html converting values are %@",issuehistryStr1);
    
    //issueHistoryTextView.text = issuehistryStr1;
    
    return html;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AttatchmentFileNameArray count];
    NSLog(@"welcome to attatchment table view");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIDentifier=@"AttatchmentCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIDentifier];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
    cell.textLabel.text=[AttatchmentFileNameArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"table view row selected");
    
    NSString *fileurl=[AttatchmentFileUrlArray objectAtIndex:indexPath.row];
    NSArray *parts = [fileurl componentsSeparatedByString:@"/"];
    NSString *filename = [parts lastObject];
    
    NSString *extn =[filename pathExtension];
    
    NSLog(@"file extn is %@",extn);
    
    NSURL  *url = [NSURL URLWithString:fileurl];
    
    //NSLog(@"not existing url is %@",url);
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if([extn isEqualToString:@"jpg"]||[extn isEqualToString:@"png"])
    {
               
        NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileurl];
        [urlData writeToFile:filePath atomically:YES];
        
        NSLog(@"the file path is %@",filePath);
        
        NSURL *audioURL = [NSURL fileURLWithPath:filePath];
        
        NSString *sourcePath =[audioURL path];
        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
        
        
        UIImage *image = [[UIImage alloc]initWithData:urlData];
        NSLog(@"image is %@",image);
        
        
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize screenSize = rect.size;
        
        ImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height+20)];
        //ImgView.backgroundColor=[UIColor orangeColor];
        ImgView.userInteractionEnabled=YES;
        
        ImgView.image = image;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(350, 1000, 55, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed55)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
       [ImgView addSubview:myButton];
        
        //[self.view addSubview:textView];
        
        [createIssueView addSubview:ImgView];
        
    }
    else if([extn isEqualToString:@"pdf"]||[extn isEqualToString:@"pptx"]||[extn isEqualToString:@"docx"] ||[extn isEqualToString:@"xlsx"])
    {
        
        NSData *pdfData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:fileurl]];
        
        // Store the Data locally as PDF File
        NSString *resourceDocPath = [[NSString alloc]initWithString:[
                                                                      [[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]
                                                                      stringByAppendingPathComponent:@"Documents"
                                                                      ]];
        
        NSString *filePath = [resourceDocPath
                              stringByAppendingPathComponent:@"myPDF.pdf"];
        [pdfData writeToFile:filePath atomically:YES];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize screenSize = rect.size;
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height-10)];
        webView.userInteractionEnabled=YES;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(350, 980, 55, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed25)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
        [webView addSubview:myButton];
        
        
        // Now create Request for the file that was saved in your documents folder
        //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 250, self.view.frame.size.width, 300)];
        
        NSURL *targetURL = [NSURL URLWithString:fileurl];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
    }
   
    else if ([extn isEqualToString:@"txt"])
    {
        NSString *urlString = fileurl;
        NSURL *myURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString *string = [NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"the content is %@",string);
        
        CGRect textViewFrame = CGRectMake(100, 500, 500, 300);
        textView = [[UITextView alloc] initWithFrame:textViewFrame];
        textView.layer.borderWidth=5.0f;
        textView.layer.borderColor=[[UIColor grayColor]CGColor];
        textView.returnKeyType = UIReturnKeyDone;
        textView.scrollEnabled=YES;
        textView.text=string;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(200, 250, 50.0, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed555)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor grayColor];
        [textView addSubview:myButton];
        
        [self.view addSubview:textView];
    }
    else if ([extn isEqualToString:@"csv"])
    {
      
        NSMutableArray *colA = [NSMutableArray array];
        NSMutableArray *colB = [NSMutableArray array];
        NSString* fileContents = [NSString stringWithContentsOfURL:url];
        NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
        for (NSString *row in rows)
        {
            NSArray* columns = [row componentsSeparatedByString:@","];
            [colA addObject:columns[0]];
            [colB addObject:columns[1]];
        }
        NSLog(@"col A is %@",colA);
        NSLog(@"Col B is %@",colB);
    }
    
    
}

-(void)cancelPressed55
{
    ImgView.image=nil;
    [ImgView removeFromSuperview];
    NSLog(@"image view cleared");
}
-(void)cancelPressed25
{
    [webView removeFromSuperview];
}
-(void)cancelPressed555
{
    [textView removeFromSuperview];
}




//Aler View Deligate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
        
    }
    else
    {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    //
}


//textField Deligate mehods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [hoursSpendTfd resignFirstResponder];
//    [estdHrsTfd resignFirstResponder];
//    [reasonsTfd resignFirstResponder];
    
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    if(textField == descriptionTfd)
    {
        
        NSLog(@"textViewDidBeginEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y =frame.origin.y -180;
        [self.view setFrame:frame];
        [UIView commitAnimations];

    }
    else if(textField == issueEntryTfd)
    {
        [issueEntryTfd resignFirstResponder];
        
    }
    
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [issueHistoryTextView resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    
    if(textField == descriptionTfd)
     {
        
        NSLog(@"textViewDidEndEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = self.view.frame;
        frame.origin.y = frame.origin.y + 180;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    
   
}
//- (void) textViewDidBeginEditing:(UITextView*)textview
//{
//    [self performSelector:@selector(placeCursorAtEnd:) withObject:issueHistoryTextView afterDelay:0.01];
//}
//
//- (void)placeCursorAtEnd:(UITextView *)textview
//{
//    NSUInteger length = issueHistoryTextView.text.length;
//    
//    issueHistoryTextView.selectedRange = NSMakeRange(length, 0);
//}

//Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchObj = [touches allObjects];
    CGPoint pnt = [touchObj locationInView:self.view];
    [questionpkr removeFromSuperview];
    [issueEntryTfd resignFirstResponder];
    [descriptionTfd resignFirstResponder];
}

-(void)userTapped
{
    [questionpkr removeFromSuperview];
    [issueEntryTfd resignFirstResponder];
    [descriptionTfd resignFirstResponder];
    //[issueHistoryTextView resignFirstResponder];
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
