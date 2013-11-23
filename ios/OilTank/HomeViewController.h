//
//  HomeViewController.h
//  OilTank
//
//  Created by Conor Breen on 21/11/2013.
//
//

#import <UIKit/UIKit.h>
#import "NVSlideMenuController.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (strong, nonatomic) IBOutlet UIImageView *gauge;
@property (strong, nonatomic) IBOutlet UIImageView *needle;
@property (strong, nonatomic) IBOutlet UILabel *lblPercent;

@property (nonatomic, copy) void(^onShowMenuButtonClicked)(void);

- (void)setOnShowMenuButtonClicked:(void (^)(void))onShowMenuButtonClicked;
- (IBAction) showFilters:(UIBarButtonItem *)button forEvent:(UIEvent *)event;

@end
