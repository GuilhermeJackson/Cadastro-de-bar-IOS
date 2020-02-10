//
//  Bar.swift
//  Meu primeiro app
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//
import UIKit

class Bar {
    //MARK: Properties
    //MARK: Initialization

    var name: String = ""
    var photo: UIImage?
    var rating: Int = 0
    var cidade: String = ""
    var estado: String = ""
    var bairro: String = ""
    var rua: String = ""
    var numero: Int = 0
    var complemento: String?
    
    init?(name: String, photo: UIImage?, rating: Int, cidade: String, estado: String, bairro: String, rua: String, numero: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0 && rating <= 5) else {
            return nil
        }
        
        guard (numero >= 1 && numero <= 999999) else{
            return nil
        }
        
        if (!estado.isEmpty) {
            let allowed = "0123456789"
            let charactersSet = CharacterSet(charactersIn: allowed)
            guard estado.rangeOfCharacter(from: charactersSet.inverted) != nil else {
                return nil
            }
        }
 
        self.name = name
        self.photo = photo
        self.rating = rating
        self.cidade = cidade
        self.bairro = bairro
        self.estado = estado
        self.rua = rua
        self.numero = numero
    }
    
    
}
