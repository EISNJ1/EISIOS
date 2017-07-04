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




//#define  ParentUrl @"http://192.168.2.5:8099/EISWebservices/services/"
#define ParentUrl @"http://mhotelsonline.com:8099/EISWebservices/services/"
 //#define ParentUrl @"http://192.168.2.109:8090/EISWebservices/services/"
//#define POST
//#define kDefaultErrorCode 12345

@implementation Webservices
{
    
}
@synthesize delegate;

-(void)loginUrl:(NSString *)LoginStrUrl
{
   
       AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:LoginStrUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [delegate didFinishService:responseObject];
         NSLog(@"JSON: %@", responseObject);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

-(void)meetingUrl:(NSString *)meetingurl
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:meetingurl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:AgendaUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:actionitemlisturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:Notesactionfbcounturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:publicnotesdecUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:projectlstspinrUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:conferencermspinrUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:Meetingtypeurlparams parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate meetingType:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
 
}
-(void)meetingupdate:(NSString *)meetingupdateurlparams meetingupdatedict:(NSDictionary *)meetingdictparams
{
    //NSString *postMsg =meetingdictparams;
    NSDictionary * callDict = meetingdictparams;
    
    // convert your dictionary to NSData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:callDict options:kNilOptions error:nil];
    // this is your service request url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:meetingupdateurlparams]];
    // set the content as format
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    // this is your response type
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    NSError *err;
    NSURLResponse *response;
    // send the synchronous connection
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    // here add your server response NSJSONSerialization
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error: &err];
    NSLog(@"json array is %@",jsonArray);
    
    // if u want to check the data in console
    NSString *tmp=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", tmp);
}
-(void)agendacount:(NSString *)agendacounturl

 {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer = responseSerializer;
    [manager GET:agendacounturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"JSON: %@",responseObject);
         [delegate agendaGoalcount:responseObject];
     }
         failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

}

