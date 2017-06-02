//
//  RoomNormalViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import AVFoundation

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {
    
    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    fileprivate var videoInput : AVCaptureDeviceInput?
    fileprivate var movieOutput : AVCaptureMovieFileOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //用下面注释掉的方法隐藏导航栏滑动返回手势依然会有
//        navigationController?.navigationBar.isHidden = true
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        //依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
          navigationController?.setNavigationBarHidden(false, animated: true)
    }

}


//Mark:- 视频的开始采集&停止采集
extension RoomNormalViewController{
    
    @IBAction func startCapture(_ sender: UIButton) {
        
        //1设置视频输入输出
        setupVideo()
        
        //设置音频的输入输出
        setupAudio()
        
        //添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        //设置写入的稳定性
        let connection = movieOutput.connection(withMediaType: AVMediaTypeVideo)
        connection?.preferredVideoStabilizationMode = .auto
        
        
        //2.给用户看到一个预览图层
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //3.开始采集
        session.startRunning()
        
        //开始将采集到的画面写入的文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        let url  = URL(fileURLWithPath: path)
        movieOutput.startRecording(toOutputFileURL: url, recordingDelegate: self)
    }
    
    
    @IBAction func stopCapture(_ sender: UIButton) {
        movieOutput?.stopRecording()
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    
    @IBAction func switchScene(_ sender: UIButton) {
        //获取之前的镜头
        guard var position = videoInput?.device.position else { return }
        //获取当前应该显示的镜头
        position = position == .front ? .back : .front
        //根据当前镜头创建新的Device
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice]
        guard let device = devices?.filter({$0.position == position}).first else { return }
        //根据新的Device创建新的Input
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        //在session中切换Input
        session.beginConfiguration()
        session.removeInput(self.videoInput)
        session.addInput(videoInput)
        session.commitConfiguration()
        self.videoInput = videoInput
    }
    
}

extension RoomNormalViewController{
    fileprivate func setupVideo(){
        //1.创建捕捉会话
        //1.给捕捉会话设置输入源(摄像头)
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else{
            print("摄像头不可用")
            return
        }
        
        /*
         var device : AVCaptureDevice!
         for d  in devices {
         if d.position == .front{
         device = d
         break
         }
         }
         */
        
        /*
         let device = devices.filter { (device : AVCaptureDevice) -> Bool in
         return device.position == .front
         }.first
         */
        //获取摄像头设备
        guard let device = devices.filter({$0.position == .front}).first else { return }
        
        //通过device创建AVCaptureInput对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {return}
        self.videoInput = videoInput
        //将videoInput添加到会话中去
        session.addInput(videoInput)
        
        //2.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        //3.保存videoOutput
        self.videoOutput = videoOutput
    }
    
    fileprivate func setupAudio(){
        //设置音频的输入（话筒）
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        
        //根据device创建AVCaptureInput
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        //将input添加到会话中
        session.addInput(audioInput)
        
        //2给会话设置音频输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
        
    }
}

//MARK:-获取数据
extension RoomNormalViewController : AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == videoOutput?.connection(withMediaType: AVMediaTypeVideo) {
            print("已经采集到视频数据")
        }else{
            print("已经采集到音频数据")
        }
    }
}

extension RoomNormalViewController : AVCaptureFileOutputRecordingDelegate{
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        
    }
}


