//
//  MyWorksInfViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "MyWorksInfViewController.h"
#import "AppDelegate.h"
#import "People2ViewController.h"

@interface MyWorksInfViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myttl;
@property (weak, nonatomic) IBOutlet UILabel *create;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *content;

@property NSMutableArray *d;

@end

@implementation MyWorksInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.myttl.text = [_data valueForKey:@"wtitle"];
       self.create.text = [_data valueForKey:@"wcreateName"];
       self.date.text = [_data valueForKey:@"wendDate"];
       self.content.text = [_data valueForKey:@"wcontent"];
}
- (void)requestGetPeople {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = @"http://localhost:8080/people/getbywid";
    //这里是将urlStr转换成了标准的网址
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求对象,这里是GET请求,NSURLRequest默认是GET请求,NSURLMutableRequest是POST请求
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //POST请求这样写,就这个地方不一样,其余全部一样
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
  
    NSString *args = [NSString stringWithFormat:@"wid=%@",[_data valueForKey:@"wid"]];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
   
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    
    NSString *msg = [dic valueForKey:@"msg"];
    NSMutableArray *data = [dic valueForKey:@"data"];
    
    if ([msg isEqualToString:@"success"]) {
        
        _d=data;
      // [self performSegueWithIdentifier:@"people" sender:nil];
        
    }
   // NSLog(@"works:%@",app.works);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     [self requestGetPeople];
    if ([segue.identifier  isEqual: @"people2"]) {
    //实例化第二个页面
       id vc = segue.destinationViewController;
        People2ViewController *page2 = vc;
        //传值
        page2.data = _d;
       

    }
}



@end
