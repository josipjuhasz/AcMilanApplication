//
//  NetworkService.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation
import Alamofire
import RxSwift

class NetworkService {
    
    public static let shared = NetworkService()
    
    init() {}
    let headers: HTTPHeaders = [
        "x-rapidapi-key": "7864f3a0c6msh4a6208255b879cap11739ejsn72789bae7c5d",
        "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
    ]
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func getData<T: Codable>(url: String) -> Observable<T>{
        return Observable.create{ observer in
            let request = AF.request(url, headers: self.headers).validate(statusCode: 100..<500).responseDecodable(of: T.self, decoder: self.jsonDecoder){ networkResponse in
                switch networkResponse.result {
                case .success:
                    do{
                        let response = try networkResponse.result.get()
                        observer.onNext(response)
                        observer.onCompleted()
                    }
                    catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

