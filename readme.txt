category on NSMutableDictionary for cleaning null values on all levels of the dictionary and its sub dictionaries and sub arrays.

say you have a dictionary
NSDictionary * responseDict;

just do
NSMutableDictionary *mutableResponseDict = [responseDict mutableCopy];
[mutableResponseDict cleanNullValues];

and all “<null>” and nil will be removed.

Caveat: we are assuming the null values should be a string. So we are replacing the null values with empty string @“”. We have no way of knowing that a given value is supposed to be an array. so an expected array can become an empty string when you clean with this method. 