//-(void)Loginserviceurl:(NSString *)Loginurl Loginparameters:(NSDictionary *)LoginCredentials
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:Loginurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<userLogin xmlns=\"http://tempuri.org/\">"
//                             "<userName>%@</userName>"
//                             "<password1>%@</password1>"
//                             "</userLogin>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[LoginCredentials objectForKey:@"userName"],[LoginCredentials objectForKey:@"password1"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    }
//    failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"SERVER" message:@"The request timed out" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//        
//        [alert show];
//    }];
//    
//    [operation start];
//
//}
//
//-(void)MeetingListurl:(NSString *)Listurl Listparameters:(NSDictionary *)Listcredentials
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Listurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<userMeetingsList xmlns=\"http://tempuri.org/\">"
//                             "<userid>%@</userid>"
//                             "<flag>%@</flag>"
//                             "</userMeetingsList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[Listcredentials objectForKey:@"userid"],[Listcredentials objectForKey:@"flag"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"meeting list is %@", string);
//
//       
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//}
//
//-(void)ActionitemListurl:(NSString *)Listurl Listparameters:(NSDictionary *)Listcredentials
//{
//     BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Listurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<actionItemList xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "</actionItemList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[Listcredentials objectForKey:@"userid"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSLog(@"%@", string);
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//}
//-(void)NotesCountlisturl:(NSString *)Countlisturl CountListparameters:(NSDictionary *)CountParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Countlisturl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<countList xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "<userId>%@</userId>"
//                             "</countList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[CountParameters objectForKey:@"meetingId"],[CountParameters objectForKey:@"userId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"meeting count %@", string);
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//}
//
//-(void)PublicCountlisturl:(NSString *)Publiccounturl Publiccountcredentilas:(NSDictionary *)PubliccountParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Publiccounturl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<count xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</count>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[PubliccountParameters objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"meeting list count %@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//    
//    
//}
//-(void)PublicDislisturl:(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)PublicDisParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<description xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</description>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[PublicDisParameters objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@" public notes list display %@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//
//}
//-(void)Projectspickerurl:(NSString *)Projectsurl ProjectsListcredentilas:(NSDictionary *)ProjectListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Projectsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectLstForMeet xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</projectLstForMeet>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ProjectListParameters objectForKey:@"usertype"],[ProjectListParameters objectForKey:@"userid"],[ProjectListParameters objectForKey:@"orgId"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//
//
//}
//-(void)ProjectspickerurlTask:(NSString *)Projectsurl ProjectsListcredentilas:(NSDictionary *)ProjectListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Projectsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectLstForTask xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</projectLstForTask>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ProjectListParameters objectForKey:@"usertype"],[ProjectListParameters objectForKey:@"userid"],[ProjectListParameters objectForKey:@"orgid"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//    
//    
//}
//
//
//
//
//-(void)createTimeSheetProject :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)projectParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str2 = [projectParameters objectForKey:@"userId"];
//    NSString *str1 = [projectParameters objectForKey:@"userType"];
//    NSString *str3 = [projectParameters objectForKey:@"orgID"];
//
//    
//    NSLog(@"the user id is %@ %@ %@",str1,str2,str3);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectLstForTask xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</projectLstForTask>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[projectParameters objectForKey:@"userType"],[projectParameters objectForKey:@"userId"],[projectParameters objectForKey:@"orgID"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//
//    
//}
//-(void)MeetingTypeurl:(NSString *)MeetingTypeurl MeetingTypeListCredentilas:(NSDictionary *)MeetingListCredentilas
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:MeetingTypeurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<meetingtype xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</meetingtype>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[MeetingListCredentilas objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//}
//-(void)ConfRoomurl:(NSString *)ConfRoomMurl ConfRoomCredentilas:(NSDictionary *)ConfRoomCredentilas
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ConfRoomMurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<pickConfRoomList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</pickConfRoomList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ConfRoomCredentilas objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//}
//-(void)createTimeSheetTask :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)taskParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str1 = [taskParameters objectForKey:@"userType"];
//    NSString *str2 = [taskParameters objectForKey:@"userId"];
//
//    NSString *str3 = [taskParameters objectForKey:@"orgId"];
//    NSString *str4 = [taskParameters objectForKey:@"projectId"];
//
//    NSLog(@"the user id is %@ %@ %@ %@",str1,str2,str3,str4);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                            "<soap:Body>"
//                            "<taskListForTimeSheet xmlns=\"http://tempuri.org/\">"
//                            "<userType>%@</userType>"
//                            "<userId>%@</userId>"
//                            "<orgId>%@</orgId>"
//                            "<projectId>%@</projectId>"
//                            "</taskListForTimeSheet>"
//                            "</soap:Body>"
//                            "</soap:Envelope>",[taskParameters objectForKey:@"userType"],[taskParameters objectForKey:@"userId"],[taskParameters objectForKey:@"orgId"],[taskParameters objectForKey:@"projectId"]];
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//}
//-(void)saveTimeSheet :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)saveTimeSheetParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str1 = [saveTimeSheetParameters objectForKey:@"taskId"];
//    NSString *str2 = [saveTimeSheetParameters objectForKey:@"submitDate"];
//    
//    NSString *str3 = [saveTimeSheetParameters objectForKey:@"hoursSpent"];
//    NSString *str4 = [saveTimeSheetParameters objectForKey:@"estHrsCompl"];
//    
//    NSLog(@"the user id is %@ %@ %@ %@",str1,str2,str3,str4);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveTimeSheet xmlns=\"http://tempuri.org/\">"
//                             "<taskId>%@</taskId>"
//                             "<submitDate>%@</submitDate>"
//                             "<hoursSpent>%@</hoursSpent>"
//                             "<estHrsCompl>%@</estHrsCompl>"
//                            "<isTaskComplited>%@</isTaskComplited>"
//                             "<resourceId>%@</resourceId>"
//                             "<projectId>%@</projectId>"
//                             "<reason>%@</reason>"
//                             "</saveTimeSheet>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[saveTimeSheetParameters objectForKey:@"taskId"],[saveTimeSheetParameters objectForKey:@"submitDate"],[saveTimeSheetParameters objectForKey:@"hoursSpent"],[saveTimeSheetParameters objectForKey:@"estHrsCompl"],
//                             [saveTimeSheetParameters objectForKey:@"isTaskComplited"],[saveTimeSheetParameters objectForKey:@"resourceId"],[saveTimeSheetParameters objectForKey:@"projectId"],[saveTimeSheetParameters objectForKey:@"reason"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//}
//-(void)timeSheetLst :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)timeSheetLstParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str1 = [timeSheetLstParameters objectForKey:@"userId"];
//    
//    
//    NSLog(@"the user id is %@ ",str1);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<timeSheetListfrManager xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "<userType>%@</userType>"
//                             "<orgId>%@</orgId>"
//                            "</timeSheetListfrManager>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[timeSheetLstParameters objectForKey:@"userId"],[timeSheetLstParameters objectForKey:@"userType"],[timeSheetLstParameters objectForKey:@"orgId"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//}
//
//-(void)timeSheetLstAll :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)timeSheetLstAllParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str1 = [timeSheetLstAllParameters objectForKey:@"userId"];
//    
//    
//    NSLog(@"the user id is %@ ",str1);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<timeSheetStLstFrAll xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "</timeSheetStLstFrAll>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[timeSheetLstAllParameters objectForKey:@"userId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//
//    
//}
//-(void)approveTimeshhet :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)ApprovetimeSheetLstAllParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:PublicDisurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *str1 = [ApprovetimeSheetLstAllParameters objectForKey:@"timeSheetLineId"];
//    
//    
//    NSLog(@"the user id is %@ ",str1);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<updateTimsheet xmlns=\"http://tempuri.org/\">"
//                             "<timeSheetLineId>%@</timeSheetLineId>"
//                             "<approvedFlag>%@</approvedFlag>"
//                             "<approvedBy>%@</approvedBy>"
//                             "<reason>%@</reason>"
//                             "</updateTimsheet>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ApprovetimeSheetLstAllParameters objectForKey:@"timeSheetLineId"],[ApprovetimeSheetLstAllParameters objectForKey:@"approvedFlag"],[ApprovetimeSheetLstAllParameters objectForKey:@"approvedBy"],[ApprovetimeSheetLstAllParameters objectForKey:@"reason"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//
//    
//}
//-(void)SaveMeetingurl:(NSString *)SaveMeeetingurl SaveMeetingDetails:(NSDictionary *)SaveMeetingDetails
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:SaveMeeetingurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveMeeting xmlns=\"http://tempuri.org/\">"
//                             "<meetingTyp>%@</meetingTyp>"
//                             "<meetinTitle>%@</meetinTitle>"
//                             "<meetDescription>%@</meetDescription>"
//                             "<startTym>%@</startTym>"
//                             "<hours>%@</hours>"
//                             "<meetOwnId>%@</meetOwnId>"
//                             "<projectId>%@</projectId>"
//                             "<meetDate>%@</meetDate>"
//                             "<ConferRoomId>%@</ConferRoomId>"
//                             "</saveMeeting>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[SaveMeetingDetails objectForKey:@"meetingTyp"],[SaveMeetingDetails objectForKey:@"meetinTitle"],[SaveMeetingDetails objectForKey:@"meetDescription"],[SaveMeetingDetails objectForKey:@"startTym"],[SaveMeetingDetails objectForKey:@"hours"],[SaveMeetingDetails objectForKey:@"meetOwnId"],[SaveMeetingDetails objectForKey:@"projectId"],[SaveMeetingDetails objectForKey:@"meetDate"],[SaveMeetingDetails objectForKey:@"ConferRoomId"]];
//    
//     NSLog(@"details update %@ %@ %@ %@ %@ %@ %@ %@ %@",[SaveMeetingDetails objectForKey:@"meetingTyp"],[SaveMeetingDetails objectForKey:@"meetinTitle"],[SaveMeetingDetails objectForKey:@"meetDescription"],[SaveMeetingDetails objectForKey:@"startTym"],[SaveMeetingDetails objectForKey:@"hours"],[SaveMeetingDetails objectForKey:@"meetOwnId"],[SaveMeetingDetails objectForKey:@"projectId"],[SaveMeetingDetails objectForKey:@"meetDate"],[SaveMeetingDetails objectForKey:@"ConferRoomId"]);
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//}
//
//-(void)UpdateMeetingurl:(NSString *)UpdateMeeetingurl UpdateMeetingDetails:(NSDictionary *)UpdateMeetingDetails
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:UpdateMeeetingurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<updateMeeting xmlns=\"http://tempuri.org/\">"
//                             "<meetingTyp>%@</meetingTyp>"
//                             "<meetinTitle>%@</meetinTitle>"
//                             "<meetDescription>%@</meetDescription>"
//                             "<startTym>%@</startTym>"
//                             "<hours>%@</hours>"
//                             "<meetOwnId>%@</meetOwnId>"
//                             "<projectId>%@</projectId>"
//                             "<meetDate>%@</meetDate>"
//                             "<meetingId>%@</meetingId>"
//                             "<ConferRoomId>%@</ConferRoomId>"
//                             "</updateMeeting>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[UpdateMeetingDetails objectForKey:@"meetingTyp"],[UpdateMeetingDetails objectForKey:@"meetinTitle"],[UpdateMeetingDetails objectForKey:@"meetDescription"],[UpdateMeetingDetails objectForKey:@"startTym"],[UpdateMeetingDetails objectForKey:@"hours"],[UpdateMeetingDetails objectForKey:@"meetOwnId"],[UpdateMeetingDetails objectForKey:@"projectId"],[UpdateMeetingDetails objectForKey:@"meetDate"],[UpdateMeetingDetails objectForKey:@"meetingId"],[UpdateMeetingDetails objectForKey:@"ConferRoomId"]];
//    
//    
//    NSLog(@"details update %@ %@ %@ %@ %@ %@ %@ %@ %@",[UpdateMeetingDetails objectForKey:@"meetingTyp"],[UpdateMeetingDetails objectForKey:@"meetinTitle"],[UpdateMeetingDetails objectForKey:@"meetDescription"],[UpdateMeetingDetails objectForKey:@"startTym"],[UpdateMeetingDetails objectForKey:@"hours"],[UpdateMeetingDetails objectForKey:@"meetOwnId"],[UpdateMeetingDetails objectForKey:@"projectId"],[UpdateMeetingDetails objectForKey:@"meetDate"],[UpdateMeetingDetails objectForKey:@"ConferRoomId"]);
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    [operation start];
//    
//    
//}
//-(void)ActionItemListKill:(NSString *)ActionItemListClass ActionItemListKillParameters:(NSDictionary *)ACtionItemListDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ActionItemListClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<actionItemStatus xmlns=\"http://tempuri.org/\">"
//                             "<noteLineId>%@</noteLineId>"
//                             "<actionItemStatus>%@</actionItemStatus>"
//                             "</actionItemStatus>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ACtionItemListDictionary objectForKey:@"noteLineId"],[ACtionItemListDictionary objectForKey:@"actionItemStatus"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//-(void)AgendaListurl:(NSString *)AgendaListurl AgendaListParameters:(NSDictionary *)AgendaListParameters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:AgendaListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<agendaListData xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</agendaListData>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[AgendaListParameters objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//-(void)agendaSavedurl:(NSString *)AgendaSavedurl AgendaSavedParameters:(NSDictionary *)AgendaSavedParamaters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:AgendaSavedurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveAgenda xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "<objectDesc>%@</objectDesc>"
//                             "<budgetedTym>%@</budgetedTym>"
//                              "</saveAgenda>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[AgendaSavedParamaters objectForKey:@"meetingId"],[AgendaSavedParamaters objectForKey:@"objectDesc"],[AgendaSavedParamaters objectForKey:@"budgetedTym"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//
//}
//-(void)GoalsListurl:(NSString *)GoalsListurl GoalsListParameters:(NSDictionary *)GoalsListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:GoalsListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<goalsListData xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</goalsListData>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[GoalsListParameters objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//-(void)GoalsSavedurl:(NSString *)GoalsSavedurl GoalsSavedParameters:(NSDictionary *)GoalsSavedParamaters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:GoalsSavedurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveGoals xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "<objectDesc>%@</objectDesc>"
//                             "<budgetedTym>%@</budgetedTym>"
//                             "</saveGoals>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[GoalsSavedParamaters objectForKey:@"meetingId"],[GoalsSavedParamaters objectForKey:@"objectDesc"],[GoalsSavedParamaters objectForKey:@"budgetedTym"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//}
//
//-(void)ParticipantsListurl:(NSString *)Participantsurl ParticipantsListParameters:(NSDictionary *)ParticipantsListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<participantsListData xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</participantsListData>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ParticipantsListParameters objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//}
//-(void)ParticipantsResourceName:(NSString *)ResourceNameurl ParticipantsResourceParameters:(NSDictionary *)ResourceNameParameters
//
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ResourceNameurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<pariResList xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</pariResList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ResourceNameParameters objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//}
//
//-(void)RoleName:(NSString *)RoleNameurl RoleParameters:(NSDictionary *)RoleParameters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:RoleNameurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<rolesListData xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</rolesListData>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[RoleParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//
//}
//
//-(void)SaveParticipantsurl:(NSString *)Saveurl SaveParticipantsParameters:(NSDictionary *)SaveParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Saveurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveParticipants xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "<resourceId>%@</resourceId>"
//                             "<participantRole>%@</participantRole>"
//                              "<flag>%@</flag>"
//                             "</saveParticipants>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[SaveParameters objectForKey:@"meetingId"],[SaveParameters objectForKey:@"resourceId"],[SaveParameters objectForKey:@"participantRole"],[SaveParameters objectForKey:@"flag"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//-(void)AgendaGoalsCounturl:(NSString *)AgendaGoalsCounturl AgendaGoalParameters:(NSDictionary *)AgendaGoalsCredentials
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:AgendaGoalsCounturl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<agendaGoalCountData xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</agendaGoalCountData>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[AgendaGoalsCredentials objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//}
//
//
//-(void)AssignedTourl:(NSString *)Assignedurl AssignedValues:(NSDictionary *)AssignedToListParameter
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Assignedurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<actionItemAssignedToList xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</actionItemAssignedToList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[AssignedToListParameter objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//}
//
//-(void)SaveActionitemsList:(NSString *)Saveurl SaveActionItemParametres:(NSDictionary *)SaveActionItemData
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Saveurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveActionItem xmlns=\"http://tempuri.org/\">"
//                             "<ObjId>%@</ObjId>"
//                             "<ObjDesc>%@</ObjDesc>"
//                             "<category>%@</category>"
//                             "<actionItemDesc>%@</actionItemDesc>"
//                             "<assignedId>%@</assignedId>"
//                             "<dueDate>%@</dueDate>"
//                             "<priority>%@</priority>"
//                             "<effortReq>%@</effortReq>"
//                             "<effortUom>%@</effortUom>"
//                             "<created_by>%@</created_by>"
//                             "</saveActionItem>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[SaveActionItemData objectForKey:@"ObjId"],[SaveActionItemData objectForKey:@"ObjDesc"],[SaveActionItemData objectForKey:@"category"],[SaveActionItemData objectForKey:@"actionItemDesc"],[SaveActionItemData objectForKey:@"assignedId"],[SaveActionItemData objectForKey:@"dueDate"],[SaveActionItemData objectForKey:@"priority"],[SaveActionItemData objectForKey:@"effortReq"],[SaveActionItemData objectForKey:@"effortUom"],[SaveActionItemData objectForKey:@"created_by"]];
//    
//    
//    
//    NSLog(@"data is %@ %@ %@ %@ %@ %@ %@ %@ %@ %@",[SaveActionItemData objectForKey:@"ObjId"],[SaveActionItemData objectForKey:@"ObjDesc"],[SaveActionItemData objectForKey:@"category"],[SaveActionItemData objectForKey:@"actionItemDesc"],[SaveActionItemData objectForKey:@"assignedId"],[SaveActionItemData objectForKey:@"dueDate"],[SaveActionItemData objectForKey:@"priority"],[SaveActionItemData objectForKey:@"effortReq"],[SaveActionItemData objectForKey:@"effortUom"],[SaveActionItemData objectForKey:@"created_by"]);
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//}
//
//-(void)SaveActionItemTablist:(NSString *)ActionItemListUrl ActionItemListDictionary:(NSDictionary *)ListOfActionItemsTab
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:ActionItemListUrl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<actionItemTabList xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "<agendaId>%@</agendaId>"
//                             "</actionItemTabList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ListOfActionItemsTab objectForKey:@"userId"],[ListOfActionItemsTab objectForKey:@"agendaId"]];
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"action item tab response is %@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//
//}
//
//-(void)SavedActionitems:(NSString *)ListofActionitemsurl ListofActionitemsParameters:(NSDictionary *)ListActionitemsParameters
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:ListofActionitemsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<actionItemBasedOnUserId xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "</actionItemBasedOnUserId>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ListActionitemsParameters objectForKey:@"userId"]];
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//       NSLog(@"action item tab response is %@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//    
//}
//
/////-----------------NotesSave-------------------
//
//-(void)NotesList:(NSString *)NOtesListurl NotesListParametrs:(NSDictionary *)NotesListParametrs
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:NOtesListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<notesList xmlns=\"http://tempuri.org/\">"
//                             "<objectId>%@</objectId>"
//                             "<userId>%@</userId>"
//                             "</notesList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[NotesListParametrs objectForKey:@"objectId"],
//                             [NotesListParametrs objectForKey:@"userId"]];
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //NSLog(@"%@", string);
//        
//        [delegate serviceCal:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//}
//-(void)SaveNotes:(NSString *)SaveNotesUrl NotesparametrsForSave:(NSDictionary *)NotesSaveParameters{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:SaveNotesUrl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveNotes xmlns=\"http://tempuri.org/\">"
//                             "<ObjId>%@</ObjId>"
//                             "<noteCategory>%@</noteCategory>"
//                             "<noteRef>%@</noteRef>"
//                             "<noteDesc>%@</noteDesc>"
//                             "<assignedId>%@</assignedId>"
//                             "<publicPriv>%@</publicPriv>"
//                             "</saveNotes>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[NotesSaveParameters objectForKey:@"ObjId"],[NotesSaveParameters objectForKey:@"noteCategory"],[NotesSaveParameters objectForKey:@"noteRef"],[NotesSaveParameters objectForKey:@"noteDesc"],[NotesSaveParameters objectForKey:@"assignedId"],[NotesSaveParameters objectForKey:@"publicPriv"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//       // NSLog(@"%@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//    
//}
//
////-----------FeedBack----------------------
//-(void)Feedbacklisturl:(NSString *)Feedbacklisturl FeedbackCredentials:(NSDictionary *)FeedbackCredentials{
//    
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Feedbacklisturl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<feedbackList xmlns=\"http://tempuri.org/\">"
//                             "<userId>%@</userId>"
//                             "<meetingId>%@</meetingId>"
//                             "</feedbackList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[FeedbackCredentials objectForKey:@"userId"],[FeedbackCredentials objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //NSLog(@"%@", string);
//        
//        [delegate Servicecal1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//}
//-(void)SaveFeedbackurl:(NSString *)SaveFeedbackurl SaveFeedBackCredentials:(NSDictionary *)SaveFeedbackParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:SaveFeedbackurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveFeedBack xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "<userId>%@</userId>"
//                             "<positiveComments>%@</positiveComments>"
//                             "<negativeComm>%@</negativeComm>"
//                             "</saveFeedBack>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[SaveFeedbackParameters objectForKey:@"meetingId"],[SaveFeedbackParameters objectForKey:@"userId"],[SaveFeedbackParameters objectForKey:@"positiveComments"],[SaveFeedbackParameters objectForKey:@"negativeComm"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate ServiceCalls:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//    
//}
//
////----------issue Module ----------//
//
//-(void)issueList :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)issueListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user type is %@ ",[issueListParameters objectForKey:@"usertype"]);
//    NSLog(@"the user id is %@ ",[issueListParameters objectForKey:@"userID"]);
//    NSLog(@"the user org id  is %@ ",[issueListParameters objectForKey:@"orgId"]);
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issuesList xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<userID>%@</userID>"
//                             "<orgId>%@</orgId>"
//                             "</issuesList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[issueListParameters objectForKey:@"usertype"],[issueListParameters objectForKey:@"userID"],[issueListParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@""];
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;p&gt;" withString:@""];
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;/p&gt;" withString:@""];
////        string = [string stringByReplacingOccurrencesOfString:@"" withString:@""];
////        NSLog(@"THE ISSUE LIST IS  %@", string);
////        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//
//}
//
//
//-(void)createIssueProjectSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)projectListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user type is %@ ",[projectListParameters objectForKey:@"usertype"]);
//
//    NSLog(@"the user id is %@ ",[projectListParameters objectForKey:@"userID"]);
//    
//    NSLog(@"the org id is %@ ",[projectListParameters objectForKey:@"orgId"]);
//
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectLstForTask xmlns=\"http://tempuri.org/\">"
//                              "<usertype>%@</usertype>"
//                             "<userID>%@</userID>"
//                              "<orgId>%@</orgId>"
//                             "</projectLstForTask>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[projectListParameters objectForKey:@"usertype"],[projectListParameters objectForKey:@"userID"],[projectListParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//
//-(void)createIssueStatusSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)statusListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[statusListParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issueStatusList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</issueStatusList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[statusListParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)createIssueIssueTypeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)issueTypeListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[issueTypeListParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issueTypeList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                            "</issueTypeList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[issueTypeListParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)createIssueAssighToeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)assignToListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[assignToListParameters objectForKey:@"prjctId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<assignResFrIsses1 xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</assignResFrIsses1>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[assignToListParameters objectForKey:@"prjctId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)createIssueTeamSubmittedeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)teamSubmittedListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[teamSubmittedListParameters objectForKey:@"prjctId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<teamSubFrIsses xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</teamSubFrIsses>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[teamSubmittedListParameters objectForKey:@"prjctId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//
//-(void)createIssueSeveritySpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)severityListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[severityListParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issueBusinessPriorityList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</issueBusinessPriorityList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[severityListParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//
//-(void)saveIssue :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)saveIssueParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[saveIssueParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveAndUpdateIssues xmlns=\"http://tempuri.org/\">"
//                            "<issueNo>%@</issueNo>"
//                             "<issueStatus>%@</issueStatus>"
//                             "<description>%@</description>"
//                             "<businessPriorty>%@</businessPriorty>"
//                             "<issueType>%@</issueType>"
//                             "<projectId>%@</projectId>"
//                             "<teamImpact>%@</teamImpact>"
//                             "<resourceId>%@</resourceId>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//                             "<orgId>%@</orgId>"
//                             "<userId>%@</userId>"
//                             "<issueId>%@</issueId>"
//                             "<logDescription>%@</logDescription>"
//                             "</saveAndUpdateIssues>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[saveIssueParameters objectForKey:@"issueNo"],[saveIssueParameters objectForKey:@"issueStatus"],
//                             
//                             [saveIssueParameters objectForKey:@"description"],[saveIssueParameters objectForKey:@"businessPriorty"]
//                             
//                             ,[saveIssueParameters objectForKey:@"issueType"],[saveIssueParameters objectForKey:@"projectId"],
//                             [saveIssueParameters objectForKey:@"teamImpact"],[saveIssueParameters objectForKey:@"resourceId"],
//                             [saveIssueParameters objectForKey:@"saveUpdateType"],[saveIssueParameters objectForKey:@"orgId"],
//                             [saveIssueParameters objectForKey:@"userId"],[saveIssueParameters objectForKey:@"issueId"],
//                             [saveIssueParameters objectForKey:@"logDescription"]];
//    
//
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    for (id key in saveIssueParameters)
//    {
//        NSLog(@"key=%@ value=%@",key,[saveIssueParameters objectForKey:key] );
//    }
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)updateIssue :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)updateIssueParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the user id is %@ ",[updateIssueParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveAndUpdateIssues xmlns=\"http://tempuri.org/\">"
//                             "<issueNo>%@</issueNo>"
//                             "<issueStatus>%@</issueStatus>"
//                             "<description>%@</description>"
//                             "<businessPriorty>%@</businessPriorty>"
//                             "<issueType>%@</issueType>"
//                             "<projectId>%@</projectId>"
//                             "<teamImpact>%@</teamImpact>"
//                             "<resourceId>%@</resourceId>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//                             "<orgId>%@</orgId>"
//                             "<userId>%@</userId>"
//                             "<issueId>%@</issueId>"
//                             "<logDescription>%@</logDescription>"
//                             "</saveAndUpdateIssues>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[updateIssueParameters objectForKey:@"issueNo"],[updateIssueParameters objectForKey:@"issueStatus"],
//                             
//                             [updateIssueParameters objectForKey:@"description"],[updateIssueParameters objectForKey:@"businessPriorty"]
//                             
//                             ,[updateIssueParameters objectForKey:@"issueType"],[updateIssueParameters objectForKey:@"projectId"],
//                             [updateIssueParameters objectForKey:@"teamImpact"],[updateIssueParameters objectForKey:@"resourceId"],
//                             [updateIssueParameters objectForKey:@"saveUpdateType"],[updateIssueParameters objectForKey:@"orgId"],
//                             [updateIssueParameters objectForKey:@"userId"],[updateIssueParameters objectForKey:@"issueId"],
//                             [updateIssueParameters objectForKey:@"logDescription"]];
//    
//    
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    for (id key in updateIssueParameters)
//    {
//        NSLog(@"key=%@ value=%@",key,[updateIssueParameters objectForKey:key] );
//    }
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate serviceCal:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)SaveAttatchmentInIssue:(NSString *)SaveAttatchmentIssueClass SaveAttatchmentIssuesDictionary:(NSDictionary *)SaveATtatchmentsISsueParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:SaveAttatchmentIssueClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the user id is %@ ",[updateIssueParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveIssueAttachment xmlns=\"http://tempuri.org/\">"
//                             "<issueId>%@</issueId>"
//                             "<attachmentName>%@</attachmentName>"
//                             "<attachmentBytes>%@</attachmentBytes>"
//                             "</saveIssueAttachment>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[SaveATtatchmentsISsueParameters objectForKey:@"issueId"],[SaveATtatchmentsISsueParameters objectForKey:@"attachmentName"],[SaveATtatchmentsISsueParameters objectForKey:@"attachmentBytes"]];
//      NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//-(void)IssueAttatchmentsList:(NSString *)IssueAttatchmentsListClass IssueAttatchmentsListDictionary:(NSDictionary *)IssueAttatchmentsListDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:IssueAttatchmentsListClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the user id is %@ ",[updateIssueParameters objectForKey:@"orgId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issueAttachmentList xmlns=\"http://tempuri.org/\">"
//                             "<issueId>%@</issueId>"
//                             "</issueAttachmentList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[IssueAttatchmentsListDictionary objectForKey:@"issueId"]];
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//}
//
//
//
////Resolution screen
//-(void)resolutionAssignTo :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaAssignToParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the projectId  is %@ ",[resolutionaAssignToParameters objectForKey:@"projectId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<assignResFrIsses1 xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</assignResFrIsses1>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[resolutionaAssignToParameters objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//
//-(void)resolutionReleaseImpact :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaReleaseImpactParameters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the projectId  is %@ %@",[resolutionaReleaseImpactParameters objectForKey:@"orgId"],[resolutionaReleaseImpactParameters objectForKey:@"prjctId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<releseImpactList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</releseImpactList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[resolutionaReleaseImpactParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//
//-(void)resolutionRejectReason :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaRejectReasonParameters
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the projectId  is %@ %@",[resolutionaRejectReasonParameters objectForKey:@"orgId"],[resolutionaRejectReasonParameters objectForKey:@"prjctId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<rejctReasonList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</rejctReasonList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[resolutionaRejectReasonParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)resolutionResolutionType  :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionResolutionTypeParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the projectId  is %@ %@",[resolutionResolutionTypeParameters objectForKey:@"orgId"],[resolutionResolutionTypeParameters objectForKey:@"prjctId"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<resolutionTypeList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</resolutionTypeList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[resolutionResolutionTypeParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)resolutionUpdate  :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionUpdateParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Participantsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the projectId  is %@ %@",[resolutionUpdateParameters objectForKey:@"escalatedToResrc"],[resolutionUpdateParameters objectForKey:@"releaseImpact"]);
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<updateIssueResolution xmlns=\"http://tempuri.org/\">"
//                             "<escalatedToResrc>%@</escalatedToResrc>"
//                             "<releaseImpact>%@</releaseImpact>"
//                             "<dateResolutionNededBy>%@</dateResolutionNededBy>"
//                             "<rejctRsn>%@</rejctRsn>"
//                             "<resolutionTyp>%@</resolutionTyp>"
//                             "<dateRslvd>%@</dateRslvd>"
//                             "<dateClsd>%@</dateClsd>"
//                             "<resolutionDtls>%@</resolutionDtls>"
//                             "<issueId>%@</issueId>"
//                             "</updateIssueResolution>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[resolutionUpdateParameters objectForKey:@"escalatedToResrc"],[resolutionUpdateParameters objectForKey:@"releaseImpact"],[resolutionUpdateParameters objectForKey:@"dateResolutionNededBy"],
//                             
//                             [resolutionUpdateParameters objectForKey:@"rejctRsn"],
//                             [resolutionUpdateParameters objectForKey:@"resolutionTyp"],
//                             [resolutionUpdateParameters objectForKey:@"dateRslvd"],
//                             [resolutionUpdateParameters objectForKey:@"dateClsd"],
//                             [resolutionUpdateParameters objectForKey:@"resolutionDtls"],
//                             [resolutionUpdateParameters objectForKey:@"issueId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//
//-(void)MeetingInfourl:(NSString *)MeetingInfoDetails  MeetingDetails:(NSDictionary *)MeetingInfocredentilas
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:MeetingInfoDetails];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<meetingInfo xmlns=\"http://tempuri.org/\">"
//                             "<meetingId>%@</meetingId>"
//                             "</meetingInfo>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[MeetingInfocredentilas objectForKey:@"meetingId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
////----------------------------TaskListModule----------------------
//
//-(void)TasksHPListServiceurl:(NSString *)TaskListurl TaskListParameters:(NSDictionary *)TaskListCredentials
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"url is %@",ParentUrl);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<userTasksList xmlns=\"http://tempuri.org/\">"
//                             "<orgVp>%@</orgVp>"
//                             "<userId>%@</userId>"
//                             "<userType>%@</userType>"
//                             "</userTasksList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[TaskListCredentials objectForKey:@"orgVp"],[TaskListCredentials objectForKey:@"userId"],[TaskListCredentials objectForKey:@"userType"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"task list 9is %@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//// TAsk HolidaysList Service
//
////Task Save---------------------
//
//-(void)TaskCategorySpinnerListurl:(NSString *)categoryurl Taskcategorycredentials:(NSDictionary *)CategoryParametrs
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:categoryurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<taskCategoryList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</taskCategoryList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[CategoryParametrs objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //NSLog(@"task category%@", string);
//        
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//}
//
//-(void)TaskPrioritySpinnerurl:(NSString *)Priorityurl TaskPriorityparameters:(NSDictionary *)PriorityParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Priorityurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<taskPriorityList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</taskPriorityList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[PriorityParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//       // NSLog(@"priortiy %@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)TaskResourceurl:(NSString *)Resourceurl ResourceParameters:(NSDictionary *)ResourceParametrs
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:Resourceurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<resListFrProject xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</resListFrProject>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[ResourceParametrs objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//   // NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"resource %@", string);
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//   
//    [operation start];
//
//    
//}
//-(void)SaveNewTaskurl:(NSString *)NewTaskurl NewTaskSaveParameters:(NSDictionary *)SaveNewTaskCredentials
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:NewTaskurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//
//    NSString *soapMessage = [NSString stringWithFormat:
//                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                              "<soap:Body>"
//                              "<saveOrUpdateTask xmlns=\"http://tempuri.org/\">"
//                              "<orgId>%@</orgId>"
//                              "<taskcat>%@</taskcat>"
//                              "<tskPriority>%@</tskPriority>"
//                              "<taskDescription>%@</taskDescription>"
//                              "<taskEffort>%@</taskEffort>"
//                              "<plStartDate>%@</plStartDate>"
//                              "<plEndDate>%@</plEndDate>"
//                              "<tskAssinTo>%@</tskAssinTo>"
//                              "<tskAssinBy>%@</tskAssinBy>"
//                              "<projectId>%@</projectId>"
//                              "<taskId>%@</taskId>"
//                              "<saveUpdateType>%@</saveUpdateType>"
//                             "<hardDependcyId>%@</hardDependcyId>"
//                             "<hourPerDay>%@</hourPerDay>"
//                              "</saveOrUpdateTask>"
//                              "</soap:Body>"
//                             "</soap:Envelope>",[SaveNewTaskCredentials objectForKey:@"orgId"],[SaveNewTaskCredentials objectForKey:@"taskcat"],[SaveNewTaskCredentials objectForKey:@"tskPriority"],[SaveNewTaskCredentials objectForKey:@"taskDescription"],[SaveNewTaskCredentials objectForKey:@"taskEffort"],[SaveNewTaskCredentials objectForKey:@"plStartDate"],[SaveNewTaskCredentials objectForKey:@"plEndDate"],[SaveNewTaskCredentials objectForKey:@"tskAssinTo"],[SaveNewTaskCredentials objectForKey:@"tskAssinBy"],[SaveNewTaskCredentials objectForKey:@"projectId"],[SaveNewTaskCredentials objectForKey:@"taskId"],[SaveNewTaskCredentials objectForKey:@"saveUpdateType"],[SaveNewTaskCredentials objectForKey:@"hardDependcyId"],[SaveNewTaskCredentials objectForKey:@"hourPerDay"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    // NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//       NSLog(@"resource %@", string);
//        
//        [delegate serviceCal:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//-(void)UploadTask:(NSString *)UploadTaskurl
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:UploadTaskurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"url is %@",ParentUrl);
//    //NSLog(@"task id is %@",)
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<emptyMethodCheck xmlns=\"http://tempuri.org/\">"
//                             "</emptyMethodCheck>"
//                             "</soap:Body>"
//                             "</soap:Envelope>"];
//        
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    
//    [theRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/fileTask" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"one",@"2",@"two",@"3",@"theree",@"4",@"four",@"5",@"Five",nil];
//    
//    
//    //    for(int i=0;i<[uploadTaskDetails count];i++)
//    //    {
//    //        NSLog(@"key=%@",[uploadTaskDetails objectForKey:i]);
//    //    }
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@","];
//        NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        // NSLog(@"resource %@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//}
//
//-(void)UploadTask:(NSString *)UploadTaskurl UploadTaskParameters:(NSDictionary *)UploadTaskDetails
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:UploadTaskurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"url is %@",ParentUrl);
//    //NSLog(@"task id is %@",)
////    NSString *soapMessage = [NSString stringWithFormat:
////                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
////                             "<soap:Body>"
////                             "<checkingServiceIOS xmlns=\"http://tempuri.org/\">"
////                             "<namey>%@</namey>"
////                             "</checkingServiceIOS>"
////                             "</soap:Body>"
////                             "</soap:Envelope>",[UploadTaskDetails objectForKey:@"namey"]];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<uploadFileFrTask xmlns=\"http://tempuri.org/\">"
//                             "<taskId>%@</taskId>"
//                             "<fileType>%@</fileType>"
//                             "<date>%@</date>"
//                             "<fileName>%@</fileName>"
//                             "<fileBytes>%@</fileBytes>"
//                             "<byteLenth>%@</byteLenth>"
//                             "<taskHistory>%@</taskHistory>"
//                             "</uploadFileFrTask>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[UploadTaskDetails objectForKey:@"taskId"],[UploadTaskDetails objectForKey:@"fileType"],[UploadTaskDetails objectForKey:@"date"],[UploadTaskDetails objectForKey:@"fileName"],[UploadTaskDetails objectForKey:@"fileBytes"],[UploadTaskDetails objectForKey:@"byteLenth"],[UploadTaskDetails objectForKey:@"taskHistory"]];
////    NSString *soapMessage = [NSString stringWithFormat:
////                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
////                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
////                             "<soap:Body>"
////                             "<fileTask xmlns=\"http://tempuri.org/\">"
////                             "<taskId>%@</taskId>"
////                             "<fileType>%@</fileType>"
////                             "<date>%@</date>"
////                             "<fileName>%@</fileName>"
////                             "<fileBytes>%@</fileBytes>"
////                             "<byteLenth>%@</byteLenth>"
////                             "<taskHistory>%@</taskHistory>"
////                             "</fileTask>"
////                             "</soap:Body>"
////                             "</soap:Envelope>",[UploadTaskDetails objectForKey:@"taskId"],[UploadTaskDetails objectForKey:@"fileType"],[UploadTaskDetails objectForKey:@"date"],[UploadTaskDetails objectForKey:@"fileName"],[UploadTaskDetails objectForKey:@"fileBytes"],[UploadTaskDetails objectForKey:@"byteLenth"],[UploadTaskDetails objectForKey:@"taskHistory"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//
//    [theRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/fileTask" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
////    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"one",@"2",@"two",@"3",@"theree",@"4",@"four",@"5",@"Five",nil];
//    
//    
////    for(int i=0;i<[uploadTaskDetails count];i++)
////    {
////        NSLog(@"key=%@",[uploadTaskDetails objectForKey:i]);
////    }
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@","];
//        NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        // NSLog(@"resource %@", string);
//        
//        [delegate didFinishData:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//    
//    
//}
//-(void)TaskFileListurl:(NSString *)TaskFileListurl TaskFileListParameters:(NSDictionary *)TaskFileCredentials
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskFileListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<tasksFileTypes xmlns=\"http://tempuri.org/\">"
//                             "<taskId>%@</taskId>"
//                             "<fileType>%@</fileType>"
//                             "</tasksFileTypes>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[TaskFileCredentials objectForKey:@"taskId"],[TaskFileCredentials objectForKey:@"fileType"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//       
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@","];
//        NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        [delegate serviceCal:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//    
//
//}
//-(void)HardDependency :(NSString *)HardDependencyClass HardDependencyParameters :(NSDictionary *)HardDependencyParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:HardDependencyClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<hardDependencyList xmlns=\"http://tempuri.org/\">"
//                             "<projId>%@</projId>"
//                             "<taskId>%@</taskId>"
//                             "</hardDependencyList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[HardDependencyParameters objectForKey:@"projId"],[HardDependencyParameters objectForKey:@"taskId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@","];
//        NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [delegate ServiceCalls1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    [operation start];
//}
//
//-(void)Downloads:(NSString *)Downloadsurl Downloadparameters:(NSDictionary *)DownloadListCredentilas
////-(void)Downloads:(NSString *)Downloadsurl Downloadparameters:(NSDictionary *)DownloadListCredentilas active:(UIProgressView *)progressView
//{
//    //progressView.frame = CGRectMake(400,100,30,50);
//   // progressView.progress = 0.0;
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:Downloadsurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getTaskDownloadUrl xmlns=\"http://tempuri.org/\">"
//                             "<taskUpdatedId>%@</taskUpdatedId>"
//                             "<fileType>%@</fileType>"
//                             "</getTaskDownloadUrl>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[DownloadListCredentilas objectForKey:@"taskUpdatedId"],[DownloadListCredentilas objectForKey:@"fileType"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",[DownloadListCredentilas objectForKey:@"taskUpdatedId"]);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//   
//    
//    
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
//        //NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    
//    
//    
////    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//    
//        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            if (totalBytesExpectedToRead > 0) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //progressView.alpha = 1;
//                  //progressView.progress = (float)totalBytesRead / (float)totalBytesExpectedToRead;
//                   NSLog(@"floa t is %lld   %lld",totalBytesRead,totalBytesExpectedToRead);
//                    //[progressView setTrackTintColor:[UIColor blueColor]];
//                    NSString *label = [NSString stringWithFormat:@"Downloaded %lld of %lld bytes",
//                                       totalBytesRead,
//                                       totalBytesExpectedToRead];
//                    //progressLabel.text = label;
//                });
//            }
//        }];
//    
//    [operation start];
//        
//        // NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
////        float start = (float)totalBytesRead / totalBytesExpectedToRead;
////        NSLog(@"floa t is %lld   %lld",totalBytesRead,totalBytesExpectedToRead);
////
////        progressView.progress= 0.5;
////
////        [progressView setProgressTintColor:[UIColor redColor]];
////                //totalBytesWritten / (float)totalBytesExpectedToWrite;
////        // [progressView setUserInteractionEnabled:NO];
////        
////        // progressView.progress=0.5f;
////        
////        [progressView setProgressViewStyle:UIProgressViewStyleBar];
////        
////        [progressView setTrackTintColor:[UIColor blueColor]];
////        
////        
////        // [progressView setTrackImage:[UIImage    imageNamed:@"logo.png"]];
////        
////        //[self.view addSubview:progressView];
////        
////        //[delegate Downloading:progress];
////        
////    }];
//    
//}
////Task Holidays Calander
//
//-(void)HolidaysList:(NSString *)HolidaysListClassDetails HolidaysListParametersDetails:(NSDictionary *)HoldiaysListDetails
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:HolidaysListClassDetails];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<holidaysList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</holidaysList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[HoldiaysListDetails objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is 123456 %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@","];
//        NSLog(@"resource %@", string);
//        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        [delegate didFinishService:responseObject];
//        
//        
//     }
//     
//     failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//                                         NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//                                     }];
//    [operation start];
//
//}
//
////holidays service for task
//-(void)HolidaysListForTask:(NSString *)HolidysListClass HolidaysListParameters:(NSDictionary *)HolidaysListDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:HolidysListClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<taskPlannedEnDate xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "<planedStartDate>%@</planedStartDate>"
//                             "<effortDays>%@</effortDays>"
//                             "</taskPlannedEnDate>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[HolidaysListDictionary objectForKey:@"orgId"],[HolidaysListDictionary objectForKey:@"planedStartDate"],[HolidaysListDictionary objectForKey:@"effortDays"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSLog(@"the service data is %@", string);
//         
//         //        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@""];
//         //
//         //        string = [string stringByReplacingOccurrencesOfString:@"&lt;p style=&quot;padding-left: 30px; text-align: justify;&quot;&gt;" withString:@""];
//         //        string = [string stringByReplacingOccurrencesOfString:@"&lt;/p&gt;" withString:@""];
//         //        string = [string stringByReplacingOccurrencesOfString:@".;" withString:@""];
//         //
//         //        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//         
//         [delegate didfinishactionitemlist:responseObject];
//        // NSLog(@"THE ISSUE LIST IS  %@", string);
//         
//         
//     }
//     
//     
//                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                         NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//                                     }];
//    [operation start];
//    
//
//    
//}
//
////----------------------Requirement Module------------------------------------
//
//-(void)reqList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<reqGatheringList xmlns=\"http://tempuri.org/\">"
//                             "<orgVp>%@</orgVp>"
//                             "<userId>%@</userId>"
//                             "<userType>%@</userType>"
//                             "</reqGatheringList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqListParameters objectForKey:@"orgVp"],[reqListParameters objectForKey:@"userId"],[reqListParameters objectForKey:@"userType"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"the service data is %@", string);
//        
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;br&gt;" withString:@""];
////        
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;p style=&quot;padding-left: 30px; text-align: justify;&quot;&gt;" withString:@""];
////        string = [string stringByReplacingOccurrencesOfString:@"&lt;/p&gt;" withString:@""];
////        string = [string stringByReplacingOccurrencesOfString:@".;" withString:@""];
////
////        responseObject = [string dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [delegate didfinishactionitemlist:responseObject];
//        NSLog(@"THE ISSUE LIST IS  %@", string);
//
//        
//    }
//     
//     
//        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//}
//
//-(void)reqProjectSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqProjectSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projLstForReqGath xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</projLstForReqGath>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqProjectSpinnerParameters objectForKey:@"usertype"],[reqProjectSpinnerParameters objectForKey:@"userId"],[reqProjectSpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//                
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqContactSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqContactpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<reqGathContactList xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</reqGathContactList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqContactpinnerParameters objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqCoreProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCoreProcessSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<coreProcessList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</coreProcessList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqCoreProcessSpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        [delegate didNotesCountFinished:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//-(void)reqProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqProcessSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<processList xmlns=\"http://tempuri.org/\">"
//                             "<coreProcessId>%@</coreProcessId>"
//                             "</processList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqProcessSpinnerParameters objectForKey:@"coreProcessId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//
//
//-(void)reqSubProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqSubProcessSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<subProcessList xmlns=\"http://tempuri.org/\">"
//                             "<processId>%@</processId>"
//                             "</subProcessList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqSubProcessSpinnerParameters objectForKey:@"processId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqActivitySpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqActivitySpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<activityList xmlns=\"http://tempuri.org/\">"
//                             "<subProcessId>%@</subProcessId>"
//                             "</activityList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqActivitySpinnerParameters objectForKey:@"subProcessId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishData:responseObject];
//        
//       
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqTypeSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqTypeSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getReqTypesList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getReqTypesList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqTypeSpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didEndTask:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqCriticality1Spinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCriticality1SpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getCriticalityList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getCriticalityList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqCriticality1SpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//       
//
//        
//        [delegate serviceCal:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)reqCriticality2Spinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCriticality2SpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getSystemList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getSystemList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[reqCriticality2SpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Servicecal1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)saveRequirement :(NSString *)TaskListurl
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<shaikMethod xmlns=\"http://tempuri.org/\">"
//                             "</shaikMethod>"
//                             "</soap:Body>"
//                             "</soap:Envelope>"];
//    
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate ServiceCalls:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//
//-(void)saveRequirement :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)saveRequirementParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
////
////    NSString *soapMessage = [NSString stringWithFormat:
////                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
////                             "<soap:Body>"
////                             "<saveOrUpdateReqGather xmlns=\"http://tempuri.org/\">"
////                             "<objectType>%@</objectType>"
////                             "<objectName>%@</objectName>"
////                             "<complexity>%@</complexity>"
////                             "<purpose>%@</purpose>"
////                             "<existingNew>%@</existingNew>"
////                             "<approval>%@</approval>"
////                             "<resourceName>%@</resourceName>"
////                             "<comments>%@</comments>"
////                             "<asisReqId>%@</asisReqId>"
////                             "<isTaskCompl>%@</isTaskCompl>"
////                             "<reqObjId>%@</reqObjId>"
////                             "<saveUpdateType>%@</saveUpdateType>"
////                             "</saveOrUpdateReqGather>"
////                             "</soap:Body>"
////                             "</soap:Envelope>",[saveRequirementParameters objectForKey:@"objectType"],
////                             [saveRequirementParameters objectForKey:@"objectName"],
////                             [saveRequirementParameters objectForKey:@"complexity"],
////                             [saveRequirementParameters objectForKey:@"purpose"],
////                             [saveRequirementParameters objectForKey:@"existingNew"],
////                             [saveRequirementParameters objectForKey:@"approval"],
////                             [saveRequirementParameters objectForKey:@"resourceName"],
////                             [saveRequirementParameters objectForKey:@"comments"],
////                             [saveRequirementParameters objectForKey:@"asisReqId"],
////                             [saveRequirementParameters objectForKey:@"isTaskCompl"],
////                             [saveRequirementParameters objectForKey:@"reqObjId"],
////                             [saveRequirementParameters objectForKey:@"saveUpdateType"]];
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveOrUpdateReqGather xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "<resourceId>%@</resourceId>"
//                             "<coreProcessId>%@</coreProcessId>"
//                             "<processId>%@</processId>"
//                             "<subProcessId>%@</subProcessId>"
//                             "<activityId>%@</activityId>"
//                             "<description>%@</description>"
//                             "<history>%@</history>"
//                             "<reqType>%@</reqType>"
//                             "<criticality>%@</criticality>"
//                             "<system>%@</system>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//                             "<asisReqId>%@</asisReqId>"
//                             "<userId>%@</userId>"
//                             "<requirementName>%@</requirementName>"
//                             "</saveOrUpdateReqGather>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[saveRequirementParameters objectForKey:@"projectId"],
//                             [saveRequirementParameters objectForKey:@"resourceId"],
//                             [saveRequirementParameters objectForKey:@"coreProcessId"],
//                             [saveRequirementParameters objectForKey:@"processId"],
//                             [saveRequirementParameters objectForKey:@"subProcessId"],
//                             [saveRequirementParameters objectForKey:@"activityId"],
//                             [saveRequirementParameters objectForKey:@"description"],
//                             [saveRequirementParameters objectForKey:@"history"],
//                             [saveRequirementParameters objectForKey:@"reqType"],
//                              [saveRequirementParameters objectForKey:@"criticality"],
//                              [saveRequirementParameters objectForKey:@"system"],
//                              [saveRequirementParameters objectForKey:@"saveUpdateType"],
//                              [saveRequirementParameters objectForKey:@"asisReqId"],
//                             [saveRequirementParameters objectForKey:@"userId"],[saveRequirementParameters objectForKey:@"requirementName"]];
//    
//
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate ServiceCalls:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//
//-(void)updateRequirement :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)updateRequirementParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveOrUpdateReqGather xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "<resourceId>%@</resourceId>"
//                             "<coreProcessId>%@</coreProcessId>"
//                             "<processId>%@</processId>"
//                             "<subProcessId>%@</subProcessId>"
//                             "<activityId>%@</activityId>"
//                             "<description>%@</description>"
//                             "<history>%@</history>"
//                             "<reqType>%@</reqType>"
//                             "<criticality>%@</criticality>"
//                             "<system>%@</system>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//                             "<asisReqId>%@</asisReqId>"
//                             "<userId>%@</userId>"
//                             "<requirementName>%@</requirementName>"
//                             "</saveOrUpdateReqGather>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[updateRequirementParameters objectForKey:@"projectId"],
//                             [updateRequirementParameters objectForKey:@"resourceId"],
//                             [updateRequirementParameters objectForKey:@"coreProcessId"],
//                             [updateRequirementParameters objectForKey:@"processId"],
//                             [updateRequirementParameters objectForKey:@"subProcessId"],
//                             [updateRequirementParameters objectForKey:@"activityId"],
//                             [updateRequirementParameters objectForKey:@"description"],
//                             [updateRequirementParameters objectForKey:@"history"],
//                             [updateRequirementParameters objectForKey:@"reqType"],
//                             [updateRequirementParameters objectForKey:@"criticality"],
//                             [updateRequirementParameters objectForKey:@"system"],
//                             [updateRequirementParameters objectForKey:@"saveUpdateType"],
//                             [updateRequirementParameters objectForKey:@"asisReqId"],[updateRequirementParameters objectForKey:@"userId"],[updateRequirementParameters objectForKey:@"requirementName"]];
//    
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate ServiceCalls1:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
////object Requirement
//-(void)requirementObjectLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementObjectLstParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getObjectList xmlns=\"http://tempuri.org/\">"
//                             "<assignReqId>%@</assignReqId>"
//                             "</getObjectList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[requirementObjectLstParameters objectForKey:@"assignReqId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)requirementObjectSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementObjectSpinnerLstParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getObjectTypeList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getObjectTypeList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[requirementObjectSpinnerLstParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)requirementPurposeSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementPurposeSpinnerLstParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getPurposeList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getPurposeList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[requirementPurposeSpinnerLstParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
////-(void)requirementResourceSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementResourceSpinnerLstParameters
////{
////    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
////    [BaseURL appendString:TaskListurl];
////    NSURL *url = [NSURL URLWithString:BaseURL];
////    
////    
////    NSString *soapMessage = [NSString stringWithFormat:
////                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
////                             "<soap:Body>"
////                             "<getOrgResourceList xmlns=\"http://tempuri.org/\">"
////                             "<orgId>%@</orgId>"
////                             "</getOrgResourceList>"
////                             "</soap:Body>"
////                             "</soap:Envelope>",[requirementResourceSpinnerLstParameters objectForKey:@"orgId"]];
////    
////    
////    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
////    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
////    NSLog(@"length is %@",msgLength);
////    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
////    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
////    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
////    [theRequest setHTTPMethod:@"POST"];
////    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
////    
////    
////    
////    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
////    
////    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
////        NSLog(@"%@", string);
////        
////        
////        
////        [delegate Serviceactiondone:responseObject];
////        
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
////    }];
////    [operation start];
////
////}
////
//-(void)requirementComplexitySpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementComplexitySpinnerLstParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getComplexityList xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getComplexityList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",[requirementComplexitySpinnerLstParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//
//
//-(void)saveRequirementObject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)saveRequirementObjectParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveOrUpdateObject xmlns=\"http://tempuri.org/\">"
//                             
//                             "<objectType>%@</objectType>"
//                             "<objectName>%@</objectName>"
//                             "<complexity>%@</complexity>"
//                             "<purpose>%@</purpose>"
//                             "<existingNew>%@</existingNew>"
//                             "<approval>%@</approval>"
//                             "<resourceName>%@</resourceName>"
//                             "<comments>%@</comments>"
//                             "<asisReqId>%@</asisReqId>"
//                             "<isTaskCompl>%@</isTaskCompl>"
//                             "<reqObjId>%@</reqObjId>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//
//                             "</saveOrUpdateObject>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [saveRequirementObjectParameters objectForKey:@"objectType"],
//                             [saveRequirementObjectParameters objectForKey:@"objectName"],
//                             [saveRequirementObjectParameters objectForKey:@"complexity"],
//                             [saveRequirementObjectParameters objectForKey:@"purpose"],
//                             [saveRequirementObjectParameters objectForKey:@"existingNew"],
//                             [saveRequirementObjectParameters objectForKey:@"approval"],
//                             [saveRequirementObjectParameters objectForKey:@"resourceName"],
//                             [saveRequirementObjectParameters objectForKey:@"comments"],
//                             [saveRequirementObjectParameters objectForKey:@"asisReqId"],
//                             [saveRequirementObjectParameters objectForKey:@"isTaskCompl"],
//                             [saveRequirementObjectParameters objectForKey:@"reqObjId"],
//                             [saveRequirementObjectParameters objectForKey:@"saveUpdateType"]];
//    
//
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishData:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)updateRequirementObject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)updateRequirementObjectParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveOrUpdateObject xmlns=\"http://tempuri.org/\">"
//                             
//                             "<objectType>%@</objectType>"
//                             "<objectName>%@</objectName>"
//                             "<complexity>%@</complexity>"
//                             "<purpose>%@</purpose>"
//                             "<existingNew>%@</existingNew>"
//                             "<approval>%@</approval>"
//                             "<resourceName>%@</resourceName>"
//                             "<comments>%@</comments>"
//                             "<asisReqId>%@</asisReqId>"
//                             "<isTaskCompl>%@</isTaskCompl>"
//                             "<reqObjId>%@</reqObjId>"
//                             "<saveUpdateType>%@</saveUpdateType>"
//                             
//                             "</saveOrUpdateObject>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [updateRequirementObjectParameters objectForKey:@"objectType"],
//                             [updateRequirementObjectParameters objectForKey:@"objectName"],
//                             [updateRequirementObjectParameters objectForKey:@"complexity"],
//                             [updateRequirementObjectParameters objectForKey:@"purpose"],
//                             [updateRequirementObjectParameters objectForKey:@"existingNew"],
//                             [updateRequirementObjectParameters objectForKey:@"approval"],
//                             [updateRequirementObjectParameters objectForKey:@"resourceName"],
//                             [updateRequirementObjectParameters objectForKey:@"comments"],
//                             [updateRequirementObjectParameters objectForKey:@"asisReqId"],
//                             [updateRequirementObjectParameters objectForKey:@"isTaskCompl"],
//                             [updateRequirementObjectParameters objectForKey:@"reqObjId"],
//                             [updateRequirementObjectParameters objectForKey:@"saveUpdateType"]];
//    
//    
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didEndTask:responseObject];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//}
//
////-------project expances ------------//
//
//-(void)projectExpencesListSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpencesListSpinnerParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the %@ %@ %@",[projectExpencesListSpinnerParameters objectForKey:@"usertype"],
//          [projectExpencesListSpinnerParameters objectForKey:@"userId"],
//          [projectExpencesListSpinnerParameters objectForKey:@"orgId"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projLstForReqGath xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</projLstForReqGath>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [projectExpencesListSpinnerParameters objectForKey:@"usertype"],
//                             [projectExpencesListSpinnerParameters objectForKey:@"userId"],
//                             [projectExpencesListSpinnerParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//
//
//-(void)projectExpencesList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpencesListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<expenses xmlns=\"http://tempuri.org/\">"
//                             "<projId>%@</projId>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "<userType>%@</userType>"
//                             "</expenses>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [projectExpencesListParameters objectForKey:@"projId"],[projectExpencesListParameters objectForKey:@"userId"],[projectExpencesListParameters objectForKey:@"orgId"],[projectExpencesListParameters objectForKey:@"userType"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
////create project Expences
//-(void)createprojectExpencesCategorySpinnerList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)createprojectExpencesCategorySpinnerListParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<category xmlns=\"http://tempuri.org/\">"
//                             "<projectId>%@</projectId>"
//                             "</category>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [createprojectExpencesCategorySpinnerListParameters objectForKey:@"projectId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)expansesSave :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)expansesSaveParameters
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    NSString *soapMessage =[NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveExp xmlns=\"http://tempuri.org/\">"
//                             "<date>%@</date>"
//                             "<amount>%@</amount>"
//                             "<budgtCatgry>%@</budgtCatgry>"
//                             "<projId>%@</projId>"
//                             "</saveExp>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [expansesSaveParameters objectForKey:@"date"],
//                             [expansesSaveParameters objectForKey:@"amount"],
//                             [expansesSaveParameters objectForKey:@"budgtCatgry"],
//                             [expansesSaveParameters objectForKey:@"projId"]];
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//   
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@" the result is %@",string);
//        
//        
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)expansesUpdate :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)expansesUpdateParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<updateExp xmlns=\"http://tempuri.org/\">"
//                             "<proj_amnt_Id>%@</proj_amnt_Id>"
//                             "<date>%@</date>"
//                             "<amount>%@</amount>"
//                             "<budgtCatgry>%@</budgtCatgry>"
//                             "<projId>%@</projId>"
//                             "</updateExp>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [expansesUpdateParameters objectForKey:@"proj_amnt_Id"],
//                             [expansesUpdateParameters objectForKey:@"date"],
//                             [expansesUpdateParameters objectForKey:@"amount"],
//                             [expansesUpdateParameters objectForKey:@"budgtCatgry"],
//                             [expansesUpdateParameters objectForKey:@"projId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)DownloadFile:(NSString *)DownloadFileUrlString DownloadFileParameters:(NSDictionary *)DownloadFileUrlParameters
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:DownloadFileUrlString];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getAttachmentUrl xmlns=\"http://tempuri.org/\">"
//                             "<exp_attach_Id>%@</exp_attach_Id>"
//                             "<proj_amnt_Id>%@</proj_amnt_Id>"
//                             "</getAttachmentUrl>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [DownloadFileUrlParameters objectForKey:@"exp_attach_Id"],
//                             [DownloadFileUrlParameters objectForKey:@"proj_amnt_Id"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//
//}
//-(void)saveAttatchmentInProjectExpenses:(NSString *)saveAttatchmentProjectExpensesClassString saveAttatchmentProjectExpensesParameters:(NSDictionary *)saveAttatchmentProjectExpensesDictionary
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:saveAttatchmentProjectExpensesClassString];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<saveProjExpensesAttachment xmlns=\"http://tempuri.org/\">"
//                             "<projExpenseId>%@</projExpenseId>"
//                             "<fileName>%@</fileName>"
//                             "<fileBytes>%@</fileBytes>"
//                             "</saveProjExpensesAttachment>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [saveAttatchmentProjectExpensesDictionary objectForKey:@"projExpenseId"],
//                             [saveAttatchmentProjectExpensesDictionary objectForKey:@"fileName"],[saveAttatchmentProjectExpensesDictionary objectForKey:@"fileBytes"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//    
//}
//-(void)projectExpensesAttatchmentList:(NSString *)projectExpensesAttatchmentClass projectExpensesAttatchmentDictionary:(NSDictionary *)projectExpensesListParameters
//{
//    BaseURL = [[NSMutableString alloc]initWithString:ParentUrl];
//    [BaseURL appendString:projectExpensesAttatchmentClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectAttachmentList xmlns=\"http://tempuri.org/\">"
//                             "<projExpenseId>%@</projExpenseId>"
//                             "</projectAttachmentList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [projectExpensesListParameters objectForKey:@"projExpenseId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//
//    
//}
//
////-------------Dash Board-----------------//
//-(void)organizationReportGraph :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)organizationReportGraphParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<orgResourceRep xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</orgResourceRep>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [organizationReportGraphParameters objectForKey:@"usertype"],
//                             [organizationReportGraphParameters objectForKey:@"userId"],
//                             [organizationReportGraphParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)peopleBySkillsReport :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)peopleBySkillsReportParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<peopleBySkillReprt xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</peopleBySkillReprt>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [peopleBySkillsReportParameters objectForKey:@"usertype"],
//                             [peopleBySkillsReportParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didfinishactionitemlist:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)noOfProjectsReports :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)noOfProjectsReportsParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<noOfProjsByResReprt xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</noOfProjsByResReprt>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [noOfProjectsReportsParameters objectForKey:@"usertype"],
//                             [noOfProjectsReportsParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didNotesCountFinished:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)avgBlgRateByOrganization :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)avgBlgRateByOrganizationParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<avgBilngRateByOrg xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</avgBilngRateByOrg>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [avgBlgRateByOrganizationParameters objectForKey:@"usertype"],
//                             [avgBlgRateByOrganizationParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)noOfResourcesByPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)noOfResourcesByPrgrmParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<noOfResByPrograms xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "<userId>%@</userId>"
//                             "</noOfResByPrograms>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [noOfResourcesByPrgrmParameters objectForKey:@"usertype"],
//                             [noOfResourcesByPrgrmParameters objectForKey:@"orgId"],[noOfResourcesByPrgrmParameters objectForKey:@"userId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//}
//
//-(void)allocataedCapacityToPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)allocataedCapacityToPrgrmParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<alctedCapToProgrm xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</alctedCapToProgrm>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [allocataedCapacityToPrgrmParameters objectForKey:@"usertype"],
//                             [allocataedCapacityToPrgrmParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishData:responseObject];
//        
//        
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)allocatedCapacityToProject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)allocatedCapacityToProjectParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<alctedCapToProj xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</alctedCapToProj>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [allocatedCapacityToProjectParameters objectForKey:@"usertype"],
//                             [allocatedCapacityToProjectParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didEndTask:responseObject];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)assignedCapacityToProgram :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)assignedCapacityToProgramParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<asgnedCapToProgram xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</asgnedCapToProgram>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [assignedCapacityToProgramParameters objectForKey:@"usertype"],
//                             [assignedCapacityToProgramParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate serviceCal:responseObject];
//        
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)assignedCapacityToProject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)assignedCapacityToProjectParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<asgnedCapToProj xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</asgnedCapToProj>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [assignedCapacityToProjectParameters objectForKey:@"usertype"],
//                             [assignedCapacityToProjectParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Servicecal1:responseObject];
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//
//-(void)avgCostOfReourceByPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)avgCostOfReourceByPrgrmParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getAvgCstResProgrm xmlns=\"http://tempuri.org/\">"
//                             "<usertype>%@</usertype>"
//                             "<orgId>%@</orgId>"
//                             "</getAvgCstResProgrm>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [avgCostOfReourceByPrgrmParameters objectForKey:@"usertype"],
//                             [avgCostOfReourceByPrgrmParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate ServiceCalls:responseObject];
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//}
//-(void)TaskOVerView:(NSString *)TaskOverViewClass TaskOVerViewListParameters:(NSDictionary *)TaskOverViewDataParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskOverViewClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the parameter string is %@ %@ %@",[TaskOverViewDataParameters objectForKey:@"userType"],[TaskOverViewDataParameters objectForKey:@"userId"],[TaskOverViewDataParameters objectForKey:@"orgId"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getTaskOverviewList xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</getTaskOverviewList>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [TaskOverViewDataParameters objectForKey:@"userType"],
//                             [TaskOverViewDataParameters objectForKey:@"userId"],[TaskOverViewDataParameters objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        //-(void)Serviceactiondone1 : (id)result;
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//}
//-(void)ProjectCostDetails:(NSString *)ProjectCostDetailsClass ProjectCostParameters:(NSDictionary *)ProjectCostDetailsDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ProjectCostDetailsClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the parameter string is %@",[ProjectCostDetailsDictionary objectForKey:@"orgId"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getEachProgramBudgs xmlns=\"http://tempuri.org/\">"
//                             "<orgId>%@</orgId>"
//                             "</getEachProgramBudgs>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [ProjectCostDetailsDictionary objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        //-(void)Serviceactiondone1 : (id)result;
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//}
//-(void)ProgramList:(NSString *)ProgramListClass ProgramListParameters:(NSDictionary *)ProgramListDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ProgramListClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the parameter string is %@",[ProgramListDictionary objectForKey:@"orgId"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getPrjBudCstLst xmlns=\"http://tempuri.org/\">"
//                             "<programId>%@</programId>"
//                             "</getPrjBudCstLst>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [ProgramListDictionary objectForKey:@"programId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//        
//        //-(void)Serviceactiondone1 : (id)result;
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//    
//    
//}
//
//
////Programs Under Each Owner
//
//-(void)prgrmByOwnerReports :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)prgrmByOwnerReportsParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getNoOfPrgmsForOwner xmlns=\"http://tempuri.org/\">"
//                             "<OrgId>%@</OrgId>"
//                             "</getNoOfPrgmsForOwner>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [prgrmByOwnerReportsParameters objectForKey:@"OrgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate didFinishService:responseObject];
//
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)prgrmByOwnerDetails :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)prgrmByOwnerDetailsParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the parameter string is %@",[prgrmByOwnerDetailsParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getOwnerResDetsChart xmlns=\"http://tempuri.org/\">"
//                             "<programOwner>%@</programOwner>"
//                             "</getOwnerResDetsChart>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [prgrmByOwnerDetailsParameters objectForKey:@"programOwner"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate ServiceCalls1:responseObject];
//
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//
//-(void)projectExpancesBytesService :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpancesBytesServiceParameters
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskListurl];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<getBytes xmlns=\"http://tempuri.org/\">"
//                             "<exp_attach_Id>%@</exp_attach_Id>"
//                             "<proj_amnt_Id>%@</proj_amnt_Id>"
//                             "</getBytes>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [projectExpancesBytesServiceParameters objectForKey:@"exp_attach_Id"],
//                             [projectExpancesBytesServiceParameters objectForKey:@"proj_amnt_Id"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@" the result is%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        //-(void)Serviceactiondone1 : (id)result;
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//
//}
//-(void)OVerViewEffortAndBookedTime:(NSString *)OverViewEffortAndBookedTimeClass OverViewBookedAndTimeParameters:(NSDictionary *)OverViewEffortAndBookedTimeDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:OverViewEffortAndBookedTimeClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<effortAndBookedTimeOvervieGraph xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</effortAndBookedTimeOvervieGraph>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [OverViewEffortAndBookedTimeDictionary objectForKey:@"userType"],
//                             [OverViewEffortAndBookedTimeDictionary objectForKey:@"userId"],[OverViewEffortAndBookedTimeDictionary objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//        //-(void)Serviceactiondone1 : (id)result;
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//
//}
//-(void)taskOverViewGraph:(NSString *)TaskOverViewGraphClass TaskOverViewGraphParameters:(NSDictionary *)TaskOverViewGraphDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TaskOverViewGraphClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<taskOverviewChart xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</taskOverviewChart>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [TaskOverViewGraphDictionary objectForKey:@"userType"],
//                             [TaskOverViewGraphDictionary objectForKey:@"userId"],[TaskOverViewGraphDictionary objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", string);
//        
//        
//        
//        [delegate Serviceactiondone1:responseObject];
//        
//         
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//    }];
//    [operation start];
//    
//
//}
//-(void)issuesOverViewChart:(NSString *)issueOVerViewClass IssueOverviewParameters:(NSDictionary *)IssuesOverViewDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:issueOVerViewClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<issusOverviewChart xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<userId>%@</userId>"
//                             "<orgId>%@</orgId>"
//                             "</issusOverviewChart>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [IssuesOverViewDictionary objectForKey:@"userType"],
//                    [IssuesOverViewDictionary objectForKey:@"userId"],[IssuesOverViewDictionary objectForKey:@"orgId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSLog(@"%@", string);
//         
//         
//         
//         [delegate Serviceactiondone1:responseObject];
//         
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//     }];
//    [operation start];
//    
//    
//}
//-(void)TeamResourcesForAdmin :(NSString *)TeamResourceForAdminClass TeamResourceForAdminParameters:(NSDictionary *)TeamResourcesForAdminDictionary
//{
//    
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:TeamResourceForAdminClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<teamResForAdmin xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<orgId>%@</orgId>"
//                             "<userId>%@</userId>"
//                             "</teamResForAdmin>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [TeamResourcesForAdminDictionary objectForKey:@"userType"],
//                             [TeamResourcesForAdminDictionary objectForKey:@"orgId"],[TeamResourcesForAdminDictionary objectForKey:@"userId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSLog(@"%@", string);
//         
//         
//         
//         [delegate Serviceactiondone1:responseObject];
//         
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//     }];
//    [operation start];
//}
//-(void)ProejctsForAll :(NSString *)ProjectsForAllClass ProjectsForAllParameters:(NSDictionary *)ProejctsForAllDictionary
//{
//    BaseURL = [[NSMutableString alloc] initWithString:ParentUrl];
//    [BaseURL appendString:ProjectsForAllClass];
//    NSURL *url = [NSURL URLWithString:BaseURL];
//    
//    //NSLog(@"the parameter string is %@",[projectExpancesBytesServiceParameters objectForKey:@"programOwner"]);
//    
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>""<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                             "<soap:Body>"
//                             "<projectsForAll xmlns=\"http://tempuri.org/\">"
//                             "<userType>%@</userType>"
//                             "<orgId>%@</orgId>"
//                             "<userId>%@</userId>"
//                             "</projectsForAll>"
//                             "</soap:Body>"
//                             "</soap:Envelope>",
//                             [ProejctsForAllDictionary objectForKey:@"userType"],
//                             [ProejctsForAllDictionary objectForKey:@"orgId"],[ProejctsForAllDictionary objectForKey:@"userId"]];
//    
//    
//    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *  msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    NSLog(@"length is %@",msgLength);
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue: @"http://tempuri.org/userLogin" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//         NSLog(@"%@", string);
//         
//         
//         
//         [delegate Serviceactiondone1:responseObject];
//         
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
//     }];
//    [operation start];
//    
//}

@end
