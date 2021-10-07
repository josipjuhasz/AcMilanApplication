//
//  Repository.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation
import RxSwift

class RepositoryImpl: Repository {
   
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getResults() -> Observable<ResultsResponse> {
        let resultsResponse: Observable<ResultsResponse> = networkService.getData(url: "https://api-football-v1.p.rapidapi.com/v3/fixtures?team=489&last=40")
        return resultsResponse
    }
    
    func getResultsDetails(id: Int) -> Observable<ResultsResponse>{
        let transfersResponse: Observable<ResultsResponse> = networkService.getData(url: "https://api-football-v1.p.rapidapi.com/v3/fixtures?id=\(id)")
        return transfersResponse
    }
    
    func getSeason(season: String) -> Observable<PlayerResponse> {
        let seasonResponse: Observable<PlayerResponse> = networkService.getData(url: "https://api-football-v1.p.rapidapi.com/v3/players?team=489&season=\(season.prefix(4))")
        return seasonResponse
    }
    
    func getTransfers(id: Int) -> Observable<TransfersResponse>{
        let transfersResponse: Observable<TransfersResponse> = networkService.getData(url: "https://api-football-v1.p.rapidapi.com/v3/transfers?player=\(id)")
        return transfersResponse
    }
}

protocol Repository: AnyObject {
    
    func getResults() -> Observable<ResultsResponse>
    func getSeason(season: String) -> Observable<PlayerResponse>
    func getTransfers(id: Int) -> Observable<TransfersResponse>
    func getResultsDetails(id: Int) -> Observable<ResultsResponse>
}
