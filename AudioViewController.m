//
//  AudioViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 12/16/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//



//
//  AudioViewController.m
//  EISIOSApp
//
//  Created by iAppSoft on 12/16/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "AudioViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Base64.h"
#import <AudioToolbox/AudioToolbox.h>
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
@interface AudioViewController ()
{
    NSString *Usernamestr,*Useridstr,*orgIdstr,*Usertypestr;
    AVAudioRecorder *audioRecorder;
    NSString   *recorderFilePath;
    NSDictionary *editedObject;
    NSString *fileType,*fileBytes,*byteLenth,*TaskHistorystr,*datestr,*audiodatestr;
    NSData *data;
    NSMutableString *fileName;
    NSXMLParser *AudioListParser,*AudioDataParser,*UploadParserParser;
    //FilesList
    NSMutableArray *AudiolistArray,*AudioNamesArray,*FILE_NAMEArray,*TASK_UPDATE_IDArray,*FILE_URL_Array;
    NSArray *SplitArray;
    //Audiodata
    NSMutableArray *AudioDataArray,*AudioBytesArray,*soundsArray;
    NSArray *AudioSplitArray;
    NSString *BytsStr,*AudioNamestr,*AudioBytesstr,*fileUrlStr;
    NSMutableString *BytesString;
    NSURL *soundFileURL;
}
@property BOOL stoped;
@property(nonatomic,retain)AVAudioPlayer *audioPlayer;
@property(nonatomic,strong)UIDocumentInteractionController *controller;
@end

@implementation AudioViewController
@synthesize audioPlayer;


