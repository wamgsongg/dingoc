//
//  ViewController.m
//  ding
//
//  Created by wangsong on 2020/5/25.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()<NSURLSessionDataDelegate>//这个是请求数据的代理

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property User *user;



@end

@implementation ViewController

- (void)viewDidLoad {
    self.user = [[User alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //test
    
}

//请求URL
- (void)requestURL {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    NSString *urlStr = @"http://localhost:8080/user/login";
    //这里是将urlStr转换成了标准的网址
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求对象,这里是GET请求,NSURLRequest默认是GET请求,NSURLMutableRequest是POST请求
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //POST请求这样写,就这个地方不一样,其余全部一样
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *name = _username.text;//参数
    NSString *pwd = _password.text;//参数
    NSString *args = [NSString stringWithFormat:@"loginname=%@&password=%@",name,pwd];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    NSLog(@"dic:%@", dic);
    NSString *msg = [dic valueForKey:@"msg"];
     NSDictionary *data = [dic valueForKey:@"data"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if ([msg isEqualToString:@"success"]) {
        User *u = [[User alloc]init];
      
        u.loginName = [data valueForKey:@"loginName"];
        u.user_name = [data valueForKey:@"userName"];
    
        u.uid = [[data valueForKey:@"uid"] intValue];
        u.userCode = [data valueForKey:@"userCode"];
        u.userDepartment = [data valueForKey:@"userDepartment"];
        u.did = [[data valueForKey:@"userDid"] intValue];
        u.userEmail = [data valueForKey:@"userEmail"];
        u.userIcon = [data valueForKey:@"userIcon"];
        u.userQQ = [data valueForKey:@"userQq"];
        u.userSex = [data valueForKey:@"userSex"];
        u.userStatus = [data valueForKey:@"userStatus"];
        u.userWechat = [data valueForKey:@"userWechat"];
        u.userTel = [data valueForKey:@"userTel"];
        app.usr = u;
        
    }
    if (app.usr.loginName!=nil) {
                  NSLog(@"usr:%@",app.usr);
        
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
    else{
        [MBProgressHUD showError:@"fail"];
        return;
    }
   // NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
   // NSLog(@"%@", result);
   
    //创建会话对象,并设置代理
     /*
      第一个参数：会话对象的配置信息,defaultSessionConfiguration表示默认配置
     NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
     config.timeoutIntervalForRequest = 10;//超时时间
     config.allowsCellularAccess = YES;//是否允许使用蜂窝网络(后台传输不适用)
     */
    /*
     第二个参数：谁成为代理，此处为控制器本身即self
     */
    /*
     第三个参数：队列，该队列决定代理方法在哪个线程中调用，可以传主队列|非主队列;
     [NSOperationQueue mainQueue]   主队列：   代理方法在主线程中调用
     [[NSOperationQueue alloc]init] 非主队列： 代理方法在子线程中调用
     */
    //NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    
    //这是普通的GET和POST 数据请求(将session和request传到下级)
    //[self dataSession:session withRequest:request];
    
    //上传文件(将session和request传到下级)
    //[self fileUploadSession:session withRequest:request];
    
}

/*************普通的GET和POST 数据请求****************普通的GET和POST 数据请求*********************/
- (void)dataSession:(NSURLSession *)session withRequest:(NSURLRequest *)request {
    
    // 会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            //解析JSON
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"dic:%@", dic);
            NSDictionary *data = [dic valueForKey:@"data"];
            NSLog(@"data:%@", data);
            NSString *msg = [dic valueForKey:@"msg"];
            if ([msg isEqualToString:@"success"]) {
                User *u = [[User alloc]init];
                u.loginName = [data valueForKey:@"loginName"];
                self.user = u;
            }
        } else {
            
            NSLog(@"error is %@", error.localizedDescription);
        }
        if (self.user.loginName!=nil) {
               NSLog(@"loginname:%@",self.user.loginName);
             [self performSegueWithIdentifier:@"login" sender:nil];
        }else{
            [MBProgressHUD showError:@"fail"];
            return;
        }
        
    }];
    
    //执行任务
    [dataTask resume];
   
    
}

//
//#pragma mark ---NSURLSessionDataDelegate(普通GET和POST 数据请求代理)
////接收到服务器响应的时候调用该方法
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
//
//    //NSLog(@"%@", response);
//
//    //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
//    //默认是取消的
//    /*
//        NSURLSessionResponseCancel = 0,         默认的处理方式，取消
//        NSURLSessionResponseAllow = 1,          接收服务器返回的数据
//        NSURLSessionResponseBecomeDownload = 2, 变成一个下载请求
//        NSURLSessionResponseBecomeStream        变成一个流
//    */
//   // completionHandler(NSURLSessionResponseAllow);
//   // completionHandler(NSURLSessionResponseCancel);
//}
//
////接收到服务器返回数据会调用该方法,可能调用多次
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
//
//    NSLog(@"ddd:%@", data);
//
//    //拼接服务器返回的数据
//    //[self.data appendData:data];
//
//}
//
//
//
//
//
//#pragma maek---数据请求,文件上传,文件下载通用的方法
////任务完成时候(成功或者失败)的时候都会调用该方法,如果请求失败则error有值
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//
//    if (error == nil) {
//        //NSLog(@"%@", session);
//    }else {
//        NSLog(@"%@", error);
//        // 保存恢复数据(断点下载)
//        NSLog(@"%@", error.userInfo[NSURLSessionDownloadTaskResumeData]);
//    }
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)userLogin:(id)sender {
    
    [self requestURL];
    
    
    //返回
    //[self dismissModalViewControllerAnimated:true];
}



@end
