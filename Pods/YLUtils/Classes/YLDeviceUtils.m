//
//  YLDeviceUtils.m
//  YLUtils
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLDeviceUtils.h"

#include <sys/utsname.h>

NSString *const YLAppVersionUnknown = @"Unknown";
NSString *const YLInterfaceOrientationPortrait = @"portrait";
NSString *const YLInterfaceOrientationLandscape = @"landscape";

NSString *const kOS7VersionString = @"7.0";
NSString *const kOS8VersionString = @"8.0";

@interface YLDeviceUtils ()
@property (copy, nonatomic) NSString *version;
@end

@implementation YLDeviceUtils

+ (YLDeviceUtils *)sharedUtils {
  static YLDeviceUtils *gUtils = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    gUtils = [[[self class] alloc] init];
  });
  return gUtils;
}

- (BOOL)hasTelephone {
  return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4155551234"]];
}

- (BOOL)hasSkype {
  return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype://4155551234?call"]];
}

- (BOOL)hasCamera {
#if TARGET_IPHONE_SIMULATOR
  return YES;
#endif
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)canMakePhoneCall {
  return [self hasTelephone] || [self hasSkype];
}

- (NSString *)appleMachineName {
  struct utsname u;
  if (uname(&u) >= 0) return [NSString stringWithUTF8String:u.machine];
  return nil;
}

- (BOOL)isPad {
  return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (NSString *)_systemVersion {
  static NSString *SystemVersion = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SystemVersion = [[UIDevice currentDevice] systemVersion];
  });
  return SystemVersion;
}

- (BOOL)isOS7OrLater {
  return [self systemVersionIsGreaterThan:kOS7VersionString inclusive:YES];
}

- (BOOL)isOS8OrLater {
  return [self systemVersionIsGreaterThan:kOS8VersionString inclusive:YES];
}

- (BOOL)systemVersionIsEqualTo:(NSString *)version {
  return [[self _systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame;
}

- (BOOL)systemVersionIsGreaterThan:(NSString *)version inclusive:(BOOL)inclusive {
  NSComparisonResult comparisonResult = [[self _systemVersion] compare:version options:NSNumericSearch];
  if (inclusive) {
    return comparisonResult != NSOrderedAscending;
  } else {
    return comparisonResult == NSOrderedDescending;
  }
}

- (BOOL)systemVersionIsLessThan:(NSString *)version inclusive:(BOOL)inclusive {
  NSComparisonResult comparisonResult = [[self _systemVersion] compare:version options:NSNumericSearch];
  if (inclusive) {
    return comparisonResult != NSOrderedDescending;
  } else {
    return comparisonResult == NSOrderedAscending;
  }
}

- (YLDeviceType)deviceType {
  NSString *machine = [self appleMachineName];
  return (YLDeviceType)[self _deviceTypes][machine] ? : YLDeviceTypeUnknown;
}

/*!
 Get a dictionary of all known device types.
 @result Device type dictionary
 */
- (NSDictionary *)_deviceTypes {
  static NSDictionary *DeviceTypes;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // This list is sourced from http://theiphonewiki.com/wiki/Models
    DeviceTypes = @{
                    @"iPod1,1" : @(YLDeviceTypeIPodTouch),
                    @"iPod2,1" : @(YLDeviceTypeIPodTouch2),
                    @"iPod3,1" : @(YLDeviceTypeIPodTouch3),
                    @"iPod4,1" : @(YLDeviceTypeIPodTouch4),
                    @"iPod5,1" : @(YLDeviceTypeIPodTouch5),
                    @"i386" : @(YLDeviceTypeIPhoneSimulator),
                    @"x86_64" : @(YLDeviceTypeIPhoneSimulator),
                    @"iPhone1,1" : @(YLDeviceTypeIPhone),
                    @"iPhone1,2" : @(YLDeviceTypeIPhone3G),
                    @"iPhone2,1" : @(YLDeviceTypeIPhone3GS),
                    @"iPhone3,1" : @(YLDeviceTypeIPhone4), // GSM
                    @"iPhone3,2" : @(YLDeviceTypeIPhone4), // Unknown - China?
                    @"iPhone3,3" : @(YLDeviceTypeIPhone4), // CDMA
                    @"iPhone4,1" : @(YLDeviceTypeIPhone4S),
                    @"iPhone5,1" : @(YLDeviceTypeIPhone5), // GSM
                    @"iPhone5,2" : @(YLDeviceTypeIPhone5), // Universal
                    @"iPhone5,3" : @(YLDeviceTypeIPhone5C), // GSM
                    @"iPhone5,4" : @(YLDeviceTypeIPhone5C), // Universal
                    @"iPhone6,1" : @(YLDeviceTypeIPhone5S), // GSM
                    @"iPhone6,2" : @(YLDeviceTypeIPhone5S), // Universal
                    @"iPad1,1" : @(YLDeviceTypeIPad),
                    @"iPad2,1" : @(YLDeviceTypeIPad2), // WiFi-only
                    @"iPad2,2" : @(YLDeviceTypeIPad2), // GSM
                    @"iPad2,3" : @(YLDeviceTypeIPad2), // CDMA
                    @"iPad2,4" : @(YLDeviceTypeIPad2), // New iPad 2
                    @"iPad2,5" : @(YLDeviceTypeIPadMini), // WiFi-only
                    @"iPad2,6" : @(YLDeviceTypeIPadMini), // GSM
                    @"iPad2,7" : @(YLDeviceTypeIPadMini), // Universal
                    @"iPad3,1" : @(YLDeviceTypeIPad3), // WiFi-only
                    @"iPad3,2" : @(YLDeviceTypeIPad3), // Universal
                    @"iPad3,3" : @(YLDeviceTypeIPad3), // GSM-only
                    @"iPad3,4" : @(YLDeviceTypeIPad4), // WiFi-only
                    @"iPad3,5" : @(YLDeviceTypeIPad4), // GSM-only
                    @"iPad3,6" : @(YLDeviceTypeIPad4) // Universal
                    };
  });
  return DeviceTypes;
}

