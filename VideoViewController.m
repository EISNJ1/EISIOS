#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Base64.h"
@interface VideoViewController ()
{
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    NSXMLParser *VideosListParser,*downloadataParser,*UploadParser;
    NSString *fileType,*fileBytes,*byteLenth,*TaskHistorystr,*datestr;
    NSMutableString *fileName,*BytesString;
    
    //VideoFilesList
    NSMutableArray *VideoslistArray,*VideosNamesArray,*FILE_NAMEArray,*TASK_UPDATE_IDArray,*FILE_URL_Array;
    NSArray *SplitArray;
    NSString *videodatestr,*Filenamestr,*fileUrlStr;
    NSData *Videodata;
    
    ALAssetsLibrary *library;
    //DownloadData
    
    NSMutableArray *FILE_BYTESArrray,*VideoFileDownloadArray;
    NSArray *DownloadSplitArray;
    
}
@end

@implementation VideoViewController



- (void)viewDidLoad
{
    fileName   = [[NSMutableString alloc]init];
    
    fileType = @"video";
    
    
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
    
    [self ListofVideos];
    
    
    [super viewDidLoad];
    
}
-(void)ListofVideos
{
    NSString *TaskFileurl  = @"TasksFilesList";
    NSDictionary *credentials = @{@"taskId":_TaskIdstr,@"fileType":fileType};
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
    [Musicbtn setImage:[UIImage imageNamed:@"music.png"] forState:UIControlStateNormal];
    [Musicbtn addTarget:self action:@selector(ChooseFromGallery:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:Musicbtn];
    
    UIButton *SoundRecordbtn = [[UIButton alloc]initWithFrame:CGRectMake(445, 95 , 107, 85)];
    [SoundRecordbtn setImage:[UIImage imageNamed:@"soundrecord.png"] forState:UIControlStateNormal];
    [SoundRecordbtn addTarget:self action:@selector(RecordAndPlay:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:SoundRecordbtn];
    
}
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)Music:(id)sender
{
    
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController: picker animated: YES];
    
    
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    
    // Dismiss the media item picker.
    
    
    
    // MPMediaItem *item = [[mediaItemCollection items] objectAtIndex:0];
    
    // NSData *data = [item valueForProperty:MPMediaItemPropertyAssetURL];
    // NSLog(@"data is %@",item);
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}
-(void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)ChooseFromGallery:(id)sender {
    
    [selectionView removeFromSuperview];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)RecordAndPlay:(id)sender {
    
    [selectionView removeFromSuperview];
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary
                                 *) info
{
    //    if ([mediaType isEqualToString:@"public.movie"]){
    //        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        NSString *mediaType = info[UIImagePickerControllerMediaType];
        
        
        if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            NSURL *videoURL = [info valueForKey:UIImagePickerControllerMediaURL];
            Videodata = [NSData dataWithContentsOfURL:videoURL];
            NSString *urlString=[videoURL path];
            NSString *videoName = urlString.lastPathComponent;
            
            
            fileBytes = [Videodata base64Encoding];
            fileType = @"video";
            int len = [Videodata length];
            byteLenth = [NSString stringWithFormat:@"%d",len];
            NSDate *date =[NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            datestr = [formatter stringFromDate:date];
            fileName = [[NSMutableString alloc]initWithString:_TaskIdstr];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyyMMdd_HHmmss"];
            videodatestr = [formatter1 stringFromDate:date];
            [fileName appendString:@"_"];
            [fileName appendString:videodatestr];
            [fileName appendString:videoName];
            NSLog(@"chandu %@",fileName);
            
            TaskHistorystr = @"value";
            
            NSString *UploadTaskUrl =@"UploadFilesForTasks";
            NSDictionary *credentials =@{@"taskId":_TaskIdstr,@"fileType":fileType,@"date":datestr,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":TaskHistorystr};
            [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
            [Servicecall setDelegate:self];
            
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        
        [self ListofVideos];
    }
    
    
    //    if ([UIImagePickerController isSourceTypeAvailable:
    //         UIImagePickerControllerSourceTypePhotoLibrary])
    //    {
    //
    //    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //     NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    //    NSLog(@"data is %@",imageData);
    //    fileBytes = [imageData base64Encoding];
    //    fileType = @"video";
    //    int len = [imageData length];
    //    byteLenth = [NSString stringWithFormat:@"%d",len];
    //    NSDate *date =[NSDate date];
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    //    datestr = [formatter stringFromDate:date];
    //
    //    fileName = [[NSMutableString alloc]initWithString:_TaskIdstr];
    //    [fileName appendString:@"image"];
    //    [fileName appendString:datestr];
    //
    //    //Or you can get the image url from AssetsLibrary
    //    //NSString *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    //
    //    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    //
    //    // define the block to call when we get the asset based on the url (below)
    //    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    //    {
    //
    //        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
    //        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
    //
    //    };
    //
    //
    //    // get the asset library and fetch the asset based on the ref url (pass in block above)
    //    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    //    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    //
    //    TaskHistorystr = @"value";
    //
    //    NSString *UploadTaskUrl = @"UploadFilesForTasks";
    //    NSDictionary *credentials = @{@"taskId":_TaskIdstr,@"fileType":fileType,@"date":datestr,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":TaskHistorystr};
    //    [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
    //    [Servicecall setDelegate:self];
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    //    //self.ChooseFromGallery.hidden =YES;
    //    //NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
    //    // NSLog(@"urlvideo is :::%@",urlvideo);
    //
    //    //NSError *error = nil;
    //    //NSDictionary * properties = [[NSFileManager defaultManager] attributesOfItemAtPath:urlvideo.path error:&error];
    //    // NSNumber * size = [properties objectForKey: NSFileSize];
    //    ///NSLog(@"size: %@", size);
    //
    //    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:urlvideo];
    //    //CMTime duration = playerItem.duration;
    //    //float seconds = CMTimeGetSeconds(duration);
    //    //NSLog(@"duration: %.2f", seconds);
    //
    //    /*urlvideo contains the URL of that video file that has to be uploaded. Then convert the url into NSString type because setFile method requires NSString as a parameter
    //     */
    //    //    NSString *urlString=[urlvideo path];
    //    //
    //    //    NSString *username = @"xxxxxx";
    //    //    NSString *password = @"xxxxxx";
    //    //
    //    //    NSString *videoName = urlString.lastPathComponent;
    //    //
    //    //    NSString *urlpath = [NSString stringWithFormat:@"http://enteryoururl"];
    //    //    urlpath = [urlpath stringByAppendingString:@"username="];
    //    //    urlpath = [urlpath stringByAppendingString:username];
    //    //    urlpath = [urlpath stringByAppendingString:@"&password="];
    //    //    urlpath = [urlpath stringByAppendingString:password];
    //    //
    //    //
    //    //    NSURL *url = [NSURL URLWithString:[urlpath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    //
    //    //    request = [ASIFormDataRequest requestWithURL:url];
    //    //
    //    //    [request setPostValue:videoName forKey:@"Filename"];
    //    //    [request setFile:urlString forKey:@"videoFile"];
    //    //    [request setRequestMethod:@"POST"];
    //    //    [request setDelegate:self];
    //    //    [request setDidStartSelector:@selector(requestStarted:)];
    //    //    [request setDidFinishSelector:@selector(requestFinished:)];
    //    //    [request setDidFailSelector:@selector(requestFailed:)];
    //    //    [request setUploadProgressDelegate:self];
    //    //    [request setTimeOutSeconds:50000];
    //    //    [request startAsynchronous];
    //    //    NSLog(@"responseStatusCode %i",[request responseStatusCode]);
    //    //    NSLog(@"responseStatusCode %@",[request responseString]);
    //    //    progressIndicator.hidden=NO;
    //}
}

-(void)Downloading:(float)Downloading
{
    UIProgressView *progressView = [[UIProgressView alloc] init];
    
    progressView.frame = CGRectMake(100,100,100,20);
    
    [progressView setProgressTintColor:[UIColor redColor]];
    
    [progressView setUserInteractionEnabled:NO];
    
    progressView.progress=Downloading;
    
    [progressView setProgressViewStyle:UIProgressViewStyleBar];
    
    [progressView setTrackTintColor:[UIColor blueColor]];
    
    
    // [progressView setTrackImage:[UIImage    imageNamed:@"logo.png"]];
    
    [self.view addSubview:progressView];
}
-(void)serviceCal:(id)ServerData
{
    VideosListParser = [[NSXMLParser alloc]initWithData:ServerData];
    VideosListParser.delegate = self;
    [VideosListParser parse];
}

-(void)didEndTask:(id)Taskend
{
    downloadataParser = [[NSXMLParser alloc]initWithData:Taskend];
    downloadataParser.delegate = self;
    [downloadataParser parse];
    
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
    if (parser==VideosListParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            VideosNamesArray                =[NSMutableArray new];
            VideoslistArray                 =[NSMutableArray new];
            FILE_NAMEArray                  =[NSMutableArray new];
            TASK_UPDATE_IDArray             =[NSMutableArray new];
            FILE_URL_Array=[NSMutableArray new];
            
            //VideoslistArray                 =[NSArray new];
            SplitArray                      =[NSArray new];
        }
    }
    
    if (parser==downloadataParser)
    {
        if([elementName isEqualToString:@"tasksBytesResponse"])
        {
            VideoFileDownloadArray          =[NSMutableArray new];
            FILE_BYTESArrray                 =[NSMutableArray new];
            //FILE_NAMEArray                  =[NSMutableArray new];
            //TASK_UPDATE_IDArray             =[NSMutableArray new];
            BytesString= [[NSMutableString alloc]init];
            //VideoslistArray                 =[NSArray new];
            DownloadSplitArray                      =[NSArray new];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == VideosListParser)
    {
        
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [VideoslistArray addObject:string];
            
            
        }
    }
    if (parser == UploadParser)
    {
        
        if ([string isEqualToString:@"Inserted"])
        {
            [self ListofVideos];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"List UpDated" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
        }
    }
    
    
    if (parser == downloadataParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            // [VideoFileDownloadArray addObject:string];
            [BytesString appendString:string];
            
            
        }
        
    }
    
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (parser == VideosListParser)
    {
        
        
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            for (int i = 0; i<[VideoslistArray count]; i++)
            {
                SplitArray=[[VideoslistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                [FILE_NAMEArray addObject:[[SplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString: @"FILE_NAME==" withString:@""]];
                
                [TASK_UPDATE_IDArray addObject:[[SplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
                
                fileUrlStr=[[SplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"FILE_URL==" withString:@""];
                
                [FILE_URL_Array addObject:fileUrlStr];
                
            }
            [VideosTV reloadData];
        }
    }
    
    if (parser == downloadataParser)
    {
        
        if([elementName isEqualToString:@"tasksBytesResponse"])
        {
            [VideoFileDownloadArray addObject:BytesString];
            
            for (int i = 0; i<[VideoFileDownloadArray count]; i++)
            {
                DownloadSplitArray=[[VideoFileDownloadArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                
                [TASK_UPDATE_IDArray addObject:[[SplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
               
                
                
            }
            
            NSMutableData *data2 = [[FILE_BYTESArrray objectAtIndex:0]base64DecodedData];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSLog(@"hai %@",documentsDirectory);
            
            NSString *mp3strng = @".mp4";
            
            NSString *appFile = [documentsDirectory stringByAppendingPathComponent:Filenamestr];
            
            
            appFile =  [appFile stringByAppendingString:mp3strng];
            NSLog(@"nyt %@", appFile);
            
            [data2 writeToFile:appFile atomically:YES];
            
            
            
            
            NSURL *audioURL = [NSURL fileURLWithPath:appFile];
            
            NSString *sourcePath =[audioURL path];
            UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
            
            
            MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioURL];
            [self presentModalViewController:moviePlayer animated:NO];
            
        }
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FILE_NAMEArray count];
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
    cell.textLabel.text  = [FILE_NAMEArray objectAtIndex:indexPath.row];
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *TaskFileurl  = @"DownloadFileUrl";
    NSDictionary *credentials = @{@"taskUpdatedId":[TASK_UPDATE_IDArray objectAtIndex:indexPath.row],@"fileType":fileType};
    [Servicecall Downloads:TaskFileurl Downloadparameters:credentials];
    [Servicecall setDelegate:self];
    
    Filenamestr = [FILE_NAMEArray objectAtIndex:indexPath.row];
    
    NSString *fileURL =[FILE_URL_Array objectAtIndex:indexPath.row];
    NSArray *parts = [fileURL componentsSeparatedByString:@"/"];
    NSString *filename = [parts lastObject];
    
    NSLog(@"file name is %@",filename);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    //NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    //NSString* foofile = [documentsDirectory stringByAppendingPathComponent:filename];
    //NSLog(@"foofile %@",foofile);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSLog(@"boolean value is %hhd",fileExists);
    
    
    if (fileExists)
    {
        
        NSURL *videoURL = [NSURL fileURLWithPath:filePath];
        NSLog(@"existig url is%@",videoURL);
        
        NSString *sourcePath =[videoURL path];
        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
        
        
        MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:videoURL];
        [self presentModalViewController:moviePlayer animated:NO];
    }
    else
    {
        NSURL  *url = [NSURL URLWithString:fileURL];
        
        NSLog(@"not existing url is %@",url);
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
            [urlData writeToFile:filePath atomically:YES];
            
            NSLog(@"the file path is %@",filePath);
            
            NSURL *audioURL = [NSURL fileURLWithPath:filePath];
            
            NSString *sourcePath =[audioURL path];
            UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
            
            
            MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioURL];
            [self presentModalViewController:moviePlayer animated:NO];
            
        }
    }

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
        else {
            
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
}



@end