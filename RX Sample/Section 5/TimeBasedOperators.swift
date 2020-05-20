//
//  TimeBasedOperators.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/19/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class TimeBasedOperators {
    public static func run(button: UIButton){
        
        
        //MARK: Buffer
        /*
         it emits arrays of elements (length = count!)
         not as useful as u might think !!!
         */
        example(of: "Buffer"){
            let disposeBag = DisposeBag()
            let bufferTimeSpan = 5
            let bufferMaxCount = 2
            
            let sourceObservable = PublishSubject<String>()
            
            sourceObservable
                .buffer(timeSpan: .seconds(bufferTimeSpan) , count: bufferMaxCount, scheduler: MainScheduler.instance)
                .subscribe{
                    print($0)
            }.disposed(by: disposeBag)

//            sourceObservable.onNext("S")
//            sourceObservable.onNext("A")
//            sourceObservable.onNext("L")
//            sourceObservable.onNext("M")

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
                for i in 1...10 {
                    sourceObservable.onNext("\(i)")
                }
            }
            
        }
        //MARK: Window
        /*
         like buffer, except it emits observables instead of arrays
         */
        
        //MARK: Delay Subscription
        /*
          pretty obvious! it will start recieving elements after the delay
         */
        
        //MARK: Delay
        /*
         this one subscribes immediately! but delays each element like it's been emited delayed seconds later!
         */
        
        
    }
}
