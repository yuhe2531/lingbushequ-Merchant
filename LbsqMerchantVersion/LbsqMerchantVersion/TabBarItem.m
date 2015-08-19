//
//  TabBarItem.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "TabBarItem.h"

@interface TabBarItem ()

@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *originImage;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleL;

@end

@implementation TabBarItem

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title selectedImage:(UIImage *)selectedImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = NO;
        _originImage = image;
        _selectedImage = selectedImage;
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = self.bounds;
        [self addSubview:_button];
        [self createTabBarSubviewsWithImage:image title:title];
    }
    return self;
}

-(void)createTabBarSubviewsWithImage:(UIImage *)image title:(NSString *)title
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 25, 25)];
    _imageView.backgroundColor = KRandomColor;
    _imageView.image = image;
    _imageView.centerX = self.width/2;
    [self addSubview:_imageView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom, self.width, 20)];
    _titleL.centerX = _imageView.centerX;
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = title;
    _titleL.font = [UIFont systemFontOfSize:13];
    [self addSubview:_titleL];
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        _imageView.image = _selectedImage;
    } else {
        _imageView.image = _originImage;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
