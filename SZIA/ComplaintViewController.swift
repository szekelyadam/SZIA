//
//  ComplaintViewController.swift
//  SZIA
//
//  Created by Ádibádi on 06/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class ComplaintViewController: UIViewController, UITextViewDelegate {

    @IBAction func editingDidEndOnExit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBOutlet weak var complaintContentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        complaintContentTextView.delegate = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