- (void)viewDidLoad
{
    soundsArray = [[NSMutableArray alloc]init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Usernamestr = [defaults objectForKey:@"UserName"];
    Useridstr   = [defaults objectForKey:@"UserId"];
    orgIdstr    = [defaults objectForKey:@"OrgId"];
    Usertypestr = [defaults objectForKey:@"UserType"];
    
    fileType = @"audio";
    //data = [[NSData alloc]init];
    [super viewDidLoad];
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
    
    recordTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(400, AudioTV.frame.size.height+300, 80, 50)];
    recordTimeLabel.hidden=YES;
    recordTimeLabel.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:recordTimeLabel];
    
    recordimagebtn=[[UIButton alloc]initWithFrame:CGRectMake(300, AudioTV.frame.size.height+300, 80, 50)];
    recordimagebtn.hidden=YES;
    [recordimagebtn setImage:[UIImage imageNamed:@"soundrecord"] forState:UIControlStateNormal];
    [self.view addSubview:recordimagebtn];
    
    [self ListOfAudios];
    
    
    NSLog(@"task id str is %@",_TaskIdstr);
    
    
}
-(void)ListOfAudios
{
    NSString *TaskFileurl  = @"TasksFilesList";
    NSDictionary *credentials = @{@"taskId":_TaskIdstr,@"fileType":fileType};
    [Servicecall TaskFileListurl:TaskFileurl TaskFileListParameters:credentials];
    [Servicecall setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    [Musicbtn addTarget:self action:@selector(Music:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:Musicbtn];
    
    SoundRecordbtn = [[UIButton alloc]initWithFrame:CGRectMake(445, 95 , 107, 85)];
    [SoundRecordbtn setImage:[UIImage imageNamed:@"soundrecord.png"] forState:UIControlStateNormal];
    [SoundRecordbtn addTarget:self action:@selector(RecordAudio:) forControlEvents:UIControlEventTouchUpInside];
    [selectionView addSubview:SoundRecordbtn];
    
}
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)Music:(id)sender
{
    [selectionView removeFromSuperview];
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController: picker animated: YES];
    
    
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    
    
    
    // Dismiss the media item picker.
    
    
    
    
    
    MPMediaItem * item  = [[mediaItemCollection items] objectAtIndex:0];
    //    NSURL * url = [item valueForProperty:MPMediaItemPropertyAssetURL];
    //     NSLog(@"ha title  is %@",url);
    //
    ////     MPMediaItem *item = [[mediaItemCollection items] objectAtIndex:index];
    ////     NSURL *url  = [item valueForProperty:MPMediaItemPropertyAssetURL];
    
    fileName = [[NSMutableString alloc]initWithString:_TaskIdstr];
    [fileName appendString: [item valueForProperty: MPMediaItemPropertyTitle]];
    //
    //
    //    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
    //
    //    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
    //                                                                      presetName:AVAssetExportPresetAppleM4A];
    //
    //    exporter.outputFileType =   @"com.apple.m4a-audio";
    //
    
    //
    //    [[NSDate date] timeIntervalSince1970];
    //    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    //    //NSString *intervalSeconds = [NSString stringWithFormat:@"%0.0f",seconds];
    //
    //    //NSString* fileName1 = [NSString stringWithFormat:@"%@.m4a",intervalSeconds];
    //
    //    NSString *exportFile = [myDocumentsDirectory stringByAppendingPathComponent:fileName];
    //
    //    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
    //    data =[NSData dataWithContentsOfURL:exportURL];
    //    NSLog(@"mydocumetn   %@",data);
    //    exporter.outputURL = exportURL;
    //
    //    // do the export
    //    // (completion handler block omitted)
    //    [exporter exportAsynchronouslyWithCompletionHandler:
    //     ^{
    //         int exportStatus = exporter.status;
    //
    //         switch (exportStatus)
    //         {
    //             case AVAssetExportSessionStatusFailed:
    //             {
    //                 NSError *exportError = exporter.error;
    //                 NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
    //                 break;
    //             }
    //             case AVAssetExportSessionStatusCompleted:
    //             {
    //                 NSLog (@"AVAssetExportSessionStatusCompleted");
    //
    //
    //                 NSURL *audioUrl = exportURL;
    //                 NSLog(@"Audio Url=%@",audioUrl);
    //                 data = [NSData dataWithContentsOfURL:audioUrl];
    //                 data = [NSData dataWithContentsOfFile:[myDocumentsDirectory
    //                                                                 stringByAppendingPathComponent:fileName]];
    //
    //                 NSLog(@"Data %@",data);
    //                 //data = nil;
    //
    //                 break;
    //             }
    //             case AVAssetExportSessionStatusUnknown:
    //             {
    //                 NSLog (@"AVAssetExportSessionStatusUnknown"); break;
    //             }
    //             case AVAssetExportSessionStatusExporting:
    //             {
    //                 NSLog (@"AVAssetExportSessionStatusExporting"); break;
    //             }
    //             case AVAssetExportSessionStatusCancelled:
    //             {
    //                 NSLog (@"AVAssetExportSessionStatusCancelled"); break;
    //             }
    //             case AVAssetExportSessionStatusWaiting:
    //             {
    //                 NSLog (@"AVAssetExportSessionStatusWaiting"); break;
    //             }
    //             default:
    //             {
    //                 NSLog (@"didn't get export status"); break;
    //             }
    //         }
    //
    //
    //         }];
    
    //    NSURL *url = [item valueForProperty: MPMediaItemPropertyAssetURL];
    //
    //    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
    //
    //    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
    //                                                                      presetName: AVAssetExportPresetPassthrough];
    //    NSLog (@"Core Audio %@ directly open library URL %@",
    //		   coreAudioCanOpenURL (url) ? @"can" : @"cannot",
    //
    //    url);
    //	NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
    //	NSLog (@"compatible presets for songAsset: %@",
    //		   [AVAssetExportSession exportPresetsCompatibleWithAsset:songAsset]);
    //    exporter.outputFileType = @"com.apple.m4a-audio";
    //
    //    NSString *exportFile = [myDocumentsDirectory() stringByAppendingPathComponent:
    //                            @"exported.mp4"];
    //    myDeleteFile(exportFile);
    NSURL *exportURL ;//= [NSURL fileURLWithPath:exportFile];
    //    exporter.outputURL = exportURL;
    //     NSLog (@"didn't get export status %@",url);
    //    // do the export
    //    // (completion handler block omitted)
    //    [exporter exportAsynchronouslyWithCompletionHandler :^{
    //		int exportStatus = exporter.status;
    //		switch (exportStatus) {
    //			case AVAssetExportSessionStatusFailed: {
    //				// log error to text view
    //				NSError *exportError = exporter.error;
    //				NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
    //        }
    //			case AVAssetExportSessionStatusCompleted: {
    //                data = [NSData dataWithContentsOfFile:[myDocumentsDirectory() stringByAppendingPathComponent:
    //                                                       @"exported.mp4"]];
    //         NSLog (@"didn't  %@",data);
    //            }
    //        }
    
    if (!item) {
        return;
    }
    NSURL *assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:assetURL options:nil];
    
    NSLog (@"Core Audio %@ directly open library URL %@",
           coreAudioCanOpenURL (assetURL) ? @"can" : @"cannot",
           assetURL);
    
    NSLog (@"compatible presets for songAsset: %@",
           [AVAssetExportSession exportPresetsCompatibleWithAsset:songAsset]);
    
    
    /* approach 1: export just the song itself
     */
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
                                      initWithAsset: songAsset
                                      presetName: AVAssetExportPresetAppleM4A];
    NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
    exporter.outputFileType = @"com.apple.m4a-audio";
    NSString *exportFile = [myDocumentsDirectory() stringByAppendingPathComponent: @"exported.m4a"];
    // end of approach 1
    
    /* approach 1.5: export just the song itself in a quicktime container
     AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
     initWithAsset: songAsset
     presetName: AVAssetExportPresetMediumQuality];
     NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
     
     // exporter.outputFileType = @"public.mpeg-4"; // nope - uncaught exception 'NSInvalidArgumentException', reason: 'Invalid output file type'
     exporter.outputFileType = @"com.apple.quicktime-movie";
     NSString *exportFile = [myDocumentsDirectory() stringByAppendingPathComponent: @"exported.mov"];
     // end of approach 1.5
     */
    
    
    /* approach 2: create a movie with the song as a track, export that
     AVMutableComposition *composition = [AVMutableComposition composition];
     AVMutableCompositionTrack *compositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio
     preferredTrackID:kCMPersistentTrackID_Invalid];
     AVAssetTrack *songTrack = [songAsset compatibleTrackForCompositionTrack:compositionTrack];
     NSError *insertError = nil;
     [compositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, songAsset.duration)
     ofTrack:songTrack
     atTime:kCMTimeZero
     error:&insertError];
     if (insertError) {
     NSLog (@"Error inserting into compositionTrack: %@", insertError);
     return;
     }
     NSLog (@"Created composition");
     AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
     initWithAsset: composition
     presetName: AVAssetExportPresetMediumQuality];
     NSLog (@"output types: %@", [exporter supportedFileTypes]);
     exporter.outputFileType = @"com.apple.quicktime-movie";
     NSString *exportFile = [myDocumentsDirectory() stringByAppendingPathComponent: @"exported.mov"];
     // end of approach 2
     */
    
    // set up export (hang on to exportURL so convert to PCM can find it)
    myDeleteFile(exportFile);
    
    exportURL = [NSURL fileURLWithPath:exportFile];
    exporter.outputURL = exportURL;
    
    // do the export
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exporter.status;
        switch (exportStatus) {
            case AVAssetExportSessionStatusFailed: {
                // log error to text view
                NSError *exportError = exporter.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                
                
            }
            case AVAssetExportSessionStatusCompleted: {
                data =[NSData dataWithContentsOfFile:[myDocumentsDirectory() stringByAppendingPathComponent: @"exported.m4a"]];
                [self UploadAudio];
                //NSLog (@"hai %@",data);
                NSLog (@"AVAssetExportSessionStatusCompleted");
                
                // set up AVPlayer
                // [self setUpAVPlayerForURL: exporter.outputURL];
                //[self enablePCMConversionIfCoreAudioCanOpenURL: exporter.outputURL];
                
            }
        }
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}
-(void)UploadAudio
{
    
    fileBytes = [data base64Encoding];
    
    int len = [data length];
    byteLenth = [NSString stringWithFormat:@"%d",len];
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datestr = [formatter stringFromDate:date];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyyMMdd_HHmmss"];
    audiodatestr = [formatter1 stringFromDate:date];
    [fileName appendString:@"_"];
    [fileName appendString:audiodatestr];
    [fileName appendString:@".mp3"];
    
    TaskHistorystr = @"value";
    
    NSString *UploadTaskUrl = @"UploadFilesForTasks";
    NSDictionary *credentials = @{@"taskId":_TaskIdstr,@"fileType":fileType,@"date":datestr,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":TaskHistorystr};
    [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
    [Servicecall setDelegate:self];
    
//    NSString *UploadTaskUrl = @"UploadFilesForTasks";
//    NSDictionary *credentials = @{@"namey":@"sheik"};
//    [Servicecall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
//    [Servicecall setDelegate:self];

    
    
}


NSString* myDocumentsDirectory() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];;
}

