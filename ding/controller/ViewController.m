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
#define FileName @"cn.edu.zucc.iOSclub.ding.plist"

@interface ViewController ()<NSURLSessionDataDelegate>//这个是请求数据的代理
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property(strong,nonatomic)NSManagedObjectContext *context;
@property (nonatomic,strong) NSTimer *timer;//轮播定时器
@property User *user;



@end

@implementation ViewController

- (void)viewDidLoad {
    self.user = [[User alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //test
    [self setupContext];

    //设置轮播图
    int count = 5;
    CGFloat imageY = 0;
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        NSString *imageName = [NSString stringWithFormat:@"img_0%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    CGFloat contentW = count * imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.pageControl.numberOfPages = count;
    self.scrollView.pagingEnabled = YES;
    [self addTimer];
    self.scrollView.delegate=self;
    //键盘监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.password setSecureTextEntry:YES];
    
    // 判断是否存在保存偏好设置的文件
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self filePath]]) {
        // 创建NSUserDefaults实例对象
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *name=[user objectForKey:@"Name"];
        NSString *password=[user objectForKey:@"Password"];
        BOOL remember=[[user objectForKey:@"isRemember"]boolValue];
        
        // 显示到界面中
        self.username.text=name;
        if (remember) {
            self.password.text=password;
        }
        [self.rememberSwitch setOn:remember];
        
    }
    
    
}


//添加定时器方法
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//移除定时器
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

// 定时器调用的方法
- (void)nextImage{
    // 图片的总数
    int count = 5;
    // 增加pageControl的页码
    NSInteger page = 0;
    if (self.pageControl.currentPage == count - 1) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    // 计算scrollView滚动的位置
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}
//开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
//停止拖拽的时候调用方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    [UIView beginAnimations:@"keyboardWillShow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect rect=self.view.frame;
    rect.origin.y=-60;
    self.view.frame=rect;
    [UIView commitAnimations];
}

// 键盘关闭时调用的方法
-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:@"keyboardWillHide" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
    [UIView commitAnimations];
}

// 屏幕单击事件响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES]; // 退出键盘
}

-(void)dealloc{
    // 移除通知监听器
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// 按回车键，切换文本框的输入焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username) {
        [self.password becomeFirstResponder];
    }
    return YES;
}

// 获取路径FileName文件的路径的方法
-(NSString *)filePath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Preferences"];
    return [finalPath stringByAppendingPathComponent:FileName];
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
    NSString *name=self.username.text;
    NSString *password=self.password.text;
    NSNumber *remember=[NSNumber numberWithBool:self.rememberSwitch.on];
    
    [self requestURL];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
          [user setObject:name forKey:@"Name"];
          [user setObject:password forKey:@"Password"];
          [user setObject:remember forKey:@"isRemember"];
          
          // 立即保存信息
          [user synchronize];
}

- (IBAction)showPassword:(id)sender {
    if(![sender isOn]){
           [self.password setSecureTextEntry:YES];
       }else{
           [self.password setSecureTextEntry:NO];
       }
}
- (void)setupContext{
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSError *error = nil;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"user.sqlite"];
    NSLog(@"文件路径：%@", sqlitePath);
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    
    context.persistentStoreCoordinator = store;
    
    self.context = context;
}



@end
