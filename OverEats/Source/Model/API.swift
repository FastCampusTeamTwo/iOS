//
//  API.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

private let baseURL = "https://www.overeats.kr/api"

// API Protocol
protocol APIProtocol
{
    var urlString: String { get }
}


/// URL의 EndPoint에 파라미터 값을 포함하여 URL을 반환하는 API 열거형
///
/// - 호출 방법 : API.postLogin.urlString
///             API.getRestaurantList(latitude: 37.494760, longitude: 127.051284, pageSize: 20).urlString
///
/// ex) get 또는 post로 변수 앞에 네이밍 참고
/// - getRestaurantList: 메인 페이지 레스토랑 리스트
/// - postLogin: 로그인 API 파라미터에 userName, password 포함
enum API: APIProtocol
{
    // GET API URL 리스트를 열거형으로 정의 %02d
    // 참조) String format에 아규먼트 값을 넣을 경우 필요한 형식
    // %d = Int, %ld = Double, %f = Float, %@ = String
    // %.4f 는 Float의 소숫점 4자리까지만 표기함, 참고로 API에 사용되는 위도 경도 값은 소숫점 6자리 까지
    // %03 는 000, 001, 002 로 형 변환하며, %02는 01, 02, 03 로 형 변환
    enum GET_LIST: String
    {
        case restaurantList = "/restaurant/?lat=%.6f&lng=%.6f&page_size=%d"
        case menuList = "/%@/menu"
    }
    // POST API URL 리스트를 열거형으로 정의
    enum POST_LIST: String
    {
        case login = "/login"
    }
    
    // GET API
    case getRestaurantList(latitude: Float, longitude: Float, pageSize: Int)
    case getMenuList(restaurantId: String)
    
    // POST API
    case postLogin
    
    // endPoint에 파라미터 값을 반환하는 변수
    private var endpointString: String {
        get {
            switch self {
            case .getRestaurantList(let latitude, let longitude, let pageSize):
                return String(format: GET_LIST.restaurantList.rawValue, latitude, longitude, pageSize)
            case .postLogin:
                return String(format: POST_LIST.login.rawValue)
            case .getMenuList(let restaurantId):
                return String(format: GET_LIST.menuList.rawValue, restaurantId)
            }
        }
    }
    
    // 기본 URL 주소와 Endpoint를 합쳐주는 변수
    var urlString: String {
        get {
            return baseURL + self.endpointString
        }
    }
    
//    var URL: NSURL? {
//        get {
//            return NSURL(string: self.urlString)
//        }
//    }
}
