//
//  YLURLMatchingRule.m
//  YLUtils
//
//  Created by Alexander Haefner on 4/11/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLURLMatchingRule.h"

NSString *const kYLURLMatchingRuleKeyHost = @"host";
NSString *const kYLURLMatchingRuleKeyPath = @"path";
NSString *const kYLURLMatchingRuleKeyQuery = @"query";

@interface YLURLMatchingRule ()
@property (copy, nonatomic) NSDictionary *doesContainRules;
@property (copy, nonatomic) NSDictionary *doesNotContainRules;
@property (copy, nonatomic) NSDictionary *context;
@end

@implementation YLURLMatchingRule

+ (instancetype)matchingRuleURLDoesContain:(NSDictionary *)doesContain doesNotContain:(NSDictionary *)doesNotContain context:(NSDictionary *)context {
  YLURLMatchingRule *rule = [[[self class] alloc] init];

  // We'll do some extra validation of arguments, since we are passing dictionaries
  for (NSString *key in [doesContain allKeys]) {
    NSAssert([self _validateKey:key], @"You have given an invalid key argument as a part of the doesContain dictionary.  Allowed keys are host, path, and query");
  }
  for (NSString *key in [doesNotContain allKeys]) {
    NSAssert([self _validateKey:key], @"You have given an invalid key argument as a part of the doesNotContain dictionary.  Allowed keys are host, path, and query");
  }
  for (NSArray *value in [doesContain allValues]) {
    NSAssert([value isKindOfClass:[NSArray class]], @"The values for doesContain must all be arrays");
  }
  for (NSArray *value in [doesNotContain allValues]) {
    NSAssert([value isKindOfClass:[NSArray class]], @"The values for doesNotContain must all be arrays");
  }

  rule.doesContainRules = doesContain;
  rule.doesNotContainRules = doesNotContain;
  rule.context = context;
  return rule;
}

+ (instancetype)firstRuleMatchingURL:(NSURL *)url inRules:(NSArray */*of YLURLMatchingRule*/)rules {
  for (YLURLMatchingRule *rule in rules) {
    if ([rule matchesURL:url]) {
      return rule;
    }
  }
  return nil;
}

- (BOOL)matchesURL:(NSURL *)url {
  // Check that the things that should be present in the URL are
  BOOL ruleMatched = [self _matchRules:self.doesContainRules inURL:url rulesShouldBePresentInURL:YES];
  // Check that the things that should not be present in the URL are not
  ruleMatched = ruleMatched && [self _matchRules:self.doesNotContainRules inURL:url rulesShouldBePresentInURL:NO];
  return ruleMatched;
}

#pragma mark - YLURLMatchingRule private utility methods

- (BOOL)_matchRules:(NSDictionary *)containmentMatchingRules inURL:(NSURL *)url rulesShouldBePresentInURL:(BOOL)shouldBePresentInURL {
  /*
   Returns YES if all the rules in the containmentMatchingRules argument are matched to the components of the URL
   */
  BOOL conditionsMet = YES;
  for (NSString *ruleKeys in @[@"host", @"path", @"query"]) {
    // URLRuleComponents e.g. rules for host part of URL or path part of url
    NSArray *URLRuleComponents = containmentMatchingRules[ruleKeys];
    for (NSString *string in URLRuleComponents) {
      BOOL componentContainsExpectedValue = ([[url valueForKey:ruleKeys] ?: @"" rangeOfString:string].location != NSNotFound);
      conditionsMet = conditionsMet && (componentContainsExpectedValue == shouldBePresentInURL);
    }
  }
  return conditionsMet;
}

+ (BOOL)_validateKey:(NSString *)key {
  return [@[kYLURLMatchingRuleKeyHost, kYLURLMatchingRuleKeyPath, kYLURLMatchingRuleKeyQuery] containsObject:key];
}

@end
