//
//  MenuViewController.h
//  OilTank
//
//  Created by Conor Breen on 21/11/2013.
//
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end