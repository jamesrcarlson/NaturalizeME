//
//  StudyController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Study.h"

@interface StudyController : NSObject

+ (StudyController *)sharedInstance;

- (Study *)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital;

- (void)addArray:(Study *)study;

- (void)save;

@end
