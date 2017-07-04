//
//  projectExpencesViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 15/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "projectExpencesViewController.h"

@interface projectExpencesViewController ()

@end

@implementation projectExpencesViewController

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
    //----------------view back ground stroke--------------------//
    totalLbl.layer.cornerRadius = totalLbl.frame.size.width / 2;
    totalLbl.clipsToBounds = YES;
    totalLbl.layer.borderWidth = 3.0f;
    totalLbl.layer.borderColor = [UIColor blueColor].CGColor;
    totalLbl.layer.cornerRadius = 10.0f;
    totalLbl.layer.cornerRadius=4;
    
    //----------------view back ground stroke--------------------//
    projectNmaeTfd.layer.cornerRadius = projectNmaeTfd.frame.size.width / 2;
    projectNmaeTfd.clipsToBounds = YES;
    projectNmaeTfd.layer.borderWidth = 3.0f;
    projectNmaeTfd.layer.borderColor = [UIColor blueColor].CGColor;
    projectNmaeTfd.layer.cornerRadius = 10.0f;
    projectNmaeTfd.layer.cornerRadius=4;
    
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

    [self projectSpinnerService];
    //[self projectExpancesListService];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [expancesLstTl reloadData];
    [self viewDidLoad];
}

-(IBAction)pkrBtnClk:(id)sender;
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 170, self.view.frame.size.width-40, 300)];
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
}

