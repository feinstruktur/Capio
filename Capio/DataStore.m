//
//  DataStore.m
//  Capio
//
//  Created by Sven A. Schmidt on 12.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "DataStore.h"
#import "AppOverview.h"
#import "Tuple.h"


@implementation DataStore


#pragma mark - Workers

- (NSArray *)dummyData:(NSUInteger)count {
  NSTimeInterval oneDay = 24 * 60 * 60;
  NSMutableArray *newData = [NSMutableArray array];
	for (NSUInteger i = 0; i <= count; i++ ) {
		id x = [NSDecimalNumber numberWithDouble:oneDay*i];
		id y = [NSDecimalNumber numberWithUnsignedInteger:[self randomWithMax:count]];
    Tuple *t = [[Tuple alloc] init];
    t.x = x;
    t.y = y;
		[newData addObject:t];
	}
  return newData;
}


- (NSUInteger)randomWithMax:(NSUInteger)maxValue {
  NSUInteger r = arc4random() % (maxValue+1); // [0,maxValue]
  return r;
}


- (NSArray *)appList {
  static NSDateFormatter *dateFormatter = nil;
  if (! dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
  }

  NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/dev/apps"];
  NSData *data = [NSData dataWithContentsOfURL:url];
  NSError *error = nil;
  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  
  NSMutableArray *apps = [NSMutableArray array];
  [jsonDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    if ([obj isKindOfClass:[NSDictionary class]]) {
      NSDictionary *dict = (NSDictionary *)obj;
      AppOverview *item = [[AppOverview alloc] init];
      item.appName = [dict objectForKey:@"app_name"];
      item.appDescription = [dict objectForKey:@"app_description"];
      item.appOwner = [dict objectForKey:@"app_owner"];
      NSArray *server_list = [dict objectForKey:@"server_list"];
      item.serverCount = [NSNumber numberWithUnsignedInteger:[server_list count]];
      NSString *value = [dict objectForKey:@"report_date"];
      item.reportDate = [dateFormatter dateFromString:value];
      item.ragRed = [dict objectForKey:@"red_rag_count"];
      item.ragAmber = [dict objectForKey:@"amber_rag_count"];
      item.ragGreen = [dict objectForKey:@"green_rag_count"];
      item.ragTotal = [NSNumber numberWithUnsignedInteger:[item.ragRed unsignedIntValue] + [item.ragAmber unsignedIntValue] + [item.ragGreen unsignedIntValue]];
      [apps addObject:item];
    }
  }];
  return apps;
}

#pragma mark - Initializers

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (DataStore *)sharedDataStore {
  static DataStore *sharedDataStore = nil;
  
  if (sharedDataStore) {
    return sharedDataStore;
  }
  
  @synchronized(self) {
    if (!sharedDataStore) {
      sharedDataStore = [[DataStore alloc] init];
    }
    
    return sharedDataStore;
  }
}


@end
