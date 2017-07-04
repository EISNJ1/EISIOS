//
//  programByOwnerReportsViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 29/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "programByOwnerReportsViewController.h"

@interface programByOwnerReportsViewController ()

@end

@implementation programByOwnerReportsViewController

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
    //-------------------Right side pop Button---------------------//
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,nil];

    //-------------------service parameters data------------------//
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    OrgIdStr    = [defaults objectForKey:@"OrgId"];
    UserTypestr = [defaults objectForKey:@"UserType"];
    [self programByOwnerReportsService];
    
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
-(void)programByOwnerReportsService
{
    Servicecall = [[Webservices alloc]init];
    NSString *projectLstForTask = @"ExecuteDashBoard";
    NSDictionary *credentials = @{@"OrgId":OrgIdStr};
    [Servicecall prgrmByOwnerReports:projectLstForTask TaskListParameters:credentials];
    [Servicecall setDelegate:self];

}

-(void)didFinishService :(id)Userlogindetails
{
    xmlParser = [[NSXMLParser alloc]initWithData:Userlogindetails];
    xmlParser.delegate = self;
    [xmlParser parse];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"getNoOfPrgmsForOwnerResponse"])
    {
        getNoOfPrgmsForOwnerResponseStr          = [[NSString alloc] init];
        getNoOfPrgmsForOwnerResponseSplitAry   = [[NSArray alloc] init];
        getNoOfPrgmsForOwnerResponseDataAry    = [[NSArray alloc] init];
        
        Org_IdAry        = [[NSMutableArray alloc] init];
        Program_OwnerAry  = [[NSMutableArray alloc] init];
        First_NameAry  = [[NSMutableArray alloc] init];
        BudgetAry  = [[NSMutableArray alloc] init];
        NoofProgramsAry  = [[NSMutableArray alloc] init];
        NoofResourcesAry  = [[NSMutableArray alloc] init];

        
        
    }
 
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    if (parser == xmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"The List is Empty" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            NSString *chandu = @"*********";
            
            
            getNoOfPrgmsForOwnerResponseStr = [getNoOfPrgmsForOwnerResponseStr stringByAppendingString:chandu];
            getNoOfPrgmsForOwnerResponseStr = [getNoOfPrgmsForOwnerResponseStr stringByAppendingString:string];
            //NSLog(@"agenda details are test %@",string);
            getNoOfPrgmsForOwnerResponseDataAry = [getNoOfPrgmsForOwnerResponseStr componentsSeparatedByString:@"*********"];
        }
    }
    
 
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if (parser == xmlParser)
    {
        
        if ([elementName isEqualToString:@"getNoOfPrgmsForOwnerResponse"])
        {
            
            for (int i=1; i<[getNoOfPrgmsForOwnerResponseDataAry count]; i++)
            {
                
                getNoOfPrgmsForOwnerResponseSplitAry = [[getNoOfPrgmsForOwnerResponseDataAry objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                // NSLog(@"split  is %@",orgResourceRepResponseSplitAry);
                
                for (int j=1; j<[getNoOfPrgmsForOwnerResponseSplitAry count]; j++)
                {
                    Org_IdStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:1] stringByReplacingOccurrencesOfString:@"Org_Id==" withString:@""];
                    
                    Program_OwnerStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:2] stringByReplacingOccurrencesOfString:@"Program_Owner==" withString:@""];
                    
                    First_NameStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:3] stringByReplacingOccurrencesOfString:@"First_Name==" withString:@""];

                    BudgetStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:4] stringByReplacingOccurrencesOfString:@"Budget==" withString:@""];

                    NoofProgramsStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:5] stringByReplacingOccurrencesOfString:@"No.ofPrograms==" withString:@""];
                    
                    NoofResourcesStr = [[getNoOfPrgmsForOwnerResponseSplitAry objectAtIndex:6] stringByReplacingOccurrencesOfString:@"No.ofResources==" withString:@""];


                    
                }


                [Org_IdAry addObject:Org_IdStr];
                [Program_OwnerAry addObject:Program_OwnerStr];
                [First_NameAry addObject:First_NameStr];
                [BudgetAry addObject:BudgetStr];
                [NoofProgramsAry addObject:NoofProgramsStr];
                [NoofResourcesAry addObject:NoofResourcesStr];

                
                
            }
            //NSLog(@"split  is %@ %@ %@ %@ %@",reqTypeArray,contactAry,criticialityAry,activityAry,systemAry);
            
            NSLog(@"  is %@ %@ %@ %@ %@ %@",Org_IdAry,Program_OwnerAry,First_NameAry,BudgetAry,NoofProgramsAry,NoofResourcesAry);
            [programOwnerReportsTbl reloadData];
            
            
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return [reqTypeArray count];
    return [Org_IdAry count];
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    [cell.contentView.layer setBorderColor:[UIColor purpleColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    
    
    //cell.textLabel.text = [dashBoardListAry objectAtIndex:indexPath.row];
    UILabel *nameLbl = (UILabel*)[cell viewWithTag:1];
    nameLbl.font=[UIFont systemFontOfSize:25];
    nameLbl.text = [First_NameAry objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"WELCOME";
    
    
    UILabel *nameLbl2 = (UILabel*)[cell viewWithTag:2];
    nameLbl2.font=[UIFont systemFontOfSize:25];
    nameLbl2.text= [NoofProgramsAry objectAtIndex:indexPath.row];
    
    UILabel *nameLbl3 = (UILabel*)[cell viewWithTag:3];
    nameLbl3.font=[UIFont systemFontOfSize:25];
    nameLbl3.text= [BudgetAry objectAtIndex:indexPath.row];
    
    UILabel *nameLbl4 = (UILabel*)[cell viewWithTag:4];
    nameLbl4.font=[UIFont systemFontOfSize:25];
    nameLbl4.text= [NoofResourcesAry objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    //save the data to defaults
//    NSString *str = [dashBoardListAry objectAtIndex:indexPath.row];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:str forKey:@"TableString"];
    
    NSString *str = @"Program By Owner Reports";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:@"TableString"];

    //save the data to defaults
    NSString *str1 = [Program_OwnerAry objectAtIndex:indexPath.row];
    //NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str1 forKey:@"TableString1"];
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
