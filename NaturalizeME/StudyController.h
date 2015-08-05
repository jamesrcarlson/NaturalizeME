//
//  StudyController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Study.h"
#import "Answers.h"



@interface StudyController : NSObject

+ (StudyController *)sharedInstance;

- (Answers *)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital;

- (void)addArray:(Answers *)study;

- (void)save;

@property (nonatomic, retain) NSString * question;

@property (strong, nonatomic, readonly)NSArray *answersHolderArray;



@end
