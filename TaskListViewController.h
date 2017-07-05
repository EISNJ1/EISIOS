//
//  TaskListViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/27/14 11.54Am.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "CreatTaskViewController.h"
#import "AudioViewController.h"
#import "VideoViewController.h"
#import "TextUploadViewController.h"
#import "FileUploadViewController.h"
@class TextUploadViewController;
@interface TaskListViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UISearchBarDelegate>
{
    CreatTaskViewController *CreatTaskVC;
    Webservices *Servicecall;
    UIView *loadingView;
    IBOutlet UITableView *TaskListTV;
    IBOutlet UITextField *Serchpickertxtfiled,*searchpickertxtfld1;
    UIAlertView *LogoutAlert;
    IBOutlet UISearchBar *Serchbar,*searchBar1;
    IBOutlet UILabel *totalTaskLabel;
    IBOutlet UIButton *filterbtn;
    UIActivityIndicatorView *activityView;
    UILabel *loadingLabel;
    UIPickerView *PrirotyPickerview,*ResourcePickerview,*ExpiredTaskPickerView;
    AudioViewController *AudioVC;
    VideoViewController *VideoVC;
    TextUploadViewController *TextVC;
    FileUploadViewController *FileVC;
    NSMutableArray *uniqueDescriptionArray,*equalTempArray,*equalTempArray1;
    NSString *searchString,*descStr,*descStr1;
    BOOL isSearching;
    
    NSMutableArray *tempArray;
    NSMutableArray *FilterArray;
    
    NSMutableArray *taskStatusArray;
    
    NSMutableArray *dessearchArray1,*startdatesearchArray1,*enddatesearchArray1,*effortsearchArray1,*assignedsearchArray1,*createdbysearchArray1,*prioritysearchArray1,*taskIdSearchArray1,*taskHardDependencySearchArray1,*taskHoursPerdaySearchArray1,*taskProjectNameSearchArray1,*taskCategorySearchArray1,*taskStatusSearchArray1,*taskAssignedByIdSearchArray1,*taskCreatedBySearchArray1;
    
    UILabel *Expirelabel;
}
@end
