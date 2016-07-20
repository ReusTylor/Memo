//
//  RootViewController.h
//  asd
//
//  Created by 创新创业中心 on 16/7/14.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIBarButtonItem*btn1;
@property(nonatomic,strong) UITableView  *data;
@property(nonatomic,strong) NSMutableArray *arry1,*arry2,*arrytitle,*arry3,*complete;
@property(nonatomic,strong) NSMutableArray *content;
@property(nonatomic,strong) UIButton * Bottom;
@property NSInteger isHidden;
-(instancetype) initWithIndex:(NSIndexPath*)indexPath and :(NSInteger)page;

- (void)reloadData ;


@end
