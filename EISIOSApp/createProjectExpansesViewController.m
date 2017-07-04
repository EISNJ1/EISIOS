//
//  createProjectExpansesViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 16/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "createProjectExpansesViewController.h"

@interface createProjectExpansesViewController ()

@end

@implementation createProjectExpansesViewController
@synthesize tblProjectNmae,tblCategoryName,tblProjectAmountID,tblExpAttachID,tblDateStr,tblAmountStr,tblImageNameStr,fileurl,projectIdStr,projectIdCategryIdStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    _scroolview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:_scroolview];
//    [_scroolview addSubview:createExpencesView];
    
    //----------------view back ground stroke--------------------//
    attachmentsTextView.layer.cornerRadius = attachmentsTextView.frame.size.width / 2;
    attachmentsTextView.clipsToBounds = YES;
    attachmentsTextView.layer.borderWidth = 3.0f;
    attachmentsTextView.layer.borderColor = [UIColor blueColor].CGColor;
    attachmentsTextView.layer.cornerRadius = 10.0f;
    attachmentsTextView.layer.cornerRadius=4;
    [attachmentsTextView setHidden:YES];
    [galleryBtn setHidden:YES];
    [cameraBtn setHidden:YES];
    [attatchmentlabel setHidden:YES];
    
    createExpencesView.layer.cornerRadius = createExpencesView.frame.size.width / 2;
    createExpencesView.clipsToBounds = YES;
    createExpencesView.layer.borderWidth = 3.0f;
    createExpencesView.layer.borderColor = [UIColor blueColor].CGColor;
    createExpencesView.layer.cornerRadius = 10.0f;
    createExpencesView.layer.cornerRadius=4;
    
    
    //-------------------Right side pop Button---------------------//
    
    createTimeSheetActionBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_new_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createTimeetActionBtnClk)];
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:createTimeSheetActionBarBtn,logOutBtn,homeBtn,nil];
    
    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    
    [self projectSpinnerService];
   
    
    [expansesUpdateBtn setHidden:YES];

    if ([tblProjectNmae length]>0)
    {
        [expensesSaveBtn setHidden:YES];
        [expansesUpdateBtn setHidden:NO];
        projectTfd.text = tblProjectNmae;
        categoryTfd.text = tblCategoryName;
        [headingLabel setText:@"Update Project Expenses"];
        dateTfd.text = tblDateStr;
        tblDateStr = [tblDateStr substringToIndex:10];
        dateTfd.text = tblDateStr;
        
        [atachmentsImageView setImage:[UIImage imageNamed:tblImageNameStr]];

        amountTfd.text = tblAmountStr;
        NSLog(@"project name is %@" ,tblProjectNmae);
        
        
        pkrCategoryIDStr=projectIdCategryIdStr;
        pkrProjectAmountIDStr = tblProjectAmountID;
        pkrProjectIDStr=projectIdStr;
        NSLog(@"project id str is %@",pkrProjectIDStr);
        NSLog(@"projectpkramount id str is %@",pkrProjectAmountIDStr);
        //pkrExpAtachIDStr = tblExpAttachID;
        
        imageNameLbl.text = tblImageNameStr;
        NSLog(@"the image table name str is %@",tblImageNameStr);
        NSLog(@"the attatchment id is %@",tblExpAttachID);
        NSLog(@"the amount id is %@",tblProjectAmountID);
        [attachmentsTextView setHidden:NO];
        [galleryBtn setHidden:NO];
        [cameraBtn setHidden:YES];
        [attatchmentlabel setHidden:NO];
        
        [self projectSpinnerService];
        [self attatchmentList];
        [self categorySpinnerListService];
        
        //[self downloadFilesUrl];

    }
    else
    {
        [headingLabel setText:@"Save Project Expenses"];
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
    _scroolview.contentSize = CGSizeMake(320, 1300);
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)attatchmentList
{
    NSLog(@"pkr project id str is %@",pkrProjectAmountIDStr);
    Servicecall=[[Webservices alloc]init];
    NSString *attatchmetnList=@"ProjectExpense";
    NSDictionary *attatchmentListParameters=@{@"projExpenseId":pkrProjectAmountIDStr};
    [Servicecall projectExpensesAttatchmentList:attatchmetnList projectExpensesAttatchmentDictionary:attatchmentListParameters];
    [Servicecall setDelegate:self];
}
-(void)getBytesService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ProjectExpense";
    NSDictionary *credentials = @{@"exp_attach_Id":tblExpAttachID,@"proj_amnt_Id":tblProjectAmountID};
    [Servicecall projectExpancesBytesService:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    NSLog(@"the service response is");
}

