//
//  Question.h
//  NaturalizeME
//
//  Created by James Carlson on 8/13/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong) NSString *title;
@property (strong) NSString *questionNumber;
@property (strong) NSNumber *answersNeeded;
@property (strong) NSArray *correctAnswers;
@property (strong) NSArray *incorrectAnswers;
@property (strong) NSString *explanation;

@property (strong, readonly) NSArray *randomSetOfAnswers;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;


@end
