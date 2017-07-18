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
-(void)savemeeting:(id)savemeetingurl;
-(void)agendaGoalcount:(id)agnedacounturl;
-(void)AgendaList:(id)Agendalist;
-(void)GoalList: (id)Goallist;
-(void)actionitemkill:(id)actionitemkillstatus;
-(void)saveagenda:(id)saveagendameeting;
-(void)participantslist:(id)participantslisturl;
-(void)participantresourcename:(id)participantsreslist;
-(void)participantsrole:(id)participantsroleresponse;
-(void)saveparticipants:(id)saveparticipantsresource;
-(void)actionItemList:(id)actionItemlist;
-(void)noteslist:(id)notesList;
-(void)feedbackList:(id)feedbacklist;
-(void)actionitemassigned:(id)actionitemassignedto;
-(void)saveactionitem:(id)actionitemresponse;
-(void)savenotes:(id)saveNotes;
-(void)savefeedback:(id)saveFeedback;

//Timesheet

-(void)timesheetlist:(id)timesheetresponse;
-(void)approvetimesheet:(id)approvetimesheetresponse;
-(void)tasklistfortimesheet:(id)tasklistfortimesheetresponse;

// Issues

-(void)issuelist:(id)issuesresponse;
-(void)issuestatus:(id)issuestatusresponse;
-(void)issuetype:(id)issuetyperesponse;
-(void)assigntoservice:(id)assigntoserviceresponse;
-(void)teamsubmittedservice:(id)teamsubmittedresponse;
-(void)servityservice:(id)servityserviceresponse;
-(void)saveissueservice:(id)saveissueresponse;

//Requirement
-(void)requirementlist:(id)reqiurementList;

//Project Expenses

-(void)projectExpenseslist:(id)ProjectExpensesresponse;

//DASH BOARD
-(void)oganizationresourcereport:(id)oganizationresourcereportresponse;
-(void)peoplebyskills:(id)peoplebyskillsresponse;
-(void)numofprojectsbyresourcereport:(id)numofprojectsbyresourceReport;
-(void)averagebillingratebyorganisation:(id)averagebillingratebyOrganisation;
-(void)numofresourcesbyprogram:(id)numofresourcesbyProgram;
-(void)allocatedcapacitytoprogram:(id)allocatedcapacitytoProgram;
-(void)allocatedcapacitytoproject:(id)allocatedcapacitytoProject;
-(void)assignedcapacitytoprogram:(id)assignedcapacitytoProgram;
-(void)assignedcapacitytoproject:(id)assignedcapacitytoProject;
-(void)averagecostofresourceofprogram:(id)averagecostofresourceofProgram;
-(void)numofresourcesbyproject:(id)numofresourcesbyProject;
-(void)numofresourcesbyteam:(id)numofresourcesbyTeam;
-(void)programchartsbudgetcost:(id)programchartsbudgetCost;
-(void)programspinner:(id)programSpinner;


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
    NSString *exp;

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
-(void)meetingupdate:(NSString *)meetingupdateurlparams meetingupdatedict:(NSString *)meetingdictparams;
-(void)agendacount:(NSString *)agendacounturl;
-(void)AgendaListUrl:(NSString *)AgendalistUrl;
-(void)savemeeting :(NSString *)savemeetingurl meetingparams:(NSString *)meetingsavedict;
-(void)goallistUrl:(NSString *)GoallistUrl;
-(void)actionitemkill :(NSString *)actionitemclose actionitemkillurl:(NSString *)actionitemkillparams;
-(void)agendameeting:(NSString *)saveagenda agendameetingparams:(NSString *)saveagendameeting;
-(void)ParticipantlistUrl:(NSString *)ParticipantListUrl;
-(void)participantsresourcename:(NSString *)participantsresourcenamelist;
-(void)participantrole:(NSString *)participantsrolestring;
-(void)saveparticipant:(NSString *)saveparticipantmeeting saveparticipantparams:(NSString *)saveparticipantsurl;
-(void)noteslistUrl:(NSString *)notesListUrl;
-(void)actionItemListUrl:(NSString *)actionItemlistUrl;
-(void)feedbackListUrl:(NSString *)feedbacklistUrl;
-(void)actionitemassignedto:(NSString *)actiontiemassignedtospinner;
-(void)saveactionitemUrl:(NSString *)saveactionitemclass saveactionitemparams:(NSString *)saveactionitemparameters;
-(void)savenotesUrl:(NSString *)savenoteslist savenotesparams:(NSString *)savenotesurl;
-(void)savefeedbackUrl:(NSString *)Savefeedback savefeedbackparams:(NSString *)saveFeedbackUrl;


// TimeSheet Json

-(void)timesheet:(NSString *)timesheetlist;
-(void)approvetimesheet:(NSString *)approvetimesheetclass approvetimesheetparams:(NSString *)approvetimesheetprameters;
-(void)tasklistfortimesheet:(NSString *)tasklistfortimesheetclass;

// Issues Json
-(void)issueslist:(NSString *)issueslistclass;
-(void)issuestatusclass:(NSString *)issuestatusparams;
-(void)issuetypeservice:(NSString *)issuetypeserviceclass;
-(void)assigntoservice:(NSString *)assigntoserviceclass;
-(void)teamsubmittedservice:(NSString *)teamsubmittedserviceclass;
-(void)servityservice:(NSString *)servityserviceclass;
-(void)saveissue:(NSString *)saveissueclass saveissueparams:(NSString *)saveissueparameters;

// Requirement Json
-(void)requirementListUrl:(NSString *)requirementlistUrl;


//Project Expenses

-(void)ProjectExpenseslist:(NSString *)projectexpenses;
// Dash board

-(void)oganizationresourcereport:(NSString *)oganizationresourcereportparams;
-(void)peoplebyskill:(NSString *)peoplebyskillparams;
-(void)numofprojectsbyResourcereportsUrl:(NSString *)numofprojectsbyresourcereportUrl;
-(void)averagebillingratebyOrganisationUrl:(NSString *)averagebillingratebyorganisationUrl;
-(void)numofresourcesbyProgramUrl:(NSString *)numofresourcesbyprogramUrl;
-(void)allocatedcapacitytoProgramUrl:(NSString *)allocatedcapacitytoprogramUrl;
-(void)allocatedcapacitytoProjectUrl:(NSString *)allocatedcapacitytoprojectUrl;
-(void)assignedcapacitytoProgramUrl:(NSString *)assignedcapacitytoprogramUrl;
-(void)assignedcapacitytoProjectUrl:(NSString *)assignedcapacitytoprojectUrl;
-(void)averagecostofresourceofProgramUrl:(NSString *)averagecostofresourceofprogramUrl;
-(void)numofresourcesbyprojectUrl:(id)numofresourcesbyProjectUrl;
-(void)numofresourcesbyteamUrl:(id)numofresourcesbyTeamUrl;
-(void)programchartsbudgetcostUrl:(id)programchartsbudgetCostUrl;
-(void)programspinnerUrl:(id)programSpinnerUrl;



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