-(void)projectSpinnerService
{
    
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr};
    [Servicecall projectExpencesListSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)categorySpinnerListService
{
    NSLog(@"welcome to %@",pkrProjectIDStr);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ProjectExpense";
    NSDictionary *credentials = @{@"projectId":pkrProjectIDStr};
    [Servicecall createprojectExpencesCategorySpinnerList:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)saveService
{
    //NSLog(@"byte array string is in save %@",byteArray);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"SaveExpenses";
    NSDictionary *credentials = @{@"date":dateTfd.text,@"amount":amountTfd.text,@"budgtCatgry":pkrCategoryIDStr,@"projId":pkrProjectIDStr};
   // NSLog(@"the dict is %@",credentials);
    
    [Servicecall expansesSave:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)updateService
{
    NSLog(@"the projectamountid stringis %@",pkrProjectAmountIDStr);
    NSLog(@"the projectid stringis %@",pkrProjectIDStr);
    NSLog(@"budget category id is %@",pkrCategoryIDStr);
    //NSLog(@"the file byte array stringis %@",byteArray);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"SaveExpenses";
    NSDictionary *credentials = @{@"proj_amnt_Id":pkrProjectAmountIDStr,@"date":dateTfd.text,@"amount":amountTfd.text,@"budgtCatgry":pkrCategoryIDStr,@"projId":pkrProjectIDStr};
    [Servicecall expansesUpdate:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
    
}
-(void)didFinishService :(id)Userlogindetails
{
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    attatchmentXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    attatchmentXmlParser.delegate=self;
    [attatchmentXmlParser parse];
    
    attatchmentListXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    attatchmentListXmlParser.delegate=self;
    [attatchmentListXmlParser parse];
    
    
    
}
-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];

    
}
-(void)didNotesCountFinished :(id)Notescountlist    
{
    xmlParser2 = [[NSXMLParser alloc]initWithData:Notescountlist];
    xmlParser2.delegate = self;
    [xmlParser2 parse];
    
}
-(void)Serviceactiondone : (id)result
{
    xmlParser3 = [[NSXMLParser alloc]initWithData:result];
    xmlParser3.delegate = self;
    [xmlParser3 parse];
}

-(void)Serviceactiondone1 : (id)result
{
    xmlParser4 = [[NSXMLParser alloc]initWithData:result];
    xmlParser4.delegate = self;
    [xmlParser4 parse];
    
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
    [expensesSaveBtn setHidden:NO];
    [expansesUpdateBtn setHidden:YES];
    
    projectTfd.text = nil;
    categoryTfd.text = nil;
    dateTfd.text = nil;
    amountTfd.text = nil;
    pkrProjectAmountIDStr = nil;
    pkrExpAtachIDStr = nil;
    
    tblProjectNmae = nil;
    tblCategoryName = nil;
    tblDateStr = nil;
    tblAmountStr = nil;
    
    tblProjectAmountID = nil;
    tblExpAttachID = nil;
    
    imageNameLbl.text=nil;
    
    [self projectSpinnerService];
    [attachmentsTextView setHidden:YES];
    [galleryBtn setHidden:YES];
    [cameraBtn setHidden:YES];
    [attatchmentlabel setHidden:YES];
    //[self categorySpinnerListService];
}

-(IBAction)expansesSaveBtnClk:(id)sender
{
    if (([projectTfd.text length] == 0)|| ([dateTfd.text length ]== 0) || ([amountTfd.text length]== 0) || ([categoryTfd.text length]== 0))
        
    {
        //Alert View
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Project Expenses Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
        [alertView show];
    }
    else
    {
        [self saveService];

    }
    
    
}
-(IBAction)expansesUpdateBtnClk:(id)sender
{
    if (([projectTfd.text length] == 0)|| ([dateTfd.text length ]== 0) || ([amountTfd.text length]== 0) || ([categoryTfd.text length]== 0) )
    
{
    //Alert View
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Fill The Project Expenses Details" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
    [alertView show];
}
    else
    {
    [self updateService];
    }
    
}
-(IBAction)expansesHomeBtnClk:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}


