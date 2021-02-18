//
//  RealmService.swift
//  VKsimulator
//
//  Created by Admin on 17.02.2021.
//

import Foundation
import RealmSwift


class RealmService{
    
    static let shared = RealmService()
    private lazy var realm : Realm? = {
        #if DEBUG
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm error")
        #endif
        return try? Realm()
    }()
    
    private init() {
    }
    
    func saveGroups(_ groups: [VKGroup.Group]){
        
        guard let realm = realm else { return }
        
        var realmGroups : [RealmGroup] = []
        for group in groups{
            realmGroups.append(group.convertToRealm())
        }
            
        do {
            realm.beginWrite()
            realm.deleteAll()
            realm.add(realmGroups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        #if DEBUG
            print("Groups saved to realm")
        #endif
    }
    
    func loadGroups()->[VKGroup.Group]{
        guard let realm = realm else { return [] }
        let realmGroups = realm.objects(RealmGroup.self)
        
        
        var clearGroups : [VKGroup.Group] = []
        for realmGroup in realmGroups{
            clearGroups.append(realmGroup.convertToClear())
        }
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return clearGroups
    }
    
    func savePhotos(_ elements: [VKPhoto.Photo]){
        
        guard let realm = realm else { return }
        
        var arrayRealm : [RealmPhoto] = []
        for element in elements{
            arrayRealm.append(element.convertToRealm())
        }
            
        do {
            realm.beginWrite()
            realm.deleteAll()
            realm.add(arrayRealm)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        #if DEBUG
        print("\(type(of: elements)) saved to realm")
        #endif
    }
    
    func loadPhotos()->[VKPhoto.Photo]{
        guard let realm = realm else { return [] }
        let realmArray = realm.objects(RealmPhoto.self)
        
        
        var clearArray : [VKPhoto.Photo] = []
        for item in realmArray{
            clearArray.append(item.convertToClear())
        }
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return clearArray
    }
    
    func saveUsers(_ elements: [VKUser.User]){
        
        guard let realm = realm else { return }
        
        var arrayRealm : [RealmUser] = []
        for element in elements{
            arrayRealm.append(element.convertToRealm())
        }
            
        do {
            realm.beginWrite()
            realm.deleteAll()
            realm.add(arrayRealm)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        #if DEBUG
        print("\(type(of: elements)) saved to realm")
        #endif
    }
    
    func loadUsers()->[VKUser.User]{
        guard let realm = realm else { return [] }
        let realmArray = realm.objects(RealmUser.self)
        
        
        var clearArray : [VKUser.User] = []
        for item in realmArray{
            clearArray.append(item.convertToClear() as! VKUser.User)
        }
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return clearArray
    }
    
    func load<T1:Object,T2>(typeRealm: T1.Type)->[T2] where T1: ConvertToClear {
        guard let realm = realm else { return [] }
        let realmArray = realm.objects(T1.self)
        
        
        var clearArray : [T2] = []
        for item in realmArray{
            clearArray.append(item.convertToClear() as! T2)
        }
        #if DEBUG
            print("Groups loaded from realm")
        #endif
        return clearArray
    }
    
    func save<T1:Object,T2:ConvertToRealm>(typeRealm: T1, _ elements: [T2]){
        
        guard let realm = realm else { return }
        
        var arrayRealm : [T1] = []
        for element in elements{
            arrayRealm.append(element.convertToRealm() as! T1)
        }
            
        do {
            realm.beginWrite()
            realm.deleteAll()
            realm.add(arrayRealm)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        #if DEBUG
        print("\(type(of: elements)) saved to realm")
        #endif
    }
    
//    func save<T1,T2>(_ groups: [T1],_ type2: T2.Type) where T2:Object {
//
//        guard let realm = realm else { return }
//
//        var realmGroups : [T2] = []
//        for group in groups{
//            realmGroups.append(group.convertToRealm())
//        }
//
//        do {
//            realm.beginWrite()
//            realm.add(realmGroups)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//        #if DEBUG
//            print("Groups saved to realm")
//        #endif
//    }
    
}
