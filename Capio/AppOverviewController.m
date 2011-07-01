//
//  AppOverview.m
//  Capio
//
//  Created by Sven A. Schmidt on 29.06.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "AppOverviewController.h"
#import "AppOverview.h"


@implementation AppOverviewController

@synthesize detailItem = _detailItem;
@synthesize performanceCostToggle = _performanceCostToggle;
@synthesize popover = _popover;
@synthesize appName = _appName;
@synthesize appDescription = _appDescription;
@synthesize appOwner = _appOwner;
@synthesize serverCount = _serverCount;
@synthesize reportDate = _reportDate;
@synthesize ragRed = _ragRed;
@synthesize ragAmber = _ragAmber;
@synthesize ragGreen = _ragGreen;
@synthesize ragTotal = _ragTotal;
@synthesize detailView = _detailView;
@synthesize blankView = _blankView;
@synthesize dateButton = _dateButton;


#pragma mark -
#pragma mark Managing the detail item


// When setting the detail item, update the view and dismiss the popover controller if it's showing.
- (void)setDetailItem:(AppOverview *)newDetailItem {  
  if (_detailItem != newDetailItem) {
    _detailItem = newDetailItem;
    [self updateView];
  }
}


- (void)updateView {
  static NSDateFormatter *dateFormatter = nil;
  if (dateFormatter == nil) {
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  }
  self.view = self.detailView;
  self.appName.text = self.detailItem.appName;
  self.appDescription.text = self.detailItem.appDescription;
  self.appOwner.text = self.detailItem.appOwner;
  self.serverCount.text = [self.detailItem.serverCount stringValue];
  self.reportDate.text = [dateFormatter stringFromDate:self.detailItem.reportDate];
  self.ragRed.titleLabel.text = [self.detailItem.ragRed stringValue];
  self.ragAmber.titleLabel.text = [self.detailItem.ragAmber stringValue];
  self.ragGreen.titleLabel.text = [self.detailItem.ragGreen stringValue];
  self.ragTotal.titleLabel.text = [self.detailItem.ragTotal stringValue];
}


- (void)tapped:(id)sender {
  DatePopupController *vc = [[DatePopupController alloc] initWithNibName:@"DatePopup" bundle:nil];
  vc.datePicker.date = self.detailItem.reportDate;
  vc.delegate = self;
  self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
  self.popover.popoverContentSize = CGSizeMake(300, 260);
  [self.popover presentPopoverFromRect:self.dateButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}


#pragma mark -
#pragma mark Split view support


- (void)splitViewController:(MGSplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController: (UIPopoverController*)pc
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc 
          popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
  [self setAppName:nil];
  [self setAppDescription:nil];
  [self setAppOwner:nil];
  [self setServerCount:nil];
  [self setReportDate:nil];
  [self setPerformanceCostToggle:nil];
  [self setRagRed:nil];
  [self setRagAmber:nil];
  [self setRagGreen:nil];
  [self setRagTotal:nil];
  [self setDateButton:nil];
  [self setBlankView:nil];
  [self setDetailView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark - DatePopupControllerDelegate


- (void)cancel:(id)sender {
  [self.popover dismissPopoverAnimated:YES];
}


- (void)done:(id)sender {
  DatePopupController *vc = (DatePopupController *)self.popover.contentViewController;
  NSLog(@"%@", vc.datePicker.date);
  if (! [self.detailItem.reportDate isEqualToDate:vc.datePicker.date]) {
    self.detailItem.reportDate = vc.datePicker.date;
    [self updateView];
  }
  [self.popover dismissPopoverAnimated:YES];
}


@end
