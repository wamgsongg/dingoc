//
//  WorkingInfViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "WorkingInfViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD+MJ.h"


@interface WorkingInfViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myttl;
@property (weak, nonatomic) IBOutlet UILabel *create;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WorkingInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[_data valueForKey:@"wtitle"] isKindOfClass:[NSNull class]]) {
         self.myttl.text = [_data valueForKey:@"wtitle"];
    }
   if (![[_data valueForKey:@"wcreateName"] isKindOfClass:[NSNull class]]) {
       self.create.text = [_data valueForKey:@"wcreateName"];
   }
    if (![[_data valueForKey:@"wendDate"] isKindOfClass:[NSNull class]]) {
        self.date.text = [_data valueForKey:@"wendDate"];
    }
    if (![[_data valueForKey:@"wcontent"] isKindOfClass:[NSNull class]]) {
         self.content.text = [_data valueForKey:@"wcontent"];
    }
     
}

- (void)requestAddEvent {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = @"http://localhost:8080/event/create";
 
    NSURL *url = [NSURL URLWithString:urlStr];
    

    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
  NSString *id = [NSString stringWithFormat:@"%d",app.usr.uid];
    NSString *args = [NSString stringWithFormat:@"uid=%@&wid=%@",id,[_data valueForKey:@"wid"]];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
   
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    
    NSString *msg = [dic valueForKey:@"msg"];
    NSMutableArray *data = [dic valueForKey:@"data"];
    
    [MBProgressHUD showSuccess:msg];
               return;
        
    
   // NSLog(@"works:%@",app.works);
}

- (IBAction)apply:(id)sender {
    [self requestAddEvent];
}


@end
