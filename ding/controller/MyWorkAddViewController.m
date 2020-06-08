//
//  MyWorkAddViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "MyWorkAddViewController.h"
#import "Work.h"
#import "MBProgressHUD+MJ.h"
#import "AppDelegate.h"

@interface MyWorkAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myttl;
@property (weak, nonatomic) IBOutlet UIDatePicker *enddate;
@property (weak, nonatomic) IBOutlet UITextView *content;


@end

@implementation MyWorkAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}
- (void)requestAddWork{
    NSMutableDictionary *work = [[NSMutableDictionary alloc]init];
    
    NSString *ttl = _myttl.text;
       if (![ttl isEqualToString:@""]) {
           [work setValue:ttl forKey:@"wTitle"];
       }else{
           [MBProgressHUD showError:@"请输入title"];
           return;
       }
       NSString *cont = _content.text;
       if (![cont isEqualToString:@""]) {
           [work setValue:cont forKey:@"wContent"];
       }else{
           [MBProgressHUD showError:@"请输入content"];
           return;
       }
       NSDate *theDate = [_enddate date];
       if (theDate) {
           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
           formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
           NSString *dateString = [formatter stringFromDate:theDate];
           [work setValue:dateString forKey:@"wEndDate"];
       }else{
           [MBProgressHUD showError:@"请选择endDate"];
           return;
       }
       AppDelegate *app = [[UIApplication sharedApplication] delegate];
       [work setValue:[NSString stringWithFormat:@"%d",app.usr.uid] forKey:@"wCreateId"];
       [work setValue:app.usr.user_name forKey:@"wCreateName"];
       [work setValue:app.usr.userDepartment forKey:@"wDepartment"];
       [work setValue:@"doing" forKey:@"wStatus"];
       NSLog(@"%@",work);
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    
    NSString *urlStr = @"http://localhost:8080/works/create";

    NSURL *url = [NSURL URLWithString:urlStr];
  
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
    NSData* json = [NSJSONSerialization dataWithJSONObject:work options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
   // NSData *bodyData = [NSKeyedArchiver archivedDataWithRootObject:work];
   // request.HTTPBody = bodyData;
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//
//     NSURLResponse *response = nil;
//    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
//    NSLog(@"wdic:%@", dic);
//    NSString *msg = [dic valueForKey:@"msg"];
//    NSMutableArray *data = [dic valueForKey:@"data"];
     NSURLSession* session = [NSURLSession sharedSession];
        NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // 错误判断
            if (data==nil||error)return;
           // 解析JSON
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"wdic:%@", dic);
            NSString *msg = [dic valueForKey:@"msg"];
            NSMutableArray *da = [dic valueForKey:@"data"];
            
            if ([msg isEqualToString:@"success"]) {
                [MBProgressHUD showSuccess:msg];
                return;
                // NSLog(@"%@",app.working);
            }
        }];
        
    [task resume];
    
    
    
    //NSLog(@"works:%@",app.works);
}



- (IBAction)add:(id)sender {
   
   [self requestAddWork];
}

@end
