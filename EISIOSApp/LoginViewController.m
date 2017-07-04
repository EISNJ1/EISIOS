//
//  LoginViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginAppDelegate.h"
#import "UserData.h"
@interface LoginViewController ()
{
    NSXMLParser *xmlParser;
    NSMutableArray *LoginCredentials,*resultArray;
    BOOL checked;
    LoginAppDelegate *appDel;
    NSManagedObjectContext *objectContext;
}
@end

@implementation LoginViewController
@synthesize frame,layer;
- (void)viewDidLoad
{
    
    
    int k = 0;
    for (int i =10,j=100;i;--i,j-=100)
    {
        k++;
        
    }
    NSLog(@" K = %d",k);
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint =[NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    
    
    Servicecall = [[Webservices alloc]init];
    //GridVC      = [[GridViewViewController alloc]init];
    
    [super viewDidLoad];
	view1.layer.borderColor = [UIColor purpleColor].CGColor;
    view1.layer.borderWidth = 3.0f;
    [Usernametxtfield setText:@"Ravivupp"];
    Usernametxtfield.delegate = self;
    Passwordtxtfield.secureTextEntry= YES;
    [Passwordtxtfield setText:@"RVuppala1"];
    Passwordtxtfield.delegate=self;
    
    
    [[checkboxbtn layer] setBorderWidth:2.0f];
    [[checkboxbtn layer] setBorderColor:[UIColor purpleColor].CGColor];
    [[Loginbtn layer] setBorderWidth:2.0f];
    [[Loginbtn layer] setBorderColor:[UIColor purpleColor].CGColor];
    [[Usernametxtfield layer] setBorderWidth:2.0f];
    [[Usernametxtfield layer] setBorderColor:[UIColor purpleColor].CGColor];
    [[Passwordtxtfield layer] setBorderWidth:2.0f];
    [[Passwordtxtfield layer] setBorderColor:[UIColor purpleColor].CGColor];
    
    
    UIImageView *UserIMage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"person"]];
    Usernametxtfield.leftView = UserIMage;
    Usernametxtfield.leftViewMode = UITextFieldViewModeAlways;
    [Usernametxtfield addSubview:UserIMage];
    
    UIImageView *PassCodeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passowrd"]];
    Passwordtxtfield.leftView = PassCodeImage;
    Passwordtxtfield.leftViewMode = UITextFieldViewModeAlways;
    [Passwordtxtfield addSubview:PassCodeImage];
}

-(IBAction)LoginBtnTapped:(id)sender
{
   NSString *stringurl=[NSString stringWithFormat:@"https://2-dot-eiswebservice1.appspot.com/_ah/api/bp/v1/userLogin?userName=%@&password=%@",Usernametxtfield.text,Passwordtxtfield.text];
   NSString *encode=[stringurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Servicecall=[[Webservices alloc]init];
   [Servicecall loginUrl:encode];
   [Servicecall setDelegate:self];
  
    if (checked)
   {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:Usernametxtfield.text  forKey:@"infoString"];
    [defaults setObject:Passwordtxtfield.text  forKey:@"infoString1"];
    [defaults synchronize];
    Usernametxtfield.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"infoString"];
    Passwordtxtfield.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"infoString1"];
}
    else
    {
        Usernametxtfield.text = nil;
        Passwordtxtfield.text = nil;
    }
}

- (IBAction)checkButton:(id)sender {
    if (checked) {
        checked = NO;
        [checkboxbtn setImage:[UIImage imageNamed:@"lightgreen_unchecked_checkbox.png"] forState:UIControlStateNormal];
    } else {
        checked = YES;
        [checkboxbtn setImage:[UIImage imageNamed:@"lightgreen_checked_checkbox.png"] forState:UIControlStateNormal];
    }
}

-(void)didFinishService:(id)Userlogindetails
{
  
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=Userlogindetails;
    
    resultArray=[[NSMutableArray alloc]init];
    LoginCredentials=[[NSMutableArray alloc]init];
    
  resultArray = [dict objectForKey:@"userDeatils"];
    for(NSDictionary *fbId in resultArray)
    {
       [LoginCredentials addObject:[fbId valueForKey:@"userName"]];
        [LoginCredentials addObject:[fbId valueForKey:@"pswrd"]];
        [LoginCredentials addObject:[fbId valueForKey:@"userId"]];
        [LoginCredentials addObject:[fbId valueForKey:@"orgId"]];
        [LoginCredentials addObject:[fbId valueForKey:@"userStatus"]];
    }

    NSLog(@"array is %@",LoginCredentials);
    if ([LoginCredentials count]>0)
    {
        [self SaveDatabase];
        
        NSUserDefaults *defaul =[ NSUserDefaults standardUserDefaults];
        [defaul setObject:[LoginCredentials objectAtIndex:0]forKey:@"UserName"];
        [defaul setObject:[LoginCredentials objectAtIndex:2] forKey:@"UserId"];
        [defaul setObject:[LoginCredentials objectAtIndex:4] forKey:@"UserType"];
        [defaul setObject:[LoginCredentials objectAtIndex:3] forKey:@"OrgId"];
        [defaul synchronize];
        GridVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GridView"];
        GridVC.UserNamestr = [LoginCredentials objectAtIndex:0];
        [self.navigationController pushViewController:GridVC animated:YES];
        

    }
    else
    {
        UIAlertView *alertt=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Invalid username or password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertt show];
    }
    
}

-(void)SaveDatabase
{
    appDel = [[UIApplication sharedApplication] delegate];
    objectContext = appDel.managedObjectContext;
    
    UserData *userdetails = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:objectContext];
    //NSLog(@"user name is %@",userdetails.username);
    userdetails.username = [LoginCredentials objectAtIndex:0];
    userdetails.userid  = [LoginCredentials objectAtIndex:2];
    userdetails.userType = [LoginCredentials objectAtIndex:4];
    userdetails.orgId = [LoginCredentials objectAtIndex:3];
    NSLog(@"user name is %@",userdetails.username);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == Usernametxtfield || textField== Passwordtxtfield) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = view1.frame;
        frame.origin.y =frame.origin.y -180;
        [view1 setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [Usernametxtfield resignFirstResponder];
    if (textField == Usernametxtfield || textField== Passwordtxtfield) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = view1.frame;
        frame.origin.y = frame.origin.y + 180;
        [view1 setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}

@end
