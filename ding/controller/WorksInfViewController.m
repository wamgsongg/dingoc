//
//  WorksInfViewController.m
//  ding
//
//  Created by wangsong on 2020/5/30.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "WorksInfViewController.h"
#import "AppDelegate.h"
#import "PeopleViewController.h"

@interface WorksInfViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myttl;

@property (weak, nonatomic) IBOutlet UILabel *create;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UITextView *content;

@property NSMutableArray *d;

@end

@implementation WorksInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myttl.text = [_data valueForKey:@"wtitle"];
    self.create.text = [_data valueForKey:@"wcreateName"];
    self.date.text = [_data valueForKey:@"wendDate"];
    self.content.text = [_data valueForKey:@"wcontent"];
    //self.wtitle.text = [self.date valueForKey:@"wtitle"];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    if ([segue.identifier  isEqual: @"people"]) {
    //实例化第二个页面
       id vc = segue.destinationViewController;
        PeopleViewController *page2 = vc;
        //传值
        page2.data = _d;
       

    }
}



@end
