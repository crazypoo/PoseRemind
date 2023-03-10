//
//  PRPoseClassifier.swift
//  PoseRemind
//
//  Created by 邓杰豪 on 2022/11/8.
//  Copyright © 2022 Jax. All rights reserved.
//

import UIKit
import TensorFlowLite
import PooTools

class ClassifierModel:PTBaseModel
{
    var nameString:String = ""
    var floats:Float = 0
}

class PRPoseClassifier {
    private let poseLabels = FileInfo(name: "pose_labels", ext: "text")
    private var interpreter: Interpreter!
    private var inputTensor: Tensor!
    private var outputTensor: Tensor!


//    init(interpreter: Interpreter) {
//        self.interpreter = interpreter
//    }
    
    init() throws {
        let fileInfo = FileInfo(name: "pose_classifier", ext: "tflite")
        self.interpreter = try Interpreter.init(modelPath: Bundle.main.path(forResource: fileInfo.name, ofType: fileInfo.ext)!)
        try interpreter.allocateTensors()

        // Get allocated input and output `Tensor`s.
        inputTensor = try interpreter.input(at: 0)
        outputTensor = try interpreter.output(at: 0)
    }
    
    func classify(person:Person)->[ClassifierModel]
    {
        var inputVector = [Float]()
        person.keyPoints.enumerated().forEach { index,keyPoint in
            inputVector[index * 3] = Float(keyPoint.coordinate.x)
            inputVector[index * 3 + 1] = Float(keyPoint.coordinate.y)
            inputVector[index * 3 + 2] = keyPoint.score
        }
        
        var outputTensor = [Float]()
        return [ClassifierModel]()
    }
//
//
//    fun classify(person: Person?): List<Pair<String, Float>> {
//        // Preprocess the pose estimation result to a flat array
//        val inputVector = FloatArray(input[1])
//        person?.keyPoints?.forEachIndexed { index, keyPoint ->
//            // REVERSE X, Y !!!!!!
//            inputVector[index * 3] = keyPoint.coordinate.x
//            inputVector[index * 3 + 1] = keyPoint.coordinate.y
//            inputVector[index * 3 + 2] = keyPoint.score
//        }
//
//        // Postprocess the model output to human readable class names
//        val outputTensor = FloatArray(output[1])
//        interpreter.run(arrayOf(inputVector), arrayOf(outputTensor))
//        val output = mutableListOf<Pair<String, Float>>()
//        outputTensor.forEachIndexed { index, score ->
//            output.add(Pair(labels[index], score))
//        }
//        return output
//    }
}
