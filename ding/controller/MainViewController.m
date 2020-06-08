//
//  MainViewController.m
//  ding
//
//  Created by wangsong on 2020/5/25.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "Work.h"

@interface MainViewController ()



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestGetWorks];
    [self requestGetWorking];
    // Do any additional setup after loading the view.
}

- (void)requestGetWorks {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = @"http://localhost:8080/works/getbyuid";
    //这里是将urlStr转换成了标准的网址
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求对象,这里是GET请求,NSURLRequest默认是GET请求,NSURLMutableRequest是POST请求
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //POST请求这样写,就这个地方不一样,其余全部一样
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
    NSString *id = [NSString stringWithFormat:@"%d",app.usr.uid];
    NSString *args = [NSString stringWithFormat:@"uid=%@",id];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"arg:%@", args);
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    NSLog(@"wdic:%@", dic);
    NSString *msg = [dic valueForKey:@"msg"];
    NSMutableArray *data = [dic valueForKey:@"data"];
    
    if ([msg isEqualToString:@"参加的事务"]) {
        app.works = data;
        
    }
    NSLog(@"works:%@",app.works);
}
- (void)requestGetWorking {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = @"http://localhost:8080/works/getbydate";
    //这里是将urlStr转换成了标准的网址
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求对象,这里是GET请求,NSURLRequest默认是GET请求,NSURLMutableRequest是POST请求
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //POST请求这样写,就这个地方不一样,其余全部一样
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
    
    //NSString *args = [NSString stringWithFormat:@""];
    //request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"arg:%@", args);
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    NSLog(@"wdic:%@", dic);
    NSString *msg = [dic valueForKey:@"msg"];
    NSMutableArray *data = [dic valueForKey:@"data"];
    
    if ([msg isEqualToString:@"success"]) {
        app.working = data;
       // NSLog(@"%@",app.working);
    }
    //NSLog(@"works:%@",app.works);
}


@end
