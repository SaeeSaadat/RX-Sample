//
//  Transformers.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/18/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class Transformers {
    
    public static func run(){
        
        //MARK: Map
        // change the elements inside the initial array and return a different one !
        example(of: "map") {
            let disposeBag = DisposeBag()
            
            let letters = ["1 S" , "2 A" , "3 L" , "4 A" , "5 M" , "6 G" , "7 O" , "8 L" , "9 A" , "10 B" , "11 I"]
            Observable<String>.from(letters)
                .map {
                    var components = $0.components(separatedBy: " ")
                    components[0] = components[0] + ")"
                    return components.joined(separator: " ")
                }
                .subscribe(onNext:{
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        

        
        //MARK: FlatMap
        // subscribe to a specific attribute of the element !
        // this way, if an attribute inside the element changes, the observer will be called !
        example(of: "FlatMap") {
            let disposeBag = DisposeBag()
    
            let ryan = Jedi(rank: BehaviorSubject(value: .youngling))
            let charlotte = Jedi(rank: BehaviorSubject(value: .youngling))
            
            let student = PublishSubject<Jedi>()
            
            student
                .flatMap {
                    $0.rank
                }
                .subscribe(onNext:{
                    print($0.rawValue)
                })
                .disposed(by: disposeBag)
            
            student.onNext(ryan)
            ryan.rank.onNext(.master)
            student.onNext(charlotte)
            ryan.rank.onNext(.yoda)
        }
        
        //MARK: FlatMapLatest
        // just like faltMap, but this time, when a new element is emitted, the previous ones will be ignored !!
        example(of: "flatMapLatest"){
            let disposeBag = DisposeBag()
             
            let ryan = Jedi(rank: BehaviorSubject(value: .youngling))
            let charlotte = Jedi(rank: BehaviorSubject(value: .youngling))
            
            let student = PublishSubject<Jedi>()
            
            student
                .flatMapLatest {
                    $0.rank
            }
            .subscribe(onNext:{
                print($0.rawValue)
            })
                .disposed(by: disposeBag)
            
            student.onNext(ryan)
            ryan.rank.onNext(.master)
            student.onNext(charlotte)
            ryan.rank.onNext(.yoda) //now this will not be observed !!! because we're observing the last element which is charlotte ! ryan just doesn't matter anymore !
        }
        
    }
}
