//
//  UserData.h
//  EISIOSApp
//
//  Created by iAppSoft on 11/12/14.
//  Copyright (c) 2014 EISPvtLtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserData : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * orgId;
@property (nonatomic, retain) NSString * userType;

@end
