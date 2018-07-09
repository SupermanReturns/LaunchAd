//
//  ViewController.m
//  LaunchAd
//
//  Created by Superman on 2018/7/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+JWWebCache.h"

@interface ViewController ()
@property (weak, nonatomic)  UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:webView];
    _webView=webView;
    [_webView setUserInteractionEnabled:YES];             //是否支持交互
    [_webView setOpaque:YES];                              //Opaque为不透明的意思
    [_webView setScalesPageToFit:YES];                    //自动缩放以适应屏幕

    // Do any additional setup after loading the view, typically from a nib.

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
