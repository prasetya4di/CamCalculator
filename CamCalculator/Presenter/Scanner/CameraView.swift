//
//  CameraView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import AVFoundation
import Vision
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    private let completionHandler: (String) -> Void
    
    init(completionHandler: @escaping (String) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController(completionHandler: completionHandler)
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let completionHandler: (String) -> Void
    
    init(completionHandler: @escaping (String) -> Void) {
        self.completionHandler = completionHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return session
        }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            return session
        }
        
        session.addInput(videoInput)
        return session
    }()
    
    private lazy var textRecognitionRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  let detectedText = observations.first?.topCandidates(1).first?.string else {
                return
            }
            
            self?.completionHandler(detectedText)
        }
        request.recognitionLevel = .accurate
        return request
    }()
    
    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoDataOutputQueue"))
        return output
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCaptureSession()
    }
    
    private func setupCaptureSession() {
        guard captureSession.canAddOutput(videoDataOutput) else {
            return
        }
        
        captureSession.addOutput(videoDataOutput)
        
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }
    
    private func startCaptureSession() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    private func stopCaptureSession() {
        if captureSession.isRunning {
            
            captureSession.stopRunning()
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right)
        
        do {
            try imageRequestHandler.perform([textRecognitionRequest])
        } catch {
            print("Error performing text recognition: \(error)")
        }
    }
}
