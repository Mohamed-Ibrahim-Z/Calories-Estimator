import pandas as pd
import re
from fuzzywuzzy import process

# Importing csv file
data = pd.read_csv('Food and Calories - Sheet1.csv')

# Matching label to closest match
label = input('Enter the food name: ').capitalize()
label = process.extractOne(label, data['Food'])[0]

# Retriving data from csv
weight = float(input('Enter the weight of the food: '))

calories = data.loc[data['Food'] == label, 'Calories'].values[0]
calories = int((int, re.findall(r'\d+', calories))[1][0])

serving = data.loc[data['Food'] == label, 'Serving'].values[0]
serving = int((int, re.findall(r'\d+', serving))[1][1])

# Estimation Equation
estimated_calories = calories * weight / serving
print(f'Estimated calories: {estimated_calories}')

# print estimated_calories with 2 decimal places
print(f'Estimated calories: {estimated_calories:.2f}')
