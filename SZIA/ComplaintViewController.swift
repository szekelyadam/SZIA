//
//  ComplaintViewController.swift
//  SZIA
//
//  Created by Ádibádi on 06/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class ComplaintViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var complainantNameTopConstraint: NSLayoutConstraint!
    @IBAction func editingDidEndOnExit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBOutlet weak var complaintContentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        complaintContentTextView.delegate = self
    }

    @IBAction func complaintControlTouchUpInside(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                
                if (self.complaintContentTextView.frame.origin.y + self.complaintContentTextView.frame.size.height) > (self.view.frame.size.height - keyboardSize.height) {
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                        self.complainantNameTopConstraint.constant = -((self.complaintContentTextView.frame.origin.y + self.complaintContentTextView.frame.size.height) - (self.view.frame.size.height - keyboardSize.height))
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.complainantNameTopConstraint.constant = 10
            self.view.layoutIfNeeded()
        })
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
