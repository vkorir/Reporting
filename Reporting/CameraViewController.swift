//
//  CameraViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/5/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var capture: RoundButton!
    @IBOutlet weak var sendImage: RoundButton!
    var selectedImage = UIImage()
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    let photoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        captureNewSession(devicePosition: AVCaptureDevicePosition.back)
        super.viewDidLoad()
        toggleUI(isInPreviewMode: false)
    }
    
    func selectImage(_ image: UIImage) {
        selectedImage = image
    }
    
    func captureNewSession(devicePosition: AVCaptureDevicePosition) {
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
        captureSession.stopRunning()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        if let deviceDiscoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                                             mediaType: AVMediaTypeVideo,
                                                                             position: AVCaptureDevicePosition.unspecified) {
            for device in deviceDiscoverySession.devices {
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if (device.position == devicePosition) {
                        captureDevice = device
                        if captureDevice != nil{
                            do {
                                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                                
                                if captureSession.canAddOutput(photoOutput) {
                                    captureSession.addOutput(photoOutput)
                                }
                            }
                            catch {
                                print("error: \(error.localizedDescription)")
                            }
                            
                            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                                view.layer.addSublayer(previewLayer)
                                previewLayer.frame = view.layer.frame
                                captureSession.startRunning()
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            selectedImage = UIImage(data: photoData!)!
        }
        toggleUI(isInPreviewMode: true)
    }
    
    func toggleUI(isInPreviewMode: Bool) {
        if isInPreviewMode {
            imageView.image = selectedImage
            capture.isHidden = true
            sendImage.isHidden = false
        } else {
            capture.isHidden = false
            sendImage.isHidden = true
            imageView.image = nil
        }
        view.bringSubview(toFront: imageView)
        view.bringSubview(toFront: capture)
        view.bringSubview(toFront: sendImage)
    }
    
    @IBAction func takePhoto(_ sender: RoundButton) {
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        photoOutput.capturePhoto(with: settingsForMonitoring, delegate: self)
    }
    
    @IBAction func sendImage(_ sender: RoundButton) {
        performSegue(withIdentifier: "CameraToReport", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
        let destination = segue.destination as! ReportViewController
        destination.chosenImage = selectedImage
        destination.hideCamera = true
        toggleUI(isInPreviewMode: false)
    }
}
