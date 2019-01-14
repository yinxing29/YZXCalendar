//
//  YZXCalendarHeader.h
//  YZXCalendar
//
//  Created by 尹星 on 2018/3/15.
//  Copyright © 2018年 尹星. All rights reserved.
//

#ifndef YZXCalendarHeader_h
#define YZXCalendarHeader_h

#define CustomRedColor [UIColor hexColor:@"dd514d"]
#define CustomBlackColor [UIColor hexColor:@"4a4a4a"]
#define CustomLineColor [UIColor hexColor:@"f2f2f2"]
#define CustomGrayColor [UIColor hexColor:@"9b9b9b"]
#define CustomColor(x) [UIColor hexColor:x]
#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//当前window
#define Window [[UIApplication sharedApplication].delegate window]

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

/*当前机型是否iPhoneX或iPhoneXs*/
#define YZX_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/*当前机型是否iPhoneXR*/
#define YZX_IPHONEXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

/*当前机型是否iPhoneXsMax*/
#define YZX_IPHONEXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

/*当前机型是否iPhoneX系列*/
#define kDevice_iPhoneX (YZX_IPHONEX || YZX_IPHONEXR || YZX_IPHONEXSMAX)

#define StatusBarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height

#define HomeIndicator  34

#define NavigationBarHeight  44

#define errorLog(x) NSLog(@"%@",x);

//判断是否为iPhone_x,确定显示内容应该减去的高度
//#ifdef kDevice_iPhoneX

#define TOPHEIGHT_IPHONE_X (StatusBarHeight + NavigationBarHeight + HomeIndicator)

//#else

#define TOPHEIGHT (StatusBarHeight + NavigationBarHeight)

//#endif
//-----

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define FONT8   [UIFont systemFontOfSize:8.0f]
#define FONT9   [UIFont systemFontOfSize:9.0f]
#define FONT10  [UIFont systemFontOfSize:10.0f]
#define FONT11  [UIFont systemFontOfSize:11.0f]
#define FONT12  [UIFont systemFontOfSize:12.0f]
#define FONT13  [UIFont systemFontOfSize:13.0f]
#define FONT14  [UIFont systemFontOfSize:14.0f]
#define FONT15  [UIFont systemFontOfSize:15.0f]
#define FONT16  [UIFont systemFontOfSize:16.0f]
#define FONT17  [UIFont systemFontOfSize:17.0f]
#define FONT18  [UIFont systemFontOfSize:18.0f]
#define FONT19  [UIFont systemFontOfSize:19.0f]
#define FONT20  [UIFont systemFontOfSize:20.0f]
#define FONT21  [UIFont systemFontOfSize:21.0f]
#define FONT22  [UIFont systemFontOfSize:22.0f]
#define FONT23  [UIFont systemFontOfSize:23.0f]
#define FONT26  [UIFont systemFontOfSize:26.0f]
#define FONT30  [UIFont systemFontOfSize:30.0f]
#define FONT31  [UIFont systemFontOfSize:31.0f]
#define FONT32  [UIFont systemFontOfSize:32.0f]
#define FONT33  [UIFont systemFontOfSize:33.0f]
#define FONT34  [UIFont systemFontOfSize:34.0f]
#define FONT35  [UIFont systemFontOfSize:35.0f]
#define FONT36  [UIFont systemFontOfSize:36.0f]

#endif /* YZXCalendarHeader_h */
