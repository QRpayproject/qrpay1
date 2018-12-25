//
//  QRViewController.swift
//  qrpay
//
//  Created by imac1 on 21.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
   
    var timer: Timer!;
    var isStartQr=false;
    let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

       startQr()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startQr(){
        isStartQr=true;
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        /* guard  let inputu = try? AVCaptureDeviceInput(device: captureDevice) else {
         return
         
         }*/
        do{
            //önceki aygıt nesnesini kullanarak AVCaptureDeviceInput sınıfının nir örneği alındı
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //Giriş cihazını yakalama oturumuna ayarla
            captureSession.addInput(input)
            
            //Bir AVCaptureMetadataoutput nesnesini başlatın ve yakalama oturumu içi çıkış aygıtı olarak ayarlayın
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            
            //Delegeyi ayarlayın ve geri aramayı yürütmek için varsayılan gönderi kuyruğunu kullanın
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            
            
            //cihazın kamerası tarafından yakalanan videoyu ekranda görüntülememiz için aşağıdaki kodu ekledik
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
            //QR kodunu vurgulamak için önce bir UIView nesnesi oluşturacağız ve sınırını yeşile ayarlayacağız.
            
            qrCodeFrameView = UIView()
            //UIView nesnesinin boyutu varsayılan olarak sıfır olarak ayarlandığından qrCodeFrameView değişkeni ekranda görünmez. Daha sonra, bir QR kodu algılandığında, boyutunu değiştirir ve yeşil bir kutuya dönüştürürüz.
            print("dış")
            if let qrCodeFrameView = qrCodeFrameView {
                print("iç")
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
               
                
            }
        } catch {
            //herhangi bir hata oluşursa , sadece hatayı yazdırın ve daha fazla devam etmeyin
            print(error)
            return
        }
        
       
        


}
    func metadataOutput(_ output:AVCaptureMetadataOutput, didOutput metadataObjects:[AVMetadataObject],from connection: AVCaptureConnection){
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("QR kodu algılanmadı")
            return
        }
        
        // Meta veri nesnesi
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            //  Bulunan meta veriler, QR kodu meta verilerine eşitse, durum etiketinin metnini güncelleyin ve sınırları ayarlayın.
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            //Son olarak, QR kodun okunabilir bilgilere çözüyoruz.
            // Kodlanan bilgilere bir AVMetadataMachineReadableCode nesnesinin stringValue özelliği kullanılarak erişilebilir.
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
                var value = metadataObj.stringValue
                if((value?.count)!>0){
                    print(value)
                    captureSession.stopRunning();
                }
            }
        
}

}
}
