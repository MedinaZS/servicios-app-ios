//
//  ServiceModel.swift
//  servicios-app-ios
//
//  Created by Montserrat Medina on 2023-08-25.
//

import Foundation


func getServices() -> [String: [String]] {
    
    let servicesList = [
        "Telefonias": [
            "Tigo", "Claro", "Tigo", "Claro"
        ],
        "Servicios Privados": [
            "Medilife", "Sancor", "Medilife", "Sancor"
        ],
        "Servicios Publicos": [
            "Copaco", "Essap","Copaco", "Essap",
            "Copaco", "Essap","Copaco", "Essap", "Sancor"]
    ]
    
    return servicesList
    
}

func getServicesKeys () -> [String] {
    return ["Telefonias", "Servicios Privados", "Servicios Publicos" ]
}

