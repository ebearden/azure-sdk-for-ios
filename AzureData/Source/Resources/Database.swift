//
//  Database.swift
//  AzureData
//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

/// Represents a database in the Azure Cosmos DB account.
///
/// - Remark:
///   Each Azure Cosmos DB database account can have zero or more databases.
///   A database in Azure Cosmos DB is a logical container for document collections and users.
///   Refer to [databases](http://azure.microsoft.com/documentation/articles/documentdb-resources/#databases) for more details on databases.
public struct Database : CodableResource {
    
    public static var type = "dbs"
    public static var list = "Databases"

    public internal(set) var id:         String
    public internal(set) var resourceId: String
    public internal(set) var selfLink:   String?
    public internal(set) var etag:       String?
    public internal(set) var timestamp:  Date?
    public internal(set) var altLink:    String? = nil
    
    public mutating func setAltLink(to link: String) {
        self.altLink = link
    }
    public mutating func setEtag(to tag: String) {
        self.etag = tag
    }

    /// Gets the self-link for collections from the Azure Cosmos DB service.
    public internal(set) var collectionsLink: String?
    
    /// Gets the self-link for users from the Azure Cosmos DB service.
    public internal(set) var usersLink: String?
    
    
    public init (_ id: String) { self.id = id; resourceId = "" }
}


extension Database {
    
    enum CodingKeys: String, CodingKey {
        case id
        case resourceId         = "_rid"
        case selfLink           = "_self"
        case etag               = "_etag"
        case timestamp          = "_ts"
        case collectionsLink    = "_colls"
        case usersLink          = "_users"
    }
}


extension Database : CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Database :\n\tid : \(self.id)\n\tresourceId : \(self.resourceId)\n\tselfLink : \(self.selfLink.valueOrNilString)\n\tetag : \(self.etag.valueOrNilString)\n\ttimestamp : \(self.timestamp.valueOrNilString)\n\taltLink : \(self.altLink.valueOrNilString)\n\tcollectionsLink : \(self.collectionsLink.valueOrNilString)\n\tusersLink : \(self.usersLink.valueOrNilString)\n--"
    }
}
