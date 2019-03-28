import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/konstantin/iOS/CreateML/twitter-sanders-apple3.csv"))

let(traningData, testingData) = data.randomSplit(by: 0.8, seed: 5) //80% training data, 20% testing data

let sentimentClassifier = try MLTextClassifier(trainingData: traningData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Konstantin Grahovsky", shortDescription: "A model trained to classify sentiment on", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/konstantin/iOS/CreateML/TweetSentimentClassifier.mlmodel"))

try sentimentClassifier.prediction(from: "@Apple is a terrible company")
try sentimentClassifier.prediction(from: "I just found the best restaurant ever, and it's @MacDonalds")
try sentimentClassifier.prediction(from: "I think @1C ads are jusk ok.")
