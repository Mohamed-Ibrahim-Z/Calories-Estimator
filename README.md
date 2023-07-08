# CalorieMe: Image-based Calorie Estimator System

## Abstract

In recent years, owing to the rise in healthy eating, various food photo recognition
applications for recording meals have been released. However, some of these
applications require human assistance for calorie estimation; such as manual input
or the help of a nutrition expert. Additionally, even with automated ones, food
categories are often limited, or images from multiple viewpoints are required .
Meanwhile, methodologies on image recognition have advanced greatly because of
the advent of Convolutional Neural Network (CNN). CNN has improved
accuracies of various image recognition tasks such as classification and object
detection.

## Overview

The CalorieMe is an image-based calorie estimator application innovated to help people keep track with their calorie intake by allowing users to estimate the calorie content of a meal by taking a picture of it, using an ID or credit card as a reference object. The application goes through three main phases: 
1. segmentation
1. weight estimation
1. calories calculation

The final result contains information about each ingredient, their respective calorie values, and the total calories. Additionally, including the macronutrient values for the entire meal, such as the total grams of protein, carbohydrates, and fat.

## Objectives

* The main objective of the project is to estimate meal calories, this can be achieved by:

    * Identifying meal ingredients.
    * Estimating the weight of each ingredient.
    * Calculating total meal calories based on each ingredient quantity.

* The secondary objective is to provide the user with the macronutrient values for the entire meal, such as the total grams of protein, carbohydrates, and fat.

* Finally, building an interactive user-friendly platform that encourages users to
manage their nutrition plan.

## System Architecture

![System Architecture](README%20PICS/System%20Architecture.png)

## Methodology

The CalorieMe application is divided into three main phases:

1. Segmentation
1. Weight Estimation
1. Calories Calculation

### Segmentation
#### (DeepLapV3 Plus Model + YOLO v5)

* DeepLapV3 Plus was built to Identify and segment the food.

* YOLO v5 Food Recognition Model was developed to improve classification and mask generation tasks.

![Segmentation](README%20PICS/Segmentation%20sample.jpg)

* Food Segmentation
  - DeepLapV3 Plus
    - Pixel Accuracy: 74%
    - Mean Intersection Over Union: 0.45

* Food Recognition
  - YOLOv5
    - Precision: 0.82
    - Recall: 0.793
    - MAP50: 0.869
    - MAP50-95: 0.686

![Real-Life Scenario](README%20PICS/Segmentation%20scenario.jpg)


### Weight Estimation

* Approach: The usage of a reference object by comparing reference object pixels with the ingredient.

* Contour analysis: detect edges using canny edge detection, to find four sides of the reference object.

![Contour Analysis](README%20PICS/Contour%20analysis%20sample.png)


### Calories Calculation

* Using the weight and label of each ingredient, the calories are calculated with the macro-nutrients values.

![Calories Calculation](README%20PICS/Calories%20Calculation.png)

## Results

| Food Name     | Real Calorific Value(Kcal) | Estimated Calories(Kcal) | Error | Error (%) |
|---------------|---------------------|--------------------|-------|-----------|
| French Fries         | 277                  | 316                 | 39     | 14%     |
| Rice        | 198                  | 200                | 2    | 1%    |
| Egg sunny side up        | 90                  | 158                 | 68     | 75%     |


## Installation

You can get the app from here [CalorieMe App](https://github.com/Mohamed-Ibrahim-Z/Calories-Estimator/releases/download/V1.1.0/CalorieMe.apk)

Check the repository for latest app releases and you can view the source code from here [CalorieMe Source Code](https://github.com/Mohamed-Ibrahim-Z/Calories-Estimator/archive/refs/tags/V1.1.0.zip)

You can also view a full demo of the app from here [CalorieMe Demo](README%20PICS/demo.mp4)

## Inteded Users

1. **Fitness enthusiasts**: as fitness enthusiasts’ main goal is to stay in
shape and keep track of what they eat during the day. CalorieMe will
speed up this process.

1. **People who suffer from chronic diseases**: People who suffer from
chronic diseases such as heart diseases, diabetes, .. etc must keep track
of their diet and their macro nutrient portions (fats/carbohydrates) to
ensure their safety. CalorieMe should help them to monitor their
health.

1. **Casual users**: are people who aim to keep track of their calories
intake throughout the day to keep a healthy lifestyle. Calorie me will
encourage them to do so.

## Future Work

* Model accuracy improvements by fine-tunning our Models.

* Adding more food categories to the model.

* Building a Complete Immersive system with weekly reports and goals to help the user enjoy the process.


## Time Plan

![Time Plan](README%20PICS/Time%20plan.png)

## Contributors

* [Bavlly magid](https://github.com/bavllymagid)
* [Mazen Khaled](https://github.com/3bshafy)
* [Mazen Mohamed](https://github.com/IX0XI)
* [Mohamed Ibrahim](https://github.com/Mohamed-Ibrahim-Z)
* [Muhammad Sabry](https://github.com/MuhammadS25)
* [Waleed Mohamed](https://github.com/WaleedMohamed0)

### Supervised by

* [Dr. Hanan Hindy](https://github.com/HananHindy)
* [TA. Yomna Ahmed](yomna.Ahmed@cis.asu.edu.eg)

## Contributing

Contributions to the Calories Estimator application are welcome. If you would like to contribute:
1. Fork the repository.
1. Make your changes.
1. Submit a pull request, describing the changes you have made.

### For more information, please check the [CalorieMe Documentation](https://github.com/Mohamed-Ibrahim-Z/Calories-Estimator/blob/main/Documentation%20%26%20Presentation/CalorieMe%20Final%20version%20BorderLess.pdf).

