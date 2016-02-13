//
//  Helper.m
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2015 Microapps. All rights reserved.
//

#import "Helper.h"
#import "CustomAlertViewDelegate.h"
#import <Github-Swift.h>
#import "Repository.h"
#import "Issue.h"
#import "Contributer.h"
#import "UIImageView+AFNetworking.h"
@implementation Helper

+ (Helper*)getInstance
{
    Helper* _me_1 = [[Helper alloc] init];
    return _me_1;
}
+(NSDate *)dateFromDotNetJSONString:(NSString *)dateString
{
    // Extract the numeric part of the date.  Dates should be in the format
    // "/Date(x)/", where x is a number.  This format is supplied automatically
    // by JSON serialisers in .NET.
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:dateString options:0 range:NSMakeRange(0, [dateString length])];
    
    if (regexResult) {
        // NSTimeInterval is specified in seconds, with milliseconds as
        // fractions.  The value we get back from the web service is specified
        // in milliseconds.  Both values are since 1st Jan 1970 (epoch).
        NSTimeInterval seconds = [[dateString substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        //        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
        //            NSString *sign = [dateString substringWithRange:[regexResult rangeAtIndex:2]];
        //            // hours
        //            seconds += [[NSString stringWithFormat:@"%@%@", sign, [dateString substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
        //            // minutes
        //            seconds += [[NSString stringWithFormat:@"%@%@", sign, [dateString substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        //        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}


+ (NSString*) getDotNetDate:(NSDate*) date {
    double timeSince1970= date.timeIntervalSince1970;
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    offset=offset/3600;
    double nowMillis = 1000.0 * (timeSince1970);
    NSString *dotNetDate=[NSString stringWithFormat:@"/Date(%.0f%+03d00)/",nowMillis,offset] ;
    return dotNetDate;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(id)getJSONDictObjFromString:(NSString *)jsonString{
    NSError * err;
    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        
        return jsonString;
    }
    
    NSData *data =[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * response;
    if(data!=nil){
        response = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    }
    return response;
}

+(NSString *)getStringFromJSONDictObj:(id)jsonDictObj{
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:jsonDictObj options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    return jsonString;
}
+ (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString {
    /*
     Returns a user-visible date time string that corresponds to the specified
     RFC 3339 date time string. Note that this does not handle all possible
     RFC 3339 date time strings, just one of the most common styles.
     */
    
    NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_EG"];
//    2016-02-06T15:17:54Z
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy'-'mm'-'dd'T'HH':'mm':'ss'Z'"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    NSDate *gregorianDate = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    
    NSString *userVisibleDateTimeString;
    if (gregorianDate != nil) {
        // Convert the date object to a user-visible date string.
        NSDateFormatter *userVisibleDateFormatter = [[NSDateFormatter alloc] init];
        assert(userVisibleDateFormatter != nil);
        
        [userVisibleDateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [userVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        userVisibleDateTimeString = [userVisibleDateFormatter stringFromDate:gregorianDate];
    }
    return userVisibleDateTimeString;
}

+(NSMutableArray *)getReposArr:(NSArray *)jsonArr{
    NSMutableArray *reposArr = [[NSMutableArray alloc] init];
    NSError* err = nil;
    Repository* repo = nil;
    NSString* str = nil;
    NSDictionary *repoDict;
    for (int i=0; i<jsonArr.count; i++) {
        repoDict = jsonArr[i];
        str = [self getStringFromJSONDictObj:repoDict];
        str = [str stringByReplacingOccurrencesOfString:@"null"
                                             withString:@"\"\""];
        repo = [[Repository alloc] initWithString:str error:&err];
//        if(err != nil && repo != nil){
        repo.url = [repoDict objectForKey:@"description"];
            [reposArr addObject:repo];
//        }
    }
    return reposArr;

}


+(NSMutableArray *)getIssuesArr:(NSArray *)jsonArr{
    NSMutableArray *issuesArr = [[NSMutableArray alloc] init];
    NSError* err = nil;
    Issue* issue = nil;
    NSString* str = nil;
    NSDictionary *issueDict;
    for (int i=0; i<jsonArr.count; i++) {
        issueDict = jsonArr[i];
        str = [self getStringFromJSONDictObj:issueDict];
        str = [str stringByReplacingOccurrencesOfString:@"null"
                                             withString:@"\"\""];
        issue = [[Issue alloc] initWithString:str error:&err];
        if(err != nil && issue != nil){
            [issuesArr addObject:issue];
        }
    }
    return issuesArr;
    
}


+(NSMutableArray *)getCommittersArr:(NSArray *)jsonArr{
    NSMutableArray *commitsArr = [[NSMutableArray alloc] init];
    NSError* err = nil;
    Contributer* issue = nil;
    NSString* str = nil;
    NSDictionary *issueDict;
    for (int i=0; i<jsonArr.count; i++) {
        issueDict = jsonArr[i];
        str = [self getStringFromJSONDictObj:issueDict];
        str = [str stringByReplacingOccurrencesOfString:@"null"
                                             withString:@"\"\""];
        issue = [[Contributer alloc] initWithString:str error:&err];
//        if(err != nil && issue != nil){
            [commitsArr addObject:issue];
//        }
    }
    return commitsArr;
    
}



+(void) configureSenderImageView:(NSString*)senderImageURL imageView:(UIImageView*)imageView selected:(BOOL)selected
{
//    self.isSenderImageSelected = selected;
    if (selected) {
        imageView.image = [UIImage imageNamed:@"check_yes"];
        imageView.contentMode = UIViewContentModeCenter;
    } else {
        //        [self.senderImageView setImageWithURL:[NSURL URLWithString:senderImageURL] placeholderImage:[UIImage imageNamed:@"person"]];
        [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:senderImageURL]] placeholderImage:[UIImage imageNamed:@"person"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleToFill;
            if (selected) {
                imageView.image = [UIImage imageNamed:@"check_yes"];
                imageView.contentMode = UIViewContentModeCenter;
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            if (selected) {
                imageView.image = [UIImage imageNamed:@"check_yes"];
                imageView.contentMode = UIViewContentModeCenter;
            }
        }];
    }
}
@end
