//
//  GoogleSignInViewController.swift
//  CodingExercise
//
//  Created by Suslov Babu on 29/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleSignInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login".localize()
          NotificationCenter.default.addObserver(self, selector: #selector(GoogleSignInViewController.loginSuccess(notification:)), name: Notification.Name("GoogleLoginSuccess"), object: nil)
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginSuccess(notification: Notification){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! ViewController

        self.navigationController?.viewControllers = [viewController]
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print("llDispatch signIn: GIDSignIn!, error: ")
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
