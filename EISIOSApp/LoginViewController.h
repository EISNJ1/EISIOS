//
//  LoginViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "GridViewViewController.h"
@interface LoginViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UITextFieldDelegate>
{
    //kumar check it
    IBOutlet UIView *view1;
    IBOutlet UIButton *checkboxbtn,*Loginbtn;
    IBOutlet UITextField *Usernametxtfield,*Passwordtxtfield;
    Webservices *Servicecall;
    GridViewViewController *GridVC;
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property(nonatomic,assign)CGRect frame;
@property(nonatomic,strong)CALayer* layer;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
