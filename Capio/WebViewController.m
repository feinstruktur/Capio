//
//  WebViewController.m
//  Capio
//
//  Created by Sven A. Schmidt on 04.08.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize url = _url;
@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  NSLog(@"WebView viewDidLoad");
  NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
  [self.webView loadRequest:request];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)reload:(id)sender {
  NSLog(@"url: %@", self.webView.request);
  [self.webView reload];
}

@end
