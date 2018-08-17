//
//  ViewController.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "ViewController.h"
#import "WLChainHeader.h"

const void *label_countDown = "fds";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WLButton *b = WLButton.wl_init()
    .wl_size(CGRectMake(0, 25, 100, 100))
    .wl_backgroundColor([UIColor redColor])
    .wl_button_title(@"1234",UIControlStateNormal)
    .wl_button_textSize(30,UIControlStateNormal)
    .wl_button_image([UIImage imageNamed:@"beauty_no_paly_type"],UIControlStateNormal)
    .wl_button_layout(UIViewContentModeBottom,1)
    .wl_button_addTarget(self,@selector(click_b:),UIControlEventTouchUpInside)
    .wl_end();
    [self.view addSubview:b];
    
    
    UIButton *w = UIButton.wl_init()
    .wl_size(CGRectMake(0, CGRectGetMaxY(b.frame)+5, 100, 100))
    .wl_backgroundColor([UIColor redColor])
    .wl_button_title(@"1234",UIControlStateNormal)
    .wl_button_textSize(30,UIControlStateNormal)
    .wl_button_image([UIImage imageNamed:@"beauty_no_paly_type"],UIControlStateNormal)
    .wl_button_layout(UIViewContentModeBottom,1)
    .wl_button_addTarget(self,@selector(click_b:),UIControlEventTouchUpInside)
    .wl_end();
    [self.view addSubview:w];
    
    
    UIView *v = UIView.wl_init()
    .wl_size(CGRectMake(0,CGRectGetMaxY(w.frame)+5,50,50))
    .wl_backgroundColor([UIColor yellowColor])
    .wl_end();
    [self.view addSubview:v];

    
    UIImageView *i = UIImageView.wl_init()
    .wl_size(CGRectMake(0,CGRectGetMaxY(v.frame)+5,100,100))
    .wl_backgroundColor([UIColor yellowColor])
    .wl_imageView_imageUrl(@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534245522084&di=ed1246fbde94bedd9a46056ef0661e13&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F060828381f30e92404cafd0c47086e061d95f7a5.jpg",nil)
    .wl_end();
    [self.view addSubview:i];
    
    
    UILabel *l = UILabel.wl_init()
    .wl_size(CGRectMake(0, CGRectGetMaxY(i.frame)+5, 100, 100))
    .wl_backgroundColor([UIColor grayColor])
    .wl_addTap(self,@selector(click:))
    .wl_label_alignment(NSTextAlignmentCenter)
    .wl_label_title(@"4321")
    .wl_addStongToObject(self,label_countDown);
    [self.view addSubview:l];

}

-(void)click:(UITapGestureRecognizer *)sender{
    NSLog(@"%@",sender);
    UILabel *l = self.wl_getValue(label_countDown);
    l.wl_label_countDown_time(3)
    .wl_label_countDown_waitTittle(@"ddd")
    .wl_label_countDown_begin(self,@selector(over:));
}

-(void)over:(NSString *)sender{
//    self.wl_removeValue();
    NSLog(@"%@",sender);
}

-(void)click_b:(UIButton *)sender{
    NSLog(@"%@",sender);
}

@end
