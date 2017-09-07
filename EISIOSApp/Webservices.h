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
-(void)userbasedmeetingdetails:(id)userbasedmeetingdetailsservice;

//Timesheet

-(void)timesheetlist:(id)timesheetresponse;
-(void)approvetimesheet:(id)approvetimesheetresponse;
-(void)tasklistfortimesheet:(id)tasklistfortimesheetresponse;
-(void)savetimesheetservice:(id)savetimesheetresponse;
-(void)approvetimesheetservice:(id)approvetimesheetresponse;

// Issues

-(void)issuelist:(id)issuesresponse;
-(void)issuestatus:(id)issuestatusresponse;
-(void)issuetype:(id)issuetyperesponse;
-(void)assigntoservice:(id)assigntoserviceresponse;
-(void)teamsubmittedservice:(id)teamsubmittedresponse;
-(void)servityservice:(id)servityserviceresponse;
-(void)saveissueservice:(id)saveissueresponse;
-(void)resoulutionescalatetoservice:(id)resolutionescalatetoresponse;
-(void)resolutionreleaseimpactservice:(id)resolutionreleaseimpactresponse;
-(void)rejectreasonservice:(id)rejectreasonresponse;
-(void)resolutiontypeservice:(id)resolutiontyperesponse;
-(void)resolutionupdate:(id)resolutionupdateresponse;
-(void)issuesfilelist:(id)issuesfilelistresponse;


//Task

-(void)tasklist:(id)taskList;
-(void)prioritylist:(id)priorityList;
-(void)holidaysList:(id)holidaysList;
-(void)categorylist:(id)categoryList;
-(void)resourcespinner:(id)resourcespinnerresponse;
-(void)enddatespinner:(id)enddateresponse;
-(void)savetaskservice:(id)savetaskresponse;
-(void)uploadtasktextservice:(id)uploadtasktextresponse;
-(void)harddependencyservice:(id)harddependencylistresponse;
-(void)textuploadingservice:(id)textuploadingresponse;
-(void)taskfilelistservice:(id)taskfilelistresponse;


//Requirement
-(void)requirementlist:(id)reqiurementList;
-(void)contacttype:(id)contacttyperesponse;
-(void)coreprocess:(id)coreprocessresponse;
-(void)processservice:(id)processresponse;
-(void)subprocessservice:(id)subprocessresponse;
-(void)activityservice:(id)activityresponse;
-(void)requirementype:(id)requirementtyperesponse;
-(void)criticality:(id)criticalityresponse;
-(void)systemservice:(id)systemserviceresponse;
-(void)saverequirement:(id)saverequirementresponse;
-(void)requirementobject:(id)requirementobjectresponse;
-(void)requirementobjectspinner:(id)requirementobjectspinnerresponse;
-(void)requirementpurpose:(id)requirementpurposeresponse;
-(void)requirementcomplexity:(id)requirementcomplexityresponse;
-(void)saverequirementobject:(id)saverequirementObject;

//Project Expenses

-(void)projectExpenseslist:(id)ProjectExpensesresponse;
-(void)categoryspinner:(id)categoryresponse;
-(void)saveprojectexpenses:(id)saveprojectexpensesresponse;
-(void)updateprojectexpenses:(id)updateprojectexpensesresponse;
-(void)projectexpensesattatchmentlistclass:(id)projectexpensesattatchmentlistresponse;

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
-(void)programbyownerlist:(id)programbyownerList;
-(void)programownerchart:(id)programownerChart;
-(void)taskoverviewlist:(id)taskoverviewList;
-(void)effortandbookedtime:(id)effortandbookedTime;
-(void)issueoverview:(id)issueoverView;
-(void)taskoverview:(id)taskoverView;


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
@property(nonatomic,weak)NSData *imgdata;
@property(nonatomic,weak)NSString *filename;

#define POST

#pragma Meeting Module Json Services

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
-(void)userbasedmeetingdetails:(NSString *)userbasedmeetingdetailsclass;


#pragma Timesheet json services

-(void)timesheet:(NSString *)timesheetlist;
-(void)approvetimesheet:(NSString *)approvetimesheetclass approvetimesheetparams:(NSString *)approvetimesheetprameters;
-(void)tasklistfortimesheet:(NSString *)tasklistfortimesheetclass;
-(void)savetimesheet:(NSString *)savetimesheetclass savetimesheetparams:(NSString *)savetimesheetparameters;


#pragma Issues json services

