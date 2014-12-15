//
//  ViewController.m
//  TableViewListLikeQQFriends
//
//  Created by lmwl123 on 12/15/14.
//  Copyright (c) 2014 zhaoqihao. All rights reserved.
//

#import "ViewController.h"

@interface SectionItem : NSObject

@property (nonatomic,assign)BOOL isFolding;

@end

@implementation SectionItem
@synthesize isFolding=_isFolding;

@end

@interface ViewController (){
    NSMutableArray *sections;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
@synthesize tableView=_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sections=[[NSMutableArray alloc]init];
    for(int i=0;i<3;i++){
        SectionItem *item=[[SectionItem alloc]init];
        [sections addObject:item];
    }
    
    [self.tableView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[tableView indexPathForSelectedRow]isEqual:indexPath]) return 80;
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIControl *control=[[UIControl alloc]init];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 39)];
    
    switch (section) {
        case 0:
            [label setText:@"大学同学"];
            break;
        case 1:
            [label setText:@"高中同学"];
            break;
        case 2:
            [label setText:@"小学同学"];
            break;
    }
    
    [control addSubview:label];
    [control setTag:section];
    
    UIView *separatorLine=[[UIView alloc]init];
    [control addSubview:separatorLine];
    [separatorLine setBackgroundColor:[UIColor lightGrayColor]];
    [separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separatorLine]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorLine)]];
    [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorLine(==0.28)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorLine)]];
    [separatorLine setUserInteractionEnabled:NO];
    
    [control addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    return control;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    [[cell textLabel]setText:@"Hello"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)click:(id)sender{
    NSInteger currentSection=[sender tag];
    NSIndexSet *set=[NSIndexSet indexSetWithIndex:currentSection];
    SectionItem *item=[sections objectAtIndex:currentSection];
    [item setIsFolding:!item.isFolding];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
