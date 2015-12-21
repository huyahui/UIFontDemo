//
//  FontListViewController.m
//  UIFontDemo
//
//
//  Copyright (c) 2013年 . All rights reserved.
//

#import "FontListViewController.h"

@interface FontListViewController ()
{
    NSMutableDictionary *_fontNames;
    NSMutableArray *_sortedFontName;
}
@end

@implementation FontListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _fontNames = [[NSMutableDictionary alloc] init];
        self.title = @"字体一览表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [(UITableView *)self.view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self setupData];
}
//初始化数据
- (void)setupData
{
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *fontName in familyNames) {
        [_fontNames setObject:[self subFontNameByFontName:fontName] forKey:fontName];
    }
    NSArray *orderFontName = [[_fontNames allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _sortedFontName = [[NSMutableArray alloc] initWithArray:orderFontName];
}
- (NSArray *)subFontNameByFontName:(NSString *)fontName
{
    return [UIFont fontNamesForFamilyName:fontName];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_fontNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_fontNames objectForKey:[_sortedFontName objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = [self getFontNameByIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.font = [UIFont fontWithName:cell.textLabel.text size:17];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sortedFontName objectAtIndex:section];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [self getFontNameByIndexPath:indexPath]);
}
- (NSString *)getFontNameByIndexPath:(NSIndexPath *)indexPath
{
    return  [[_fontNames objectForKey:[_sortedFontName objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}
- (void)dealloc
{
    [_fontNames release];
    [_sortedFontName release];
    [super dealloc];
}
@end
