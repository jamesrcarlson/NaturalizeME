//
//  SetupController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/25/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupInfo.h"

@interface SetupController : NSObject

@property (strong, readonly)NSArray *civicsInfo;

+ (SetupController *)sharedInstance;

- (SetupInfo *)storeCivicsInfo:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital;

-(void)removeInfo:(SetupInfo *)civicInfo;

-(void)save;


@end
