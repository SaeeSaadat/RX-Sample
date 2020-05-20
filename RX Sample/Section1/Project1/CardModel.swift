//
//  CardModel.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/15/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation

class CardModel{

    public static let cards = [("A" , 11) , ("A" , 2) , ("A" , 3) , ("A" , 4) , ("A" , 5), ("A" , 6), ("A" , 7), ("A" , 8), ("A"                     , 9), ("A" , 10), ("A" , 10), ("A" , 10), ("A" , 10) ,
                        ("B" , 11) , ("B" , 2) , ("B" , 3) , ("B" , 4) , ("B" , 5), ("B" , 6), ("B" , 7), ("B" , 8), ("B" , 9), ("B" , 10), ("B" , 10), ("B" , 10), ("B" , 10) ,
                        ("C" , 11) , ("C" , 2) , ("C" , 3) , ("C" , 4) , ("C" , 5), ("C" , 6), ("C" , 7), ("C" , 8), ("C" , 9), ("C" , 10), ("C" , 10), ("C" , 10), ("C" , 10) ,
                        ("D" , 11) , ("D" , 2) , ("D" , 3) , ("D" , 4) , ("D" , 5), ("D" , 6), ("D" , 7), ("D" , 8), ("D" , 9), ("D" , 10), ("D" , 10), ("D" , 10), ("D" , 10)
    ]

    public static func cardString(for hand: [(String, Int)]) -> String{
        return hand.map{$0.0 + String($0.1)}.joined(separator: " ")
    }

    public static func points(for hand: [(String , Int)]) -> Int {
        return hand.map{$0.1}.reduce(0 , +)
    }
}

enum BlackjackError : Error {
    case busted
}
