//
//  MessageService.swift
//  Message
//
//  Created by Марк Коваль on 07/09/2022.
//

import UIKit

final class MessageService {
    
    func addMessage(offset: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        
        guard let urlMessage = URL(string: "https://numia.ru/api/getMessages?offset=\(offset)") else { return }
        
        let messageTask = URLSession.shared.dataTask(with: urlMessage) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(MessageModel.self, from: data)
                    completion(.success(result.result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        messageTask.resume()
    }
}
