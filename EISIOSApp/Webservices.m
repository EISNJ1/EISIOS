//
//  Webservices.m
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import "Webservices.h"
#import "AFNetworking.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#import "AFHTTPSessionManager.h"
//#import "AFURLConnectionOperation.h"
#import <Foundation/Foundation.h>
#import "FileUploadViewController.h"
#import "JSONKit.h"
#import "LoginAppDelegate.h"




//#define  ParentUrl @"http://192.168.2.5:8099/EISWebservices/services/"
//#define ParentUrl @"http://mhotelsonline.com:8099/EISWebservices/services/"
 //#define ParentUrl @"http://192.168.2.109:8090/EISWebservices/services/"
#define  ParentUrl @"https://2-dot-eiswebservice1-173410.appspot.com/_ah/api/"
//#define POST
//#define kDefaultErrorCode 12345

@implementation Webservices
{
    FileUploadViewController *fileupload;
    
    
}
@synthesize delegate;

#pragma Login json services mark

-(void)loginUrl:(NSString *)LoginStrUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:LoginStrUrl];
    
    //NSURL *url=[NSURL URLWithString:BaseURL];
    
       AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [delegate didFinishService:responseObject];
         NSLog(@"JSON: %@", responseObject);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

#pragma Meeting Module Json services marks

-(void)meetingUrl:(NSString *)meetingurl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:meetingurl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
          //NSLog(@"JSON: %@",responseObject);
    [delegate meetingList:responseObject];
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)agendaUrl :(NSString *)AgendaUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:AgendaUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate agendaList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)actionitemlist:(NSString *)actionitemlisturl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:actionitemlisturl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate actionitemList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)notesactionfbcountUrl:(NSString *)Notesactionfbcounturl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:Notesactionfbcounturl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate notesactionfbcount:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)publicnotesdecurl:(NSString *)publicnotesdecUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:publicnotesdecUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate publicnotesdec:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)projectlstspinrurl:(NSString *)projectlstspinrUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:projectlstspinrUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate projectlistspinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)conferencermspinrurl:(NSString *)conferencermspinrUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:conferencermspinrUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate conferencermspinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)meetingTypeUrl:(NSString *)Meetingtypeurlparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:Meetingtypeurlparams];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate meetingType:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
 
}
-(void)meetingupdate:(NSString *)meetingupdateurlparams meetingupdatedict:(NSString *)meetingdictparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:meetingupdateurlparams];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[meetingdictparams dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate meetingupdate:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];


}
-(void)agendacount:(NSString *)agendacounturl

{
     BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:agendacounturl];
     
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate agendaGoalcount:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)savemeeting:(NSString *)savemeetingurl meetingparams:(NSString *)meetingsavedict
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:savemeetingurl];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[meetingsavedict dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate savemeeting:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
}

-(void)actionitemkill:(NSString *)actionitemclose actionitemkillurl:(NSString *)actionitemkillparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:actionitemclose];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[actionitemkillparams dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate actionitemkill:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
}


-(void)AgendaListUrl:(NSString *)AgendalistUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:AgendalistUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate AgendaList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

-(void)goallistUrl:(NSString *)GoallistUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:GoallistUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate GoalList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)agendameeting:(NSString *)saveagenda agendameetingparams:(NSString *)saveagendameeting
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saveagenda];
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saveagendameeting dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil)
         {
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saveagenda:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}


-(void)ParticipantlistUrl:(NSString *)ParticipantListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:ParticipantListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate participantslist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)participantsresourcename:(NSString *)participantsresourcenamelist
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:participantsresourcenamelist];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate participantresourcename:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)participantrole:(NSString *)participantsrolestring
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:participantsrolestring];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate participantsrole:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}
-(void)saveparticipant:(NSString *)saveparticipantmeeting saveparticipantparams:(NSString *)saveparticipantsurl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saveparticipantmeeting];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saveparticipantsurl dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saveparticipants:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}

-(void)noteslistUrl:(NSString *)notesListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:notesListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate noteslist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

-(void)actionItemListUrl:(NSString *)actionItemlistUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:actionItemlistUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate actionItemList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

-(void)feedbackListUrl:(NSString *)feedbacklistUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:feedbacklistUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate feedbackList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}


