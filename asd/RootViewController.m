//
//  RootViewController.m
//  asd
//
//  Created by 创新创业中心 on 16/7/14.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "RootViewController.h"
#import "secondpage.h"
#import "Header.h"
#import "correctpage.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidden = 0;
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title=@"备忘录";
    [self.navigationController.navigationBar setBarTintColor:[UIColor purpleColor]];
    UIBarButtonItem *leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonSystemItemSearch target:self action:@selector(makeSelectable)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    UIBarButtonItem*rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"添加"style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
 [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
   
    
    
    
    CGRect windowframe=[[UIScreen mainScreen]bounds];
    [super viewDidLoad];
    self.data =[[UITableView alloc]initWithFrame:CGRectMake(0,0 ,windowframe.size.width,windowframe.size.height) style:UITableViewStylePlain];
    [self.data setDelegate:self];
    [self.data setDataSource:self];

    [self.data setAllowsMultipleSelectionDuringEditing:YES];
    self.arrytitle=[[NSMutableArray alloc]initWithObjects:@"!!!",@"!!",@"!" ,@"complete",nil];

    
    
    
   
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"content"])
    {
        self.content=[[NSMutableArray alloc] initWithObjects:@[], @[], @[],@[], nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.content forKey:@"content"];
    }
    else
    {
        self.content=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"content"]];
    }
     [self.view addSubview:self.data];
    
    
    
    
    
    self.Bottom=[[UIButton alloc]initWithFrame:CGRectMake(0, 640, ScreenSize.width, 36)];
    self.Bottom.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.Bottom.backgroundColor=[UIColor grayColor];
    self.Bottom.font = [UIFont fontWithName:@"Arial" size:15.0f];
    [self.Bottom setTitle:@"隐藏已完成项目" forState:UIControlStateNormal];
    [self.Bottom addTarget:self action:@selector(hidecomplete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.Bottom];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshpage) name:@"refresh" object:nil];//通知
}




-(void)hidecomplete:(UIButton*)sender{
        self.isHidden = 1 - self.isHidden;

        [self.data reloadData];
}



- (void)clicked{
    secondpage *second = [[secondpage  alloc]init];
    [self.navigationController pushViewController:second animated:YES];
  
 
}


-(void)makeSelectable {
  
    if(self.data.isEditing) {
        [self.data setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"添加"];
        [self.navigationItem.rightBarButtonItem setAction:@selector(clicked)];
    }
    else {
        [self.data setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"删除"];
        [self.navigationItem.rightBarButtonItem setAction:@selector(removeSelectedCells)];
    }
}

-(void)refreshpage{
    [self reloadData];
    NSLog(@"tableView reloadData begin...");
    [self.data reloadData];
    NSLog(@"tableView reloadData ended.");
}


-(void) removeSelectedCells{
 NSMutableArray *deleteBooks=[NSMutableArray arrayWithArray:self.data.indexPathsForSelectedRows];
    [deleteBooks sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSIndexPath *item1=obj1;
        NSIndexPath *item2=obj2;
        return item1.row<item2.row;
    }];
    for (int i=0; i<deleteBooks.count; ++i) {
       
        NSIndexPath *item= deleteBooks[i];
        NSMutableArray* cont=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"content"]];
        NSMutableArray* section = [NSMutableArray arrayWithArray:cont[item.section]];
        [section removeObjectAtIndex:item.row];
        cont[item.section] = [NSArray arrayWithArray:section];
        [[NSUserDefaults standardUserDefaults] setObject:cont forKey:@"content"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
      
    }
    [self reloadData];

    [self.data deleteRowsAtIndexPaths:deleteBooks withRowAnimation:UITableViewRowAnimationFade];
    
    [self.data setEditing:NO animated:YES];


}

- (void)reloadData {
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"content"]){
        self.content=[[NSMutableArray alloc] initWithObjects:@[], @[], @[], nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.content forKey:@"content"];
    }
    else {
        self.content=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"content"]];
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [self.arrytitle objectAtIndex:section];
 
}

//-(void)gettag{
//    NSInteger *realtag=self.Bottom.tag;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return[self.arrytitle count] - self.isHidden;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.content[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [cell.textLabel setText:[(self.content[indexPath.section][indexPath.row]) objectForKey:@"title"]];
    //[cell.detailTextLabel setText:[self.content[indexPath.section][indexPath.row] objectForKey:@"detail"]];
    //[cell.detailTextLabel setText:[self.content[indexPath.section]indexPathp[indexPath.row] objectFor]]
    [cell.detailTextLabel setTextColor:rgb(133,127,127)];
   
    [cell.detailTextLabel setText:[self.content[indexPath.section][indexPath.row] objectForKey:@"createtime"]];

    [cell setBackgroundColor:nil];
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSMutableArray* cont=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"content"]];
        NSMutableArray* item = [NSMutableArray arrayWithArray:cont[indexPath.section]];
        [item removeObjectAtIndex:indexPath.row];
        cont[indexPath.section] = [NSArray arrayWithArray:item];
        [[NSUserDefaults standardUserDefaults] setObject:cont forKey:@"content"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if(![[NSUserDefaults standardUserDefaults] objectForKey:@"content"]){
            self.content=[[NSMutableArray alloc] initWithObjects:@[], @[], @[], nil];
            [[NSUserDefaults standardUserDefaults] setObject:self.content forKey:@"content"];
        }
        else {
            self.content=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"content"]];
        }

        [self.data deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        
        
    }];
    deleteAction.backgroundColor=[UIColor blueColor];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        correctpage *detailPage = [[correctpage alloc]initWithIndex:indexPath and:0];
        [self.navigationController pushViewController:detailPage animated:NO];

       
      //self.navigationItem.title=@"返回";
       
        
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[deleteAction, editAction];
}

// 左滑多选菜单

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
    
    if(self.data .editing==NO){
        if (oneCell.accessoryType == UITableViewCellAccessoryNone)
       {
        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
     
       }
        else
        oneCell.accessoryType = UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        //oneCell.textLabel.text = @"(变化)";
////        if (oneCell.hidden==NO) {
////            oneCell.hidden=YES;
////        }
    }
}

//cell选择

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//判断是否进行交换



-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"%ld %ld -> %ld %ld", sourceIndexPath.section, sourceIndexPath.row, destinationIndexPath.section, destinationIndexPath.row);
 
    NSMutableArray* cont=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"content"]];
    NSMutableArray* item = [NSMutableArray arrayWithArray:cont[sourceIndexPath.section]];
    NSDictionary *preitem= item[sourceIndexPath.row];
    [item removeObjectAtIndex:sourceIndexPath.row];
    cont[sourceIndexPath.section] = [NSArray arrayWithArray:item];
    [[NSUserDefaults standardUserDefaults] setObject:cont forKey:@"content"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
  
   NSMutableArray* cont1=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"content"]];
   NSMutableArray *item1 = [NSMutableArray arrayWithArray:cont1[destinationIndexPath.section]];
  
    [item1 insertObject:preitem atIndex:destinationIndexPath.row];
    cont1[destinationIndexPath.section] = [NSArray arrayWithArray:item1];
   [[NSUserDefaults standardUserDefaults] setObject:cont1 forKey:@"content"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self reloadData];

   
}

@end
