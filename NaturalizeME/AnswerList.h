//
//  Answers.h
//  NaturalizeME
//
//  Created by James Carlson on 8/8/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const AnswersArrayKey = @"answersArray";


@interface AnswerList : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@property (strong)NSMutableArray *answers;


@end
