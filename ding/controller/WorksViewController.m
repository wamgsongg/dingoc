//
//  WorksViewController.m
//  ding
//
//  Created by wangsong on 2020/5/26.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "WorksViewController.h"
#import "AppDelegate.h"
#import "Work.h"
#import "WorksTableViewCell.h"
#import "WorksInfViewController.h"


@interface WorksViewController ()
@property NSMutableArray *tableData;
@end

@implementation WorksViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [self requestGetWork];
    _tableData = app.works;
    if ([app.usr.userStatus isEqualToString:@"员工"]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.tableView.rowHeight = 90;
}
- (void)requestGetWork {
    
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
- (void)requestGetWorks {
    
    //设置请求的URL(注意网址里面不要加中文字符,如果不放心可以用注释这个)
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = @"http://localhost:8080/works/getbycid";
    //这里是将urlStr转换成了标准的网址
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求对象,这里是GET请求,NSURLRequest默认是GET请求,NSURLMutableRequest是POST请求
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //POST请求这样写,就这个地方不一样,其余全部一样
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
      request.HTTPMethod = @"POST";
    NSString *id = [NSString stringWithFormat:@"%d",app.usr.uid];
    NSString *args = [NSString stringWithFormat:@"cid=%@",id];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"arg:%@", args);
    NSURLResponse *response = nil;
    NSData *da = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:da options:kNilOptions error:nil];
    NSLog(@"wdic:%@", dic);
    NSString *msg = [dic valueForKey:@"msg"];
    NSMutableArray *data = [dic valueForKey:@"data"];
    
    if ([msg isEqualToString:@"发起的事务"]) {
       
        app.myworks = data;
    }
   
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
 }
  
#pragma mark - Table view data source
  
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   return 1;
}
  
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}
  
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //指定cellIdentifier为自定义的cell
  static NSString *CellIdentifier = @"WorksTableViewCell";
  //自定义cell类
  WorksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //通过xib的名称加载自定义的cell
    cell = [[[NSBundle mainBundle] loadNibNamed:@"WorksTableViewCell" owner:self options:nil] lastObject];
  }
    
  //添加测试数据
    //Work *w =[[Work alloc]init];
    NSDictionary *w = [_tableData objectAtIndex:indexPath.row];
    NSLog(@"w:%@",w);
    cell.title.text = [w valueForKey:@"wtitle"];
    
    
    cell.create.text = [w valueForKey:@"wcreateName"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[w valueForKey:@"wendDate"]];
    NSLog(@"w1:%@",strDate);
    
   
   
    cell.endDate.text = [w valueForKey:@"wendDate"];
    cell.status.text = [w valueForKey:@"wstatus"];
  //测试图片
  //cell.iamge.image = [UIImage imageNamed:@"testImage.jpg"];
   return cell;
}
  
#pragma mark - Table view delegate
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"work" sender:nil];
}
#pragma mark - actionsheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  执行跳转之前会调用
 *  在这个方法中,目标控制器的view还没有被创建
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"work"]) {
    //实例化第二个页面
       id vc = segue.destinationViewController;
        WorksInfViewController *page2 = vc;
        //传值
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        page2.data = [_tableData objectAtIndex:path.row];

    }else if ([segue.identifier  isEqual: @"mycreate"]){
        [self requestGetWorks];
    }
    
}
@end
