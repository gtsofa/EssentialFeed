//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Julius on 08/06/2022.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
