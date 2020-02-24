//
//  ViewController.swift
//  PM2_storyboardLoginConexionAPI
//
//  Created by Gerardo on 20/02/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfdUsuario: UITextField!
    @IBOutlet weak var tfdPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
    }

    @IBAction func sendDataToServer(_ sender: Any) {
        
        
        
        
        
//        let alert = UIAlertController(title: "enviar datos", message: "Se enviara la informacion al servidor", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
//            action in
//            guard let title = self.tfdTituloPost.text else {print("No hay un titulo valido"); return}
//            guard let information = self.tfdTituloPost.text else {print("No hay informacion valida"); return}
            
//            let datos = Datos(title: title, information: information)
//            let postRequest = APIRequest(endpoint: "post")
//            postRequest.save(datos, completion: { result in
//                switch result{
//                    case .success(let datos):
//                        print("El siguiente mensaje ha sido enviado titulo:\(datos.post_title)\n informacion:\(datos.information)")
//                    case .failure(let err):
//                        print("Ocurrio un error: \(err)")
//                }
//            })
//        }))
//        self.present(alert, animated: true)
//
//
  
        
        
        guard let usuario = tfdUsuario.text else {print("campo usuaio vacio"); return}
        guard let password = tfdPassword.text else {print("campo password vacio"); return}
        let datos = Datos(usuario: usuario, password: password)
       
        let postRequest = APIRequest(endpoint: "post/\(usuario)")
        postRequest.get(datos, completion: { result in
            switch result{
                case .success(let datos):
                    if password == datos.password {
                        DispatchQueue.main.async { // Correct
                           self.performSegue(withIdentifier: "secondView", sender: self)
                        }

                    }
                    else {
                        DispatchQueue.main.async { // Correct
                            let alert = UIAlertController(title: "", message: "Contraseña incorrecta", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            self.tfdPassword.text = ""
                        }
                    }
                case .failure(let err):
                    print("Error: \(err)")
            }
        })
    
    }
    
    @IBAction func createUser(_ sender: Any) {
        
            guard let usuario = tfdUsuario.text else {print("campo usuaio vacio"); return}
            guard let password = tfdPassword.text else {print("campo password vacio"); return}
            let datos = Datos(usuario: usuario, password: password)

            let postRequest = APIRequest(endpoint: "post")
            postRequest.save(datos, completion: { result in
                switch result{
                    case .success(let response):
                        print("se envio el usuario: \(datos.usuario)\n password: \(datos.password)\n \(response)")
                    
                        DispatchQueue.main.async { // Correct
                           self.performSegue(withIdentifier: "secondView", sender: self)
                        }
                    
                    case .failure(let err):
                        print("Error: \(err)")
                }
            })
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let usuario = tfdUsuario.text!
        let password = tfdPassword.text!
        
        let vc = segue.destination as! SecondViewController
        vc.labelUsuario = usuario
        vc.labelPassword = password
    }
    
}



