//
//  Bar.swift
//  Meu primeiro app
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//
import UIKit
import os.log

class Bar: NSObject, NSCoding {
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(estado, forKey: PropertyKey.estado)
        aCoder.encode(cidade, forKey: PropertyKey.cidade)
        aCoder.encode(bairro, forKey: PropertyKey.bairro)
        aCoder.encode(rua, forKey: PropertyKey.rua)
        aCoder.encode(numero, forKey: PropertyKey.numero)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        guard let cidade = aDecoder.decodeObject(forKey: PropertyKey.cidade) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let estado = aDecoder.decodeObject(forKey: PropertyKey.estado) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let bairro = aDecoder.decodeObject(forKey: PropertyKey.bairro) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let rua = aDecoder.decodeObject(forKey: PropertyKey.rua) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let numero = aDecoder.decodeInteger(forKey: PropertyKey.numero)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, cidade: cidade, estado: estado, bairro: bairro, rua: rua, numero: numero)
    }
    
    //MARK: Properties

    var name: String = ""
    var photo: UIImage?
    var rating: Int = 0
    var cidade: String = ""
    var estado: String = ""
    var bairro: String = ""
    var rua: String = ""
    var numero: Int = 0
    var complemento: String?
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bars")
    

    
    
    //MARK: Initialization
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
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let estado = "estado"
        static let cidade = "cidade"
        static let bairro = "bairro"
        static let rua = "rua"
        static let numero = "numero"
    }
    
    
}
