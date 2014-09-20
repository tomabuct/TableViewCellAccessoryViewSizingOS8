//
//  YLURLMatchingRule.h
//  YLUtils
//
//  Created by Alexander Haefner on 4/11/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

extern NSString *const kYLURLMatchingRuleKeyHost;
extern NSString *const kYLURLMatchingRuleKeyPath;
extern NSString *const kYLURLMatchingRuleKeyQuery;

@interface YLURLMatchingRule : NSObject

/*!
 This class is for creating a set of rules to match an NSURL against.  Rules are divided into three parts of the URL, the host, the path, and the query.

 The doesContain and doesNotContain dictionaries define rules for matching URLs.  The dictionaries can contain the following optional keys: "host",
 "path", "query".  The value for each of these keys should be an NSArray.  So for example:

 doesContain = {"host" = @["yelp.com"]} will match with a host of yelp.com, and any (or no) query/path would cause the rule to be considered valid.

 @param doesContain An NSDictionary of NSArrays whose keys can be only the following: "host", "path", "query".  These parameters must be in an NSURL to be considered a match.
 @param doesNotContain An NSDictionary of NSArrays whose keys can be only the following: "host", "path", "query".  These parameters must not be in an NSURL to be considered a match.
 @param context A dictionary that you want to be associated with the rule match

 @see NSURL+YLURLMatchingRuleUtils
 */
+ (instancetype)matchingRuleURLDoesContain:(NSDictionary *)doesContain doesNotContain:(NSDictionary *)doesNotContain context:(NSDictionary *)context;

/*!
 Given an array of YLURLMatchingRule objects, will check each rule in order and return the first rule that matches the URL
 @param url The url to match rules against
 @param rules An NSArray of YLURLMatchingRule
 @return The first rule matched in the array, nil otherwise
*/
+ (instancetype)firstRuleMatchingURL:(NSURL *)url inRules:(NSArray */*of YLURLMatchingRule*/)rules;

/*!
 Giving an NSURL, will return YES/NO if that YLURLMatchingRule matches the current NSURL
 @param url The url to match the current rule against
 @return YES if the URL matches the rule, NO otherwise
 */
- (BOOL)matchesURL:(NSURL *)url;

@property (readonly, copy, nonatomic) NSDictionary *doesContainRules;
@property (readonly, copy, nonatomic) NSDictionary *doesNotContainRules;
@property (readonly, copy, nonatomic) NSDictionary *context;

@end
