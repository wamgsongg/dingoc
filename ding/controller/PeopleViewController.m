//
//  PeopleViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "PeopleViewController.h"
#import "PeopleTableViewCell.h"
#import "PersonViewController.h"

@interface PeopleViewController ()

@end

@implementation PeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_data);

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
    return _data.count;
}
  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
  {
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"PeopleTableViewCell";
    //自定义cell类
    PeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      //通过xib的名称加载自定义的cell
      cell = [[[NSBundle mainBundle] loadNibNamed:@"PeopleTableViewCell" owner:self options:nil] lastObject];
    }
      
    //添加测试数据
      //Work *w =[[Work alloc]init];
      NSDictionary *p = [_data objectAtIndex:indexPath.row];
      //NSLog(@"w:%@",w);
      cell.name.text = [p valueForKey:@"userName"];
      
     
   
    //测试图片
    //cell.iamge.image = [UIImage imageNamed:@"testImage.jpg"];
     return cell;
  }
#pragma mark - Table view delegate
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"person" sender:nil];
}
#pragma mark - actionsheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"person"]) {
    //实例化第二个页面
       id vc = segue.destinationViewController;
       PersonViewController *page2 = vc;
        //传值
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        page2.data = [_data objectAtIndex:path.row];

    }
    
}

@end
