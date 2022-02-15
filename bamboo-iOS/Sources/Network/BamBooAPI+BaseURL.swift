//
//  BamBooAPI+BaseURL.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Foundation

extension BamBooAPI{
    func getBaseURL() -> URL{
        return URL(string: "https://server.joog-lim.info/apiV3/")!
    }
}