BOOL coreAudioCanOpenURL (NSURL* url) {
    OSStatus openErr = noErr;
    AudioFileID audioFile = NULL;
    openErr = AudioFileOpenURL((__bridge CFURLRef) url,
                               kAudioFileReadPermission ,
                               0,
                               &audioFile);
    if (audioFile) {
        AudioFileClose (audioFile);
    }
    return openErr ? NO : YES;
}

void myDeleteFile (NSString* path) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        
    {
        NSError *deleteErr = nil;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&deleteErr];
        if (deleteErr) {
            NSLog (@"Can't delete %@: %@", path, deleteErr);
        }
    }
}


-(void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)ChooseFromGallery:(id)sender
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kuu, nil];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)RecordAndPlay:(id)sender
{
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

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary
                                 *) info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    //Or you can get the image url from AssetsLibrary
    NSString *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //self.ChooseFromGallery.hidden =YES;
    //NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
    // NSLog(@"urlvideo is :::%@",urlvideo);
    
    //NSError *error = nil;
    //NSDictionary * properties = [[NSFileManager defaultManager] attributesOfItemAtPath:urlvideo.path error:&error];
    // NSNumber * size = [properties objectForKey: NSFileSize];
    ///NSLog(@"size: %@", size);
    
    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:urlvideo];
    //CMTime duration = playerItem.duration;
    //float seconds = CMTimeGetSeconds(duration);
    //NSLog(@"duration: %.2f", seconds);
    
    /*urlvideo contains the URL of that video file that has to be uploaded. Then convert the url into NSString type because setFile method requires NSString as a parameter
     */
    //    NSString *urlString=[urlvideo path];
    //
    //    NSString *username = @"xxxxxx";
    //    NSString *password = @"xxxxxx";
    //
    //    NSString *videoName = urlString.lastPathComponent;
    //
    //    NSString *urlpath = [NSString stringWithFormat:@"http://enteryoururl"];
    //    urlpath = [urlpath stringByAppendingString:@"username="];
    //    urlpath = [urlpath stringByAppendingString:username];
    //    urlpath = [urlpath stringByAppendingString:@"&password="];
    //    urlpath = [urlpath stringByAppendingString:password];
    //
    //
    //    NSURL *url = [NSURL URLWithString:[urlpath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //
    //    request = [ASIFormDataRequest requestWithURL:url];
    //
    //    [request setPostValue:videoName forKey:@"Filename"];
    //    [request setFile:urlString forKey:@"videoFile"];
    //    [request setRequestMethod:@"POST"];
    //    [request setDelegate:self];
    //    [request setDidStartSelector:@selector(requestStarted:)];
    //    [request setDidFinishSelector:@selector(requestFinished:)];
    //    [request setDidFailSelector:@selector(requestFailed:)];
    //    [request setUploadProgressDelegate:self];
    //    [request setTimeOutSeconds:50000];
    //    [request startAsynchronous];
    //    NSLog(@"responseStatusCode %i",[request responseStatusCode]);
    //    NSLog(@"responseStatusCode %@",[request responseString]);
    //    progressIndicator.hidden=NO;
}

