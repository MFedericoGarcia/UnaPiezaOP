//
//  ImageCache.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
    
    func insert(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    private var task: URLSessionDataTask?
    
    func load(from url: URL) {
        self.isLoading = true
        if let cached = ImageCache.shared.image(for: url) {
            self.image = cached
            self.isLoading = false
            return
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.error = error
                    return
                }
                guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                    self.error = URLError(.badServerResponse)
                    return
                }
                guard let data = data, let uiImage = UIImage(data: data) else {
                    self.error = URLError(.cannotDecodeContentData)
                    return
                }
                ImageCache.shared.insert(uiImage, for: url)
                self.image = uiImage
            }
        }.resume()
    }
    
    func cancel() {
        task?.cancel()
        isLoading = false
    }
}


struct CachedAsyncImage: View {
    let url: URL
    var placeholderSize: CGSize = CGSize(width: 100, height: 100)
    @StateObject private var loader = ImageLoader()

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.isLoading {
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else {
                // Initial state before load starts
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            }
        }
        .onAppear { loader.load(from: url) }
    }
}


struct CachedAsyncImage2: View {
    let url: URL
    var placeholderSize: CGSize = CGSize(width: 250, height: 250)
    @StateObject private var loader = ImageLoader()

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.isLoading {
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else {
                // Initial state before load starts
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            }
        }
        .onAppear { loader.load(from: url) }
    }
}

struct CachedAsyncImage3: View {
    let url: URL
    var placeholderSize: CGSize = CGSize(width: 300, height: 500)
    @StateObject private var loader = ImageLoader()

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.isLoading {
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else if loader.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            } else {
                // Initial state before load starts
                ProgressView()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            }
        }
        .onAppear { loader.load(from: url) }
    }
}

