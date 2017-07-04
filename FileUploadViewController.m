//
//  FileUploadViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 12/22/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "FileUploadViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Base64.h"


@interface FileUploadViewController ()<UIDocumentInteractionControllerDelegate>
{
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    NSXMLParser *FileDataParser,*FileListParser,*UploadParser;
    //ListofFiles
    NSMutableArray *FileListArray,*FileNamesArray,*TaskUpdateIdArray,*FILE_URL_Array;
    NSArray *FileSplitArray;
    NSString *Filenamestr,*FileUrlStr;
    //FileData
    NSMutableArray *FileDataArray,*FileBytesArray;
    NSArray *FileDataSplitArray;
    NSMutableString *BytesString;
    
    
    NSString*fileType,*fileBytes,*byteLenth,*TaskHistorystr,*datestr,*imagedatestr,*imagedatastr;
    NSMutableString *fileName;
}
@end

@implementation FileUploadViewController


- (void)viewDidLoad
{
    fileType = @"file";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    
   
    
    Servicecall =[[Webservices alloc]init];
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
    
    
    homebtn.layer.borderWidth = 2.0f;
    homebtn.layer.cornerRadius = 10;
    [homebtn addTarget:self action:@selector(TaskListPage) forControlEvents:UIControlEventTouchUpInside];
    [self ListOfFiles];
    [super viewDidLoad];
    
}

