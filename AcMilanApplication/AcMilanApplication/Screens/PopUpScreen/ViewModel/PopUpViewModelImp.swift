//
//  PopUpViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 03.08.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PopUpViewModelImp: PopUpViewModel {
    func getPlayerStatistics(data: [PlayerDetails]) -> [String] {
        var topPlayers = [String]()
        
        var topScorer = ""
        var topScorerImage = ""
        var topAssists = ""
        var topAssistsImage = ""
        var mostAppearances = ""
        var mostAppearancesImage = ""
        var bestRating = ""
        var bestRatingImage = ""
        
        var mostGoalsHelper = 0
        var mostAssistsHelper = 0
        var mostAppearancesHelper = 0
        var highestRatingHelper = 0.0
        
        for element in data {
            
            var safeMostGoals = 0
            var safeMostAssists = 0
            var safeMostAppereances = 0
            var safeHighestRating = 0.0
            
            for value in element.statistics{
                
                safeMostGoals = safeMostGoals + (value.goals.total ?? 0)
                safeMostAssists = safeMostAssists + (value.goals.assists ?? 0)
                safeMostAppereances = safeMostAppereances + (value.games.appearences ?? 0)
                
                safeHighestRating = (Double(value.games.rating?.prefix(4) ?? "") ?? 0.0)
                
                if safeHighestRating > Double(highestRatingHelper){
                    highestRatingHelper = safeHighestRating
                    
                    bestRating = "\(element.player.name ?? ""): \(highestRatingHelper) rating"
                    bestRatingImage = element.player.photo ?? ""
                }
                
            }
            
            if safeMostGoals > mostGoalsHelper{
                
                mostGoalsHelper = safeMostGoals
                
                topScorer = "\(element.player.name ?? ""): \(mostGoalsHelper) goals"
                topScorerImage = element.player.photo ?? ""
            }
            
            if safeMostAssists > mostAssistsHelper{
                mostAssistsHelper = safeMostAssists
                
                topAssists = "\(element.player.name ?? ""): \(mostAssistsHelper) assists"
                topAssistsImage = element.player.photo ?? ""
            }
            
            if safeMostAppereances > mostAppearancesHelper{
                mostAppearancesHelper = safeMostAppereances
                
                mostAppearances = "\(element.player.name ?? ""): \(mostAppearancesHelper) appereances"
                mostAppearancesImage = element.player.photo ?? ""
            }
        }
        
        topPlayers.append(topScorer)
        topPlayers.append(topScorerImage)
        topPlayers.append(topAssists)
        topPlayers.append(topAssistsImage)
        topPlayers.append(mostAppearances)
        topPlayers.append(mostAppearancesImage)
        topPlayers.append(bestRating)
        topPlayers.append(bestRatingImage)
        
        return topPlayers
    
    }
}


