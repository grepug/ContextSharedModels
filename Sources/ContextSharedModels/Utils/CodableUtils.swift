import Foundation

extension Encodable {
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    public func toString(pretty: Bool = false) throws -> String {
        do {
            let encoder = encoder

            if pretty {
                encoder.outputFormatting = .prettyPrinted
            }

            return String(data: try encoder.encode(self), encoding: .utf8)!
        } catch {
            throw error
        }
    }

    public func toData() throws -> Data {
        do {
            return try encoder.encode(self)
        } catch {
            throw error
        }
    }
}

extension Decodable {
    public static func fromData(_ data: Data, print shouldPrint: Bool = true) throws -> Self {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(Self.self, from: data)
        } catch {
            if shouldPrint {
                print("decoding error: \(error)", "string: \(String(data: data, encoding: .utf8) ?? "no string")")
            }

            throw error
        }
    }

    public static func fromString(_ string: String, print: Bool = true) throws -> Self {
        do {
            return try Self.fromData(Data(string.utf8), print: print)
        } catch {
            throw error
        }
    }
}
