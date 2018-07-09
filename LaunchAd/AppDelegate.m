//
//  AppDelegate.m
//  LaunchAd
//
//  Created by Superman on 2018/7/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchAd.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    ViewController *vc=[[ViewController alloc]init];
    self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:vc];
    NSString *gifUrlString = @"http://img1.imgtn.bdimg.com/it/u=473895314,616407725&fm=206&gp=0.jpg";
//    NSString *gifUrlString=@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=百度图片&step_word=&hs=0&pn=52&spn=0&di=112733981580&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=2340257520%2C3784673432&os=912815621%2C1372726060&simid=4283992138%2C614604785&adpicid=0&lpn=0&ln=1943&fr=&fmq=1531100461883_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fwww.lagou.com%2Fi%2Fimage%2FM00%2F02%2FA9%2FCgqKkVaXQS6AKKguAAE_359Yjsk306.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bsw257_z%26e3Bv54AzdH3F25g2ftAzdH3F88d0a8_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0&islist=&querylist=";
    


    LaunchAd *launchAd =[LaunchAd initImageWithURL:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height-150) strUrl:gifUrlString adDuration:10.0 options:JWWebImageDefault result:^(UIImage *image, NSURL *url) {
        NSLog(@"URL====%@",url);
    }];
    launchAd.hideSkip = NO;
    launchAd.clickBlock = ^{
        NSString *url=@"https://www.baidu.com";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    };
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
