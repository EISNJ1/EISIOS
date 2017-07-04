//
//  AudioViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 12/16/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface AudioViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,WebserviceownProtocal,NSXMLParserDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate,MPMediaPickerControllerDelegate,NSURLConnectionDelegate>
{
    Webservices *Servicecall;

    UIAlertView *LogoutAlert;
    UIView *selectionView;
    IBOutlet UIButton *Uploadbtn,*choose;
    IBOutlet UITableView *AudioTV;
    UIActivityIndicatorView  *activityView;
    NSArray *dirPaths;
    NSString *docsDir,*soundFilePath;
    IBOutlet UIButton *homebtn;
    //UIBarButtonItem *stopButton;
    UILabel *recStateLabel;
    
    NSTimer *myTimer;
    
    UIActivityIndicatorView *spinner;
    
    NSDictionary *recordSetting;
    MPMediaItem *song;
    NSURL *exportURL;
    BOOL isNotRecording;
     NSURL *temporaryRecFile;
    
    UIButton *SoundRecordbtn;
    UILabel *recordTimeLabel;
    UIButton *recordimagebtn;
    
    UIBarButtonItem *RcordButton,*stopButton;
}
@property(nonatomic,strong)NSString *TaskIdstr;
@property (nonatomic, retain) NSData *audioData;
//@property(strong,nonatomic)AVAudioPlayer *audioPlayer;
@end