-(void)saveactionitemUrl:(NSString *)saveactionitemclass saveactionitemparams:(NSString *)saveactionitemparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saveactionitemclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saveactionitemparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saveactionitem:data];
             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
    

}
-(void)actionitemassignedto:(NSString *)actiontiemassignedtospinner
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:actiontiemassignedtospinner];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate actionitemassigned:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}


-(void)savenotesUrl:(NSString *)savenoteslist savenotesparams:(NSString *)savenotesurl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:savenoteslist];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[savenotesurl dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil)
         {            
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate savenotes:data];
             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}

-(void)savefeedbackUrl:(NSString *)Savefeedback savefeedbackparams:(NSString *)saveFeedbackUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:Savefeedback];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[saveFeedbackUrl dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate savefeedback:data];
             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
}

-(void)userbasedmeetingdetails:(NSString *)userbasedmeetingdetailsclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:userbasedmeetingdetailsclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate userbasedmeetingdetails:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

#pragma Timesheet Json services mark

-(void)timesheet:(NSString *)timesheetlist
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:timesheetlist];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate timesheetlist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)approvetimesheet:(NSString *)approvetimesheetclass approvetimesheetparams:(NSString *)approvetimesheetprameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:approvetimesheetclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[approvetimesheetprameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate approvetimesheet:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
}

-(void)tasklistfortimesheet:(NSString *)tasklistfortimesheetclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:tasklistfortimesheetclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate tasklistfortimesheet:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    

}

-(void)savetimesheet:(NSString *)savetimesheetclass savetimesheetparams:(NSString *)savetimesheetparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:savetimesheetclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[savetimesheetparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate savetimesheetservice:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}

#pragma Issues json services

-(void)issueslist:(NSString *)issueslistclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:issueslistclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate issuelist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)issuestatusclass:(NSString *)issuestatusparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:issuestatusparams];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate issuestatus:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)issuetypeservice:(NSString *)issuetypeserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:issuetypeserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate issuetype:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)assigntoservice:(NSString *)assigntoserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:assigntoserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate assigntoservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}
-(void)teamsubmittedservice:(NSString *)teamsubmittedserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:teamsubmittedserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate teamsubmittedservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)servityservice:(NSString *)servityserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:servityserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate servityservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)saveissue:(NSString *)saveissueclass saveissueparams:(NSString *)saveissueparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saveissueclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saveissueparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saveissueservice:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}

-(void)issueresolutionescalteto:(NSString *)issueresolutionescalatetoparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:issueresolutionescalatetoparameters];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate resoulutionescalatetoservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}
-(void)resolutionreleaseimpact:(NSString *)resolutionreleaseimpactparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:resolutionreleaseimpactparameters];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate resolutionreleaseimpactservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    

    
}
-(void)rejectreasonclass:(NSString *)rejectreasonparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:rejectreasonparameters];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate rejectreasonservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)resolutiontypeclass:(NSString *)resolutiontypeparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:resolutiontypeparameters];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate resolutiontypeservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}
-(void)updateresolutionclass:(NSString *)resolutionupdate resolutionupdateparams:(NSString *)resolutionupdateparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:resolutionupdate];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[resolutionupdateparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate resolutionupdate:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
    

}


#pragma Task Module json services

-(void)tasklistUrl:(NSString *)taskListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:taskListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate tasklist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)prioritylistUrl:(NSString *)priorityListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:priorityListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate prioritylist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)categorylistUrl:(NSString *)categoryListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:categoryListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate categorylist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];}

-(void)holidaysListUrl:(NSString *)holidaysListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:holidaysListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate holidaysList:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)resourcespinner:(NSString *)resourcespinnerclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:resourcespinnerclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate resourcespinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
   
}
-(void)harddependencylist:(NSString *)harddependencyclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:harddependencyclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate harddependencyservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)enddateservice:(NSString *)enddateserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:enddateserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate enddatespinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    

}
-(void)savetask:(NSString *)savetaskclass savetskparameters:(NSString *)savetaskparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:savetaskclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[savetaskparams dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate savetaskservice:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
    

}