-(void)RecordAudio:(id)sender
{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [spinner setCenter:CGPointMake(250,200)]; // I do this because I'm in landscape mode
//    [AudioTV addSubview:spinner];
//    [spinner startAnimating];
    
    //[self.view addSubview:myTimer];
    
    [selectionView removeFromSuperview];
   stopButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleBordered  target:self action:@selector(stopAudio:)];
    self.navigationItem.rightBarButtonItem = stopButton;
    
    [RcordButton setEnabled:NO];
    
    //        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //        NSError *err = nil;
    //        [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    //        if(err){
    //            NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    //            return;
    //        }
    //        [audioSession setActive:YES error:&err];
    //        err = nil;
    //        if(err){
    //            NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    //            return;
    //        }
    //
    //       NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
    //
    //        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    //        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    //
    //        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    //        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    //
    //
    //
    //        // Create a new dated file
    //        NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    //        NSString *caldate = [now description];
    //       //recorderFilePath = [NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, caldate];
    //    dirPaths = NSSearchPathForDirectoriesInDomains(
    //                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    //    docsDir = dirPaths[0];
    //
    //  soundFilePath = [docsDir
    //                               stringByAppendingPathComponent:@"sound.caf"];
    //
    //    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    //
    //        //NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    //        err = nil;
    //      recorder = [[ AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSetting error:&err];
    //        if(!recorder){
    //            NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    //            UIAlertView *alert =
    //            [[UIAlertView alloc] initWithTitle: @"Warning"
    //                                       message: [err localizedDescription]
    //                                      delegate: nil
    //                             cancelButtonTitle:@"OK"
    //                             otherButtonTitles:nil];
    //            [alert show];
    //
    //            return;
    //        }
    //
    //        //prepare to record
    //        [recorder setDelegate:self];
    //        [recorder prepareToRecord];
    //    [recorder record];
    //        recorder.meteringEnabled = YES;
    //
    //        BOOL audioHWAvailable = audioSession.inputIsAvailable;
    //        if (! audioHWAvailable) {
    //            UIAlertView *cantRecordAlert =
    //            [[UIAlertView alloc] initWithTitle: @"Warning"
    //                                       message: @"Audio input hardware not available"
    //                                      delegate: nil
    //                             cancelButtonTitle:@"OK"
    //                             otherButtonTitles:nil];
    //            [cantRecordAlert show];
    //                        return;
    
    
    // start recording
    
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
    //                        error:nil];
    
    
    // [recorder recordForDuration:(NSTimeInterval) 100];
    
    
    
    
    
    //dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //docsDir = [dirPaths objectAtIndex:0];
    //soundFilePath = [docsDir stringByAppendingPathComponent:@"audioRecording.m4a"];
    // NSURL *soundFileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"audioRecording.m4a"]];
    
    //    //NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
    //                                   [NSNumber numberWithFloat:44100],AVSampleRateKey,
    //                                   [NSNumber numberWithInt: kAudioFormatAppleLossless],AVFormatIDKey,
    //                                   [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
    //                                   [NSNumber numberWithInt:AVAudioQualityMedium],AVEncoderAudioQualityKey,nil];
    //
    
    //NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    //NSDictionary *recordSettings = [NSDictionary
    //                                dictionaryWithObjectsAndKeys:
    //                                [NSNumber numberWithInt:AVAudioQualityMin],
    //                                AVEncoderAudioQualityKey,
    //                                [NSNumber numberWithInt:16],
    //                                AVEncoderBitRateKey,
    //                                [NSNumber numberWithInt: 2],
    //                                AVNumberOfChannelsKey,
    //                                [NSNumber numberWithFloat:44100.0],
    //                                AVSampleRateKey,
    //                                nil];
    
    //NSError *error = nil;
    //
    //audioRecorder = [[AVAudioRecorder alloc]
    //                 initWithURL:soundFileURL
    //                 settings:recordSettings
    //                 error:&error];
    
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    soundFilePath = [docsDir
                     stringByAppendingPathComponent:@"tmp.m4a"];
    
    soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                    [NSNumber numberWithFloat:16000.0], AVSampleRateKey,
                                    [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                    nil];
    NSError *error = nil;
    
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
    
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    else
    {
        [audioRecorder prepareToRecord];
        
        [audioRecorder record];
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }
}
////audioRecorder.delegate = self;
//if (error)
//{
//    NSLog(@"error: %@", [error localizedDescription]);
//
//} else {
//    //[audioRecorder prepareToRecord];
//
//    [audioRecorder record];
//
//    UIButton* Logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Logoutbtn setImage:[UIImage imageNamed:@"music.png"] forState:UIControlStateNormal];
//    [Logoutbtn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
//    [Logoutbtn sizeToFit];
//    UIBarButtonItem *Logoutpagebatbtn = [[UIBarButtonItem alloc] initWithCustomView:Logoutbtn];
//    self.navigationItem.rightBarButtonItem = Logoutpagebatbtn;
//
//}


