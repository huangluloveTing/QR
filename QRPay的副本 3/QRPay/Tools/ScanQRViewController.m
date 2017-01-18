//
//  ScanQRViewController.m
//  QRModel
//
//  Created by 黄露 on 2016/11/30.
//  Copyright © 2016年 黄露. All rights reserved.
//

#import "ScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>

#define SCAN_WIDTH (self.view.bounds.size.width * 0.6)

#define SCAN_PADDING (self.view.bounds.size.width * 0.2)

@interface ScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ,strong) UIView *viewPreview;

@property (nonatomic ,strong) UIView *boxView;

@property (nonatomic ,strong) CALayer *scanLayer;

@property (nonatomic ,strong) AVCaptureSession *captureSession;

@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *videoLayer;

@end

@implementation ScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _captureSession = nil;
    
    [self.view addSubview:self.viewPreview];
    
    [self startReading];
    
    UIBarButtonItem *rightBarBrn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(chooseAlbumARPhoto)];
    
    self.navigationItem.rightBarButtonItem = rightBarBrn;
}

//从相册读取二维码
- (void) chooseAlbumARPhoto {
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePickerVC.delegate = self;
    
    [self presentViewController:imagePickerVC animated:YES completion:^{
        
    }];
}

- (void) scanQRFromImage:(UIImage *)qrImage{
    
//    声明一个CIDetecor ，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
//    取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:qrImage.CGImage]];
    
    if (features == nil || features.count <= 0) {
        NSLog(@"没有扫描到二维码");
    }
    
    for (int index = 0; index < features.count
         ; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex: index];
        NSString *scannedResult = feature.messageString;
        NSLog(@"result:%@",scannedResult);
    }
}


- (void) startStopReading {
    if ([self startReading]) {
        
    }
}

- (UIView *) viewPreview {
    if (!_viewPreview) {
        _viewPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height)];
        
        
    }
    return _viewPreview;
}

- (BOOL) startReading {
    
    NSError *error = nil;
    
//    初始化捕捉设备（AVCaptureDevice)，类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
//    用captureDevice创建输入流
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@",[error localizedDescription]);
        return NO;
    }
    
//    创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
//    实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
//    将输入流添加到会话
    [_captureSession addInput:input];
    
//    将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
//    创建串行队列，并将媒体输出流添加到队列中
    dispatch_queue_t dispatchQueue = dispatch_queue_create("com.zhonglian.scanQR", NULL);
    
//    设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
 
//    设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
//     实例化预览图层
    _videoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    _videoLayer.backgroundColor = [[UIColor lightGrayColor]CGColor];
    
//    设置预览图层填充方式
    [_videoLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
//    设置图层的frame
    [_videoLayer setFrame:_viewPreview.layer.frame];
    
//    将图层添加到预览view 的图层中
    [_viewPreview.layer addSublayer:_videoLayer];
    
//    设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2,0.2,SCAN_WIDTH / self.view.frame.size.width , SCAN_WIDTH / SCAN_WIDTH / 0.6);
    
//    扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width * 0.6f, _viewPreview.bounds.size.width * 0.6f)];
    _boxView.layer.borderColor = [UIColor orangeColor].CGColor;
    _boxView.layer.borderWidth = 1;
    
    [_viewPreview addSubview:_boxView];
    
//    扫描线
    _scanLayer = [CALayer layer];
    _scanLayer.frame = CGRectMake(0, 0, CGRectGetWidth(_boxView.frame), 1);
    _scanLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    
    [self moveScanLayer:_scanLayer];
    
//    开始扫描
    [_captureSession startRunning];
    
    return YES;
}

- (void) stopReading {
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoLayer removeFromSuperlayer];
}

- (void) moveScanLayer:(CALayer *) moveLayer {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
//    CGPoint startPoint = CGPointMake(0, 0);
    
    animation.fromValue = @0;

    animation.toValue = @(_boxView.frame.size.height - 1);
    
    animation.repeatCount = MAXFLOAT;
    
//    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 5.f;
    
    [moveLayer addAnimation:animation forKey:@"scanLayer"];
}

#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name type:(NSString *)type{
    
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1.获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
}


#pragma mark -- AVCaptureDelegate

- (void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [self playSoundEffect:@"sound" type:@"caf"];
    
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        [_videoLayer removeFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSLog(@"扫描结果： %@" ,[metadataObj stringValue]);
            
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
        }
    }
}

#pragma mark -- ImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo  {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self scanQRFromImage:image];
    }];
}

@end