-(void)projectSpinnerService
{
    
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"RequirementGatheringService";
    NSDictionary *credentials = @{@"usertype":UserTypestr,@"userId":Useridstr,@"orgId":OrgIdStr};
    [Servicecall projectExpencesListSpinner:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)projectExpancesListService
{
    NSLog(@"the proejct id str is %@",pkrProjectIDStr);
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ProjectExpense";
    NSDictionary *credentials = @{@"projId":pkrProjectIDStr,@"userId":Useridstr,@"orgId":OrgIdStr,@"userType":UserTypestr};
    [Servicecall projectExpencesList:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];
}

-(void)didFinishService :(id)Userlogindetails
{
    
    fileurlXmlParser=[[NSXMLParser alloc]initWithData:Userlogindetails];
    fileurlXmlParser.delegate=self;
    [fileurlXmlParser parse];
    
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    


}
-(void)didfinishactionitemlist :(id)actionitemlist
{
    xmlParser1 = [[NSXMLParser alloc]initWithData:actionitemlist];
    xmlParser1.delegate = self;
    [xmlParser1 parse];

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
        
        }
    
    
    else if([elementName isEqualToString:@"expensesResponse"])
    {
        expancesliststring       = [[NSString alloc] init];
        expanceslistdataarray    = [[NSArray alloc] init];
        expanceslistsplitarray   = [[NSArray alloc] init];
        
        expancesIDArray         = [[NSMutableArray alloc] init];
        expancesDateArray       = [[NSMutableArray alloc] init];
        expancesAmountArray       = [[NSMutableArray alloc] init];
        expancesCategoryIDArray       = [[NSMutableArray alloc] init];
        expancesAttatchIDArray       = [[NSMutableArray alloc] init];
        expancesValueArray       = [[NSMutableArray alloc] init];
        expancesCategoryArray       = [[NSMutableArray alloc] init];
        expensesProjectnameArray=[[NSMutableArray alloc]init];
        expensesPrjname=[[NSString alloc]init];
        expensesProjectIdArray=[[NSMutableArray alloc]init];
    }
    else if([elementName isEqualToString:@"getAttachmentUrlResponse"])
    {
        fileurlArray       = [[NSMutableArray alloc]init];
        fileurlbyteArray    = [[NSMutableArray alloc]init];
        fileUrlArray=[[NSArray alloc]init];
        fileurl=[[NSMutableString alloc]init];
        filelength=[[NSMutableString alloc]init];
        fileurlstr=[[NSString alloc]init];
        fileurlSplitAary=[[NSArray alloc]init];
        FileurlStr=[[NSString alloc]init];
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
            
            
            expancesliststring = [expancesliststring stringByAppendingString:anjan];
            expancesliststring = [expancesliststring stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            expanceslistdataarray = [expancesliststring componentsSeparatedByString:@"*********"];
        }
    }
    else if (parser == fileurlXmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        if ([string isEqualToString:@"File Not Exists"])
        {
            
        }

        else{
            NSString *anjan = @"*********";
            fileurlstr = [fileurlstr stringByAppendingString:anjan];
            fileurlstr = [fileurlstr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            fileUrlArray = [fileurlstr componentsSeparatedByString:@"*********"];
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
                
                projectNameSplitAry = [[projectNameDataAry objectAtIndex:i]componentsSeparatedByString:@"###"];
                
               // NSLog(@"split  is %@",projectNameSplitAry);
                
                for (int j=1; j<[projectNameSplitAry count]; j++)
                {
                    pkrProjectIDStr = [[projectNameSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"PROJECT_ID==" withString:@""];
                    
                    projectNmaeStr = [[projectNameSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"PROJECT_NAME==" withString:@""];
                    
                    
                }
                
                
                [projectIdArray addObject:pkrProjectIDStr];
                [projectNameArray addObject:projectNmaeStr];
                
                
            }
            if ([projectNmaeTfd.text length]==0)
            {
                projectNmaeTfd.text=[projectNameArray objectAtIndex:0];
                pkrProjectIDStr=[projectIdArray objectAtIndex:0];
                [self projectExpancesListService];
                [expancesLstTl reloadData];
            }
           else
           {
            for (int i=0; i<[projectNameArray count]; i++)
            {
                projectNmaeTfd.text=[projectNameArray objectAtIndex:i];
                pkrProjectIDStr=[projectIdArray objectAtIndex:i];
                [self projectExpancesListService];
                [expancesLstTl reloadData];
            }
           }
           
            NSLog(@"split  is %@ %@ ",projectIdArray,projectNameArray);
            //[reqListTbl reloadData];
           // pkrProjectIDStr = [projectIdArray objectAtIndex:1];
            //projectNmaeTfd.text = [projectNameArray objectAtIndex:1];
//            [pkrBtn setTitle:pkrProjectIDStr forState:UIControlStateNormal];
           // [self projectExpancesListService];
            //[expancesLstTl reloadData];

            
        }
        
    }
    
    
    
    
    if (parser == xmlParser1)
    {
        
        if ([elementName isEqualToString:@"expensesResponse"])
        {
            
            for (int i=1; i<[expanceslistdataarray count]; i++)
            {
                
                expanceslistsplitarray = [[expanceslistdataarray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                //NSLog(@"split  is %@",expanceslistsplitarray);
                
                for (int j=1; j<[expanceslistsplitarray count]; j++)
                {
                    expancesIDStr = [[expanceslistsplitarray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"Project_Amount_ID==" withString:@""];
                    
                    expancesDateStr  = [[expanceslistsplitarray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Date==" withString:@""];
                    
                    expancesAmountStr = [[expanceslistsplitarray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"Amount==" withString:@""];
                    
                    expancesCategoryIDStr  = [[expanceslistsplitarray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"Budget_Category==" withString:@""];
                    
//                    expancesAttatchIDStr = [[expanceslistsplitarray objectAtIndex:5] stringByReplacingOccurrencesOfString:@"Exp_Attach_Id==" withString:@""];
                    
                    expensesProjectIdStr  = [[expanceslistsplitarray objectAtIndex:6] stringByReplacingOccurrencesOfString:@"projectId==" withString:@""];
                    
                    expancesCategoryStr  = [[expanceslistsplitarray objectAtIndex:5] stringByReplacingOccurrencesOfString:@"Budget_Category_Value==" withString:@""];
                    expensesPrjname=[[expanceslistsplitarray objectAtIndex:7]stringByReplacingOccurrencesOfString:@"projectName==" withString:@""];
                    

                    //[self downloadFIleurl];
                }
                

                [expancesIDArray addObject:expancesIDStr];
                [expancesDateArray addObject:expancesDateStr];
                
                [expancesAmountArray addObject:expancesAmountStr];
                [expancesCategoryIDArray addObject:expancesCategoryIDStr];
                
               // [expancesAttatchIDArray addObject:expancesAttatchIDStr];
                [expensesProjectIdArray addObject:expensesProjectIdStr];
                
                [expancesCategoryArray addObject:expancesCategoryStr];
                [expensesProjectnameArray addObject:expensesPrjname];
                
                NSLog(@"split  is %@,%@,%@,%@,%@,%@,%@",expancesIDArray,expancesDateArray,expancesAmountArray,expancesCategoryIDArray,expancesAttatchIDArray,expancesValueArray,expancesCategoryArray,expensesProjectIdArray);
                
            }
            
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
            
            
            [expancesLstTl reloadData];
            int total=0;
            for(NSString *currentString in expancesAmountArray)
            {
                total +=[currentString intValue];
            }
            NSLog(@"Sum:%d",total);
           // totalAmountLbl.text = [NSString stringWithFormat:@"%d",total];
            NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: total]];
            totalAmountLbl.text = numberAsString;

            
        }
        
    }
    else if (parser==fileurlXmlParser)
    {
        if ([elementName isEqualToString:@"getAttachmentUrlResponse"])
        {
            for (int i=1; i<[fileUrlArray count]; i++)
            {
                
                fileurlSplitAary = [[fileUrlArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",projectNameSplitAry);
                
                for (int j=1; j<[fileurlSplitAary count]; j++)
                {
                    FileurlStr = [[fileurlSplitAary objectAtIndex:1] stringByReplacingOccurrencesOfString:@"FILE_URL==" withString:@""];
                    
                    FileurlLengthStr = [[fileurlSplitAary objectAtIndex:2] stringByReplacingOccurrencesOfString:@"FILE_BYTES_LENGTH==" withString:@""];
                    
                    
                }
                [fileurlArray addObject:FileurlStr];
                [fileurlbyteArray addObject:FileurlLengthStr];
                
            
            
           
            NSLog(@"the file byte array is %@",fileurlbyteArray);
            
        }
             NSLog(@"the file url array is %@",fileurlArray);
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
     return [expancesCategoryArray count];
    //return [tableAry count];
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    [cell.contentView.layer setBorderColor:[UIColor blueColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    
    // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
    nameLbl.font=[UIFont systemFontOfSize:25];
    nameLbl.text = [expancesCategoryArray objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"WELCOME";
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    
    NSString *tblDateStr = [expancesDateArray objectAtIndex:indexPath.row];
    tblDateStr = [tblDateStr substringToIndex:10];
    nameLbl2.text = tblDateStr;
  //  nameLbl2.text= [expancesDateArray objectAtIndex:indexPath.row];
    
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:19];
    //nameLbl3.text= [expancesAmountArray objectAtIndex:indexPath.row];
    
    int i = [[expancesAmountArray objectAtIndex:indexPath.row] intValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    nameLbl3.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:i]];
    
    return cell;
    [expancesLstTl reloadData];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"file url array is %@",fileurlArray);
    NSLog(@"project id array is %@",expensesProjectIdArray);
    
    createProjectExpansesViewController *createProjectExpencesView = [[createProjectExpansesViewController alloc]init];
    createProjectExpencesView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateProjectExpences"];
    createProjectExpencesView.tblProjectNmae = [expensesProjectnameArray objectAtIndex:indexPath.row];
    NSLog(@"project name is %@",createProjectExpencesView.tblProjectNmae);
    createProjectExpencesView.tblCategoryName = [expancesCategoryArray objectAtIndex:indexPath.row];
    createProjectExpencesView.projectIdStr=[expensesProjectIdArray objectAtIndex:indexPath.row];
    createProjectExpencesView.projectIdCategryIdStr=[expancesCategoryIDArray objectAtIndex:indexPath.row];
    
    createProjectExpencesView.tblProjectAmountID = [expancesIDArray objectAtIndex:indexPath.row];
   // createProjectExpencesView.tblExpAttachID = [expancesAttatchIDArray objectAtIndex:indexPath.row];
    
    createProjectExpencesView.tblDateStr = [expancesDateArray objectAtIndex:indexPath.row];
    createProjectExpencesView.tblAmountStr = [expancesAmountArray objectAtIndex:indexPath.row];

    //createProjectExpencesView.tblImageNameStr = [expancesValueArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:createProjectExpencesView animated:YES];
    
}

//picker deligate Methodsnew

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [projectNameArray count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100)
    {
        return [projectNameArray objectAtIndex:row];
    }
    
    return NO;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        projectNmaeTfd.text = [projectNameArray objectAtIndex:row];
        [questionpkr removeFromSuperview];
        pkrProjectIDStr = [projectIdArray objectAtIndex:row];
        [self projectExpancesListService];
        [expancesLstTl reloadData];
        
    }
    
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
    createProjectExpansesViewController *createProjectExpencesView = [[createProjectExpansesViewController alloc]init];
    createProjectExpencesView = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateProjectExpences"];
    [self.navigationController pushViewController:createProjectExpencesView animated:YES];
    
}
-(void)downloadFIleurl
{
//    Servicecall=[[Webservices alloc]init];
//    
//    NSString *FilerUrlString=@"DownloadFileUrl";
//    
//    NSDictionary *FileurlParametrs=@{@"exp_attach_Id":expancesAttatchIDStr,@"proj_amnt_Id":expancesIDStr};
//    
//    [Servicecall DownloadFile:FilerUrlString DownloadFileParameters:FileurlParametrs];
//    [Servicecall setDelegate:self];

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
