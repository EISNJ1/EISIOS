//
//  Webservices.h
//  EISIOSApp
//
//  Created by iAppSoft on 10/30/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

@protocol WebserviceownProtocal <NSObject>
//Json methods
-(void)didFinishService :(id)Userlogindetails;
-(void)meetingList:(id)MeetingList;
-(void)agendaList:(id)AgendaList;
-(void)actionitemList:(id)actionitems;
-(void)notesactionfbcount:(id)notesactionfbCount;
-(void)publicnotesdec:(id)publicnoteDec;
-(void)projectlistspinner:(id)projectlistSpinner;
-(void)conferencermspinner:(id)conferenceroomSpinner;
-(void)meetingType:(id)meetingTypeSpinner;
-(void)meetingupdate:(id)meetingUpdateurl;
-(void)agendaGoalcount:(id)agnedacounturl;


//soap methods
-(void)didfinishactionitemlist :(id)actionitemlist;
-(void)didNotesCountFinished :(id)Notescountlist;
-(void)Serviceactiondone : (id)result;
-(void)Serviceactiondone1 : (id)result;
-(void)didFailservice :(id)error;
-(void)didFinishData :(id)Data;
-(void)didEndTask :(id)Taskend;
-(void)serviceCal :(id)ServerData;
-(void)Servicecal1 :(id)ServerData;
-(void)ServiceCalls :(id)ServiceCal;
-(void)ServiceCalls1 :(id)ServiceCal1;
-(void)Downloading :(float)Downloading;
@end

#import <Foundation/Foundation.h>

@interface Webservices : NSObject
{
    NSMutableString *BaseURL;
    UIActivityIndicatorView *act;
}
@property(nonatomic,weak)id <WebserviceownProtocal> delegate;
#define POST
// -----------------------Meeting Module Methods--------------------

-(void)loginUrl:(NSString *)LoginStrUrl ;
-(void)meetingUrl :(NSString *)meetingurl;
-(void)agendaUrl :(NSString *)AgendaUrl;
-(void)actionitemlist:(NSString *)actionitemlisturl;
-(void)notesactionfbcountUrl:(NSString *)Notesactionfbcounturl;
-(void)publicnotesdecurl:(NSString *)publicnotesdecUrl;
-(void)projectlstspinrurl:(NSString *)projectlstspinrUrl;
-(void)conferencermspinrurl:(NSString *)conferencermspinrUrl;
-(void)meetingTypeUrl:(NSString *)Meetingtypeurlparams;
-(void)meetingupdate:(NSString *)meetingupdateurlparams meetingupdatedict:(NSDictionary *)meetingdictparams;
-(void)agendacount:(NSString *)agendacounturl;


-(void)Loginserviceurl: (NSString *)Loginurl Loginparameters : (NSDictionary *)LoginCredentials;
-(void)MeetingListurl:(NSString *)Listurl Listparameters:(NSDictionary *)Listcredentials;
-(void)ActionitemListurl:(NSString *)Listurl Listparameters:(NSDictionary *)Listcredentials;
-(void)NotesCountlisturl :(NSString *)Countlisturl CountListparameters:(NSDictionary *)CountParameters;
-(void)PublicCountlisturl :(NSString *)Publiccounturl Publiccountcredentilas:(NSDictionary *)PubliccountParameters;
-(void)PublicDislisturl :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)PublicDisParameters;
-(void)Projectspickerurl :(NSString *)Projectsurl ProjectsListcredentilas :(NSDictionary *)ProjectListParameters;
-(void)MeetingTypeurl:(NSString *)MeetingTypeurl MeetingTypeListCredentilas :(NSDictionary *)MeetingListCredentilas;
-(void)ConfRoomurl:(NSString *)ConfRoomMurl ConfRoomCredentilas:(NSDictionary *)ConfRoomCredentilas;
-(void)SaveMeetingurl :(NSString *)SaveMeeetingurl  SaveMeetingDetails :(NSDictionary *)SaveMeetingDetails;
-(void)UpdateMeetingurl :(NSString *)UpdateMeeetingurl  UpdateMeetingDetails :(NSDictionary *)UpdateMeetingDetails;
-(void)AgendaGoalsCounturl :(NSString *)AgendaGoalsCounturl AgendaGoalParameters :(NSDictionary *)AgendaGoalsCredentials;

