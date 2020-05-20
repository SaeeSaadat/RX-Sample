import Foundation
import RxSwift


public let episodeI = "I: The Phantom Menace"
public let episodeII = "II: Attack of the Clones"
public let TheCloneWars = "The Clone Wars"
public let episodeIII = "III: Revenge of the Sith"
public let solo = "Solo"
public let rogueOne = "Rogue One"
public let episodeIV = "IV: A New Hope"
public let episodeV = "V: The Empire Strikes Back"
public let episodeVI = "VI: Return of the Jedi"
public let episodeVII = "VII: The Force Awakens"
public let episodeVIII = "VIII: The Last Jedi"
public let episodeIX = "Episode IX"

enum JediRanking : String {
    case youngling , master , yoda
}
class Jedi{
    //BehaviorSubject -> Variable
    var rank : BehaviorSubject<JediRanking>
    init(rank: BehaviorSubject<JediRanking>){
        self.rank = rank
    }
}

public func example(of description: String, action: ()->Void){
    print("\n--- Example of:" , description , "---")
    action()
}
