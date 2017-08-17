//
//  FileUploadViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 12/22/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface FileUploadViewController : UIViewController<WebserviceownProtocal,UIImagePickerControllerDelegate,NSXMLParserDelegate>
{
    Webservices *Servicecall;
    UIAlertView *LogoutAlert;
    UIView *selectionView;
    IBOutlet UIButton *Uploadbtn;
    IBOutlet UITableView *FileTV;
    UIImagePickerController *GalleryImage;
    UIImage *ImageforUpload;
    IBOutlet UIButton *homebtn;
    UIDocumentInteractionController *documentcontroller;
    NSString *fileurl,*filename;
    UIWebView *webView;
    NSURL *url;
    UITextView *textView;
    UIImageView *ImgView;
    UIActivityIndicatorView *activityIndicator;
    
}
@property(nonatomic,strong)NSString *Taskidstr;
//@property(nonatomic,strong)UIImage *ImageforUpload;
@property(strong,nonatomic)UIImagePickerController *camImagePickerController;
@end
