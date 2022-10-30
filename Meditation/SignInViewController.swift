//
//  ViewController.swift
//  Meditation
//
//  Created by user on 25.10.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {

    @IBOutlet weak var inputLogin: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    // keep auth token
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func SignInAction(_ sender: UIButton) {
    
        guard inputLogin.text?.isEmpty == false && inputPassword.text?.isEmpty == false else {
            return showAlert(message: "Поля пустые")
        }
        
        guard isValidEmail(emailID: inputLogin.text!) else {
            return showAlert(message: "Проверьте правильность почты")
        }
        
        //
        // authorization link:
        // http://mskko2021.mad.hakta.pro/api/user/login?email=\(inputLogin.text!)&password=\(inputPassword.text!)
        //
        let url = "https://mskko2021.mad.hakta.pro/api/user/login"
        
        let param: [String: String] =
        [
            "email": inputLogin.text!,
            "password": inputPassword.text!
        ] // [k31@ru.ru, 123]
        
        // this doesn't work
        // for HTTP the response reports that SECURE is required
        // for HTTPS the response is that connection is not secure, do you want to connect anyway?
        AF.request(url, method: .post, parameters: param, encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let token = json["token"].stringValue
                self.userDef.setValue(token, forKey: "userToken")
                
                // authorization is done
                // go to Main screen
                self.performSegue(withIdentifier: "segueToMain", sender: nil)
                
            case .failure(let error):
                /*
                // response.data is nil, error constant contains the description
                let errorJSON = JSON(response.data!)
                let errorDescription = errorJSON["error"].stringValu
                self.showAlert(message: errorDescription)
                 */
                
                print( error )
                self.showAlert(message: "Authorization failed")
            }
        }
        
        
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Уведомление", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(emailID: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
        
    
}

