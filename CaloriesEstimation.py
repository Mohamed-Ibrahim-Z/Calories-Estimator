import pandas as pd
import re
from fuzzywuzzy import process
import Test
import json


def getCalories(labels):
    # Importing csv file
    data = pd.read_csv('Food and Calories - Sheet1.csv')

    # load string from text file
    with open('category.txt', 'r') as f:
        categories = f.read()

    # split string into list with newline as separator
    categories = categories.splitlines()

    # Lower each category in list
    categories = [category.lower() for category in categories]

    desiredCategories = data['Food'].tolist()

    # lower each category in desiredCategories
    #desiredCategories = [category.lower() for category in desiredCategories]

    commonCategories = []
    missing_categories = []
    # for every missing category in missing categories extractOne from data['food'] if score is greater than 90 add to common categories
    for category in categories:
        if process.extractOne(category, desiredCategories)[1] >= 75:
            # append matched from desiredCategories to commonCategories
            commonCategories.append(process.extractOne(category, desiredCategories)[0])
        else:
            # append category to missing categories
            missing_categories.append(category)


    keys_to_save = {}

    for label in labels.keys():
        if process.extractOne(label, commonCategories)[1] >= 90 and label not in commonCategories:
            print(label, 'not found')
        else:
            keys_to_save[process.extractOne(label, commonCategories)[0]] = labels[label]


        
    # print labels
    print(keys_to_save)

    cal_map = {}
    total_calories = 0
    for label in keys_to_save.keys():
        calories_series = data.loc[data['Food'] == label, 'Calories']
        if calories_series.empty:
            # handle the case when no matching row is found
            continue

        calories = int((int, re.findall(r'\d+', calories_series.values[0]))[1][0])

        serving_series = data.loc[data['Food'] == label, 'Serving']
        if serving_series.empty:
            continue

        serving = int((int, re.findall(r'\d+', serving_series.values[0]))[1][1])

    # Estimation Equation
        estimated_calories = calories * keys_to_save[label] / serving
        total_calories += estimated_calories
        cal_map[label] = estimated_calories


    # print estimated_calories with 1 decimal places
    print(f'Estimated calories: {total_calories:.1f}')

    json = {}
    for key, value in cal_map.items():
        json[key] = value

    return json
