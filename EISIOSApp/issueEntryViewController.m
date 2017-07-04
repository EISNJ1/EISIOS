//
//  issueEntryViewController.m
//  EISIOSApp
//
//  Created by EISSYSMAC1 on 11/02/15.
//  Copyright (c) 2015 EISPvtLtd. All rights reserved.
//

#import "issueEntryViewController.h"

@interface issueEntryViewController ()

@end

@implementation issueEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)issueEntryOkBtnClk :(id)sender
{
    //save the data to defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:issueEntryTfd.text forKey:@"issueEntry"];
    [defaults synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
