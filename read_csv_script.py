import pandas as pd

def read_csv(file_path):
    try:
        # Read file CSV into DataFrame
        df = pd.read_csv(file_path)

        # Print DataFrame
        print("CSV Content:")
        print(df)

        # Return DataFrame 
        return df
    except Exception as e:
        print(f"Error: {e}")
        return None

# read file car_data.csv
file = r"C:\Users\nghie\OneDrive\Desktop\Projet_Beev\car_data.csv"
car_data = read_csv(file)
# read file consumer_data.csv
file2 = r"C:\Users\nghie\OneDrive\Desktop\Projet_Beev\consumer_data.csv"
consumer_data = read_csv(file2)

# merge two tables together according to common characteristics
merged_df = pd.merge(car_data, consumer_data, on=['Make', 'Model', 'Year'], how='inner')
merged_df
# convert to file csv
merged_df.to_csv('merged_file.csv', index=False)
merged_df

# read file merge_file.csv
file3 = r"C:\Users\nghie\OneDrive\Desktop\Projet_Beev\merged_file.csv"
merged_df = read_csv(file3)

# return a graph that would show the amount of electric vs thermal cars sold per year.
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline
sns.barplot(data=merged_df, x='Year', y='Sales Volume', hue='Engine Type')