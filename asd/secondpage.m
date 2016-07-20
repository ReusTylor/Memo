//
//  secondpage.m
//  asd
//
//  Created by 创新创业中心 on 16/7/14.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "secondpage.h"
#import "Header.h"
#import "RootViewController.h"

@interface secondpage()
@end

@implementation secondpage
-(instancetype)init{
    

    if (self=[super init]) {
        self.title=@"没事别乱写";
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    UIBarButtonItem *rightbtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(respondsToLoginButton:)];
    self.navigationItem.rightBarButtonItem=rightbtn;
    self.second=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 420, 40)];
    self.second.text=@"标题";
    self.second.backgroundColor=rgb(247,247,247);
    self.second.textAlignment=UITextAlignmentCenter;
    //self.second.layer.borderWidth=1.0;
    
    
    [self.view addSubview:self.second];    self.second2=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 420, 40)];
    self.second2.backgroundColor=rgb(247,247,247);
   
    self.second2.text=@"内容";
    self.second2.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:self.second2];

    
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.text1=[[UITextField alloc]initWithFrame:CGRectMake(0 ,40 ,windowFrame.size.width, 40)];
    self.text1.borderStyle= UITextBorderStyleNone;

    self.text1.placeholder=@"请输入标题";
    
    [self.view addSubview:self.text1];
    
    
    

    self.textview2=[[UITextView alloc]initWithFrame:CGRectMake(0, 120, 420, 300)];
    //textview2.layer.borderWidth=1.0;
    //textview2.layer.cornerRadius=5.0;
    self.textview2.backgroundColor=[UIColor whiteColor];
    self.textview2.hidden=NO;
   
    [self.view addSubview:self.textview2];
    self.textview2.delegate=self;
    
    self.hide= [[UILabel alloc]initWithFrame:CGRectMake(0, 115, 420, 40)];
    self.hide.text=@"请填写内容";
    self.hide.textColor=rgb(219, 219, 222);
    [self.view addSubview:self.hide];
    
  
    self.wordCount = [[UILabel alloc] initWithFrame:CGRectMake(340, 420, 150, 20)];
    self.wordCount.textAlignment = NSTextAlignmentLeft;
    self.wordCount.font = [UIFont fontWithName:@"Arial" size:15.0f];
    self.wordCount.backgroundColor = [UIColor clearColor];
    self.wordCount.textColor=[UIColor grayColor];
    [self.wordCount setText:@"100"];
    [self.view addSubview:self.wordCount];
    
    
//    self.date =[NSDate date];
//    self.dateFormatter =[[NSDateFormatter alloc]init];
//    [self.dateFormatter setDateFormat:@"yyyy年MM年dd日 HH时mm分ss秒"];
//    self.dateStr=[self.dateFormatter stringFromDate:self.date];
    
    
    self.import1=[[UIButton alloc] initWithFrame:CGRectMake(0,480, 140, 40)];
    self.import2=[[UIButton alloc] initWithFrame:CGRectMake(140, 480, 140, 40)];
    self.import3=[[UIButton alloc] initWithFrame:CGRectMake(280, 480,140, 40)];
    
    [self.import1 setTitle:@"!!!(最重要)" forState:UIControlStateNormal];
    [self.import2 setTitle:@"!!(重要)" forState:UIControlStateNormal];
    [self.import3 setTitle:@"!(不太重要)" forState:UIControlStateNormal];
    [self.import1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.import2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.import3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.import1.layer setBorderWidth:0.3];
    [self.import2.layer setBorderWidth:0.3];
    [self.import3.layer setBorderWidth:0.3];
    [self.import1.layer setMasksToBounds:YES];
    [self.import2.layer setMasksToBounds:YES];
    [self.import3.layer setMasksToBounds:YES];
    self.import1.tag=1;
    self.import2.tag=2;
    self.import3.tag=3;
    [self.import1 addTarget:self action:@selector(chooseimport:) forControlEvents:UIControlEventTouchUpInside];
    [self.import2 addTarget:self action:@selector(chooseimport:) forControlEvents:UIControlEventTouchUpInside];
    [self.import3 addTarget:self action:@selector(chooseimport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.import1];
    [self.view addSubview:self.import2];
    [self.view addSubview:self.import3];
}



