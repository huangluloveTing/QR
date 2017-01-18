//
//  ScanQRViewController.h
//  QRModel
//
//  Created by 黄露 on 2016/11/30.
//  Copyright © 2016年 黄露. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanQRViewController : BasesViewController

- (BOOL) startReading;

- (void) stopReading;

- (void) startStopReading;

@end
