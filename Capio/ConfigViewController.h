//
//  ConfigViewController.h
//  Capio
//
//  Created by Sven A. Schmidt on 27.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BonjourBrowser.h"


@interface ConfigViewController : UIViewController <BonjourBrowserDelegate> {
  UINavigationController *_navigationController;
}


@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;

@end
