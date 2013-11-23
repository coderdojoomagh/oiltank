//
//  MenuViewController.m
//  OilTank
//
//  Created by Conor Breen on 21/11/2013.
//
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MenuBackground"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 340, 40)];
    UILabel *lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 320, 20)];
    
    [lblHeader setText:[NSString stringWithFormat:@"Menu Section %d", section]];
    [lblHeader setTextColor:[UIColor whiteColor]];
    [lblHeader setFont:[UIFont systemFontOfSize:14]];
    
    [container setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [container addSubview:lblHeader];
    
    return container;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Menu Option %d text Label", indexPath.row];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Menu Option %d detail Label", indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    //cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    UIView *selectedBGView = [[UIView alloc]init];
    selectedBGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [cell setSelectedBackgroundView:selectedBGView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Launch new view controller etc.
    
    // Deselect selected cell
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

@end
