//
//  CommonProtocols..swift
//  LeBaluchon
//
//  Created by Claire on 26/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

// Auxiliar protocol that copies URLSession's dataTask function signature for testing purposes(to define mock types that conform to this protocol)
protocol RequestInterface {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: RequestInterface {}