//}

//- (IBAction)recordAudio:(id)sender {
//    if (!audioRecorder.recording)
//    {
//
//
//        ///_playButton.enabled = NO;
//        //_stopButton.enabled = YES;
//        NSError *error;
//        if (error)
//            NSLog(@"Error: %@",
//                  [error localizedDescription]);
//        else
//
//            NSLog(@"Error: ");
//
//    }





//- (IBAction)playAudio:(id)sender {
//    if (!audioRecorder.recording)
//    {
//       // _stopButton.enabled = YES;
//       // _recordButton.enabled = NO;
//
//        NSError *error;
//
//        AVAudioPlayer *_audioPlayer = [[AVAudioPlayer alloc]
//                        initWithData:data
//                        error:&error];
//
//        //_audioPlayer.delegate = self;
//
//        if (error)
//            NSLog(@"Error: %@",
//                  [error localizedDescription]);
//        else
//             NSLog(@"Error: ");
//            [_audioPlayer play];
//    }
//}
-(void)updateTime
{
    if([audioRecorder isRecording])
    {
        recordTimeLabel.hidden=NO;
        recordimagebtn.hidden=NO;
        
        float minutes = floor(audioRecorder.currentTime/60);
        float seconds = audioRecorder.currentTime - (minutes * 60);
        
        NSString *time = [[NSString alloc]
                          initWithFormat:@"%0.0f.%0.0f",
                          minutes, seconds];
                 recordTimeLabel.text = time;
    }
}
- (IBAction)stopAudio:(id)sender
{
    
    if (audioRecorder.recording)
    {
        NSLog(@"Error: ");
        
        [audioRecorder stop];
        recordTimeLabel.hidden=YES;
        recordimagebtn.hidden=YES;
        RcordButton = [[UIBarButtonItem alloc] initWithTitle:@"Recording" style:UIBarButtonItemStyleBordered  target:self action:@selector(RecordAudio:)];
        self.navigationItem.rightBarButtonItem = RcordButton;
        [stopButton setEnabled:NO];
        [spinner stopAnimating];
        
        data = [NSData dataWithContentsOfURL:audioRecorder.url];
        
        
        
        
        
        //MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioRecorder.url];
        
        
        
        //[self presentModalViewController:moviePlayer animated:NO];
        
        // NSLog(@"da ta is %@",data);
        fileName = [[NSMutableString alloc]initWithString:_TaskIdstr];
        [self UploadAudio];
        
        
    } //else if (_audioPlayer.playing) {
    //[_audioPlayer stop];
    //}
}
- (BOOL) sendAudioToServer :(NSData *)data1
{
    data= [NSData dataWithData:data1];
    //AVAudioPlayer*  player = [[AVAudioPlayer alloc] initWithData:data  error:nil];
    //[player prepareToPlay];
    //[player play];
    
    
    
    //now you'll just have to send that NSData to your server
    
    return YES;
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
    //[self sendAudioToServer:data1];
    //[recorder record];
    NSLog(@"stoped sent and restarted");
    // }
}
//- (IBAction)startRec:(id)sender {
//    if (!audioRecorder.recording)
//    {
//       // sendButton.enabled = YES;
//        //stopButton.enabled = YES;
//        [audioRecorder record];
//
//
//    }
//}

