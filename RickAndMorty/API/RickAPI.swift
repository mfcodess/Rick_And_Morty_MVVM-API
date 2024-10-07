//
//  RickAPI.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import Foundation

class RickAPI {
    private let baseURL = "https://rickandmortyapi.com/api/character/48"
    
    ///Выполнение сетевого запроса для получения данных из интернета
    ///Функция обрабатывает ответы от сервера, включая успешные данные или ошибки
    func fetchCharacters(completion: @escaping ([RickModel]?) -> Void) {
        
        ///Проверка, что строка baseURL корректна и может быть преобразована в URL. Если нет — возвращаем nil.
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        ///Задача нужна, чтобы отправить запрос на сервер и не тормозить приложение, пока идет запрос
        ///Код отвечает за получение данных от сервера
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            ///Этот код пытается преобразовать полученные данные (data) в массив объектов типа RickModel с помощью JSONDecoder
            do {
                ///Здесь мы пытаемся “распарсить” (преобразовать) данные из формата JSON в массив объектов RickModel. Если данные в неправильном формате или что-то пошло не так, произойдет ошибка.
                let result = try JSONDecoder().decode([RickModel].self, from: data)
                completion(result)
            } catch {
                completion(nil)
            }
        }
        ///Запускает сетевой запрос
        task.resume()
    }
}
