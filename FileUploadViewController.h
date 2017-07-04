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
    UIImagePickerController *camImagePickerController,*GalleryImage;
    UIImage *ImageforUpload;
    IBOutlet UIButton *homebtn;
    UIDocumentInteractionController *documentcontroller;
    NSString *fileurl,*filename;
    UIWebView *webView;
    NSURL *url;
    UITextView *textView;
    UIImageView *ImgView;
    
}
@property(nonatomic,strong)NSString *Taskidstr;
@end