- (IBAction)sendToServer:(id)sender
{
    _stoped = NO;
    [audioRecorder stop];
}

- (IBAction)stop:(id)sender {
    //stopButton.enabled = NO;
    //sendButton.enabled = NO;
    //recordButton.enabled = YES;
    NSLog(@"stoped sent and chabdur");
    _stoped = YES;
    [audioRecorder stop];
    audioRecorder.delegate = self;
    if (audioRecorder.recording)
    {
        
    }
    
    
}

//- (void) stopRecording
//
//  {
//
//        [recorder stop];
//
//      AVAudioPlayer*  player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
//      [player prepareToPlay];
//      [player play];
//
//        NSURL *url = [NSURL fileURLWithPath:soundFilePath];
//      NSLog(@"path is %@",[url path]);
//      data = [NSData dataWithContentsOfURL:recorder.url];//:[url path] options: 0 error:nil];
//        NSError *err = nil;
//              if(!data)
//            NSLog(@"audio data: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
//       // [editedObject setValue:[NSData dataWithContentsOfURL:url] forKey:editedFieldKey];
//
//        //[recorder deleteRecording];
//
//
//       // NSFileManager *fm = [NSFileManager defaultManager];
//
//        //err = nil;
//        //[fm removeItemAtPath:[url path] error:&err];
//       // if(err)
//           // NSLog(@"File Manager: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
//
//
//
//        UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Record" style:UIBarButtonItemStyleBordered  target:self action:@selector(RecordAudio:)];
//        self.navigationItem.rightBarButtonItem = startButton;
//
//    }
//
//    - (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
//    {
//
//        NSLog (@"audioRecorderDidFinishRecording:successfully:");
//        // your actions here
//
//
//        //NSLog(@"data is %@",data);
//
//        //fileName = @"recorder";
//        [self UploadAudio];
//
//
//    }

