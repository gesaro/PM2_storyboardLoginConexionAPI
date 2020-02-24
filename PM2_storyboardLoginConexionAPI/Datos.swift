//
//  Datos.swift
//  PM2_storyboardLoginConexionAPI
//
//  Created by Gerardo on 20/02/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import Foundation

final class Datos:Codable {
    var id:Int?
    
    var usuario:String
    var password:String
    
    init(usuario:String, password: String){
        self.usuario = usuario
        self.password = password
    }
}
