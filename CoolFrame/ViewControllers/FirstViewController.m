//
//  FirstViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "FirstViewController.h"
#import "SearchViewController.h"
#import "HomePageController.h"
#import "GlobalDefine.h"
//#import "CustomNewsBanner.h"


@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize label = _label;
@synthesize tableDataArray = _tableDataArray;
@synthesize homeTableView = _homeTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"A";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [[self label] setFrame:CGRectMake(roundf(self.view.frame.size.width - 100)/2, roundf(self.view.frame.size.height - 100)/2, 100, 100)];
//
//    [self.label setTextAlignment:NSTextAlignmentCenter];
//    [self.label setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:40.0f]];
//    [self.label setText:@"A"];
//
//    [self.view addSubview:[self label]];
    
    /*
     * 主页搜索框设置
     */
    [self setNaviBarTitle:@"CoolFrame"];
    [self setNaviBarLeftBtn:nil];
    //设置搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtnClick:) forControlEvents:UIControlEventTouchDragInside];
    [self setNaviBarRightBtn:searchBtn];
    
    /*
     * 主页界面设置，tableview 初始化
     */
    self.tableDataArray = [HomePageController getInstance].getHomePageData;
    
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customNavbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    [_homeTableView setBackgroundColor:[UIColor clearColor]];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    [self.view addSubview:_homeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] init];
    }
    
    return _label;
}

- (void)OnSearchBtnClick:(id)sender{
    SearchViewController *searchVC = [SearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据 json 模版 决定每个 section 要显示几行数据
    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    int tid = [templateID intValue];
    int rows = 0;
    
    if(tid == 1 || tid == 3 || tid == 6){
        rows = 1;
    }else if(tid == 2 || tid == 4){
        rows = 2;
    }else if(tid == 5){
        rows = 5;
    }
    
    return rows;
//    switch (tid) {
//        case 1:{
//            rows = 1
//        }
//        case 3:
//        case 6:return 1;    //模板显示一行
//            break;
//        case 2:
//        case 4:return 2;    //模板显示二行
//            break;
//        case 5:return 5;    //模板显示五行
//            break;
//        default:return 0;
//            break;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     *  default cell pattern
     */
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSMutableDictionary *dic = [_tableDataArray objectAtIndex:indexPath.section];
    NSString *templateID = [dic objectForKey:@"cTemplateId"];
    switch ([templateID intValue]) {
        case 1:{
            NSMutableArray *newsArray = [dic objectForKey:@"NewsBanner"];
            HomePageProducts *productCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageProducts"];
            if(!productCell){
                productCell = [[HomePageProducts alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageProducts"];
                [productCell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 160)];
            }
            
            NewsBanner *newsBanner = [[NewsBanner alloc] initWithFrame:productCell.frame];
            [newsBanner setNewsBannerInfo:newsArray];
                                      
//            [newsBanner setNewsBannerInfo:newsArray];
            [productCell addSubview:newsBanner];

            return productCell;
        }
            break;
        case 3:
        case 6: return cell;
            break;
        case 2:{
            // Menu button loaded
            NSMutableArray *menuArray = [dic objectForKey:@"MenuData"];
            NSMutableDictionary *dic = [menuArray objectAtIndex:indexPath.row];
            NSArray *submenus = [dic objectForKey:@"subMenus"];
            HomePageMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageMenuCell"];
            if(!cell){
                cell = [[HomePageMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageMenuCell"];
            }
            
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
            NSMutableArray *menuItems = [[NSMutableArray alloc] init];
            
            for (NSString *menuName in submenus) {
                CustomMenuItem *item = [[CustomMenuItem alloc] init];
                [item setTitle:menuName];
                [menuItems addObject:item];
            }
            
            [cell setItems:menuItems];
            return cell;
        }
            break;
        case 4:  return cell;
            break;
        case 5:{
            // news column
            NSMutableArray *topicArray = [dic objectForKey:@"TodayTopic"];
            NSMutableDictionary *dic = [topicArray objectAtIndex:indexPath.row];
            HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTodayTopicCell"];
            if(!cell){
                cell = [[HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageTodayTopicCell"];
            }
            
            //适配 iPhone 端大小，ipad端需另做设计
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
            NSString *topicTitle = [dic objectForKey:@"Title"];
            NSString *url = [dic objectForKey:@"ImgUrl"];
            UIImage *image = [UIImage imageNamed:@"topicImg.png"];
            
            [cell.textLabel setText:topicTitle];
            [cell.imgView setImage:image];
            
            return cell;
        }
            break;
        default:
            return cell;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableDataArray count];
}

#pragma mark -tableViewDelegate

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self tableView:tableView viewForHeaderInSection:section]){
        return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
    }else{
        return 0.0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42.0f)];
    [headView setBackgroundColor:[UIColor clearColor]];
    headView.layer.borderWidth = 0;
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *headviewTitle = [[UILabel alloc] init];
    [headviewTitle setFont:[UIFont systemFontOfSize:15.0f]];
    headviewTitle.backgroundColor = [UIColor clearColor];
    
    //更多的跳转
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    [moreBtn addTarget:self action:@selector(jumpToSpecficContent) forControlEvents:UIControlEventTouchUpInside];
    
    //添加栏目名称
    [headView addSubview:headviewTitle];
    
    NSMutableDictionary *columnDic = [self.tableDataArray objectAtIndex:section];
    if([[columnDic objectForKey:@"cHeadlineShow"] intValue] < 1){
        return nil;
    }
    
    if([columnDic objectForKey:@"sTitle"]){
        NSString *headTitle = [columnDic objectForKey:@"sTitle"];
        [headviewTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        [headviewTitle setFrame:CGRectMake(20, 12, 80, 20)];
        [headviewTitle setText:headTitle];
        
//        UIImageView *sep = [[UIImageView alloc] init];
//        [sep setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
//        [sep setContentMode:UIViewContentModeBottom];
//        sep.clipsToBounds = YES;
//
//        CGRect rcSep = CGRectMake(0, headView.frame.size.height - 1 , headView.frame.size.width, 1);
//        sep.frame = rcSep;
//
//        [headView addSubview:sep];
    }
    
    if([columnDic objectForKey:@"sSubtitle"]){
        NSString *sSubtitle = [columnDic objectForKey:@"sSubtitle"];
//        [moreLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        [moreLabel setFrame:CGRectMake(tableView.frame.size.width - 80, 12, 40, 20)];
//        [moreLabel setText:sSubtitle];
//        [headView addSubview:moreLabel];
        
        [moreBtn setFrame:CGRectMake(tableView.frame.size.width - 80, 12, 40, 20)];
        [moreBtn setTitle:sSubtitle forState:UIControlStateNormal];
        [headView addSubview:moreBtn];
        
        [arrowImage setFrame:CGRectMake(tableView.frame.size.width - 50, 12, 20, 20)];
        [arrowImage setImage:[UIImage imageNamed:@"redarrowRighticon"]];
        [headView addSubview:arrowImage];
    }
    
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - btn event

- (void)jumpToSpecficContent{
    NSLog(@"jumpToSpecficContent");
    
}

#pragma mark - HomePageMenuCell Delegate

- (BOOL)Menu:(HomePageMenuCell *)menu shouldSelectItemAtIndex:(NSInteger)index{
    
    return YES;
}

- (void)Menu:(HomePageMenuCell *)menu didSelectItemAtIndex:(NSInteger)index{
    
    
}


@end
