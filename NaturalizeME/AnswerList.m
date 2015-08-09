//
//  Answers.m
//  NaturalizeME
//
//  Created by James Carlson on 8/8/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswerList.h"

@implementation AnswerList

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.answers = dictionary[AnswersArrayKey];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *dictionary = @{
                                 AnswersArrayKey : self.answers,
                                 };
    
    return dictionary;
}

@end
