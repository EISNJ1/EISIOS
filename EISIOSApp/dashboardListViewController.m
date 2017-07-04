//
//  dashboardListViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 22/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "dashboardListViewController.h"

@interface dashboardListViewController ()

@end

@implementation dashboardListViewController

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    NSLog(@"user type is %@",Usertypestr);
    
    if ([Usertypestr isEqualToString:@"Y"]||[Usertypestr isEqualToString:@"A"])
    {
         dashBoardListAry = [[NSArray alloc]initWithObjects:@"Organisation Resource Report",@"People by skills Report",@"Number of projects by Resource Report",@"Average Billing Rate by Organisation",@"Number of Resources by Programs", @"Allocated capacity to Program",@"Allocated capacity to Project",@"Assigned capacity to Program",@"Assigned capacity to project",@"Average Cost of Resource by Program",@"No of Resource By Project",@"No Of Resource By Team",nil];
    }
    else
    {
        dashBoardListAry = [[NSArray alloc]initWithObjects:@"Number of Resources by Programs",@"No of Resource By Project",@"No Of Resource By Team",nil];
    }
    
   
    

    
    //----------------view back ground stroke--------------------//
    searchBackView.layer.cornerRadius = searchBackView.frame.size.width / 2;
    searchBackView.clipsToBounds = YES;
    searchBackView.layer.borderWidth = 3.0f;
    searchBackView.layer.borderColor = [UIColor purpleColor].CGColor;
    searchBackView.layer.cornerRadius = 10.0f;
    searchBackView.layer.cornerRadius=4;
    
    //-------------------Right side pop Button---------------------//
    
    homeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_home_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnClk)];
    
    logOutBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expenses_logout_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnClk)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:logOutBtn,homeBtn,nil];
    
    searchTfd.text = @"Resource Reports";
    pickerArray = [[NSArray alloc]initWithObjects:@"Resource Reports",@"Program Charts",@"Program By Owner Reports", @"Task OverView",@"Over View",nil];
    
    
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
-(IBAction)searchBtnClk:(id)sender
{
   
}

-(IBAction)searchSelectionBtnClk:(id)sender
{
    [questionpkr removeFromSuperview];
    questionpkr = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 220, self.view.frame.size.width-40, 300)];//728
    [questionpkr setShowsSelectionIndicator:YES];
    questionpkr.delegate = self;
    questionpkr.dataSource = self;
    questionpkr.tag = 100;
    questionpkr.backgroundColor=[UIColor grayColor];
    [self.view addSubview:questionpkr];
}
//picker deligate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [pickerArray count];
    }
    
    return YES;
}

-(NSString *) pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (picker.tag==100) {
        return [pickerArray objectAtIndex:row];
    }
       return NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    searchTfd.text=[pickerArray objectAtIndex:0];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag==100)
    {
        searchTfd.text=[pickerArray objectAtIndex:row];
        [questionpkr removeFromSuperview];
        
        if ([searchTfd.text isEqualToString:@"Program By Owner Reports"])
        {
            [questionpkr removeFromSuperview];

            programByOwnerReportsViewController *progrmasReportView = [[programByOwnerReportsViewController alloc]init];
            progrmasReportView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgramsReportsView"];
            [self.navigationController pushViewController:progrmasReportView animated:YES];
        }
        
        if ([searchTfd.text isEqualToString:@"Program Charts"])
        {
            [questionpkr removeFromSuperview];
            
            lineChart = [[LineChartViewController alloc]init];
            lineChart = [self.storyboard instantiateViewControllerWithIdentifier:@"lineChart"];
            [self.navigationController pushViewController:lineChart animated:YES];
        }
        if ([searchTfd.text isEqualToString:@"Task OverView"])
        {
            [questionpkr removeFromSuperview];
            
            taskOVerView  = [[TaskOverViewViewController alloc]init];
            taskOVerView = [self.storyboard instantiateViewControllerWithIdentifier:@"taskOVerView"];
            [self.navigationController pushViewController:taskOVerView animated:YES];
        }
        if ([searchTfd.text isEqualToString:@"Over View"])
        {
            overView=[[OverViewViewController alloc]init];
            overView=[self.storyboard instantiateViewControllerWithIdentifier:@"overView"];
            [self.navigationController pushViewController:overView animated:YES];
        }
    }
        
}
//touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchObj = [touches anyObject];
    CGPoint pnt = [touchObj locationInView:self.view];
    
    [questionpkr removeFromSuperview];
    
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
    return [dashBoardListAry count];
    
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
    
    
    cell.textLabel.text = [dashBoardListAry objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    //save the data to defaults
    NSString *str = [dashBoardListAry objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:@"TableString"];
    
    
       
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
