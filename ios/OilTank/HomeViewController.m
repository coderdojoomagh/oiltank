//
//  HomeViewController.m
//  OilTank
//
//  Created by Conor Breen on 21/11/2013.
//
//

#import "HomeViewController.h"
#import "NVSlideMenuController.h"
#import "MenuViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    int totalPercent;
    int loopCounter;
    int maxLoopIterations;
}

@synthesize navigationBar, menuButton, gauge, needle, lblPercent;

#define DegreesToRadians(degrees) degrees * M_PI / 180

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
    
    // This value will eventually come from our sensor via a RESTful web service which returns JSON
    int fillLevel = 77;
    
    // Kick off the animations after a delay of 1 second, just to give the user time to adjust
    [self performSelector:@selector(setOilFillLevel:) withObject:[NSNumber numberWithInt:fillLevel] afterDelay:1.0f];
    
    // Set programmatic Drop Shadow on our Gauge and Needle
    self.gauge.layer.shadowRadius = 2.0;
    self.gauge.layer.shadowOffset = CGSizeMake(2, 2);
    self.gauge.layer.shadowOpacity = 0.8;
    self.gauge.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.needle.layer.shadowRadius = 2.0;
    self.needle.layer.shadowOpacity = 0.8;
    self.needle.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setOilFillLevel:(NSNumber *)percent
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // The needle's maximum rotation 'range' is from 0 degrees to about 270 degrees
    // Otherwise it will pass the maximum fill level and your tank might explode!!!
    
    // So to get the angle in degrees the needle animation should finish at, we use our percentage value
    // to find n% of 270.
    
    CGFloat finalAngleInDegrees = ((270.0f / 100.0f) * [percent intValue]);
    
    // We start off our animation with the needle at 0 degrees (normal position)
    [rotationAnimation setFromValue:[NSNumber numberWithFloat:DegreesToRadians(0)]];
    
    // We animate the needle to n% to show the correct fill level.
    [rotationAnimation setToValue:[NSNumber numberWithFloat:DegreesToRadians(finalAngleInDegrees)]];
    [rotationAnimation setRepeatCount:1];
    [rotationAnimation setDuration:2.5f];
    
    // Using the Ease Out timing function will mean the animation will slow up as it nears completion
    [rotationAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    // These make sure the needle doesn't go back to the start!
    [rotationAnimation setRemovedOnCompletion:NO];
    [rotationAnimation setFillMode:kCAFillModeBoth];
    
    // The needle is a separate image of its own, but because we aren't rotating it around the center of the image
    // we need to manually set the anchor point of the image. Doing this without moving the image requires setting the
    // anchor point of the view's presentation layer - which moves the view away from the center of our Gauge,
    // so we then have to calculate the necessary translation to shift the presentation back to where we want it -
    // the center of our Gauge!
    [self setAnchorPoint:CGPointMake(((1.0f / 81.0f) * 72.0f), ((1.0f / 81.0f) * 9.0f)) forView:self.needle];
    
    // This kicks off our animation
    [[self.needle layer] addAnimation:rotationAnimation forKey:@"rotate"];
    
    // This give the illusion that the percentage value is counting up, by incrementing it by a tenth of the overall percent
    // with every iteration!
    totalPercent = [percent intValue];
    maxLoopIterations = 11;
    loopCounter = percent > 0 ? 0 : maxLoopIterations;
    
    [self performSelector:@selector(setOilLabelText:) withObject:[NSNumber numberWithInt:(([percent intValue] / maxLoopIterations) * loopCounter)]];
}

- (void)setOilLabelText:(NSNumber *)percent
{
    [lblPercent setText:[NSString stringWithFormat:@"%@%%", percent, nil]];
    
    if (loopCounter < maxLoopIterations)
    {
        loopCounter++;
        [self performSelector:@selector(setOilLabelText:) withObject:[NSNumber numberWithInt:((totalPercent / maxLoopIterations) * loopCounter)] afterDelay:0.15f];
    }
    else {
        [self performSelector:@selector(setOilLabelText:) withObject:[NSNumber numberWithInt:totalPercent] afterDelay:0.15f];
    }
}

- (IBAction)showFilters:(UIBarButtonItem *)sender forEvent:(UIEvent *)event
{
    if (self.onShowMenuButtonClicked)
		self.onShowMenuButtonClicked();
	else
        [self.slideMenuController toggleMenuAnimated:self];
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