-(void)uploadTextClass:(NSString *)uploadTaskText uploadTextparams:(NSDictionary *)uplaodtextparameters
{
    //LoginAppDelegate *appDelegate = (LoginAppDelegate *)[[UIApplication sharedApplication] delegate];
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:uploadTaskText];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:BaseURL parameters:uplaodtextparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        
                                        
                                            
                                            [formData appendPartWithFileData:_imgdata name:@"profile_pic" fileName:_filename mimeType:@"image/jpeg/mp3"];
                                        
                                        
                                    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress)
              {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                     ;
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error)
                      {
                          
                          
                      }
                      else
                      {
                         [delegate uploadtasktextservice:responseObject];
                          NSLog(@"response obje is %@",responseObject);
                      }
                  }];
    
    [uploadTask resume];
    

}
-(void)textuploadtask:(NSString *)textuploadingtaskclass textuploadingtaskparams:(NSString *)textuploadingparameters
{
    
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:textuploadingtaskclass];
    
        NSURL *urlstr=[NSURL URLWithString:BaseURL];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
        //sets the receiver’s timeout interval, in seconds
        [urlRequest setTimeoutInterval:30.0f];
        //sets the receiver’s HTTP request method
    
        //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
          [urlRequest setHTTPMethod:@"POST"];
    
            //sets the request body of the receiver to the specified data.
        [urlRequest setHTTPBody:[textuploadingparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
        //allocate a new operation queue
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //Loads the data for a URL request and executes a handler block on an
        //operation queue when the request completes or fails.
        [NSURLConnection
         sendAsynchronousRequest:urlRequest
         queue:queue
         completionHandler:^(NSURLResponse *response,
                             NSData *data,
                             NSError *error)
    
        {
    
            if ([data length] >0 && error == nil){
                 //process the JSON response
                 //use the main queue so that we can interact with the screen
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [delegate textuploadingservice:data];             });
             }
             else if ([data length] == 0 && error == nil)
             {
                 NSLog(@"Empty Response, not sure why?");
             }
             else if (error != nil){
                 NSLog(@"Not again, what is the error = %@", error);
             }
         }];

}

-(void)taskfileslist:(NSString *)taskfileslistclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:taskfileslistclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate taskfilelistservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)audiouploading:(NSString *)audiouplaodingclass audiouploadingparams:(NSDictionary *)audiouploadingparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:audiouplaodingclass];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:BaseURL parameters:audiouploadingparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        
                                        
                                        
                                        [formData appendPartWithFileData:_imgdata name:@"files" fileName:_filename mimeType:@"audio/mpeg"];
                                        
                                        
                                    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress)
                  {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      ;
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error)
                      {
                          NSLog(@"error occured");
                          
                      }
                      else
                      {
                          [delegate uploadtasktextservice:responseObject];
                          NSLog(@"response obje is %@",responseObject);
                      }
                  }];
    
    [uploadTask resume];

}

#pragma Requirement Module Json services

-(void)requirementListUrl:(NSString *)requirementlistUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementlistUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementlist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
-(void)contacttypelistUrl:(NSString *)contacttypelistclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:contacttypelistclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate contacttype:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)coreprocesslisturl:(NSString *)coreprocessclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:coreprocessclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate coreprocess:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}
-(void)processlisturl:(NSString *)processclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:processclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate processservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    

}
-(void)subprocessurl:(NSString *)subprocessclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:subprocessclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate subprocessservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)activityserviceurl:(NSString *)activityserviceclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:activityserviceclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate activityservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)requirementtypeurl:(NSString *)requirementclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementype:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
 
}
-(void)criticaliryurl:(NSString *)criticalityclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:criticalityclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate criticality:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)systemurl:(NSString *)systemclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:systemclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate systemservice:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)saverequirement:(NSString *)saverequirementclass saverequirementparams:(NSString *)saverequirementparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saverequirementclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saverequirementparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saverequirement:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
 
}
-(void)requirementobjectlist:(NSString *)requirementobjectlistparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementobjectlistparams];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementobject:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)requirementobjectspinner:(NSString *)requirementobjectspinnerclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementobjectspinnerclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementobjectspinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)requirementpurpose:(NSString *)requirementpurposeclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementpurposeclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementpurpose:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)requirementcomplexity:(NSString *)requirementcomplexityclass
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:requirementcomplexityclass];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate requirementcomplexity:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}