-(void)ActionItemListKill :(NSString *)ActionItemListClass ActionItemListKillParameters :(NSDictionary *)ACtionItemListDictionary;

//------------------TimeSheet Moduke------------------------

-(void)createTimeSheetProject :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)projectParameters;
-(void)createTimeSheetTask :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)taskParameters;
-(void)saveTimeSheet :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)saveTimeSheetParameters;

-(void)timeSheetLst :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)timeSheetLstParameters;

-(void)timeSheetLstAll :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)timeSheetLstAllParameters;

-(void)approveTimeshhet :(NSString *)PublicDisurl PublicDiscredentilas:(NSDictionary *)ApprovetimeSheetLstAllParameters;


//----------------Agenda Module--------------------------

-(void)AgendaListurl :(NSString *)AgendaListurl AgendaListParameters : (NSDictionary *)AgendaListParameters;
-(void)agendaSavedurl :(NSString *)AgendaSavedurl AgendaSavedParameters : (NSDictionary *)AgendaSavedParamaters;


//----------------GoalsModule-----------------------------


-(void)GoalsListurl :(NSString *)GoalsListurl GoalsListParameters : (NSDictionary *)GoalsListParameters;
-(void)GoalsSavedurl :(NSString *)GoalsSavedurl GoalsSavedParameters : (NSDictionary *)GoalsSavedParamaters;



//----------------Participants-------------------------------
-(void)ParticipantsListurl :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)ParticipantsListParameters;
//ParticipantResourcepicker
-(void)ParticipantsResourceName :(NSString *)ResourceNameurl ParticipantsResourceParameters :(NSDictionary *)ResourceNameParameters;

//PArticipantRolepicker

-(void)RoleName :(NSString *)RoleNameurl RoleParameters :(NSDictionary *)RoleParameters;
//SavePArticipents

-(void)SaveParticipantsurl :(NSString *)Saveurl SaveParticipantsParameters :(NSDictionary *)SaveParameters;
//-------------------------ActionitemsList---------------------------

-(void)AssignedTourl :(NSString *)Assignedurl AssignedValues :(NSDictionary *)AssignedToListParameter;
-(void)SaveActionitemsList :(NSString *)Saveurl  SaveActionItemParametres :(NSDictionary *)SaveActionItemData;
-(void)SavedActionitems :(NSString *)ListofActionitemsurl ListofActionitemsParameters :(NSDictionary *)ListActionitemsParameters;
-(void)SaveActionItemTablist :(NSString *)ActionItemListUrl ActionItemListDictionary :(NSDictionary *)ListOfActionItemsTab;

//-----------------------SaveNotes----------------------------
-(void)NotesList :(NSString *)NOtesListurl NotesListParametrs :(NSDictionary *)NotesListParametrs;
-(void)SaveNotes :(NSString *)SaveNotesUrl NotesparametrsForSave :(NSDictionary *)NotesSaveParameters;
//------------------------Feedback----------------------------
-(void)Feedbacklisturl :(NSString *)Feedbacklisturl FeedbackCredentials :(NSDictionary *)FeedbackCredentials;

-(void)SaveFeedbackurl :(NSString *)SaveFeedbackurl  SaveFeedBackCredentials :(NSDictionary *)SaveFeedbackParameters;
//--------------------------MeetingInfoModule-----------------------------
-(void)MeetingInfourl :(NSString *)MeetingInfoDetails MeetingDetails:(NSDictionary *)MeetingInfocredentilas;





//------------issue Module -------------//

-(void)issueList :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)issueListParameters;


-(void)createIssueProjectSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)projectListParameters;

-(void)createIssueStatusSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)statusListParameters;

-(void)createIssueIssueTypeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)issueTypeListParameters;

-(void)createIssueAssighToeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)assignToListParameters;

-(void)createIssueTeamSubmittedeSpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)teamSubmittedListParameters;

