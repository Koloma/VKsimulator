//
//  MyAppURLs.swift
//  VKsimulator
//
//  Created by Admin on 18.02.2021.
//

import Foundation


class MyAppURLs{

    static let shared = MyAppURLs()
    private init(){
        
    }
    
    lazy var filePath: URL? = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil}
        return url
    }()
    
}
