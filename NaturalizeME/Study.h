//
//  Study.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Study : NSObject

@property (nonatomic, retain) NSString * question;

+(NSInteger)questionCount;

+(NSDictionary *)questionAtIndex:(NSInteger)index;

+(NSString *)questionNumberAtIndex:(NSInteger)index;

+(NSString *)questionTitleAtIndex:(NSInteger)index;

+(NSNumber *)answersNeededAtIndex:(NSInteger)index;

+(NSInteger)answerCountAtIndex:(NSInteger)index;

+(NSString *)answerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex;

+(NSString *)explanationAtIndex:(NSInteger)index;

+(NSArray *)answers;

@property (nonatomic, strong)NSMutableArray *holder;

@end
