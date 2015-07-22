//
//  Scores.h
//  NaturalizeMe
//
//  Created by James Carlson on 7/21/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Scores : NSManagedObject

@property (nonatomic, retain) NSNumber * quizScore;
@property (nonatomic, retain) NSNumber * fullTestScore;
@property (nonatomic, retain) NSNumber * readingScore;
@property (nonatomic, retain) NSNumber * speakingScore;

@end
