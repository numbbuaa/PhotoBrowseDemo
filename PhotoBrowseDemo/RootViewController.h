//
//  RootViewController.h
//  PhotoBrowseDemo
//
//  Created by yangning on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIScrollViewDelegate>
{
    UIImageView *preImageView;//前一页
    UIImageView *currentImageView;//当前页面
    UIImageView *nextImageView;//后一页
    
    int currentPage;//当前页面编号
}

/**
 *	@brief	图片名称的数组
 */
@property(nonatomic, retain) NSArray *arrayOfPictures;

@end
