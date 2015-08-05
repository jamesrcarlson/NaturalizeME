//
//  AnswersController.h
//  NaturalizeME
//
//  Created by James Carlson on 8/5/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswersController : NSObject

@property (strong, nonatomic)NSMutableArray *answers;

+(NSInteger)questionCount;

+(NSDictionary *)questionAtIndex:(NSInteger)index;

+(NSString *)questionNumberAtIndex:(NSInteger)index;

+(NSString *)questionTitleAtIndex:(NSInteger)index;

+(NSNumber *)answersNeededAtIndex:(NSInteger)index;

+(NSInteger)answerCountAtIndex:(NSInteger)index;

+(NSString *)answerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex;

+(NSString *)BadAnswerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex;

+(NSString *)explanationAtIndex:(NSInteger)index;

+(void)setAnswerAtIndex:(NSInteger)anIndex forQuestionAtIndex:(NSInteger)index WithName:(NSString *)setName;


@end