-(void)chooseimport: (UIButton*)sender{
   if(sender.tag==1){
            [self.import1 setBackgroundColor:[UIColor redColor]];
            [self.import2 setBackgroundColor:[UIColor whiteColor]];
            [self.import3 setBackgroundColor:[UIColor whiteColor]];
            self.imp=@"imp1";
        }
        else if(sender.tag==2){
            [self.import1 setBackgroundColor:[UIColor whiteColor]];
            [self.import2 setBackgroundColor:[UIColor redColor]];
            [self.import3 setBackgroundColor:[UIColor whiteColor]];
            self.imp=@"imp2";
        }
        else{
            [self.import1 setBackgroundColor:[UIColor whiteColor]];
            [self.import2 setBackgroundColor:[UIColor whiteColor]];
            [self.import3 setBackgroundColor:[UIColor redColor]];
            self.imp=@"imp3";
        }
    }
- (void)respondsToLoginButton:(UIBarButtonItem *)sender {
    
    if ([self.text1.text isEqualToString:@""] || [self.textview2.text isEqualToString:@""]||self.imp == nil)
    {
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"警告" message:@"无法保存" preferredStyle:UIAlertControllerStyleAlert];
        [alert1 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert1 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert1 animated:YES completion:nil];
    }

    else{
        NSDate *dd = [NSDate date];
        NSDate *time = [NSDate dateWithTimeInterval:8*60*60 sinceDate:dd];
        NSString* createtime=[[NSString stringWithFormat:@"%@", time] substringWithRange:(NSRange){0, 16}];
        NSMutableDictionary* textcontent=[[NSMutableDictionary alloc]init];
        [textcontent setObject:self.text1.text forKey:@"title"];
        [textcontent setObject:self.textview2.text forKey:@"detail"];
        [textcontent setObject: createtime forKey:@"createtime"];
        int importancce = 0;
        if([self.imp isEqualToString:@"imp1"]){
            importancce = 0;
        }
        else if([self.imp isEqualToString:@"imp2"]){
            importancce = 1;
        }
        else{
            importancce = 2;
        }
        
        NSMutableArray* cont=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"content"]];
        NSMutableArray* item = [NSMutableArray arrayWithArray:cont[importancce]];
        [item addObject:textcontent];
        cont[importancce] = [NSArray arrayWithArray:item];
        [[NSUserDefaults standardUserDefaults] setObject:cont forKey:@"content"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        //[self.navigationController pushViewController:[[AddList alloc] init] animated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        
        
        [self.navigationController popViewControllerAnimated:YES];

        
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController:alert animated:YES completion:nil];
    }
}


-(void)textViewDidChange:(UITextView *)textView2 {
    int count = 100 - textView2.text.length;
    if(count >= 0) {
        [self.wordCount setText:[NSString stringWithFormat:@"%d", count]];
        UIBarButtonItem *rightbtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(respondsToLoginButton:)];
        self.navigationItem.rightBarButtonItem=rightbtn;
    }
    else {
       
        [self.wordCount setText:@"超过上限"];
        self.navigationItem.rightBarButtonItem = nil;
        
    }
    
    if(count == 100) {
        self.hide= [[UILabel alloc]initWithFrame:CGRectMake(0, 115, 420, 40)];
        self.hide.textColor=rgb(219, 219, 222);
        self.hide.text=@"请填写内容";
        self.hide.backgroundColor=[UIColor clearColor];
        
        [self.view addSubview:self.hide];
    }
    else {
        [self.hide removeFromSuperview];
    }
}

//-(void)saveData{
//    NSMutableArray *datas=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"records"]];
//    NSDictionary *data = @{
//                           @"title":self.text1.text,
//                           @"detail":self.textview2.text
//                           };
//    [datas addObject:data];
//    [[NSUserDefaults standardUserDefaults]setObject:datas forKey:@"records"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//}


@end
