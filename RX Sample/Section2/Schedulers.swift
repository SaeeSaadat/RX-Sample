//
//  Schedulers.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/17/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class Schedulers {
    public static func run(){
        

        //MARK: take(timeInterval , scheduler)
        /*
         ...asObservable().take(5.0, MainScheduler.instance).subscribe(...)
         it completes after the time interval !
         */
        
        //MARK: Debounce & Throttle
        /*
         throttle : takes a time interval and won't recieve the next element if it's emmited before that time interval has passed from the previous element !
          debounce: the function will be called after the time interval has passed since it's actually been called !
         for more : https://medium.com/fantageek/throttle-vs-debounce-in-rxswift-86f8b303d5d4
         */
        
        //MARK: subscribeOn & observeOn
        /*
         observeOn : It allows you to change the scheduler on which the observer code will be executed.
         
         subscribeOn: It allows you to change the scheduler on which the subscription code will be executed. subscribeOn changes the thread for the calls prior to it and also the methods that follow it. Order doesn’t matter, subscribeOn can be placed anywhere.
         */
        
    }
}
