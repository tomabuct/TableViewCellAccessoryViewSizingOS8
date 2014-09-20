//
//  YLDeviceUtils.h
//  YLUtils
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

typedef NS_ENUM(NSInteger, YLDeviceType) {
  YLDeviceTypeUnknown = 0,
  YLDeviceTypeIPhoneSimulator,
  YLDeviceTypeIPodTouch,
  YLDeviceTypeIPodTouch2,
  YLDeviceTypeIPodTouch3,
  YLDeviceTypeIPodTouch4,
  YLDeviceTypeIPodTouch5,
  YLDeviceTypeIPhone,
  YLDeviceTypeIPhone3G,
  YLDeviceTypeIPhone3GS,
  YLDeviceTypeIPhone4,
  YLDeviceTypeIPhone4S,
  YLDeviceTypeIPhone5,
  YLDeviceTypeIPhone5C,
  YLDeviceTypeIPhone5S,
  YLDeviceTypeIPad,
  YLDeviceTypeIPad2,
  YLDeviceTypeIPadMini,
  YLDeviceTypeIPad3,
  YLDeviceTypeIPad4
};

extern NSString *const YLAppVersionUnknown;
extern NSString *const YLInterfaceOrientationPortrait;
extern NSString *const YLInterfaceOrientationLandscape;

@interface YLDeviceUtils : NSObject

+ (YLDeviceUtils *)sharedUtils;

/*!
 Check whether this device supports NSURLs with tel:// prefix
 @result YES if tel:// is supported
 */
- (BOOL)hasTelephone;

/*!
 Check whether this device supports NSURLS in skype format
 @result YES if skype is supported
 */
- (BOOL)hasSkype;

//! Returns whether we have a camera or not
- (BOOL)hasCamera;

/*!
 Get the current device type.
 @result Device type
 */
- (YLDeviceType)deviceType;

//! Returns true if the current user interface idiom is iPad
- (BOOL)isPad;

/*!
 @result YES if iOS7 or later
 */
- (BOOL)isOS7OrLater;

/*!
 @result YES if iOS8 or later
 */
- (BOOL)isOS8OrLater;

/*!
 @param version The version to check as a string, e.g. "7.0"
 @result YES if the versions exactly match
 @warning "7.0.0" does not equal "7.0"
 */
- (BOOL)systemVersionIsEqualTo:(NSString *)version;

/*!
 @param version The version to check as a string, e.g. "7.0"
 @param inclusive Whether to include the first parameter in the check
 @result YES if the system version is greater than (or equal to) the first parameter
 */
- (BOOL)systemVersionIsGreaterThan:(NSString *)version inclusive:(BOOL)inclusive;

/*!
 @param version The version to check as a string, e.g. "7.0"
 @param inclusive Whether to include the first parameter in the check
 @result YES if the system version is less than (or equal to) the first parameter
 */
- (BOOL)systemVersionIsLessThan:(NSString *)version inclusive:(BOOL)inclusive;

/*!
 Machine name (from utsname).
 */
- (NSString *)appleMachineName;

/*!
 @result YES if iPhone 4S or higher
 */
- (BOOL)isIPhone4SOrHigher;

/*!
 @result YES if iPhone 5 or higher
 */
- (BOOL)isIPhone5OrHigher;

/*!
 Check whether device can make phone calls.
 @result YES if has a phone, NO otherwise
 */
- (BOOL)canMakePhoneCall;

/*!
 Version of device.
 @result Version from Info plist
 */
- (NSString *)appVersion;

/*!
 @result YES if the current device is retina
 */
- (BOOL)isRetina;

/*!
 @result YES if we are a taller screen height.
 */
- (BOOL)isTallScreenHeight;

/*!
 @result Interface orientation of the device.
 */
- (UIInterfaceOrientation)interfaceOrientation;

/*!
 @param The interface orientation
 @result Orientation of the device as a string
 */
- (NSString *)stringFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/*!
 @result The amount of overlap the keyboard has when showing.
 */
- (CGFloat)modalKeyboardOverlap;

@end