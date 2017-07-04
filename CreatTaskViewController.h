//
//  CreatTaskViewController.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/28/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "Toast+UIView.h"

@interface CreatTaskViewController : UIViewController<WebserviceownProtocal,NSXMLParserDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    Webservices *Servicecall;
    IBOutlet UIScrollView *ScrollV;
    IBOutlet UIView *CreateTaskView;
    IBOutlet UIButton *homebtn,*Savebtn,*ProjectListbtnpkr;
    
    UITableView *hardDependencyTableView;
    
    UIAlertView *LogoutAlert;
    IBOutlet UITextField *Projecttxtfld,*Categorytxtfld,*Prioritytxtfld,*Descriptionxtfld,*Efforttxtfld,*StartDatetxtfld,*Enddatetxtfld,*Resourcetxtfld,*hardDependencytxtfld,*hoursPerDaytxtfld;
    
    NSXMLParser *projectListXmlParser,*holidaysListXmlParser,*
    HolidaysXmlPArser;
    
    NSMutableArray *selectedRowArray,*dateArray2,*cellSelectedArray,*holidayDateArray,*holidaysListServiceDateArray,*holidayCheckedArray,*datesare1;
    
    NSMutableString *hardDependencyText,*endDateStr;
    NSString *maxDate1,*dateee;
    
    NSIndexPath *myIndexPath;
    NSString *holidayEnddate,*holidayStartdate,*convertedate,*datesare;
    
    NSMutableArray *selectedHardDependencyArray,*deselectedHardDependencyArray;
    
    int selectedRow;
    
    BOOL clearCheckMark;
    
    NSDate *startDate;
    
    NSArray *selectedRows;
    
    
}
@property(nonatomic,strong)NSString *ProjectIdstr,*CategoryIdstr,*PriorityIdstr,*ResourceIdstr,*Descriptionstr,*Effortstr,*StartDatestr,*EndDatestr,*UpDTaskId,*Prioritynamestr,*Projectnamestr,*Resourcenamestr,*categorynamestr,*hardDependencystr,*hoursPerdayStr;
@property (nonatomic,strong)NSString *navigationTitlestr,*SavebtnTitlestr;
@property (assign) BOOL locationUseBool;
@property (nonatomic,strong)UIButton *harddependencyPkrbtn,*datePickerBtn;
@property(nonatomic,readwrite)int selectedCell;
@property(nonatomic,strong)  NSIndexPath* lastIndexPath;
@property (nonatomic, strong) NSMutableArray *selectedRowArray1;
@property (nonatomic, strong) NSMutableArray *selectedCells;
@property (nonatomic, strong) NSMutableArray *selecedStates;

@end
