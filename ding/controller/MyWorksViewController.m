//
//  MyWorksViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "MyWorksViewController.h"
#import "AppDelegate.h"
#import "WorksTableViewCell.h"
#import "MyWorksInfViewController.h"

@interface MyWorksViewController ()
@property NSMutableArray *tableData;
@end

@implementation MyWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    _tableData = app.myworks;
    
    self.tableView.rowHeight = 90;
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
   
    cell.endDate.text = [w valueForKey:@"wendDate"];
    cell.status.text = [w valueForKey:@"wstatus"];
  //测试图片
  //cell.iamge.image = [UIImage imageNamed:@"testImage.jpg"];
   return cell;
}
  
#pragma mark - Table view delegate
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"mywork" sender:nil];
}
#pragma mark - actionsheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"mywork"]) {
    //实例化第二个页面
       id vc = segue.destinationViewController;
        MyWorksInfViewController *page2 = vc;
        //传值
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        page2.data = [_tableData objectAtIndex:path.row];

    }
    
}

@end
