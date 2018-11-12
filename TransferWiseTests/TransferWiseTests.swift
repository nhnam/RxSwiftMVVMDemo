//
//  TransferWiseTests.swift
//  TransferWiseTests
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Moya
import RealmSwift
import Mapper

@testable import TransferWise

class TransferWiseSpecs: QuickSpec {
    override func spec() {
        describe("Network") {
            it("should have network provider") {
                expect(provider).toNot(beNil())
            }
            it("should have provider is a Network") {
                expect(provider).to(beAKindOf(MoyaProvider<Network>.self))
            }
        }
        
        describe("Model") {
            it("Post should be an Object") {
                let post = Post()
                expect(post).to(beAKindOf(Object.self))
            }
            it("Post should be a Mappable") {
                let post = Post()
                expect(post).to(beAKindOf(Mappable.self))
            }
            it("1.should save a post successfully") {
                let post = Post()
                post.id = 198
                do {
                    expect(try RealmParser().writeObject(object: post)).toNot(throwError())
                } catch (let error) {
                    fail()
                }
            }
            it("2.should have post with id = 198") {
                let realm = try! Realm()
                let postObjects = realm.objects(Post.self)
                let posts:[Post] = postObjects.map { item -> Post in
                    return item
                }
                
                expect(posts.filter { return $0.id == 198 }.count).to(beGreaterThan(0))
            }
        }
        
        describe("Utility") {
            
        }
        
        describe("Repository") {
            it("get all posts online should not throw") {
                let onlineRepo = RemotePostRepository()
                expect(onlineRepo.getAllPost()).toNot(throwError())
            }
            
            it("get all posts offline should not throw") {
                let offlineRepo = OfflinePostRepository()
                expect(offlineRepo.getAllPost()).toNot(throwError())
            }
        }
        
        describe("ViewControllers") {
            it("it should have more fancy UI") {}
            it("it should have more validators") {}
            it("it should have beautiful loading control") {}
            it("it should have more test cases") {}
        }
        
        describe("Services") {
            it("it should have offline service") {}
            it("it should have online service") {}
            it("it should have more amazing futures") {}
            it("it should need amazing developers") {}
        }
    }
}