-(void)HomePagebtnTapped
{
    
    
    
    //    _controller = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle]URLForResource:@"music" withExtension:@".png"]];
    //    self.controller.delegate = self;
    //    CGRect navRect = self.view.frame;
    //    [self.controller presentPreviewAnimated:YES];
    
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}
-(void)Downloading:(float)Downloading
{
    
}

-(void)serviceCal:(id)ServerData
{
    AudioListParser = [[NSXMLParser alloc]initWithData:ServerData];
    AudioListParser.delegate = self;
    [AudioListParser parse];
}

-(void)didEndTask:(id)Taskend
{
    AudioDataParser = [[NSXMLParser alloc]initWithData:Taskend];
    AudioDataParser.delegate = self;
    [AudioDataParser parse];
    
}

-(void)didFinishData:(id)Data
{
    UploadParserParser = [[NSXMLParser alloc]initWithData:Data];
    UploadParserParser.delegate = self;
    [UploadParserParser parse];
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (parser==AudioListParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            AudioNamesArray                =[NSMutableArray new];
            AudiolistArray                 =[NSMutableArray new];
            FILE_NAMEArray                  =[NSMutableArray new];
            TASK_UPDATE_IDArray             =[NSMutableArray new];
            
            FILE_URL_Array                   =[NSMutableArray new];
            
            fileUrlStr=[NSString new];
            
            //VideoslistArray                 =[NSArray new];
            SplitArray                      =[NSArray new];
        }
    }
    if (parser==AudioDataParser)
    {
        if([elementName isEqualToString:@"tasksBytesResponse"])
        {
            AudioDataArray                =[NSMutableArray new];
            AudioBytesArray               =[NSMutableArray new];
            AudioSplitArray                =[NSArray new];
            BytesString                    = [[NSMutableString alloc] init];
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string
{
    if (parser == AudioListParser)
    {
        if ([string isEqualToString:@"Flase"])
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Empty List" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            [AudiolistArray addObject:string];
            
        }
    }
    if (parser == UploadParserParser)
    {
        
        if ([string isEqualToString:@"Inserted"])
        {
            [self ListOfAudios];
            [AudioTV reloadData];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"TaskList" message:@"Inserted" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
            
        }
    }
    
    
    if (parser == AudioDataParser)
    {
        [BytesString appendString:string];
        //NSLog(@"down load data %@",string);
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (parser == AudioListParser)
    {
        if([elementName isEqualToString:@"tasksFileTypesResponse"])
        {
            for (int i = 0; i<[AudiolistArray count]; i++)
            {
                SplitArray=[[AudiolistArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                [FILE_NAMEArray addObject:[[SplitArray objectAtIndex:5] stringByReplacingOccurrencesOfString: @"FILE_NAME==" withString:@""]];
                
                [TASK_UPDATE_IDArray addObject:[[SplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
                
                fileUrlStr=[[SplitArray objectAtIndex:6]stringByReplacingOccurrencesOfString:@"FILE_URL==" withString:@""];
                
                
                NSLog(@"taskupdaye atrt %@",fileUrlStr);
                [FILE_URL_Array addObject:fileUrlStr];
                NSLog(@"file url arry %@",FILE_URL_Array);
                
                
                
                
                
                
                
                
            }
            
            [AudioTV reloadData];
        }
    }
    
    if (parser == AudioDataParser)
    {
        
        if([elementName isEqualToString:@"tasksBytesResponse"])
        {
            [AudioDataArray addObject:BytesString];
            // NSLog(@"spli %@",AudioDataArray);
            for (int i = 0; i<[AudioDataArray count]; i++)
            {
                AudioSplitArray=[[AudioDataArray objectAtIndex:i] componentsSeparatedByString:@"###"];
                
                
                
                // AudioBytesstr = [[AudioSplitArray objectAtIndex:6] stringByReplacingOccurrencesOfString: @"FILE_BYTES==" withString:@""];
                [AudioBytesArray addObject: [[AudioSplitArray objectAtIndex:6] stringByReplacingOccurrencesOfString: @"FILE_BYTES==" withString:@""]];
                
                //[TASK_UPDATE_IDArray addObject:[[DownloadSplitArray objectAtIndex:1] stringByReplacingOccurrencesOfString: @"TASK_UPDATE_ID==" withString:@""]];
                
                
                
            }
            [activityView removeFromSuperview];
            
            
            NSMutableData *data2 = [[AudioBytesArray objectAtIndex:0]base64DecodedData];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSLog(@"hai %@",data2);
            
            // NSString *mp3strng = @".mp4";
            
            NSString *appFile = [documentsDirectory stringByAppendingPathComponent:AudioNamestr];
            
            // appFile =  [appFile stringByAppendingString:mp3strng];
            NSLog(@"nyt %@", appFile);
            
            [data2 writeToFile:appFile atomically:YES];
            
            
            
            
            NSURL *audioURL = [NSURL fileURLWithPath:appFile];
            
            NSString *sourcePath =[audioURL path];
            UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
            
            
            MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioURL];
            
            
            [self presentModalViewController:moviePlayer animated:NO];
            
            
            //            NSMutableData *data2  = [AudioBytesstr base64DecodedData];
            //
            //            NSString *documentsDirectory = nil;
            //            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            //            if ([paths count] > 0) {
            //                documentsDirectory = [paths objectAtIndex:0];
            //            }
            //
            //            documentsDirectory = [paths objectAtIndex:0];
            ////            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"MyNewFolder"];
            //
            ////            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            ////                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            //
            //          //  NSLog(@"hai %@",dataPath);
            //
            //            NSString *mp3strng = @".m4a";
            //
            //            NSString *appFile = [documentsDirectory stringByAppendingPathComponent:AudioNamestr];
            //
            //
            //            appFile =  [appFile stringByAppendingString:mp3strng];
            //            NSLog(@"nyt %@", appFile);
            //
            //            [data2 writeToFile:appFile atomically:YES];
            //
            //             NSURL *audioURL = [NSURL fileURLWithPath:appFile];
            //            MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioURL];
            //            [self presentModalViewController:moviePlayer animated:NO];
            //
            //
            //
            //            NSString *sourcePath =[audioURL path];
            //            UISaveVideoAtPathToSavedPhotosAlbum(sourcePath, nil, nil, nil);
            
            
            
            
        }
    }
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"delegate called");
    
    player = nil;
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
    
    //[self.view addSubview:activityView];
    
    NSLog(@"updated id is %@",[TASK_UPDATE_IDArray objectAtIndex:indexPath.row]);
    NSString *TaskFileurl  = @"DownloadFileUrl";
    NSDictionary *credentials = @{@"taskUpdatedId":[TASK_UPDATE_IDArray objectAtIndex:indexPath.row],@"fileType":fileType};
    [Servicecall Downloads:TaskFileurl Downloadparameters:credentials];
    [Servicecall setDelegate:self];
    
    
    NSString *fileurl=[FILE_URL_Array objectAtIndex:indexPath.row];
    NSArray *parts = [fileurl componentsSeparatedByString:@"/"];
    NSString *filename = [parts lastObject];
    
    NSLog(@"file name is %@",filename);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    //NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString* foofile = [documentsDirectory stringByAppendingPathComponent:filename];
    NSLog(@"foofile %@",foofile);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    NSLog(@"boolean value is %hhd",fileExists);
    
    
    if (fileExists)
    {
        
        NSURL *audioURL = [NSURL fileURLWithPath:filePath];
        NSLog(@"existig url is%@",audioURL);
        
        NSString *sourcePath =[audioURL path];
        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
        
        
        MPMoviePlayerController* moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:audioURL];
        [self presentModalViewController:moviePlayer animated:NO];
    }
    else
    {
        NSURL  *url = [NSURL URLWithString:fileurl];
        
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
    
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileurl]];
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    //
    //    
    //    NSData *audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileurl]];
    //    
    //    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    
    //    NSString *filePath = [docDirPath stringByAppendingPathComponent:@"filename.mp3"];
    //    
    //    NSLog(@"the file path is %@",filePath);
    //    if (audioData)
    //    [audioData writeToFile:filePath atomically:YES];
    
    
    
}



-(void)LogoutbtnTapped
{
    LogoutAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Do You Want To Exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES",nil];
    [LogoutAlert show];
    
    
}
-(void)TaskListPage
{
    [self.navigationController popViewControllerAnimated:YES];
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

