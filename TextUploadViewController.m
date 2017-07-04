 //
//  TextUploadViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 12/22/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "TextUploadViewController.h"
#import "Base64.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "NSString+HTML.h"
#import "NSAttributedString+Attributes.h"
@interface TextUploadViewController ()
{
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    IBOutlet UIBubbleTableView *TextTableV;
    IBOutlet UIView *textInputView;
    IBOutlet UITextField *EnterTextFld;
    NSMutableArray *TextData,*TasklistArray,*array,*notnullarray;
    NSArray *TaskSplitArray;
    NSString*fileName ;
    NSString*fileType ;
    NSString *fileBytes ;
    NSString *byteLenth ;
    NSXMLParser *TaskListXmlParser,*UploadParserParser;
    NSBubbleData *MyBubble;
    NSMutableString *resultstring;
    NSMutableDictionary *resultdict;
    NSString *string;
}
@end

@implementation TextUploadViewController



- (void)viewDidLoad
{
    
    
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
    
    
    

    
    
    
    fileName = @"fileName";
    fileType = @"text";
    fileBytes = @"fileBytes";
    byteLenth = @"byteLenth";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
 
    EnterTextFld.delegate = self;
   // TextData = [[NSMutableArray alloc] init];
    Servicecall = [[Webservices alloc]init];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f]];
    
    
    UIButton* Homepagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homepagebtn setImage:[UIImage imageNamed:@"expenses_home_icon.png"] forState:UIControlStateNormal];
    [Homepagebtn addTarget:self action:@selector(HomePagebtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Homepagebtn sizeToFit];
    UIBarButtonItem *Homepagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Homepagebtn];
    
    
    
    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Logoutbtn setImage:[UIImage imageNamed:@"expenses_logout_icon.png"] forState:UIControlStateNormal];
    [Logoutbtn addTarget:self action:@selector(LogoutbtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [Logoutbtn sizeToFit];
    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:Logoutpagebatbtn,Homepagebatbtn,nil];
    
    
    
    
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
    
    
    NSString *TaskFileurl  = @"TasksFilesList";
    NSDictionary *credentials = @{@"taskId":_taskIdstr,@"fileType":fileType};
    [Servicecall TaskFileListurl:TaskFileurl TaskFileListParameters:credentials];
    [Servicecall setDelegate:self];

    
    
//    NSBubbleData *heyBubble = [NSBubbleData dataWithText:@"Hey, halloween is soon" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:BubbleTypeSomeoneElse];
//    //heyBubble.avatar = [UIImage imageNamed:@"avatar1.png"];
//    
//    NSBubbleData *photoBubble = [NSBubbleData dataWithImage:[UIImage imageNamed:@"halloween.jpg"] date:[NSDate dateWithTimeIntervalSinceNow:-290] type:BubbleTypeSomeoneElse];
//   // photoBubble.avatar = [UIImage imageNamed:@"avatar1.png"];
//    
    
    //
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    //TextTableV.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
  //  TextTableV.typingBubble = NSBubbleTypingTypeSomebody;
    
    //[TextTableV reloadData];
    
    // Keyboard events
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didFinishData:(id)Data
{
    UploadParserParser = [[NSXMLParser alloc]initWithData:Data];
    UploadParserParser.delegate = self;
    [UploadParserParser parse];
    
}
-(void)serviceCal:(id)ServerData
{
    TaskListXmlParser = [[NSXMLParser alloc]initWithData:ServerData];
    TaskListXmlParser.delegate = self;
    [TaskListXmlParser parse];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==TaskListXmlParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            TextData                   =[NSMutableArray new];
            TasklistArray              =[NSMutableArray new];
            TaskSplitArray             =[NSArray new];
            array                      =[NSArray new];
            resultstring               =[[NSMutableString alloc]init];
            resultdict                 =[[NSMutableDictionary alloc]init];
            notnullarray=[[NSMutableArray alloc]init];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == TaskListXmlParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            //[TasklistArray addObject:string];
            [resultstring appendString:string];
            
            NSLog(@"tasklist is %@",resultstring);
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == TaskListXmlParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            if(resultstring)
                [resultdict setObject:resultstring forKey:elementName];
            resultstring = nil;
            if(resultdict)
                //[songsArray addObject:resultdict];
            string = [resultdict objectForKey:@"tasksFileTypesResponse"];
            //NSLog(@"Final Songs Array is %@",str1);
            
           TasklistArray = [string componentsSeparatedByString:@".;"];
            
            
            for (int i = 0; i<[TasklistArray count];i++)
            {
                TaskSplitArray=[[TasklistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
               NSString *a = [[TaskSplitArray objectAtIndex:2] stringByReplacingOccurrencesOfString: @"NEW_TEXT_UPLOAD==" withString:@""];
                 NSLog(@"text data %@",a);
                
                a = [a stringByConvertingHTMLToPlainText];
                
                NSLog(@"text str iss %@",a);
               
                
                NSString *notnullstring=[a stringByReplacingOccurrencesOfString:@"null" withString:@""];
                NSLog(@"string is %@",notnullstring);
              
               
                    
                   if ([notnullstring isEqualToString:@""])
                    {
                       
                        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Text is Empty" message:@"No Text Data is Available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                        
                        [alertview show];
                        
                        MyBubble.avatar = [UIImage imageNamed:nil];

                    }
                    else
                    {
                        array = [notnullstring componentsSeparatedByString:@","];
                        [array removeObject:@"null"];
                        [array removeObject:@""];
                        NSLog(@"array is %@",array);
                        for (int j = 0; j<[array count]; j++)
                        {
                           // NSString *text=[array objectAtIndex:j];
                            
                            MyBubble = [NSBubbleData dataWithText:[array objectAtIndex:j] date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeSomeoneElse];
                            MyBubble.avatar = [UIImage imageNamed:@"homeicon.png"];
                            TextTableV.showAvatars = YES;
                            TextTableV.snapInterval = 12;
                            
                            TextTableV.bubbleDataSource = self;
                            [TextData addObject:MyBubble];
                           
                    }
                    
                    
                   
                }
                    
        }
             [TextTableV reloadData];
               
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    NSLog(@"hai %d",[TextData count]);
    return [TextData count];
    
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [TextData objectAtIndex:row];
}

#pragma mark - Keyboard events

//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    [UIView animateWithDuration:0.2f animations:^{
//        
//        CGRect frame = ContentView.frame;
//        frame.origin.y -= kbSize.height;
//        ContentView.frame = frame;
//        
//        frame = TextTableV.frame;
//        frame.size.height -= kbSize.height;
//        TextTableV.frame = frame;
//    }];
//}
//
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = ContentView.frame;
        frame.origin.y += kbSize.height;
        ContentView.frame = frame;
        
        frame = TextTableV.frame;
        frame.size.height += kbSize.height;
        TextTableV.frame = frame;
    }];
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



- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == EnterTextFld )
    {
        
        NSLog(@"textViewDidBeginEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = ContentView.frame;
        frame.origin.y =frame.origin.y -310;
        [ContentView setFrame:frame];
        [UIView commitAnimations];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    
    if (textField == EnterTextFld )
    {
        [EnterTextFld resignFirstResponder];
        NSLog(@"textViewDidEndEditing:");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        CGRect frame = ContentView.frame;
        frame.origin.y = frame.origin.y + 310;
        [ContentView setFrame:frame];
        [UIView commitAnimations];
    }
    
    
}

#pragma mark - Actions

- (IBAction)sayPressed:(id)sender
{
    if ([EnterTextFld.text length]==0)
    {
        UIAlertView *entertext = [[UIAlertView alloc]initWithTitle:@"Please enter the text" message:@"" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
        [entertext show];
    }
    else{
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSMutableString *datestr = [formatter stringFromDate:date];
//        NSString *format=@"<br><font color='#ea6e38'><b>";
//      NSString *hello1=   [format stringByAppendingString:datestr];
//      NSString *hello=  [hello1 stringByAppendingString:@"</font></b>"];
        //NSLog(@"date str is %@",hello);
        
        
       
    NSBubbleData *MyBubble = [NSBubbleData dataWithText:EnterTextFld.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeSomeoneElse];
    MyBubble.avatar = [UIImage imageNamed:@"homeicon.png"];
    
    TextTableV.showAvatars = YES;
    TextTableV.snapInterval = 12;
    [TextData addObject:MyBubble];
    TextTableV.bubbleDataSource = self;
    

    TextTableV.typingBubble = NSBubbleTypingTypeMe;
        
        
        NSLog(@"enter text field text is %@",EnterTextFld.text);
        
        NSLog(@"file name is %@",fileName);
    NSString *UploadTaskUrl = @"UploadFilesForTasks";
        
        NSDictionary *credentials1 = @{@"taskId":_taskIdstr,@"fileType":fileType,@"date":datestr
                                       ,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":EnterTextFld.text};
    [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials1];
    [Servicecall setDelegate:self];
   
    [TextTableV reloadData];
    
    EnterTextFld.text = @"";
    [EnterTextFld resignFirstResponder];
    }
}
-(IBAction)Cancle:(id)sender
{
    EnterTextFld.text = @"";
    //TaskListViewController *tasklist=[[TaskListViewController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
