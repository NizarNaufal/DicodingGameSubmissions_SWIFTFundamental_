//
//  ProfileCatGue.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 24/02/21.
//

import Foundation
import UIKit

class ProfileCatGue: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileJobLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!

    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileNameLabel.text = defaults.string(forKey: "Fullname") ?? "Nizar Naufal"
        
        profileJobLabel.text = String(defaults.string(forKey: "Job") ?? "Android & iOS Engineer at Dvoretsky Groups")
        
        profileEmailLabel.text = String(defaults.string(forKey: "Email") ?? "nizar@dvoretsky.co")
        
    self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        profilePic.layer.cornerRadius =  profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true;
        profilePic.layer.borderWidth = 4.0
        profilePic.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    
    @IBAction func goToEdit(_ sender: Any) {
                // create the alert
                let alert = UIAlertController(title: "Maintenance!", message: "Mohon Maaf , Edit Profile Masih Dalam Tahap Maintenance. ", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func backToHome(_ sender: Any) {navigationController?.popToRootViewController(animated: true)}
    

}
