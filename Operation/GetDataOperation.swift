//
//  GetDataOperation.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 03.04.2021.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    
    private var request: DataRequest
    var data: Data?
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
            print("GetDataOperation : \(self?.data as Any)")
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}
