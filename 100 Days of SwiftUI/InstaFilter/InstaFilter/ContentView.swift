//
//  ContentView.swift
//  InstaFilter
//
//  Created by David Williams on 9/6/24.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.0
    @State private var filterScale = 0.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    @State private var controlsDisabled = true
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") var filterCount = 0
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        ContentUnavailableView ("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                VStack{
                    HStack{
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }.disabled(controlsDisabled)
                    HStack{
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    HStack{
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyProcessing)
                    }
                }
                HStack{
                    Button("Change Filter", action: changeFilter)
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("InstaFilter Image", image: processedImage))
                    }
                }.disabled(controlsDisabled)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a Filter", isPresented: $showingFilters){
                Button("Crystallize"){setFilter(.crystallize())}
                Button("Edges"){setFilter(.edges())}
                Button("Guassian Blur"){setFilter(.gaussianBlur())}
                Button("Pixellate"){setFilter(.pixellate())}
                Button("Sepia Tone"){setFilter(.sepiaTone())}
                Button("Unsharp Mask"){setFilter(.unsharpMask())}
                Button("Vignette"){setFilter(.vignette())}
                Button("Hole Distortion"){setFilter(.holeDistortion())}
                Button("Light Tunnel"){setFilter(.lightTunnel())}
                Button("Bokeh Blur"){setFilter(.bokehBlur())}
                Button("Cancel", role: .cancel){}
            }
        }
        
    }
    func changeFilter(){
        showingFilters = true
    }
    
    func loadImage(){
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            guard let inputImage = UIImage(data:imageData) else {return}

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            controlsDisabled = false
        }
    }
    
    func applyProcessing(){
        let inputkeys = currentFilter.inputKeys
        
        if inputkeys.contains(kCIInputIntensityKey) {currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputkeys.contains(kCIInputRadiusKey) {currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)}
        if inputkeys.contains(kCIInputScaleKey) {currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)}
       
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
