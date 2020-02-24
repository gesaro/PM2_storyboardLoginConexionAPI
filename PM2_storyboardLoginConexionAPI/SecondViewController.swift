//
//  SecondViewController.swift
//  PM2_storyboardLoginConexionAPI
//
//  Created by Gerardo on 21/02/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var labelUsuario = ""
    var labelPassword = ""
    
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var tfdPassword: UITextField!
    @IBOutlet weak var btnEliminar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUsuario.text = labelUsuario
        tfdPassword.text = labelPassword
        btnEliminar.tintColor = UIColor.red
        lblUsuario.layer.borderWidth = 1
        lblUsuario.layer.cornerRadius = 4
    
       
    }
    
    
    @IBAction func updateUser(_ sender: Any) {
        
        let datos = Datos(usuario: labelUsuario, password: tfdPassword.text!)
        
        let postRequest = APIRequest(endpoint: "post/\(labelUsuario)")
        postRequest.update(datos, completion: { result in
            switch result{
                case .success(let datos):
                    DispatchQueue.main.async { // Correct
                        let alert = UIAlertController(title: "", message: "Se actualizo correctamente", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                case .failure(let err):
                    print("Error: \(err)\n")
                    
            }
        })
        
        
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        let postRequest = APIRequest(endpoint: "post/\(labelUsuario)")
        postRequest.delete(completion: { result in
            switch result{
                case .success(let datos):
                    print("Se elimino \(datos)")
                    DispatchQueue.main.async { // Correct
//                       self.performSegue(withIdentifier: "secondView", sender: self)
                        self.dismiss(animated: true)
                        
                    }
                case .failure(let err):
                    print("Error: \(err)\n")
                    
            }
        })
    }
}
