//
//  OperatorsExamples.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/16/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class OperatorsExamples{
    public static func run(){
        
        //MARK: Ignore Elements
        example(of: "ignoreElements"){
            
            let disposeBag = DisposeBag()
            
            let cancelledProjects = PublishSubject<String>()
            
            cancelledProjects
                .ignoreElements()
                .subscribe {
                    print($0)
            }.disposed(by: disposeBag)
            
            cancelledProjects.onNext("You are not gonna get printed")
            cancelledProjects.onNext("You are not gonna be emitted either")
            cancelledProjects.onNext("You are all gonna die and no one's gonna know!")
            cancelledProjects.onCompleted() //this is gonna be printed tho !
        }
        
        //Mark: ElementAt
        example(of: "Element At") {
            let disposeBag = DisposeBag()
            let quotes = PublishSubject<String>()
            
            quotes
                .elementAt(2)
                .subscribe(onNext: {
                    print($0)
                } , onCompleted: {
                    print("Completed")
                })
                .disposed(by: disposeBag)
            
            quotes.onNext("not u")
            quotes.onNext("not u either")
            quotes.onNext("You are the chosen one !")
            quotes.onNext("nah you can go fys")
            quotes.onCompleted() //yes ! you will be emitted as well
        }
        
        
        //MARK: Filter
        
        let tomatoMeterRating : [(name: String ,rating: Float)] = [
            (name: "The Room" , rating: -100) ,
            (name: "X-Men all of them" , rating: 5) ,
            (name: "Deadpool" , rating: 99) ,
            (name: "Deadpool 2" , rating: 99.9) ,
            (name: "Deadpool 0" , rating: 0 ) ,
            (name: "Ted" , rating: 89) ,
            (name: "Ted 2" , rating: 93)
        ]
        
        example(of: "Filter") {
            let disposeBag = DisposeBag()
        
            Observable.from(tomatoMeterRating)
                .filter{ movie in
                    movie.rating >= 90
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        //MARK: Skip - Take
        /*
            Static :
         skip(n) : skips elements until the Nth element
         take(n) : takes elements until the Nth element and then stops emitting them !
         skipWhile{ $0 % 2 == 1 } : skips elements until the predicate fails and then emmits the rest
         takeWhile{ $0 < 3} : takes elements until the predicate is true ! and then stops
            Dynamic :
         skipUntil : keeps skipping till it's told not to
         takeUntil : keeps taking till it's told not to
         */
        
        example(of: "SkipWhile") {
            let disposeBag = DisposeBag()
            
            Observable.from(tomatoMeterRating)
                .skipWhile {movie in
                    movie.rating < 90
                }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        }
        
        example(of: "SkipUntil") {
            let disposeBag = DisposeBag()
            
            let subject = PublishSubject<String>()
            let trigger = PublishSubject<Void>()
            
            subject
                .skipUntil(trigger)
                .subscribe(onNext: {
                    print($0)
                })
                 .disposed(by: disposeBag)
            
            subject.onNext("1- Nope")
            subject.onNext("2- Nope")
            subject.onNext("3- Nope")
            
            trigger.onNext(())
            
            subject.onNext("4- Yup")
            subject.onNext("5- Yup")
            
        }
        
        //MARK: DistinctUntilChanged
        //if 2 elements in a row are the same , it won't emmit it  
        example(of: "DistinctUntilChanged") {
            let disposeBag = DisposeBag()
            
            enum Droid {
                case ET, R2D2, Marcus, YOMAMA
            }
            
            Observable<Droid>.of(.ET , .R2D2 , .R2D2 , .YOMAMA , .R2D2 , .YOMAMA , .YOMAMA , .YOMAMA)
                .distinctUntilChanged()
                    .subscribe(onNext: {
                        print($0)
                    })
                .disposed(by: disposeBag)
        }
        

        
    }
}