-(void)createIssueSeveritySpinner :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)severityListParameters;

-(void)saveIssue :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)saveIssueParameters;

-(void)updateIssue :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)updateIssueParameters;

-(void)SaveAttatchmentInIssue :(NSString *)SaveAttatchmentIssueClass SaveAttatchmentIssuesDictionary:(NSDictionary *)SaveATtatchmentsISsueParameters;

-(void)IssueAttatchmentsList :(NSString *)IssueAttatchmentsListClass IssueAttatchmentsListDictionary :(NSDictionary *)IssueAttatchmentsListDictionary;

//Resolution screen
-(void)resolutionAssignTo :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaAssignToParameters;

-(void)resolutionReleaseImpact :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaReleaseImpactParameters;

-(void)resolutionRejectReason :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionaRejectReasonParameters;

-(void)resolutionResolutionType  :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionResolutionTypeParameters;

-(void)resolutionUpdate  :(NSString *)Participantsurl ParticipantsListParameters :(NSDictionary *)resolutionUpdateParameters;



//----------------------TaskModule------------------------------------

-(void)TasksHPListServiceurl :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)TaskListCredentials;
//------------------Creat Task-------------------------------------------
-(void)TaskCategorySpinnerListurl :(NSString *)categoryurl Taskcategorycredentials:(NSDictionary *)CategoryParametrs;
-(void)TaskPrioritySpinnerurl :(NSString *)Priorityurl TaskPriorityparameters :(NSDictionary *)PriorityParameters;
-(void)TaskResourceurl :(NSString *)Resourceurl ResourceParameters :(NSDictionary *)ResourceParametrs;
-(void)SaveNewTaskurl :(NSString *)NewTaskurl NewTaskSaveParameters :(NSDictionary *)SaveNewTaskCredentials;
-(void)UploadTask :(NSString *)UploadTaskurl UploadTaskParameters :(NSDictionary *)uploadTaskDetails;

-(void)UploadTask :(NSString *)UploadTaskurl;
-(void)SimpleClass :(NSString *)SimpleClassName SimpleDictionary :(NSDictionary *)SimpleDictionaryParameters;
-(void)Downloads:(NSString *)Downloadsurl Downloadparameters:(NSDictionary *)DownloadListCredentilas;
-(void)ProjectspickerurlTask:(NSString *)Projectsurl ProjectsListcredentilas:(NSDictionary *)ProjectListParameters;
-(void)TaskFileListurl :(NSString *)TaskFileListurl TaskFileListParameters :(NSDictionary *)TaskFileCredentials;

-(void)HardDependency :(NSString *)HardDependencyClass HardDependencyParameters :(NSDictionary *)HardDependencyParameters;
-(void)HolidaysList :(NSString *)HolidaysListClassDetails HolidaysListParametersDetails :(NSDictionary *)HoldiaysListDetails;

-(void)HolidaysListForTask :(NSString *)HolidysListClass HolidaysListParameters :(NSDictionary *)HolidaysListDictionary;
//-(void)Downloads :(NSString *)Downloadsurl Downloadparameters :(NSDictionary *)DownloadListCredentilas   active:(UIProgressView *)progressView;
//----------------------Requirement Module------------------------------------

-(void)reqList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqListParameters;

-(void)reqProjectSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqProjectSpinnerParameters;

-(void)reqContactSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqContactpinnerParameters;

-(void)reqCoreProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCoreProcessSpinnerParameters;

-(void)reqProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqProcessSpinnerParameters;




-(void)reqSubProcessSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqSubProcessSpinnerParameters;

-(void)reqActivitySpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqActivitySpinnerParameters;

-(void)reqTypeSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqTypeSpinnerParameters;

-(void)reqCriticality1Spinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCriticality1SpinnerParameters;

-(void)reqCriticality2Spinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)reqCriticality2SpinnerParameters;

-(void)saveRequirement :(NSString *)TaskListurl;

-(void)saveRequirement :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)saveRequirementParameters;

-(void)updateRequirement :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)updateRequirementParameters;



//object Requirement

-(void)requirementObjectLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementObjectLstParameters;


