# Copyright 2024 WSO2 LLC. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV data
data = pd.read_csv("memory_usage.csv")

# Extract Time and memory usage columns
time = data["Time"]
scenarios = ["100 Connections", "200 Connections", "800 Connections", "1000 Connections"]
memory_usages = [data[scenario] for scenario in scenarios]

# Create the line graph
plt.figure(figsize=(10, 6))  # Adjust figure size as needed

# Plot each scenario with a different color
colors = ["red", "blue", "green", "orange"]
for i in range(len(scenarios)):
    plt.plot(time, memory_usages[i], label=scenarios[i], color=colors[i])

# Set labels and title
plt.xlabel("Time")
plt.ylabel("Memory Usage (%)")
plt.title("Memory Usage for Different Scenarios")

# Add a legend
plt.legend()

# Show the plot
plt.grid(True)  # Add grid lines
plt.savefig("mem_usage.png")  # Save the plot as a PNG file
