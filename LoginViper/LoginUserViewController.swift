//
//  LoginUserViewController.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 07/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import UIKit

class LoginUserViewController: UIViewController, UITextFieldDelegate {

    //Cria uma referência de Input com o Presenter
    var presenter: LoginPresenterInput?
    
    //Declara Interface de Logjn
    var eventHandler: LoginModuleInterface?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventHandler?.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.emailTextField.text = "jose@gmail.com"
        self.passwordTextField.text = "12345678"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Carrega a função de toque do botão de Login, dentro do Presenter
    @IBAction func tapLogin(_ sender: Any) {
        //Passa os parâmentros de login de acordo com os TextFields preenchidos
        presenter?.didTapLoginButton(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    //MARK:- TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginUserViewController: LoginPresenterOutput {
    func showLoading() {
        //Carrega loading do Activity Indicator.
        self.activity.startAnimating()
    }
    
    func stopLoading() {
        //Efetua parada do Activity Indicator.
        self.activity.stopAnimating()
        //self.activity.isHidden = true
    }
    
    //Mostra Alerta de Erro
    func showAlert(alertTitle: String, buttonText: String, errorMessage: String){
        
        //Cria alerta para mensagem de erro vinda do Presenter
        let alert = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    //Mostra Alerta de Sucesso
    func showAlertSuccess(alertTitle: String, buttonText: String, message: String){
        //Cria alerta para mensagem de erro vinda do Presenter
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: { action in
            
            self.presenter?.alertSuccessDismissed()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
