//
//  MoreCombining.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/19/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.

import Foundation
import RxSwift

class MoreCombining{
    public static func run(){
        
        //MARK: WithLatestFrom
        // in this example, everytime button emits a value, the value it's self will be ignored and instead the observer will recieve the latest value from textField instead! pretty useful!
        // // //        dataSource.withLatestFrom(trigger)
        example(of: "withLatestFrom") {
            let disposeBag = DisposeBag()
            
            let button = PublishSubject<Void>()
            let textField = PublishSubject<String>()
            
            button
                .withLatestFrom(textField)
                .subscribe(onNext: { value in
                    print(value)
                }).disposed(by: disposeBag)
            
            textField.onNext("Par")
            textField.onNext("Pari")
            button.onNext(())
            textField.onNext("Paris")
            button.onNext(())
            button.onNext(())
        }
        
        //MARK: Sample
        // like withLatestFrom, except it will emit if only textField has emited something since the last button tap!
        // // //            trigger.sample(dataSource)
        example(of: "sample") {
            let disposeBag = DisposeBag()
            
            let button = PublishSubject<Void>()
            let textField = PublishSubject<String>()
            
            textField
                .sample(button)
                .subscribe(onNext: { value in
                    print(value)
                }).disposed(by: disposeBag)
            
            textField.onNext("Par")
            textField.onNext("Pari")
            button.onNext(())
            button.onNext(())
            textField.onNext("Paris")
            button.onNext(())
            button.onNext(())
        }
        
    }
}
