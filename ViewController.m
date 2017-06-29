//
//  ViewController.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/19.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import "ViewController.h"
#import "EmbossFilter.h"
#import "OilPaintingFilter.h"
#import "EdgeCheck.h"
#import "ColorfulFilter.h"
#import "BlurFilter.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-60);
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton* chaFen = [self createButtonWithName:@"差分"  Frame:CGRectMake(10, ScreenHeight- 80, 60, 25)];
    [chaFen addTarget:self action:@selector(showChafen) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* Roberts = [self createButtonWithName:@"Roberts"  Frame:CGRectMake(90, ScreenHeight- 80, 100, 25)];
    [Roberts addTarget:self action:@selector(showRoberts) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* person = [self createButtonWithName:@"个性化"  Frame:CGRectMake(210, ScreenHeight- 80, 60, 25)];
    [person addTarget:self action:@selector(showPerson) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* blur = [self createButtonWithName:@"模糊"  Frame:CGRectMake(300, ScreenHeight- 80, 60, 25)];
    [blur addTarget:self action:@selector(showblur) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* orgin = [self createButtonWithName:@"原图"  Frame:CGRectMake(10, ScreenHeight- 40, 60, 25)];
    [orgin addTarget:self action:@selector(showOrgin) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* emboss = [self createButtonWithName:@"浮雕"  Frame:CGRectMake(90, ScreenHeight- 40, 60, 25)];
    [emboss addTarget:self action:@selector(showEmboss) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* oilPaint = [self createButtonWithName:@"马赛克"  Frame:CGRectMake(170, ScreenHeight- 40, 100, 25)];
    [oilPaint addTarget:self action:@selector(showOilpaint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageView];
    
    [self.view addSubview:chaFen];
    [self.view addSubview:Roberts];
    [self.view addSubview:blur];
    [self.view addSubview:person];
    [self.view addSubview:orgin];
    [self.view addSubview:emboss];
    [self.view addSubview:oilPaint];
}

-(void)showChafen{
    //X方向差分
//    _imageView.image = [EdgeCheck ChaFenEdgeX:[UIImage imageNamed:@"1.jpg"]];
    //Y方向差分
    _imageView.image = [EdgeCheck ChaFenEdgeY:[UIImage imageNamed:@"1.jpg"]];
}


-(void)showRoberts{
    _imageView.image = [EdgeCheck Roberts:[UIImage imageNamed:@"1.jpg"]];
}

-(void)showPerson{
    _imageView.image = [ColorfulFilter blueColorFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter frozenFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter redFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter fadeFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter swapFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter devilFilter:[UIImage imageNamed:@"1.jpg"]];
//    _imageView.image = [ColorfulFilter FilmFilter:[UIImage imageNamed:@"1.jpg"]];
}

-(void)showblur{
    _imageView.image = [BlurFilter BlurFilter:[UIImage imageNamed:@"1.jpg"]];
}

-(void)showOrgin{
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
}

-(void)showEmboss{
    _imageView.image = [EmbossFilter embossFiter:[UIImage imageNamed:@"1.jpg"]];
}

-(void)showOilpaint{
    //马赛克
    _imageView.image = [OilPaintingFilter MosaicFilter:[UIImage imageNamed:@"1.jpg"]];
    //油画
//    _imageView.image = [OilPaintingFilter oilPaintingFilter:[UIImage imageNamed:@"1.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton*)createButtonWithName:(NSString*)name  Frame:(CGRect)frame{
    UIButton* button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:name forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
     return  button;
}

@end
