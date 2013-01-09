//
//  RootViewController.m
//  PhotoBrowseDemo
//
//  Created by yangning on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

#define PAGECONTROLTAG 10001

@interface  RootViewController (Private)

/**
 *	@brief	向右边滚动一页
 */
- (void)scrollToRight;

/**
 *	@brief	向左边滚动一页
 */
- (void)scrollToLeft;

/**
 *	@brief	重置三个page，包括frame和image
 */
- (void)resetThreePage;

@end


@implementation RootViewController
@synthesize arrayOfPictures;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrayOfPictures = [[NSArray alloc] init];
        currentPage = 0;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Memory management

- (void)dealloc
{
    [arrayOfPictures release];
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    sv.contentSize = CGSizeMake(W*[arrayOfPictures count], H);
    sv.delegate = self;
    sv.pagingEnabled = YES;
    sv.bounces  = NO;
    
    //preImageView
    preImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*W, 0, W, H)];
    [sv addSubview:preImageView];
    [preImageView release];
    
    //currentImageView
    currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, H)];
    currentImageView.image = [UIImage imageNamed:[arrayOfPictures objectAtIndex:0]];
    [sv addSubview:currentImageView];
    [currentImageView release];
    
    //nextImageView
    nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(W, 0, W, H)];
    nextImageView.image = [UIImage imageNamed:[arrayOfPictures objectAtIndex:1]];
    [sv addSubview:nextImageView];
    [nextImageView release];
    
    sv.contentOffset = CGPointZero;
    [self.view addSubview:sv];
    [sv release];
    
    //PageControl
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, W, 20)];
    pc.tag = PAGECONTROLTAG;
    pc.numberOfPages = [arrayOfPictures count];
    pc.currentPage = 0;
    [self.view addSubview:pc];
    [pc release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算将要显示的页面编号
    int page = (scrollView.contentOffset.x - W/2)/W + 1;
    
    //更新pagecontrol
    UIPageControl *pc = (UIPageControl *)[self.view viewWithTag:PAGECONTROLTAG];
    if (page>=0 && page<=[arrayOfPictures count]-1)
    {
        pc.currentPage = page;
    }
    
    if (page == currentPage || page <= 0 || page >= [arrayOfPictures count]-1)
    {//如果将要显示的页面为当前页面或者当前页面为第一张或最后一张图片时return
        return;
    }
    else if (page > currentPage)
    {//向右滚动一页
        currentPage = page;
        [self scrollToRight];
    }
    else
    {//向左滚动一页
        currentPage = page;
        [self scrollToLeft];
    }
}

#pragma mark - Private methods

- (void)scrollToLeft
{
    [self resetThreePage];
}

- (void)scrollToRight
{
    [self resetThreePage];
}

- (void)resetThreePage
{
    preImageView.frame = CGRectMake(W*(currentPage-1), 0, W, H);
    currentImageView.frame = CGRectMake(W*currentPage, 0, W, H);
    nextImageView.frame = CGRectMake(W*(currentPage+1), 0, W, H);
    
    NSLog(@"current page is :%i",currentPage);
    
    preImageView.image = [UIImage imageNamed:[arrayOfPictures objectAtIndex:currentPage-1]];
    currentImageView.image = [UIImage imageNamed:[arrayOfPictures objectAtIndex:currentPage]];
    nextImageView.image = [UIImage imageNamed:[arrayOfPictures objectAtIndex:currentPage+1]];
}

@end
