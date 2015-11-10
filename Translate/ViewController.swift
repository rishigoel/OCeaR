//
//  ViewController.swift
//  Translate
//
//  Created by Rishi Goel on 2015-11-05.
//  Copyright (c) 2015 Rishi Goel. All rights reserved.
//

import UIKit
import AVFoundation

var dict: [String: AnyObject] = ["a":"a"]
var text: String = "a"
class ViewController: UIViewController, G8TesseractDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidden = true
        orgText.hidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var invisBut: UIButton!
    
    @IBOutlet weak var orgText: UILabel!
    
    @IBAction func invisFunc(sender: AnyObject) {
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            self.spinner.hidden = false
            self.spinner.startAnimating()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let image = dict[UIImagePickerControllerOriginalImage] as? UIImage
                let tesseract:G8Tesseract = G8Tesseract(language:"fra");
                tesseract.pageSegmentationMode = .Auto
                tesseract.engineMode = .TesseractCubeCombined
                tesseract.image = image
                tesseract.recognize()
                text = tesseract.recognizedText
                print(text)
                self.orgText.text = text
                self.orgText.hidden = false
                self.orgText.lineBreakMode = NSLineBreakMode.ByWordWrapping
                self.orgText.numberOfLines = 10
                let synth = AVSpeechSynthesizer()
                let talk = AVSpeechUtterance(string: text)
                talk.rate = 0.05
                synth.speakUtterance(talk)
                self.spinner.stopAnimating()
            })
        })
        
        
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imagePicker: UIImagePickerController!
    
    @IBAction func ocr(sender: AnyObject) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
   
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        dict = info
        
        
    }
}

