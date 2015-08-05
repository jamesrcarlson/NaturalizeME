//
//  Answers.m
//  NaturalizeME
//
//  Created by James Carlson on 8/5/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "Answers.h"

@implementation Answers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.storedAnswers = dictionary[AnswersArrayKey];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *dictionary = @{
                                 AnswersArrayKey : self.storedAnswers,
                                 };
    
    return dictionary;
}


@end
