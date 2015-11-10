//
//  TranslateViewController.swift
//  Translate
//
//  Created by Rishi Goel on 2015-11-07.
//  Copyright © 2015 Rishi Goel. All rights reserved.
//

import UIKit
import AVFoundation

class TranslateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        orgText.text = text
        print("switch")
        //listen.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var orgText: UILabel!
    @IBOutlet weak var newText: UILabel!
 
    @IBOutlet weak var listen: UIButton!
    @IBAction func speak(sender: AnyObject) {
        
        let synth = AVSpeechSynthesizer()
        let talk = AVSpeechUtterance(string: text)
        talk.rate = 0.3
        synth.speakUtterance(talk)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
