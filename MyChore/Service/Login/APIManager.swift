//
//  APIManager.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation
import Alamofire
import Combine

private let BASE_URL = "http://3.39.106.144:8080/"

class APIManger  {
    static let shared = APIManger()
    private var headers: HTTPHeaders?
    
    func setObserver() {
        LoginViewModel.shared.getAccessToken { token in
            self.headers = ["Authorization": token]
        }
    }
    
    func setRefreshToken(refreshToken: String) {
        self.headers = ["Authorization": refreshToken]
    }
}

extension APIManger {
    // parameter가 있는 get
    func getData<T: Codable, U: Decodable>(urlEndpointString: String,
                                           responseDataType: U.Type,
                                           requestDataType: T.Type,
                                           parameter: T?,
                                           completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .get, parameters: parameter, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    // parameter가 없는 get
    // urlEndpointString api 명세서에 있는 주소 사용
    // responseDataType에는 Codable 모델 사용
    // parameter에는 nil 사용
    func getData<U: Decodable>(urlEndpointString: String,
                               responseDataType: U.Type,
                               parameter: Parameters?,
                               completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
          
    // response가 list로 오는 경우
    func getListData<U: Decodable>(urlEndpointString: String,
                               responseDataType: U.Type,
                               parameter: Parameters?,
                               completionHandler: @escaping (GeneralResponseListModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        print(url)
        
        AF
            .request(url, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: self.headers)
            .responseDecodable(of: GeneralResponseListModel<U>.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func postData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .post, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in

                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    
    func getData<T: Codable, U: Decodable>(url: String,
                                           responseDataType: U.Type,
                                           requestDataType: T.Type,
                                           parameter: T?,
                                           completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: url) else { return }
        
        AF
            .request(url, method: .get, parameters: parameter, headers: headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }

    // put
    func putData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .put, parameters: parameter, encoder: .json, headers: nil)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    
    func putData(url: String, data: Data, completion: @escaping () -> Void) {
        let url = URL(string: url)

        AF.upload(data, to: url!, method: .put).responseData(emptyResponseCodes: [200]) { response in
            print(response)
            switch response.result {
            case .success(let _):
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // request model이 있는 delete
    func deleteData<T: Codable, U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                            requestDataType: T.Type,
                                            parameter: T?,
                                            completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .delete, parameters: parameter, encoder: .json, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in

                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    // request model이 없는 delete
    func deleteData<U: Decodable>(urlEndpointString: String,
                                            responseDataType: U.Type,
                                  completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        print("삭제 요청 URL --> \(url)")
        AF
            .request(url, method: .delete, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    // patch
    func patchData<U: Decodable>(urlEndpointString: String,
                                 responseDataType: U.Type,
                                 completionHandler: @escaping (GeneralResponseModel<U>)->Void) {
        
        guard let url = URL(string: BASE_URL + urlEndpointString) else { return }
        
        AF
            .request(url, method: .patch, headers: self.headers)
            .responseDecodable(of: GeneralResponseModel<U>.self) { response in
                print(response)
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