/*!
 @result iPhone major version number, i.e. if it's iPhone5,1 then major version is 5
 */
- (NSInteger)_iPhoneHardwareMajorVersion {
  NSString *machine = [self appleMachineName];
  
  if ([machine hasPrefix:@"iPhone"] && [machine length] >= 7) {
    NSString *hwVersion = [machine substringWithRange:NSMakeRange(6, 1)];
    return [hwVersion integerValue];
  }
  
  return 0;
}

- (BOOL)isIPhone4SOrHigher {
  return [self _iPhoneHardwareMajorVersion] >= 4;
}

- (BOOL)isIPhone5OrHigher {
  return [self _iPhoneHardwareMajorVersion] >= 5;
}

- (NSString *)appVersion {
  if (!self.version) {
    self.version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
  }
  return self.version ?: YLAppVersionUnknown;
}

- (BOOL)isRetina {
  return [[UIScreen mainScreen] scale] == 2;
}

- (BOOL)isTallScreenHeight {
  // Test against the bounds because applicationFrame might be smaller due to status bar
  return ![self isPad] && [[UIScreen mainScreen] bounds].size.height >= 568;
}

- (UIInterfaceOrientation)interfaceOrientation {
  return [UIApplication sharedApplication].statusBarOrientation;
}

- (NSString *)stringFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  switch (interfaceOrientation) {
    case UIInterfaceOrientationPortrait:
    case UIInterfaceOrientationPortraitUpsideDown:
      return YLInterfaceOrientationPortrait;
    case UIInterfaceOrientationLandscapeLeft:
    case UIInterfaceOrientationLandscapeRight:
      return YLInterfaceOrientationLandscape;
  }
  return nil;
}

- (CGFloat)modalKeyboardOverlap {
  // TODO(nakoury): I hate doing it this way, but I'm not sure of a way to precalculate the overlap. I use the hide/show keyboard notifications to actually determine the overlap when I can, but I can't arbitrarily determine what the overlap will be that way.
  CGFloat keyboardOverlap = 216;
  if ([self isPad]) {
    if (UIInterfaceOrientationIsLandscape([self interfaceOrientation])) {
      keyboardOverlap = 224;
    } else {
      keyboardOverlap = 72;
    }
  }
  
  return keyboardOverlap;
}

@end