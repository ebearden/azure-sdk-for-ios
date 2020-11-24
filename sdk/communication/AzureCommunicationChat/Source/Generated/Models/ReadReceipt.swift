// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable identifier_name
// swiftlint:disable line_length
// swiftlint:disable cyclomatic_complexity

/// A chat message read receipt indicates the time a chat message was read by a recipient.
public struct ChatMessageReadReceipt: Codable {
    // MARK: Properties

    /// Chat message read receipt sender id.
    public let senderId: String?
    /// Id for the chat message that has been read. This id is generated by the server.
    public let chatMessageId: String?
    /// Chat message read receipt timestamp. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    public let readOn: Date?

    // MARK: Initializers

    /// Initialize a `ChatMessageReadReceipt` structure.
    /// - Parameters:
    ///   - senderId: Chat message read receipt sender id.
    ///   - chatMessageId: Id for the chat message that has been read. This id is generated by the server.
    ///   - readOn: Chat message read receipt timestamp. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    public init(
        senderId: String? = nil, chatMessageId: String? = nil, readOn: Iso8601Date? = nil
    ) {
        self.senderId = senderId
        self.chatMessageId = chatMessageId
        self.readOn = readOn
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case senderId
        case chatMessageId
        case readOn
    }

    /// Initialize a `ChatMessageReadReceipt` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.senderId = try? container.decode(String.self, forKey: .senderId)
        self.chatMessageId = try? container.decode(String.self, forKey: .chatMessageId)
        self.readOn = try? container.decode(Iso8601Date.self, forKey: .readOn)
    }

    /// Encode a `ChatMessageReadReceipt` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if senderId != nil { try? container.encode(senderId, forKey: .senderId) }
        if chatMessageId != nil { try? container.encode(chatMessageId, forKey: .chatMessageId) }
        if readOn != nil { try? container.encode(readOn, forKey: .readOn) }
    }
}