-(void)requirementObjectSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementObjectSpinnerLstParameters;

-(void)requirementPurposeSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementPurposeSpinnerLstParameters;

//-(void)requirementResourceSpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementResourceSpinnerLstParameters;

-(void)requirementComplexitySpinnerLst :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)requirementComplexitySpinnerLstParameters;

-(void)saveRequirementObject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)saveRequirementObjectParameters;

-(void)updateRequirementObject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)updateRequirementObjectParameters;

//-------project Expences----------------//

-(void)projectExpencesListSpinner :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpencesListSpinnerParameters;

-(void)projectExpencesList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpencesListParameters;

//create ProjectExpences
-(void)createprojectExpencesCategorySpinnerList :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)createprojectExpencesCategorySpinnerListParameters;

-(void)expansesSave :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)expansesSaveParameters;

-(void)expansesUpdate :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)expansesUpdateParameters;

-(void)DownloadFile :(NSString *)DownloadFileUrlString DownloadFileParameters :(NSDictionary *)DownloadFileUrlParameters;
-(void)saveAttatchmentInProjectExpenses :(NSString *)saveAttatchmentProjectExpensesClassString saveAttatchmentProjectExpensesParameters:(NSDictionary *)saveAttatchmentProjectExpensesDictionary;

-(void)projectExpensesAttatchmentList :(NSString *)projectExpensesAttatchmentClass projectExpensesAttatchmentDictionary:(NSDictionary *)projectExpensesListParameters;

//-------------Dash Board-----------------//
-(void)organizationReportGraph :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)organizationReportGraphParameters;

-(void)peopleBySkillsReport :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)peopleBySkillsReportParameters;

-(void)noOfProjectsReports :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)noOfProjectsReportsParameters;

-(void)avgBlgRateByOrganization :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)avgBlgRateByOrganizationParameters;

-(void)noOfResourcesByPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)noOfResourcesByPrgrmParameters;

-(void)allocataedCapacityToPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)allocataedCapacityToPrgrmParameters;

-(void)allocatedCapacityToProject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)allocatedCapacityToProjectParameters;

-(void)assignedCapacityToProgram :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)assignedCapacityToProgramParameters;

-(void)assignedCapacityToProject :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)assignedCapacityToProjectParameters;

-(void)avgCostOfReourceByPrgrm :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)avgCostOfReourceByPrgrmParameters;

-(void)TaskOVerView :(NSString *)TaskOverViewClass TaskOVerViewListParameters :(NSDictionary *)TaskOverViewDataParameters;

-(void)ProjectCostDetails:(NSString *)ProjectCostDetailsClass ProjectCostParameters:(NSDictionary *)ProjectCostDetailsDictionary;

-(void)ProgramList:(NSString *)ProgramListClass ProgramListParameters:(NSDictionary *)ProgramListDictionary
;

-(void)OVerViewEffortAndBookedTime:(NSString *)OverViewEffortAndBookedTimeClass OverViewBookedAndTimeParameters:(NSDictionary *)OverViewEffortAndBookedTimeDictionary;

-(void)taskOverViewGraph:(NSString *)TaskOverViewGraphClass TaskOverViewGraphParameters:(NSDictionary *)TaskOverViewGraphDictionary;

-(void)issuesOverViewChart:(NSString *)issueOVerViewClass IssueOverviewParameters:(NSDictionary *)IssuesOverViewDictionary;

-(void)TeamResourcesForAdmin :(NSString *)TeamResourceForAdminClass TeamResourceForAdminParameters:(NSDictionary *)TeamResourcesForAdminDictionary;

-(void)ProejctsForAll :(NSString *)ProjectsForAllClass ProjectsForAllParameters:(NSDictionary *)ProejctsForAllDictionary;
//Programs Under Each Owner

-(void)prgrmByOwnerReports :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)prgrmByOwnerReportsParameters;

-(void)prgrmByOwnerDetails :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)prgrmByOwnerDetailsParameters;

-(void)projectExpancesBytesService :(NSString *)TaskListurl  TaskListParameters :(NSDictionary *)projectExpancesBytesServiceParameters;


@end
