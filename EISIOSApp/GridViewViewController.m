//
//  GridViewViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "GridViewViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"

@interface GridViewViewController ()
{
    NSArray * a,*animationImages;
    
   
}
@end

@implementation GridViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"user name str is %@",_UserNamestr);
   
    a = [[NSArray alloc ]initWithObjects:@"Meeting",@"Time",@"Issues",@"Task",@"Requirement",@"Dash Board",@"Project Expenses", nil];
    animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"meeting.png"],
                         [UIImage imageNamed:@"clock"],
                         [UIImage imageNamed:@"issues.png"],
                         [UIImage imageNamed:@"stocktask.png"],
                         [UIImage imageNamed:@"requirements.png"],
                         [UIImage imageNamed:@"dashboard.png"],
                         [UIImage imageNamed:@"expenses.png"]
                         ,nil];
    
    UIButton *Eisbutton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [Eisbutton setImage:[UIImage imageNamed:@"homeicon.png"] forState:UIControlStateNormal];
    
    [Eisbutton setFrame:CGRectMake(0, 0, 53, 101)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 250, 80)];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    NSMutableString *UserName  = [[NSMutableString alloc]initWithString:@"WelCome Mr/Ms "];
    [UserName appendString:_UserNamestr];
    [label setText:UserName];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [Eisbutton addSubview:label];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:Eisbutton];
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.40 green:0.52 blue:0.55 alpha:1.0]];
    self.navigationItem.leftBarButtonItem = barButton;
 
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItem = Logoutpagebatbtn;
    
    colorsArray= [[NSArray alloc]initWithObjects: [UIColor colorWithRed:0.52 green:0.77 blue:0.77 alpha:1.0],
   [UIColor colorWithRed:0.40 green:0.52 blue:0.55 alpha:1.0],
    [UIColor colorWithRed:0.67 green:0.55 blue:0.55 alpha:1.0],
    [UIColor colorWithRed:0.25 green:0.19 blue:0.42 alpha:1.0],
    [UIColor colorWithRed:0.19 green:0.42 blue:0.42 alpha:1.0],
    [UIColor colorWithRed:0.44 green:0.16 blue:0.40 alpha:1.0],
    [UIColor colorWithRed:0.44 green:0.43 blue:0.16 alpha:1.0],
    [UIColor colorWithRed:0.16 green:0.44 blue:0.21 alpha:1.0],nil];
    
                               
    }

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.40 green:0.52 blue:0.55 alpha:1.0]];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return a.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    cell.textLabel.backgroundColor=[colorsArray objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor=[colorsArray objectAtIndex:indexPath.row];
//    if (indexPath.row == 0)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(75/255.0) green:(60/255.0) blue:(57/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 1)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(219/255.0) blue:(169/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 2)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(217/255.0) green:(151/255.0) blue:(185/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 3)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 4)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(0/255.0) green:(140/255.0) blue:(121/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 5)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(121/255.0) green:(71/255.0) blue:(137/255.0) alpha:1.0f];
//    }
//    if (indexPath.row == 6)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor=[UIColor colorWithRed:(0/255.0) green:(106/255.0) blue:(169/255.0) alpha:1.0f];
//    }
//    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [a objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:@"lobstor.otf" size:22];
    
    cell.imageView.image = [animationImages objectAtIndex:indexPath.row];
    [cell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.contentView.layer setBorderWidth:3.0f];
    
   
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        
        MeetingLV = [self.storyboard instantiateViewControllerWithIdentifier:@"MeetingList"];
        [self.navigationController pushViewController:MeetingLV animated:YES];
    }
    if (indexPath.row == 1)
    {
        
        TimeSheetViewController *timeSheetView = [[TimeSheetViewController alloc]init];
        timeSheetView = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeSheetList"];
        [self.navigationController pushViewController:timeSheetView animated:YES];
    }
    
    if (indexPath.row == 2)
    {
        
        issueViewController *issueView = [[issueViewController alloc]init];
        issueView = [self.storyboard instantiateViewControllerWithIdentifier:@"issueList"];
        [self.navigationController pushViewController:issueView animated:YES];
        
    }
    if (indexPath.row == 3)
    {
        
        TaskListV = [[TaskListViewController alloc]init];
        TaskListV = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskListView"];
        [self.navigationController pushViewController:TaskListV animated:YES];
        
    }
    
    if (indexPath.row == 4)
    {
        
        requirementViewController *reqView = [[requirementViewController alloc]init];
        reqView = [self.storyboard instantiateViewControllerWithIdentifier:@"reqList"];
        [self.navigationController pushViewController:reqView animated:YES];
        
    }
    if (indexPath.row == 5)
    {
        
        dashboardListViewController *dashboardListView = [[dashboardListViewController alloc]init];
        dashboardListView = [self.storyboard instantiateViewControllerWithIdentifier:@"DashBoard"];
        [self.navigationController pushViewController:dashboardListView animated:YES];
        
    }

    if (indexPath.row == 6)
    {
        
        projectExpencesViewController *projectExpencesView = [[projectExpencesViewController alloc]init];
        projectExpencesView = [self.storyboard instantiateViewControllerWithIdentifier:@"projectExpences"];
        [self.navigationController pushViewController:projectExpencesView animated:YES];
        
    }

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
