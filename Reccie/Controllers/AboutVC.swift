//
//  AboutVC.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 7/7/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import MessageUI

class AboutVC: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
        print("email button pressed")
//
//        let email = "reccieapp@gmail.com"
//        if let url = URL(string: "mailto:\(email)") {
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["reccieapp@gmail.com"])
            mail.setSubject("Feedback from Reccie App")
            
            present(mail, animated: true)
        } else {
            // show failure alert
            let alert = UIAlertController(title: "Email Client Not Found", message: "It doesn't look like you have an email client set up.", preferredStyle: .actionSheet)
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alert.addAction(actionOK)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
