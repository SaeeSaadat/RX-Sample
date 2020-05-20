//
//  Project1.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/15/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

typealias Card = (String , Int)

class Project1 {
    
    
    static func run() {
        example(of: "Project 1"){
            
            let disposeBag = DisposeBag()
            let dealtHand = PublishSubject<[Card]>()
            
            func deal(_ cardCount : UInt){
                var deck = CardModel.cards
                var cardsRemaining: UInt32 = UInt32(CardModel.cards.count)
                var hand = [Card]()
                
                for _ in 0..<cardCount {
                    let randomIndex = Int(arc4random_uniform(cardsRemaining))
                    hand.append(deck[randomIndex])
                    deck.remove(at: randomIndex)
                    cardsRemaining -= 1
                }
                
                if CardModel.points(for: hand) > 21 {
                    dealtHand.onError(BlackjackError.busted)
                }else {
                    dealtHand.onNext(hand)
                }
                
            }

            
            func doSubscribe(){
                dealtHand.subscribe(onNext: { cards in
                    print(CardModel.cardString(for: cards) , " : " , CardModel.points(for: cards))
                }, onError: { error in
                    print(error)
                    }).disposed(by: disposeBag)
            }
            
            
            doSubscribe()
            deal(3)
            
        }
    }
}