-(void)ListOfFiles
{
    NSString *TaskFileurl  = @"TasksFilesList";
    NSDictionary *credentials = @{@"taskId":_Taskidstr,@"fileType":fileType};
    [Servicecall TaskFileListurl:TaskFileurl TaskFileListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

-(IBAction)UploadBtnTapped:(id)sender
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
    [Musicbtn setImage:[UIImage imageNamed:@"gallery"] forState:UIControlStateNormal];
    [Musicbtn addTarget:self action:@selector(ChooseFromGallery:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:Musicbtn];
    
    UIButton *SoundRecordbtn = [[UIButton alloc]initWithFrame:CGRectMake(445, 95 , 107, 85)];
    [SoundRecordbtn setImage:[UIImage imageNamed:@"Camera-icon.png"] forState:UIControlStateNormal];
    [SoundRecordbtn addTarget:self action:@selector(atachmentsGalaryBtnClk:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:SoundRecordbtn];
    
}

-(IBAction)atachmentsGalaryBtnClk:(id)sender
{
    [selectionView removeFromSuperview];
    camImagePickerController = [[UIImagePickerController alloc] init];
    camImagePickerController.delegate=self;
    camImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camImagePickerController  animated:YES completion:nil];
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
   [formatter setDateFormat:@"yyyyMMddHHmmss"];
    datestr = [formatter stringFromDate:date];
    
    
    
    //Or you can get the image url from AssetsLibrary
    //NSString *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
        
        
    };
    
    fileName = [[NSMutableString alloc]initWithString:_Taskidstr];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    imagedatestr = [formatter1 stringFromDate:date];
    [fileName appendString:@"_"];
    [fileName appendString:imagedatestr];
    [fileName appendString:@"image.jpg"];
    
    TaskHistorystr = @"value";
    
    NSString *UploadTaskUrl = @"UploadFilesForTasks";
    NSDictionary *credentials = @{@"taskId":_Taskidstr,@"fileType":fileType,@"date":datestr,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":TaskHistorystr};
    [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
    [Servicecall setDelegate:self];

}
-(void)UpoloadImage
{
    
    
    

}


-(void)serviceCal:(id)ServerData
{
    FileListParser = [[NSXMLParser alloc]initWithData:ServerData];
    FileListParser.delegate = self;
    [FileListParser parse];
}

-(void)didEndTask:(id)Taskend
{
    FileDataParser = [[NSXMLParser alloc]initWithData:Taskend];
    FileDataParser.delegate = self;
    [FileDataParser parse];
    
}
-(void)didFinishData:(id)Data

{
    UploadParser = [[NSXMLParser alloc]initWithData:Data];
    UploadParser.delegate = self;
    [UploadParser parse];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==FileListParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            FileListArray                  =[NSMutableArray new];
            FileNamesArray                 =[NSMutableArray new];
            TaskUpdateIdArray              =[NSMutableArray new];
            
            
            FileSplitArray                  =[NSArray new];
            FILE_URL_Array=[NSMutableArray new];
            FileUrlStr=[NSString new];
        }
    }
    if (parser==FileDataParser)
    {
        if([elementName isEqualToString:@"tasksBytesResponse"])
        {
            FileDataArray                =[NSMutableArray new];
            FileBytesArray               =[NSMutableArray new];
            BytesString= [[NSMutableString alloc]init];
            FileDataSplitArray           =[NSArray new];
            
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == FileListParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [FileListArray addObject:string];
            
            
        }
    }
    if (parser == UploadParser)
    {
        
        if ([string isEqualToString:@"Inserted"])
        {
            [self ListOfFiles];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"List UpDated" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
        }
    }
    
    if (parser == FileDataParser)
    {
        [BytesString appendString:string];
        //NSLog(@"down load data %@",string);
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == FileListParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            for (int i = 0; i<[FileListArray count]; i++)
            {
                FileSplitArray=[[FileListArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                [FileNamesArray addObject:[[FileSplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString: @"FILE_NAME==" withString:@""]];
                
                [TaskUpdateIdArray addObject:[[FileSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
                
                FileUrlStr=[[FileSplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"FILE_URL==" withString:@""];
                
                [FILE_URL_Array addObject:FileUrlStr];
                
            }
            [FileTV reloadData];
        }
    }
    
    if (parser == FileDataParser)
    {
        
//        if([elementName isEqualToString:@"tasksBytesResponse"])
//        {
//            [FileDataArray addObject:BytesString];
//            // NSLog(@"spli %@",AudioDataArray);
//            for (int i = 0; i<[FileDataArray count]; i++)
//            {
//                FileDataSplitArray=[[FileDataArray objectAtIndex:i] componentsSeparatedByString:@"###"];
//                
//                
//                
//                imagedatastr = [[FileDataSplitArray objectAtIndex:6] stringByReplacingOccurrencesOfString: @"FILE_BYTES==" withString:@""];
//                
//                //NSLog(@"data is %@ %d",FILE_BYTESArrray,[VideoFileDownloadArray count]);
//                
//                //[TASK_UPDATE_IDArray addObject:[[DownloadSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
//                
//                
//                
//            }
//            NSMutableData *data2 = [[NSMutableData alloc]init];
//            data2 = [imagedatastr base64DecodedData];
//            
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            
//            NSString *documentsDirectory = [paths objectAtIndex:0];
//            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"MyNewFolder"];
//            
//            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
//            
//            
//            
//            
//            NSString *appFile = [dataPath stringByAppendingPathComponent:Filenamestr];
//            
//            
//            NSLog(@"nyt %@", appFile);
//            
//            [data2 writeToFile:appFile atomically:YES];
//            
//            
//            UIImage *image = [[UIImage alloc]initWithData:data2];
//            
//            
//            
//            
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//            
//            UIImageView *ImgView =[[UIImageView alloc] initWithFrame:CGRectMake(300,300,100,100)];
//            
//            ImgView.image = image;
//            [self.view addSubview:ImgView];
//            
//        }
//    }
    
}
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FileNamesArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.textLabel.text  = [FileNamesArray objectAtIndex:indexPath.row];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
    [tableView.layer setBorderWidth:2.0f];
    tableView.layer.cornerRadius = 12;
    tableView.clipsToBounds = YES;
    [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(240/255.0) green:(82/255.0) blue:(41/255.0) alpha:1.0f].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.clipsToBounds = YES;
    return cell;
    
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"wlcome to file uploading");
   fileurl=[FILE_URL_Array objectAtIndex:indexPath.row];
    NSArray *parts = [fileurl componentsSeparatedByString:@"/"];
    NSString *filename = [parts lastObject];
    
    NSString *extn =[filename pathExtension];
    
    NSLog(@"file extn is %@",extn);
    
    url = [NSURL URLWithString:fileurl];
    
    //NSLog(@"not existing url is %@",url);
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if ([extn isEqualToString:@"jpg"] || [extn isEqualToString:@"png"])
    {
        
        
        NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,fileurl];
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
        
        ImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height-10)];
        ImgView.userInteractionEnabled=YES;
        
        ImgView.image = image;
        UIButton *myButton  =   [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame      =   CGRectMake(350, 980, 55, 30.0);
        [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [myButton addTarget:self action:@selector(cancelPressed1)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
        [ImgView addSubview:myButton];
        
        //[self.view addSubview:textView];

        [self.view addSubview:ImgView];
        
    }
   if([extn isEqualToString:@"pdf"]||[extn isEqualToString:@"pptx"]||[extn isEqualToString:@"docx"] ||[extn isEqualToString:@"xlsx"])
    {
        
        NSData *pdfData = [[NSData alloc]initWithContentsOfURL:url];
        
        // Store the Data locally as PDF File
        NSString *resourceDocPath = [[NSString alloc] initWithString:[
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
        
        [myButton addTarget:self action:@selector(cancelPressed2)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor redColor];
        [webView addSubview:myButton];
        
        
        // Now create Request for the file that was saved in your documents folder
        //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 250, self.view.frame.size.width, 300)];
        
        NSURL *targetURL = [NSURL URLWithString:fileurl];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
    }
    if ([extn isEqualToString:@"ppt"])
    {
        NSURL *url=[NSURL URLWithString:[fileurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData* responseData = [NSData dataWithContentsOfURL:url];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize screenSize = rect.size;
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,screenSize.height)];
        
//        NSString* filePath = [[NSBundle mainBundle]pathForResource:file:@"ppt"];
//        NSString* fullPath = [filePath stringByExpandingTildeInPath];
//        NSURL* fileUrl = [NSURL fileURLWithPath:fullPath];
//        //NSURLRequest* fileUrlRequest = [[NSURLRequest alloc] initWithURL:fileUrl];
//        NSURLRequest* fileUrlRequest = [[NSURLRequest alloc] initWithURL:fileUrl cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:.1];
//        
//        NSError* error = nil;
//        NSURLResponse* response = nil;
//        NSData* fileData = [NSURLConnection sendSynchronousRequest:fileUrlRequest returningResponse:&response error:&error];
//        
//        fileData; // Ignore this if you're using the timeoutInterval
//        // request, since the data will be truncated.
//        
//        NSString* mimeType = [response MIMEType];
//        
        //[fileUrlRequest release];
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
        
        [myButton addTarget:self action:@selector(cancelPressed)forControlEvents:UIControlEventTouchUpInside];
        myButton.backgroundColor=[UIColor grayColor];
        [textView addSubview:myButton];
        
        [self.view addSubview:textView];
    }
    
    
    
    
}
-(void)cancelPressed
{
    [textView setHidden:YES];
    //[ImgView setHidden:YES];
}
-(void)cancelPressed1
{
    ImgView.image=nil;
    [ImgView removeFromSuperview];
    NSLog(@"image view cleared");
}
-(void)cancelPressed2
{
    [webView removeFromSuperview];
}

-(void)TaskListPage
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        else
            
        {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
}

@end
