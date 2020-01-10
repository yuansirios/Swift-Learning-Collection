//
//  YSNetwork.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/14.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit
import Alamofire

class YSNetwork: NSObject {
    
    /**
     *  网络请求成功闭包:(回调成功结果)
     */
    typealias NetworkSuccess = (_ response:AnyObject) -> ()
    
    /**
     *  网络请求失败闭包:(回调失败结果)
     */
    typealias NetworkFailure = (_ error:NSError) -> ()
    
    /**
     *  上传进度闭包:(回调:1.完成比例 2.已经上传大小,3.文件总大小)
     */
    
    typealias UploadProgress = (_ fractionCompleted: Double, _ completedUnitCount: Int64, _ totalUnitCount: Int64) -> ()
    
    /**
     *  下载进度闭包:(回调:1.单次写入大小 2.已经写入大小,3.文件总大小)
     */
    typealias DownloadProgress = (_ bytesRead:Int64, _ totalBytesRead:Int64, _ totalBytesExpectedToRead:Int64) -> ()
    
    /**
     *  网络请求单例
     */
    static let shareNetwork = YSNetwork()
    
    var sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10//请求超时时间
        return Alamofire.SessionManager(configuration: configuration)
    }()
}

extension YSNetwork {
    
    func testGetRequest() {
        YSNetwork.shareNetwork.GET(urlString: "https://strsdev.lemonev.com:8102/strs/plutus/todoCount", parameters: nil, success: { (response) in
            print("response:\(response)")
        }, failure: {(error) in
            print("error:\(error)")
        })
    }
    
    func testPostRequest() {
        YSNetwork.shareNetwork.POST(urlString: "https://strsdev.lemonev.com:8101/strs/plutus/todoCount", parameters: ["token":"5BBFFDFBE39F3E72CEE5737429AFADB8" as AnyObject], success: { (response) in
            print("response:\(response)")
        }) { (error) in
            print("error:\(error)")
        }
    }
    
    func testUploadFile() {
        
        let path = Bundle.main.path(forResource: "image", ofType: "png");
        let url = URL(fileURLWithPath: path!)
    
        var fileData = NSData()
        do {
            fileData = try Data(contentsOf: url) as NSData
        } catch let error as Error? {
            print("error:\(String(describing: error))")
        }
        
        YSNetwork.shareNetwork.upload(urlString: "https://strsdev.lemonev.com:8101/strs/plutus/uploadImage", fileData: fileData as Data, uploadProgress: { a, b,c in
            print("uploadProgress:\(a) , \(b), \(c)")
        }, success: { (reponse) in
            print("response:\(reponse)")
        }) { (error) in
            print("error:\(error)")
        }
    }
    
    /**
     GET 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func GET(urlString: String ,parameters: [String : AnyObject]? ,success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){
        self.sharedSessionManager.request(urlString,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                success(value as AnyObject)
                            case .failure(let error):
                                failure(error as NSError)
                            }
        }
    }
    
    /**
     POST 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func POST(urlString: String ,parameters: [String : AnyObject]? ,success: @escaping NetworkSuccess, failure: @escaping NetworkFailure) {
        self.sharedSessionManager.request(urlString,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    /**
     文件上传
     
     - parameter urlString:      URL
     - parameter fileData:       要上传文件路径URL(包含文件名)
     - parameter uploadProgress: 上传进度回调(子线程)
     - parameter success:        成功回调
     - parameter failure:        失败回调
     */
    func upload(urlString: String ,fileData:Data ,uploadProgress:@escaping UploadProgress, success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){
        
        self.sharedSessionManager.upload(fileData, to: urlString, method: .post, headers: ["token":"8F51FC301B8899940EF07823031B7ED6"])
            .uploadProgress { (Progress) in
                print("上传进度：\(Progress)"); uploadProgress(Progress.fractionCompleted,Progress.completedUnitCount,Progress.totalUnitCount)
            }
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    success(value as AnyObject)
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    /**
     文件下载
     
     - parameter urlString: 下载URL
     - parameter downloadProgress: 下载进度回调(子线程)
     - parameter fileSavePathURL: 文件存储路径URL(不含文件名)
     - parameter success:   成功回调
     - parameter failure:   失败回调
     */
    func download(urlString: String ,savePathURL:NSURL ,downloadProgress: @escaping DownloadProgress, success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){}
//
//
//        self.sharedSessionManager.download(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (url, response) in
//        Alamofire.download(urlString)
//
//
//                let fileName = response.suggestedFilename//建议文件名
//                return  url.appendingPathComponent(fileName!)
//
//            }.downloadProgress { (Progress) in
//                /*
//                 bytesRead 单次下载大小
//                 totalBytesRead  已经下载大小
//                 totalBytesExpectedToRead 文件总大小
//                 */
//
//                print("下载进度：\(Progress)")
//                downloadProgress(0,0,0)
//
//            }
//            .response{ response in
//                switch response.request {
//                case .success(let value):
//                    success(value as AnyObject)
//                case .failure(let error):
//                    failure(error as NSError)
//            }
//        }
}
