//
//  ImageCache.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import SwiftUI
internal import Combine

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
    private var task: URLSessionDataTask?
    
    func load(from url: URL) {
        if let cached = ImageCache.shared.image(for: url) {
            self.image = cached
            return
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, let uiImage = UIImage(data: data) else { return }
            ImageCache.shared.insert(uiImage, for: url)
            DispatchQueue.main.async {
                self.image = uiImage
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}


struct CachedAsyncImage: View {
    let url: URL
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage).resizable().scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear { loader.load(from: url) }
        .onDisappear { /* opcional: no canceles si querés mantener la descarga en curso */ }
    }
}
