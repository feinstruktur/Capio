//
//  Tuple.h
//  Capio
//
//  Created by Sven A. Schmidt on 12.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tuple : NSObject

@property (nonatomic, strong) NSDecimalNumber *x;
@property (nonatomic, strong) NSDecimalNumber *y;


+ (NSArray *)addArray:(NSArray *)a1 toArray:(NSArray *)a2;

- (void)add:(Tuple *)t;


@end
