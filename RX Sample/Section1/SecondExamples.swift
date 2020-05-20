//
//  SecondExamples.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/14/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class SecondExamples {
    
    class func run(){
        
        //MARK: publishSubject
        //new subscribers will recieve data that are emmited after their subscription ! like newspaper!
        example(of: "PublishSubject"){
            let quotes = PublishSubject<String>()
            let disposeBag = DisposeBag()
            
            quotes.onNext("it's not my fault")
            
            let subscriptionOne = quotes.subscribe{
                print("1) " , $0)
            }
            quotes.onNext("Do or Do not! i don't give a fuck !")
            
            //            let subscriptionTwo =
            quotes.subscribe{
                print("2)" , $0)
            }.disposed(by: disposeBag)
            
            quotes.onNext("come and get your love")
            
            subscriptionOne.dispose()
            
            quotes.onNext("I wanna know what cock is")
        }
        
        
        //MARK: BehaviorSubject
        // your subscribers will always get the last data ! even if it subscribes after emmiting it !
        
        example(of: "BehaviorSubject"){
            let disposeBag = DisposeBag()
            
            let quotes = BehaviorSubject(value: "I Am your DaDa")
            
            let subscriptionOne = quotes.subscribe{
                print("1) " , $0)
            }
            subscriptionOne.disposed(by: disposeBag)
        }
        
        //MARK: ReplaySubject
        // previous data will replay to the new subscriber
        example(of: "ReplaySubject"){
            let disposeBag = DisposeBag()
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            subject.onNext("Use your hips")
            
            subject.subscribe{
                print("1) " , $0)
            }
            .disposed(by: disposeBag)
            
            subject.onNext("and then eat chips")
            
            subject.subscribe{
                print("2) " , $0)
            }.disposed(by: disposeBag)
        }
        
        
        example(of: "Variable"){
            let disposeBag = DisposeBag()
            
            let variable = Variable("May the force be with me")
            
        }
        
    }
    
}
