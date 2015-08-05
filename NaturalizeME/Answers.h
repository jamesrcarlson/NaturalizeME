//
//  Answers.h
//  NaturalizeME
//
//  Created by James Carlson on 8/5/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const AnswersArrayKey = @"answersArray";


@interface Answers : NSObject

@property (nonatomic, strong) NSArray * storedAnswers;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;


@end
