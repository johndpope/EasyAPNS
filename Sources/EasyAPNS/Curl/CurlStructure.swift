//
//  CurlStructure.swift
//  EasyAPNS
//
//  Created by Damian Malarczyk on 13.07.2016.
//
//
import cURL

/**
 * Swift wrapper for curl_getinfo options
 */
public enum CurlGetOption {
    /// CURLINFO_RESPONSE_CODE
    case httpResponseCode
    /// CURLINFO_HEADER_SIZE
    case headerSize
    
    
    public var rawValue: UInt32 {
        return raw.rawValue
    }
    
    public var raw: CURLINFO {
        switch self {
        case .httpResponseCode:
            return CURLINFO_RESPONSE_CODE
        case .headerSize:
            return CURLINFO_HEADER_SIZE
        }
    }
}

/**
 * Swift wrapper for curl_setopt options
 */
public enum CurlSetOption: Hashable {
    /// CURLOPT_URL
    case url
    /// CURLOPT_PORT
    case port
    /// CURLOPT_HTTPHEADER
    case httpHeader
    /// CURLOPT_POST
    case post
    /// CURLOPT_COPYPOSTFIELDS (curl copies input post data)
    case postFields
    /// CURLOPT_TIMEOUT
    case timeout
    /// CURLOPT_USE_SSL
    case useSsl
    /// CURLOPT_SSLENGINE_DEFAULT
    case sslEngineDefault
    /// CURLOPT_SSL_VERIFYPEER
    case sslVerifyPeer
    /// CURLOPT_SSLCERT
    case sslCert
    /// CURLOPT_KEYPASSWD
    case passPhrase
    /// CURLOPT_CAPATH
    case caPath
    /// CURLOPT_HEADER
    case header
    /// CURLOPT_HTTP_VERSION
    case httpVersion
    /// CURLOPT_VERBOSE
    case verbose
    /// CURLOPT_USERAGENT
    case userAgent
    
    /**
     * curl's raw number option
     */
    public var rawValue: UInt32 {
        return raw.rawValue
    }
    
    
    /**
     * raw CURLOption value
     */
    public var raw: CURLoption {
        switch self {
        case .url:
            return CURLOPT_URL
        case .port:
            return CURLOPT_PORT
        case .httpHeader:
            return CURLOPT_HTTPHEADER
        case .post:
            return CURLOPT_POST
        case .postFields:
            return CURLOPT_COPYPOSTFIELDS
        case .timeout:
            return CURLOPT_TIMEOUT
        case .useSsl:
            return CURLOPT_USE_SSL
        case .sslEngineDefault:
            return CURLOPT_SSLENGINE_DEFAULT
        case .sslVerifyPeer:
            return CURLOPT_SSL_VERIFYPEER
        case .sslCert:
            return CURLOPT_SSLCERT
        case .passPhrase:
            return CURLOPT_KEYPASSWD
        case .caPath:
            return CURLOPT_CAPATH
        case .header:
            return CURLOPT_HEADER
        case .httpVersion:
            return CURLOPT_HTTP_VERSION
        case .verbose:
            return CURLOPT_VERBOSE
        case .userAgent:
            return CURLOPT_USERAGENT
        }
        
    }
    
    public var hashValue: Int {
        return Int(rawValue)
    }
    
}

/**
 * curl types enum, to allow setting many options at once
 */
public enum CurlOptionType {
    case int(Int), upInt8(UnsafePointer<Int8>), int64(Int64),
    umpCurlSlist(UnsafeMutablePointer<curl_slist>), umpVoid(UnsafeMutableRawPointer)
}


/**
 Structural representation of raw curl response
 */
public struct CurlResponse {
    
    /**
    -1 stands for code not yet set
     */
    public var code: Int = -1
    
    /**
     parsed array of headers
     */
    public var headers: [String] = []
    
    /**
     response body
     */
    public var body = String()
    
    let parseMode: CurlParse
    
    init(parseMode: CurlParse = .trimNewLineCharacters) {
        self.parseMode = parseMode
    }
    
}

/**
 Curl response parsing mode
 */
public enum CurlParse {
    
    /// no parsing, keep data received from curl
    case none
    
    /// trim new HTTP's new line characters
    case trimNewLineCharacters
}

/**
 Representation of curl's error
 */
public struct CurlErr: Error {
    
    /**
     curl's error code
     */
    public let err: UInt32
    
    /**
     error description obtained by curl_easy_strerror
     */
    public let description: String
    
    /**
     - parameter curlCode:CURLCode curl code structure
     */
    public init(curlCode: CURLcode) {
        self.err = curlCode.rawValue
        self.description = String(cString: curl_easy_strerror(curlCode))
    }
}