-(IBAction)expansesProjectBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(240, 190, self.view.frame.size.width-358, 300)];//410
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
}
-(IBAction)expansesDateBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    datePkr = [[UIDatePicker alloc] initWithFrame:CGRectMake(240, 255, self.view.frame.size.width-358, 300)];
    [datePkr addTarget:self action:@selector(pickerChanged1:) forControlEvents:UIControlEventValueChanged];
    datePkr.backgroundColor=[UIColor whiteColor];
    datePkr.datePickerMode = UIDatePickerModeDate;
    datePkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:datePkr];
    
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"%@",currentDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    //dateTfd.text = [formatter stringFromDate:currentDate];
    //        return NO;
    
    [datePkr setMinimumDate:currentDate];

}
- (void)pickerChanged1:(id)sender
{
    
    NSDate *selectedDate = datePkr.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    dateTfd.text = [formatter stringFromDate:selectedDate];
    //[datePkr removeFromSuperview];
    [dateTfd resignFirstResponder];
}

-(IBAction)expansesCategoryBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];

    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(240, 390, self.view.frame.size.width-358, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 101;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
}

-(IBAction)atachmentsCamBtnClk:(id)sender
{

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera ])
    {
    camImagePickerController = [[UIImagePickerController alloc]init];
    camImagePickerController.delegate=self;
    camImagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camImagePickerController  animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Connect Camera Device" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)atachmentsGalaryBtnClk:(id)sender
{
    galaryImagePickerController = [[UIImagePickerController alloc] init];
    galaryImagePickerController.delegate=self;
    galaryImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:galaryImagePickerController  animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker == camImagePickerController)
    {
        atachmentsImageView.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];

//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *localFilePath = [documentsDirectory stringByAppendingString:@"/images.png"];
//        NSLog(@"localFilePath %@",localFilePath);
//        imageNameLbl.text = localFilePath;
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyyMMdd_HHmmss"];
        NSDate *now = [NSDate date];
        NSMutableString *theDate = [[NSMutableString alloc]init];
        [theDate setString:@"IMG"];
        [theDate appendString:@"_"];
        [theDate appendString:[dateFormat stringFromDate:now]];
        [theDate appendString:@".jpg"];
        NSLog(@"theDate: %@ ", theDate);
        imageNameLbl.text = theDate;

        NSData *data =  UIImagePNGRepresentation(image);
        byteArray  = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        [self saveAttatchment];


    }
    else if (picker == galaryImagePickerController)
    {
        
        
        atachmentsImageView.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *localFilePath = [documentsDirectory stringByAppendingString:@"/images.png"];
//        NSLog(@"localFilePath.%@",localFilePath);
//        imageNameLbl.text = localFilePath;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyyMMdd_HHmmss"];
        NSDate *now = [NSDate date];
        NSMutableString *theDate = [[NSMutableString alloc]init];
        [theDate setString:@"IMG"];
        [theDate appendString:@"_"];
        [theDate appendString:[dateFormat stringFromDate:now]];
        [theDate appendString:@".jpg"];
        NSLog(@"theDate: %@ ", theDate);
         fileName= theDate;
        
        NSData *data = UIImageJPEGRepresentation(image,1.0);
        byteArray  = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
         [self saveAttatchment];
        //NSLog(@"the byte array is %@",byteArray);


    }
   

}

