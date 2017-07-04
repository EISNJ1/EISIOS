//
//  NewViewController.h
//  EISIOSApp
//
//  Created by vm mac on 30/03/2017.
//  Copyright © 2017 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"

@interface NewViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate>
{
    
    Webservices *serviceall;
    NSXMLParser *UploadParserParser,*TaskListXmlParser;
}

@end