-(void)issueslist:(NSString *)issueslistclass;
-(void)issuestatusclass:(NSString *)issuestatusparams;
-(void)issuetypeservice:(NSString *)issuetypeserviceclass;
-(void)assigntoservice:(NSString *)assigntoserviceclass;
-(void)teamsubmittedservice:(NSString *)teamsubmittedserviceclass;
-(void)servityservice:(NSString *)servityserviceclass;
-(void)saveissue:(NSString *)saveissueclass saveissueparams:(NSString *)saveissueparameters;
-(void)issueresolutionescalteto:(NSString *)issueresolutionescalatetoparameters;
-(void)resolutionreleaseimpact:(NSString *)resolutionreleaseimpactparameters;
-(void)rejectreasonclass:(NSString *)rejectreasonparameters;
-(void)resolutiontypeclass:(NSString *)resolutiontypeparameters;
-(void)updateresolutionclass:(NSString *)resolutionupdate resolutionupdateparams:(NSString *)resolutionupdateparameters;

-(void)issuesfilelistclass:(NSString *)issuesfilelistparams;

#pragma Task json services

-(void)tasklistUrl:(NSString *)taskListUrl;
-(void)prioritylistUrl:(NSString *)priorityListUrl;
-(void)holidaysListUrl:(NSString *)holidaysListUrl;
-(void)categorylistUrl:(NSString *)categoryListUrl;
-(void)resourcespinner:(NSString *)resourcespinnerclass;
-(void)harddependencylist:(NSString *)harddependencyclass;
-(void)enddateservice:(NSString *)enddateserviceclass;
-(void)savetask:(NSString *)savetaskclass savetskparameters:(NSString *)savetaskparams;
-(void)uploadTextClass:(NSString *)uploadTaskText uploadTextparams:(NSDictionary *)uplaodtextparameters;
-(void)textuploadtask:(NSString *)textuploadingtaskclass textuploadingtaskparams:(NSString *)textuploadingparameters;
-(void)taskfileslist:(NSString *)taskfileslistclass;
-(void)audiouploading:(NSString *)audiouplaodingclass audiouploadingparams:(NSDictionary *)audiouploadingparameters;


#pragma Requirement json services

-(void)requirementListUrl:(NSString *)requirementlistUrl;
-(void)contacttypelistUrl:(NSString *)contacttypelistclass;
-(void)coreprocesslisturl:(NSString *)coreprocessclass;
-(void)processlisturl:(NSString *)processclass;
-(void)subprocessurl:(NSString *)subprocessclass;
-(void)activityserviceurl:(NSString *)activityserviceclass;
-(void)requirementtypeurl:(NSString *)requirementclass;
-(void)criticaliryurl:(NSString *)criticalityclass;
-(void)systemurl:(NSString *)systemclass;
-(void)saverequirement:(NSString *)saverequirementclass saverequirementparams:(NSString *)saverequirementparameters;
-(void)requirementobjectlist:(NSString *)requirementobjectlistparams;
-(void)requirementobjectspinner:(NSString *)requirementobjectspinnerclass;
-(void)requirementpurpose:(NSString *)requirementpurposeclass;
-(void)requirementcomplexity:(NSString *)requirementcomplexityclass;
-(void)saveRequirementobject:(NSString *)saveRequirementobjectclass saveRequirementobjectparams:(NSString *)saveRequirementobjectparameters;


#pragma ProjectExpenses json services

-(void)ProjectExpenseslist:(NSString *)projectexpenses;
-(void)categoryspinnerlist:(NSString *)categorylist;
-(void)saveprojectexpenses:(NSString *)projectexpensesparams projectexpensesservice:(NSString *)projectexpensesparameters;
-(void)updateprojectexpenses:(NSString *)updateprojectexpensesclass updateprojectexpensesparams:(NSString *)updateprojectexpensesparameters;
-(void)projectexpensesattatchmentlist:(NSString *)projectexpensesattatchmentlistparams;


#pragma Dashboard json services

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
-(void)numofresourcesbyprojectUrl:(NSString *)numofresourcesbyProjectUrl;
-(void)numofresourcesbyteamUrl:(NSString *)numofresourcesbyTeamUrl;
-(void)programchartsbudgetcostUrl:(NSString *)programchartsbudgetCostUrl;
-(void)programspinnerUrl:(NSString *)programSpinnerUrl;
-(void)programbyownerlistUrl:(NSString *)programbyownerListUrl;
-(void)programownerchartUrl:(NSString *)programownerChartUrl;
-(void)taskoverviewlistUrl:(NSString *)taskoverviewListUrl;
-(void)effortandbookedtimeUrl:(NSString *)effortandbookedTimeUrl;
-(void)issueoverviewUrl:(NSString *)issueoverViewUrl;
-(void)taskoverviewUrl:(NSString *)taskoverViewUrl;

@end
