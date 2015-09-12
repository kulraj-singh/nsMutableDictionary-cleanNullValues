//
//  NSMutableDictionary+CleanNullValues.m
//  Paytm
//
//  Created by iOS Developer on 12/09/15.
//  Copyright (c) 2015 Xperts Infosoft. All rights reserved.
//

#import "NSMutableDictionary+CleanNullValues.h"

@implementation NSMutableDictionary (CleanNullValues)

- (void)cleanNullValues
{
    for (NSString *key in self.allKeys) {
        [self cleanObjectForKey:key];
    }
}

- (void)cleanObjectForKey:(NSString*)key
{
    NSObject *object = self[key];
    if (!object || [object isKindOfClass:[NSNull class]]) {
        self[key] = @"";
    }
    
    //we will need to create mutable copies and replace the object
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        NSDictionary *dict = (NSDictionary*)object;
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        [mutableDict cleanNullValues];
        [self setObject:mutableDict forKey:key];
    }
    
    //check for array in the dictionary
    if ([object isKindOfClass:[NSMutableArray class]]) {
        NSArray *arr = (NSArray*)object;
        //create mutable copy
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSObject *object in arr) {
            //the array will have dictionaries. create mutable copies and replace
            if ([object isKindOfClass:[NSMutableDictionary class]]) {
                NSDictionary *dict = (NSDictionary*)object;
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                [mutableDict cleanNullValues];
                [mutableArray addObject:mutableDict];
            } else {
                [mutableArray addObject:object];
            }
        }
        [self setObject:mutableArray forKey:key];
    }
}

@end
