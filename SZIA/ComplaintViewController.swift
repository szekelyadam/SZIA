//
//  ComplaintViewController.swift
//  SZIA
//
//  Created by Ádibádi on 06/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class ComplaintViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var complainantNameTextField: UITextField!
    @IBOutlet weak var complainantEmailTextField: UITextField!
    @IBOutlet weak var complaintSubjectTextField: UITextField!
    @IBOutlet weak var complainantNameTopConstraint: NSLayoutConstraint!
    @IBAction func editingDidEndOnExit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBOutlet weak var complaintContentTextView: UITextView!
    
    var urlSession: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
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

    @IBAction func sendComplaintButtonTouch(sender: AnyObject) {
        var complaint = [NSObject: AnyObject]()
        complaint["name"] = self.complainantNameTextField.text!
        complaint["email"] = self.complainantEmailTextField.text!
        complaint["subject"] = self.complaintSubjectTextField.text!
        complaint["content"] = self.complaintContentTextView.text
        
        if (complaint["name"] as! String == "") || (complaint["email"] as! String == "") || (complaint["subject"] as! String == "") || (complaint["content"] as! String == "") {
            let alert = UIAlertController(title: "Kérjük minden adatot tölts ki", message: "", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let jsonData: NSData!
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(complaint, options: NSJSONWritingOptions(rawValue: 0))
        } catch {
            return
        }
        
        let url = NSURL(string: "http://szia-backend.herokuapp.com/api/complaints")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postTask = urlSession.uploadTaskWithRequest(request, fromData: jsonData, completionHandler: { data, response, error in
            
            do {
                guard let response = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? [NSObject: AnyObject]
                    else {
                        return
                }
                
                let result = response["result"] as? String
                let alert = UIAlertController(title: "Panasz elküldése sikeres", message: result, preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: {
                    self.complainantNameTextField.text = ""
                    self.complainantEmailTextField.text = ""
                    self.complaintSubjectTextField.text = ""
                    self.complaintContentTextView.text = ""
                })
            } catch {}
        })
        
        postTask.resume()
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
