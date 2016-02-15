//
//  ViewController.swift
//  railtalk
//
//  Created by Jeremy Molayem on 1/18/16.
//  Copyright © 2016 Jeremy Molayem. All rights reserved.
//

import UIKit
import Wit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    //self.view.backgroundImage=[UIbackgroundImage colorWithPatternImage:[UIImage imageNamed:@"train.png"]]
    var synthesizer: AVSpeechSynthesizer?
    
    //let dataController : DataController = DataController()
    
    let witButton : WITMicButton = WITMicButton()
    
    let labelOffset : CGFloat = 25.0
    
    var textLabel : UILabel?
    var labelView : UILabel?
    var intentLabel : UILabel?
    var activatedTextView : UITextView?
    var activatedTextView2 : UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer = AVSpeechSynthesizer()
        
        //creates an NSURL object that holds the path to your image file.
        //let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        //CIImage with the CIImage(contentsOfURL:) constructor
        //let beginImage = CIImage(contentsOfURL: fileURL!)
        //The CISepiaTone filter takes only two values, the KCIInputImageKey (a CIImage) and the kCIInputIntensityKey, a float value between 0 and 1. Here you give that value 0.5.
        //let filter = CIFilter(name: "CISepiaTone")
        //filter.setValue(beginImage, forKey = kCIInputImageKey)
        //filter!.setValue(0.5, forKey: kCIInputIntensityKey)
        
        //let newImage = UIImage(CIImage: filter!.outputImage!)
        //self.imageView.image = newImage
        
        //let utterance = AVSpeechUtterance(string: "hey·I'm M·")
        //utterance.rate = 0.05
        //utterance.pitchMultiplier = 0.8
        //utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        //        synthesizer?.speakUtterance(utterance)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame;
        blurView.alpha = 0.85
        //backgroundImg.addSubview(blurView)
        //Do any additional setup after loading the view, typically from a nib.
        //dataController.loadJSONDataFromFile()
        //
        Wit.sharedInstance().delegate = self
        
        // create the button
        let screen : CGRect = UIScreen.mainScreen().bounds
        let rect : CGRect = CGRectMake(screen.size.width/2 - 50, 220, 100, 100)
        
        self.witButton.frame = rect
        self.view.addSubview(witButton)
        
        //        _ = rect;
        self.textLabel = UILabel(frame:CGRectMake(0, rect.origin.y - labelOffset - 50, screen.size.width, 50))
        if let label = textLabel {
            label.textAlignment = NSTextAlignment.Center
            label.numberOfLines = 0
            label.textColor = UIColor.whiteColor()
            self.view.addSubview(label)
        }
        
        let labelRect = CGRectMake(0, CGRectGetMaxY(self.witButton.frame) + labelOffset, screen.size.width, 50)
        self.labelView = UILabel(frame: labelRect)
        
        var intentRect = labelRect
        intentRect.origin.y = 500
        intentRect.origin.x = -100
        self.intentLabel = UILabel(frame: intentRect)
        
        if let label = labelView {
            label.textAlignment = NSTextAlignment.Center
            label.numberOfLines = 0
            label.textColor = UIColor.whiteColor()
            self.view.addSubview(label)
        }
        //
        //        if let intent = intentLabel {
        //            intent.textAlignment = NSTextAlignment.Center
        //            intent.textColor = UIColor.redColor()
        //            self.view.addSubview(intent)
        //        }
        //
        //
        //        self.activatedTextView = UITextView(frame: CGRectMake(100, 510, screen.size.width, 50))
        //        if let a = self.activatedTextView {
        //            a.editable = false
        //            a.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber
        //            a.backgroundColor = UIColor.clearColor()
        //            a.textColor = UIColor.blueColor()
        //            a.textAlignment = NSTextAlignment.Center
        //
        //            self.view.addSubview(a)
        //        }
        
        //        Wit().toggleCaptureVoiceIntent()
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController : WitDelegate {
    
    func witDidGraspIntent(outcomes: [AnyObject]!, messageId: String!, customData: AnyObject!, error e: NSError!) {
        //
        if let error = e {
            print("error ", error.localizedDescription)
            return
        }
        
        let firstOutcome : NSDictionary = (outcomes[0] as! NSDictionary)
        let text : String = firstOutcome["_text"] as! String
        let intent : String = firstOutcome["intent"] as! String
        
        let entities : Dictionary <String, Array<Dictionary<String, AnyObject>>> = firstOutcome["entities"] as! Dictionary
        
        if let r = entities["route"], s = entities["stop"] {
            let route = r[0] as Dictionary
            let stop = s[0] as Dictionary
            
            if let smetadata = stop["metadata"] as? String{
                //how would we handle two variations of the URL?
                
                let nextBusString = "\(smetadata)"

//                let nextBusString = "http://www.nextbus.com/customStopSelector/adaPrediction.jsp?a=lametro-rail&r=\(rmetadata)&d=\(rmetadata)_1_var0&s=\(smetadata)_1"
    //            let nextBusString = "http://www.nextbus.com/customStopSelector/adaPrediction.jsp?a=lametro-rail&r=\(rmetadata)&d=\(rmetadata)_1_var1&s=\(smetadata)_0"
                
                let webView = UIWebView(frame: self.view.frame)
                print(nextBusString)
                let url = NSURL(string: nextBusString);
                let urlRequest = NSURLRequest(URL: url!)
                webView.loadRequest(urlRequest)
                
                self.view.addSubview(webView)
                
                return
            }
        }
        
        self.displayErrorForMissedEntity("I misunderstood, can you repeat it?")
    }
    
    func displayErrorForMissedEntity(description: String!) {
        let alert : UIAlertController = UIAlertController(title: "Trouble hearing you", message: description, preferredStyle: UIAlertControllerStyle.Alert)

        let action : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (alertAction : UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateViewLayout() {
        
        let screen : CGRect = UIScreen.mainScreen().bounds
        
        var textLabelFrame = self.textLabel!.frame
        textLabelFrame.size.width = CGRectGetWidth(screen)
        textLabelFrame.origin.y = CGRectGetMinY(self.witButton.frame) - CGRectGetHeight(textLabelFrame) - labelOffset
        self.textLabel!.frame = textLabelFrame
        
        var labelViewFrame = self.labelView!.frame
        labelViewFrame.size.width = CGRectGetWidth(screen)
        self.labelView!.frame = labelViewFrame
    }
    
    //func speakFromIntent(intentModel: IntentModel) {
    //let utterance = AVSpeechUtterance(string: intentModel.description!)
    //utterance.rate = 0.1
    
    //synthesizer?.speakUtterance(utterance)
}







