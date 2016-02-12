//
//  Helper.h
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2015 Microapps. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject
+ (Helper*)getInstance;
+ (NSDate *)dateFromDotNetJSONString:(NSString *)dateString;
+ (NSString*) getDotNetDate:(NSDate*) date;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (void) changeLanguageWithSegmentPosition;
+ (id) getJSONDictObjFromString:(NSString*)jsonString;
+ (NSString*) getStringFromJSONDictObj:(id)jsonDictObj;
+ (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString;
+ (NSMutableArray*) getReposArr:(NSArray *)jsonArr;
@end
