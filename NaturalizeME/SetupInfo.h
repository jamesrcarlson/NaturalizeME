//
//  SetupInfo.h
//  NaturalizeME
//
//  Created by James Carlson on 7/26/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SetupInfo : NSManagedObject

@property (nonatomic, retain) NSString * governnor;
@property (nonatomic, retain) NSString * representative;
@property (nonatomic, retain) NSString * senatorOne;
@property (nonatomic, retain) NSString * senatorTwo;
@property (nonatomic, retain) NSString * stateCapital;

@end
