//
//  CommonProtocols..swift
//  LeBaluchon
//
//  Created by Claire on 26/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

protocol RequestInterface {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: RequestInterface {}