-(void)saveRequirementobject:(NSString *)saveRequirementobjectclass saveRequirementobjectparams:(NSString *)saveRequirementobjectparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:saveRequirementobjectclass];
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[saveRequirementobjectparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saverequirementobject:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}


 #pragma Project Expenses Module Json Services

-(void)ProjectExpenseslist:(NSString *)projectexpenses
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:projectexpenses];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate projectExpenseslist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)categoryspinnerlist:(NSString *)categorylist
{
    
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:categorylist];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate categoryspinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}
-(void)saveprojectexpenses:(NSString *)projectexpensesparams projectexpensesservice:(NSString *)projectexpensesparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:projectexpensesparams];
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[projectexpensesparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate saveprojectexpenses:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

    
}
-(void)updateprojectexpenses:(NSString *)updateprojectexpensesclass updateprojectexpensesparams:(NSString *)updateprojectexpensesparameters
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:updateprojectexpensesclass];
    
    
    NSURL *urlstr=[NSURL URLWithString:BaseURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlstr];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"POST"];
    //sets the request body of the receiver to the specified data.
    [urlRequest setHTTPBody:[updateprojectexpensesparameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate updateprojectexpenses:data];             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];

}

#pragma Dashboard Module json services

-(void)oganizationresourcereport:(NSString *)oganizationresourcereportparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:oganizationresourcereportparams];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate oganizationresourcereport:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}
-(void)peoplebyskill:(NSString *)peoplebyskillparams
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:peoplebyskillparams];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate peoplebyskills:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)numofprojectsbyResourcereportsUrl:(NSString *)numofprojectsbyresourcereportUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:numofprojectsbyresourcereportUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate numofprojectsbyresourcereport:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)averagebillingratebyOrganisationUrl:(NSString *)averagebillingratebyorganisationUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:averagebillingratebyorganisationUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate averagebillingratebyorganisation:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)numofresourcesbyProgramUrl:(NSString *)numofresourcesbyprogramUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:numofresourcesbyprogramUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate numofresourcesbyprogram:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)allocatedcapacitytoProgramUrl:(NSString *)allocatedcapacitytoprogramUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:allocatedcapacitytoprogramUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate allocatedcapacitytoprogram:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)allocatedcapacitytoProjectUrl:(NSString *)allocatedcapacitytoprojectUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:allocatedcapacitytoprojectUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate allocatedcapacitytoproject:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)assignedcapacitytoProgramUrl:(NSString *)assignedcapacitytoprogramUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:assignedcapacitytoprogramUrl];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate assignedcapacitytoprogram:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)assignedcapacitytoProjectUrl:(NSString *)assignedcapacitytoprojectUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:assignedcapacitytoprojectUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate assignedcapacitytoproject:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)averagecostofresourceofProgramUrl:(NSString *)averagecostofresourceofprogramUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:averagecostofresourceofprogramUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate averagecostofresourceofprogram:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)numofresourcesbyprojectUrl:(NSString *)numofresourcesbyProjectUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:numofresourcesbyProjectUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate numofresourcesbyproject:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

-(void)numofresourcesbyteamUrl:(NSString *)numofresourcesbyTeamUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:numofresourcesbyTeamUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate numofresourcesbyteam:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)programchartsbudgetcostUrl:(NSString *)programchartsbudgetCostUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:programchartsbudgetCostUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate programchartsbudgetcost:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)programspinnerUrl:(NSString *)programSpinnerUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:programSpinnerUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate programspinner:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)programbyownerlistUrl:(NSString *)programbyownerListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:programbyownerListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate programbyownerlist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)programownerchartUrl:(NSString *)programownerChartUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:programownerChartUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate programownerchart:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)taskoverviewlistUrl:(NSString *)taskoverviewListUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:taskoverviewListUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate taskoverviewlist:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

-(void)effortandbookedtimeUrl:(NSString *)effortandbookedTimeUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:effortandbookedTimeUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate effortandbookedtime:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

-(void)issueoverviewUrl:(NSString *)issueoverViewUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:issueoverViewUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate issueoverview:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)taskoverviewUrl:(NSString *)taskoverViewUrl
{
    BaseURL=[[NSMutableString alloc]initWithString:ParentUrl];
    [BaseURL appendString:taskoverViewUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:BaseURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         
         [delegate taskoverview:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

@end
