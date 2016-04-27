
//
//  RGFadeView.swift
//  RGFadeView-Swift
//
//  Created by Arvin on 15/10/29.
//  Copyright © 2015年 com.roroge. All rights reserved.
//

import UIKit

let kScreen_height: CGFloat = UIScreen.mainScreen().bounds.size.height
let kScreen_width: CGFloat = UIScreen.mainScreen().bounds.size.width
let kScreen_frame: CGRect = CGRectMake(0, 0, kScreen_width, kScreen_height)
class RGFadeView: UIView ,UITextViewDelegate{
    
    
    
    @IBOutlet weak var zuozheBtn: UIButton!
    @IBOutlet weak var titelLbl: UILabel!
    @IBOutlet var customView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var msgTextView: UITextView!

    @IBOutlet weak var placeLabel: UILabel!
    
    var _maskView : UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    func textH(height:CGFloat){
        self.customView.height(height)
msgTextView.frame = CGRectMake(msgTextView.frame.origin.x, msgTextView.frame.origin.y, msgTextView.frame.width, msgTextView.frame.height - 100)
        
    }
    func textTitle(str:String){
        titelLbl.text = str
    
        placeLabel.text = str
        
    }
    func commonInit () {
        NSBundle.mainBundle().loadNibNamed("RGFadeView", owner: self, options: nil)
        self.customView.frame.size.width = self.frame.size.width
        self.customView.width(self.width())
        self.customView.height(200)
        self.customView.bottom(self.bottom())
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0
        
        _maskView = UIView.init(frame: self.bounds)
        _maskView.backgroundColor = UIColor.blackColor()
        _maskView.alpha = 0.5
        self.addSubview(_maskView)

        self.addSubview(self.customView)
        let tap = UITapGestureRecognizer.init(target: self, action:"tapClick:")
        _maskView.addGestureRecognizer(tap)
    
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
   
    func tapClick (sender:UITapGestureRecognizer) {
        self.closeBtnClick(nil)
    }
    
    func keyboardWillChangeFrame(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        
        if endFrame?.origin.y == kScreen_height {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.customView.frame.origin.y = kScreen_height
                self.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.alpha = 1
                self.customView.bottom(kScreen_height - (endFrame?.height)!)
            })
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        if self.msgTextView.text.characters.count > 0 {
            self.placeLabel.hidden = true
        } else {
            self.placeLabel.hidden = false
        }
    }
    
    @IBAction func closeBtnClick(sender: UIButton?) {
        self.msgTextView.resignFirstResponder()
        self.msgTextView.text = ""
        self.placeLabel.hidden = false
        
    }
    
//    @IBAction func sendBtnClick(sender: UIButton) {
//       // self .closeBtnClick(nil)
//        
////        self.msgTextView.resignFirstResponder()
////        self.placeLabel.hidden = false
////        print(self.msgTextView.text)
//        
//    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
}
