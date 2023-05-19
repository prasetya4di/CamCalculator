//
//  PublisherExtension.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Foundation
import Combine

func createPublisher<T>(execute: @escaping () -> T) -> AnyPublisher<T, Never> {
    Deferred {
        Just(execute())
    }
    .eraseToAnyPublisher()
}

func createPublisher<T>(execute: @escaping () throws -> T) -> AnyPublisher<T, Error> {
    Deferred {
        Future { promise in
            do {
                let result = try execute()
                promise(.success(result))
            } catch {
                promise(.failure(error))
            }
        }
    }
    .eraseToAnyPublisher()
}

func createPublisher<T>(execute: @escaping () async throws -> T) -> AnyPublisher<T, Error> {
    Deferred {
        Future { promise in
            Task {
                do {
                    let result = try await execute()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    .eraseToAnyPublisher()
}

extension Publisher {
    func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<
        Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
            flatMap { value in
                Future { promise in
                    Task {
                        do {
                            let output = try await transform(value)
                            promise(.success(output))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
            }
        }
}
