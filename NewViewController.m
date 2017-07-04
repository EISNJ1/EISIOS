//
//  NewViewController.m
//  EISIOSApp
//
//  Created by vm mac on 30/03/2017.
//  Copyright © 2017 EISPvtLtd. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [self uploading];

    
    // Do any additional setup after loading the view.
}


-(void)uploading
{
    NSString  *TaskIdStr=@"1250",*fileType=@"text",*datestr=@"2017-03-30 12:00:55",*fileName=@"textfile",*fileBytes=@"GHVFGCDRTEDSXCFVGB",*byteLenth=@"19",*taskHistory=@"hi sheik";
    
    NSLog(@"welcome to eis");
    serviceall=[[Webservices alloc]init];
    
    NSString *UploadTaskUrl = @"UploadFilesForTasks";
    NSDictionary *credentials= @{@"taskId":TaskIdStr,@"fileType":fileType,@"date":datestr,@"fileName":fileName,@"fileBytes":fileBytes,@"byteLenth":byteLenth,@"taskHistory":taskHistory};
    [serviceall UploadTask:UploadTaskUrl UploadTaskParameters:credentials];
    [serviceall setDelegate:self];
    
    
    NSString *TaskFileurl  = @"TasksFilesList";
    NSDictionary *credentials1 = @{@"taskId":TaskIdStr,@"fileType":fileType};
    [serviceall TaskFileListurl:TaskFileurl TaskFileListParameters:credentials1];
    [serviceall setDelegate:self];
    

}
-(void)serviceCal:(id)ServerData
{
    TaskListXmlParser = [[NSXMLParser alloc]initWithData:ServerData];
    TaskListXmlParser.delegate = self;
    [TaskListXmlParser parse];
}

-(void)didFinishData:(id)Data
{
    UploadParserParser = [[NSXMLParser alloc]initWithData:Data];
    UploadParserParser.delegate = self;
    [UploadParserParser parse];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
