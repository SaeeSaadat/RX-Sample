//
//  ExampleZero.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/14/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

//Variable
//it can only emmit data ! no errors ! no completed events ! it's the simplest of em all !

class ExampleZero{
    
    class func run(){
        
        let names = Variable(["Saee" , "Alireza" , "Arshia" , "Ali" , "Mammad"])
        
        let subscription1 = names.asObservable().subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("Completed")
        }, onDisposed:{
            print("i just got Wrecked !!!!")
        } )
        print("vabalabadubdub")
        names.value.append("Gholamreza rezaE")
        subscription1.dispose()
        
        
    }
}