-(void)saveAttatchment
{
    NSLog(@"pkr project amount id is %@",pkrProjectAmountIDStr);
    Servicecall=[[Webservices alloc]init];
    NSString *SaveAttachmentClass=@"SaveExpenses";
    NSDictionary *SaveAttatchmentParameters=@{@"projExpenseId":pkrProjectAmountIDStr,@"fileName":fileName,@"fileBytes":byteArray};
    [Servicecall saveAttatchmentInProjectExpenses:SaveAttachmentClass saveAttatchmentProjectExpensesParameters:SaveAttatchmentParameters];
    [Servicecall setDelegate:self];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"projLstForReqGathResponse"])
    {
        projectStr          = [[NSString alloc] init];
        projectNameSplitAry   = [[NSArray alloc] init];
        projectNameDataAry    = [[NSArray alloc] init];
        
        projectIdArray        = [[NSMutableArray alloc] init];
        projectNameArray  = [[NSMutableArray alloc] init];
//        projectnamearray=[[NSMutableArray alloc]init];
//        projectidarray=[[NSMutableArray alloc]init];
        
    }
    
    
    else if ([elementName isEqualToString:@"categoryResponse"])
    {
        categoryliststring       = [[NSString alloc] init];
        categorylistdataarray    = [[NSArray alloc] init];
        categorylistsplitarray   = [[NSArray alloc] init];
        
        categoryCodeIDArray         = [[NSMutableArray alloc] init];
        categoryValuesArray       = [[NSMutableArray alloc] init];
        
    }
    else if ([elementName isEqualToString:@"saveExpResponse"])
    {
        saveStr       = [[NSString alloc] init];
        saveDataAry    = [[NSArray alloc] init];
        saveSplitAry   = [[NSArray alloc] init];
        
    }
    
    else if ([elementName isEqualToString:@"getAttachmentUrlResponse"])
    {
        getBytesStr       = [[NSString alloc] init];
        getBytesDataArray    = [[NSArray alloc] init];
        fileurlarray=[[NSArray alloc]init];
        
    }
    
    else if ([elementName isEqualToString:@"saveProjExpensesAttachmentResponse"])
    {
        getBytesStr       = [[NSString alloc] init];
        getBytesDataArray    = [[NSArray alloc] init];
        fileurlarray=[[NSArray alloc]init];
        
    }
    else if ([elementName isEqualToString:@"projectAttachmentListResponse"])
    {
        attatchmentListArray       = [[NSMutableArray alloc] init];
        attatchmentListSplitArray    = [[NSMutableArray alloc] init];
         attatchmentnameArray    = [[NSMutableArray alloc] init];
         attatchemntListFileurlArray    = [[NSMutableArray alloc] init];
        //fileurlarray=[[NSArray alloc]init];
        
    }

    

}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    if (parser == xmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
            NSString *anjan = @"*********";
            projectStr = [projectStr stringByAppendingString:anjan];
            projectStr = [projectStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            projectNameDataAry =[projectStr componentsSeparatedByString:@"*********"];
        }
    }
    
    
    
    
    
    else if (parser == xmlParser1)
    {
        
        if ([string isEqualToString:@"False"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
            NSString *anjan = @"*********";
            
            
            categoryliststring = [categoryliststring stringByAppendingString:anjan];
            categoryliststring = [categoryliststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            categorylistdataarray = [categoryliststring componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == xmlParser2)
    {
        
        if ([string isEqualToString:@"Problem"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Not Saved" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
            
            
            //To Split An String
             saveStr =  [saveStr stringByAppendingString:string];
            saveDataAry = [saveStr componentsSeparatedByString:@","];
            
            NSLog(@"data array is %@",saveDataAry);
            
            pkrProjectAmountIDStr = [[saveDataAry objectAtIndex:1]stringByReplacingOccurrencesOfString:@"Project_Amount_Id=" withString:@""];
            
            
           NSLog(@"the split is %@",pkrProjectAmountIDStr);

            
            //Alert View
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Successfully Saved" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [expensesSaveBtn setHidden:YES];
            [expansesUpdateBtn setHidden:NO];
            [attachmentsTextView setHidden:NO];
            [galleryBtn setHidden:NO];
            [cameraBtn setHidden:YES];
            [attatchmentlabel setHidden:NO];
              [self attatchmentList];
            
                        
            

        }
    }

    
    else if (parser == xmlParser3)
    {
        
        if ([string isEqualToString:@"problem"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
            
            //Alert View
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Successfully UPDATED" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"cancel",nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            
        }
    }

    else if (parser == xmlParser4)
    {
        
        if ([string isEqualToString:@"Problem"])
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
        else{
            
            //To Split An String
            getBytesStr =  [getBytesStr stringByAppendingString:string];
            getBytesDataArray = [getBytesStr componentsSeparatedByString:@"###"];
            
            NSString *imageBytesStr = [[getBytesDataArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@"FILE_URL==" withString:@""];
            
            NSString * imageBytesStrlength = [[getBytesDataArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"FILE_BYTES_LENGTH==" withString:@""];


            //NSLog(@"the image byte str  is %@ ",imageBytesStr);
            
            
                        
            NSMutableData *data2 =[[NSMutableData alloc]init];
            data2 = [imageBytesStr base64DecodedData];
            
           // NSLog(@"the image byte data  is %@ ",aData);

            UIImage *img = [UIImage imageWithData:data2];
            [atachmentsImageView setImage:img];
            
            NSData *data = UIImagePNGRepresentation(img);
            byteArray  = [data base64Encoding];

          
        }
    }
    else if (parser==attatchmentXmlParser)
    {
        if ([string isEqualToString:@"Inserted"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The Attatchment Uploaded Successfully" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            [self attatchmentList];
           
        }
        else
        {
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"The Attatchment  is Not Uploaded" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            
//            [alert show];
        }
    }
    else
    {
        
        if ([string isEqualToString:@"False"])
        {
                        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The Attatchment List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
                        [alert show];
        }
        else{
            
            [attatchmentListArray addObject:string];
            
            
        }
    }


}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"projLstForReqGathResponse"])
        {
            
            for (int i=1; i<[projectNameDataAry count]; i++)
            {
                
                projectNameSplitAry = [[projectNameDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",projectNameSplitAry);
                
                for (int j=1; j<[projectNameSplitAry count]; j++)
                {
                    projectIDStr = [[projectNameSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"PROJECT_ID==" withString:@""];
                    
                    projectNmaeStr = [[projectNameSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                    
                }
                
                
                [projectIdArray addObject:projectIDStr];
                [projectNameArray addObject:projectNmaeStr];
                
                
                if ([tblProjectNmae length] == 0)
                {
                    
                    projectTfd.text  = [projectNameArray objectAtIndex:0];
                    pkrProjectIDStr = [projectIdArray objectAtIndex:0];
                     //[self categorySpinnerListService];
                    
                }
                
                
                
                
                NSString *tempString = tblProjectNmae;
                NSLog(@"tbl project name is %@",tblProjectNmae);
                for(int i=0; i<[projectNameArray count]; i++)
                {
                    if([tempString isEqualToString:[projectNameArray objectAtIndex:i]])
                    {
                        
                        pkrProjectIDStr = [projectIdArray objectAtIndex:i];
                        projectTfd.text=[projectNameArray objectAtIndex:i];
                        
                        NSLog(@"the id is generated");
                        
                        
                    }
                }

                
            }
            projectnamearray=[NSMutableArray arrayWithArray:projectNameArray];
            projectidarray=[NSMutableArray arrayWithArray:projectIdArray];
            
            NSLog(@"split  is %@ %@ ",projectIdArray,projectNameArray);
           // [reqListTbl reloadData];
//           //pkrProjectIDStr = [projectIdArray objectAtIndex:0];
//            projectNmaeTfd.text = [projectNameArray objectAtIndex:0];
//            //            [pkrBtn setTitle:pkrProjectIDStr forState:UIControlStateNormal];
//            [self projectExpancesListService];
            
            
        }
        
    }
    
    
    
    
    if (parser == xmlParser1)
    {
        
        if ([elementName isEqualToString:@"categoryResponse"])
        {
            
            for (int i=1; i<[categorylistdataarray count]; i++)
            {
                
                categorylistsplitarray = [[categorylistdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",expanceslistsplitarray);
                
                for (int j=1; j<[categorylistsplitarray count]; j++)
                {
                    categoryCodeIDStr = [[categorylistsplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"Code_ID==" withString:@""];
                    
                    categoryValuesStr  = [[categorylistsplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Values==" withString:@""];
                    
                  
                    
                }
                
                
                [categoryCodeIDArray addObject:categoryCodeIDStr];
                [categoryValuesArray addObject:categoryValuesStr];
                
                
                if ([tblCategoryName length] == 0)
                {
                    
                    categoryTfd.text = [categoryValuesArray objectAtIndex:0];
                    pkrCategoryIDStr = [categoryCodeIDArray objectAtIndex:0];
                    
                }
                
                
                
                
                NSString *tempString = tblCategoryName;
                for(int i=0; i<[categoryValuesArray count]; i++)
                {
                    if([tempString isEqualToString:[categoryValuesArray objectAtIndex:i]])
                    {
                        
                        pkrCategoryIDStr = [categoryCodeIDArray objectAtIndex:i];

                        NSLog(@"the category id is generated");
                        
                    }
                }

                
                NSLog(@"split  is %@,%@",categoryCodeIDArray,categoryValuesArray);
                
            }
            
//            [expancesLstTl reloadData];
//            int total=0;
//            for(NSString *currentString in expancesAmountArray){
//                total +=[currentString intValue];
//            }
//            NSLog(@"Sum:%d",total);
//            totalAmountLbl.text = [NSString stringWithFormat:@"%d",total];
            
        }
        
    }
    
    
    
    
    if (parser == attatchmentListXmlParser)
    {
        
        if ([elementName isEqualToString:@"projectAttachmentListResponse"])
        {
            
            for (int i=0; i<[attatchmentListArray count]; i++)
            {
                
                attatchmentListSplitArray = [[attatchmentListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                
                for (int j=0; j<[attatchmentListSplitArray count]; j++)
                {
                    attatchmentNameStr=[[attatchmentListSplitArray objectAtIndex:2]stringByReplacingOccurrencesOfString:@"ExpenseAttachment==" withString:@""];
                    fileurlStr=[[attatchmentListSplitArray objectAtIndex:3]stringByReplacingOccurrencesOfString:@"attachmentUrl==" withString:@""];
                    
                }
               
                
                [attatchmentnameArray addObject:attatchmentNameStr];
                [attatchemntListFileurlArray addObject:fileurlStr];
                
                 NSLog(@"the split is %@ %@",attatchmentnameArray,attatchemntListFileurlArray);
                
            }
            [projectlisttableview reloadData];
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
            
            
        }
        else {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}
//picker deligate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        NSLog(@"project name array is %@",projectNameArray);
        return [projectnamearray count];
    }
    else if (picker.tag==101)
    {
        return [categoryValuesArray count];
    }
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [projectnamearray objectAtIndex:row];
    }
    else if (picker.tag==101)
    {
        return [categoryValuesArray objectAtIndex:row];
    }

    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        NSLog(@"project name array is %@",projectNameArray);
        projectTfd.text = [projectnamearray objectAtIndex:row];
        pkrProjectIDStr = [projectidarray objectAtIndex:row];
         [self categorySpinnerListService];
        [questionpkr removeFromSuperview];
        
    }
    else if (pickerView.tag==101)
    {
        categoryTfd.text = [categoryValuesArray objectAtIndex:row];
        pkrCategoryIDStr = [categoryCodeIDArray objectAtIndex:row];
        [questionpkr removeFromSuperview];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [attatchmentnameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"projectlistcell";
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
                                      reuseIdentifier:nil];
    }
    
    cell.textLabel.text=[attatchmentnameArray objectAtIndex:indexPath.row];
    
       return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *fileurl=[attatchemntListFileurlArray objectAtIndex:indexPath.row];
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
        
        atachmentsImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,screenSize.width+100,screenSize.height+20)];
        //ImgView.backgroundColor=[UIColor orangeColor];
        atachmentsImageView.userInteractionEnabled=YES;
        
        atachmentsImageView.image = image;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(350, 1000, 55, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed55)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
        [atachmentsImageView addSubview:myButton];
        
        //[self.view addSubview:textView];
        
        [self.view addSubview:atachmentsImageView];
        
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
        displayWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height-10)];
        displayWebview.userInteractionEnabled=YES;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(350, 980, 55, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed25)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
        [displayWebview addSubview:myButton];
        
        
        // Now create Request for the file that was saved in your documents folder
        //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 250, self.view.frame.size.width, 300)];
        
        NSURL *targetURL = [NSURL URLWithString:fileurl];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [displayWebview loadRequest:request];
        
        [self.view addSubview:displayWebview];
    }
    
    else if ([extn isEqualToString:@"txt"])
    {
        NSString *urlString = fileurl;
        NSURL *myURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString *string = [NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"the content is %@",string);
        
        CGRect textViewFrame = CGRectMake(100, 600, 500, 300);
        attatchmentTxtview1 = [[UITextView alloc] initWithFrame:textViewFrame];
        attatchmentTxtview1.layer.borderWidth=5.0f;
        attatchmentTxtview1.layer.borderColor=[[UIColor grayColor]CGColor];
        attatchmentTxtview1.returnKeyType = UIReturnKeyDone;
        attatchmentTxtview1.scrollEnabled=YES;
        attatchmentTxtview1.text=string;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(200, 250, 50.0, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed555)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor grayColor];
        [attatchmentTxtview1 addSubview:myButton];
        
        [self.view addSubview:attatchmentTxtview1];
    }

    
}

//-(IBAction)imageBtnClciked:(id)sender
//{
//    NSLog(@"welcome to eis");
//}

//Touches


-(void)cancelPressed55
{
    [atachmentsImageView removeFromSuperview];
}
-(void)cancelPressed25
{
    [displayWebview removeFromSuperview];
}
-(void)cancelPressed555
{
    [attatchmentTxtview1 removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchObj = [touches anyObject];
    CGPoint pnt = [touchObj locationInView:self.view];
    [questionpkr removeFromSuperview];
    [datePkr removeFromSuperview];
    
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
