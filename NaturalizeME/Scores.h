//
//  Scores.h
//  NaturalizeME
//
//  Created by James Carlson on 7/25/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Scores : NSManagedObject

@property (nonatomic, assign) NSInteger quizScore;
@property (nonatomic, retain) NSDate * timestamp;

@end
