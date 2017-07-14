//
//  PerfilUserViewController.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import UIKit
import MapKit

class PerfilUserViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //Cria uma referência de Input com o Presenter
    var presenter: PerfilPresenterInput?
    
    //Declara Interface de Perfil
    var eventHandler: PerfilModuleInterface?

    //Modelo de usuário retornado da API
    var user: UserLoginAPI?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var foneLabel: UILabel!
    @IBOutlet weak var celphoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var regionRadius: CLLocationDistance = 0.0
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter?.viewDidLoad()
        
    }

    @IBAction func tapButtonShowMap(_ sender: Any) {
        //Chama função para Presenter avisando que o botão de "Mostrar Mapa" foi clicado
        presenter?.didTapButtonShowMap()
    }
    
    @IBAction func tapButtonClose(_ sender: Any) {
        //Chama função para Presenter avisando que o botão de "Mostrar Mapa" foi clicado
        presenter?.didTapCloseButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PerfilUserViewController: PerfilPresenterOutput {
    func showInfoUser(id: String, name: String, email: String, phone: String, celphone: String, address: String) {
        self.idLabel.text = "id: \(id)"
        self.nameLabel.text = "Nome: \(name)"
        self.emailLabel.text = "Email: \(email)"
        self.foneLabel.text = "Telefone: \(phone)"
        self.celphoneLabel.text = "Celular: \(celphone)"
        self.addressLabel.text = "Endereço: \(address)"
    }
    
    //Mostra Alerta de Erro
    func showLogoff(alertTitle: String, buttonText: String, message: String){
        
        //Cria alerta para mensagem de erro vinda do Presenter
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    func showUserLocationInMap(name: String, lastname: String, latitude: String, longitude: String) {
        
        //Requisita a localizaçãop do usuário
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //Converte a Latitude e a Longitude de String para Doble e de Doble para CLLocationDregress
        let latitudeDegrees : CLLocationDegrees = Double(latitude)!
        let longitudeDegrees : CLLocationDegrees = Double(longitude)!
        
        //Prepara a localização do usuário pela Latitude e Longitude
        let location = CLLocationCoordinate2DMake(latitudeDegrees, longitudeDegrees)
        
        //Seleciona a região do Mapa pela localização do usuário
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        //Formata Title do Annotation
        let titleFormated = "\(name) \(lastname)"
        
        //Formata Subtitle do Anntoation
        let locationFormated = "\(latitude), \(longitude)"
        
        //Recebe a Annotation preparada com os Dados de apresentação
        let annotation = UserAnnotation(coordinate: location, title: titleFormated, subtitle: locationFormated)
        
        //Adiciona alfinete no mapa com a localização do usuário
        self.mapView.addAnnotation(annotation)
        
    }
}

