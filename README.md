# Celestia Node Network Analysis

This repository contains a network analysis tool for monitoring and analyzing the network usage of a Celestia Node. This tool can be used with any node type, such as a validator node. By using IPFM (IP Flow Meter) and a custom script, you can track the daily network usage statistics for your Celestia Node.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Data Analysis](#data-analysis)
- [Conclusion](#conclusion)

## Requirements

- A Celestia Node (Validator or other Node)
- Linux Operating System
- IPFM

## Installation

To install IPFM on your Linux machine, follow the steps below:

1. Update your package lists:

`sudo apt-get update`


2. Install the required dependencies:

`apt-get install ipfm`

3. Change your configuration file

`vi /etc/ipfm.conf`

Make sure to know where to record your logs
`FILENAME "/var/log/ipfm/internet-%Y_%m_%d-%H_%M"`


## Usage

1. Clone this repository:


`git clone <repository-url>`


2. Change to the repository directory:

`cd celestia-node-network-analysis`


3. Execute the script with the host as a parameter:

`./network_usage_stats.sh <host>`


The script will output the daily network usage statistics for the Celestia Node.

## Data Analysis

Based on the provided data for RPC:

<pre>2023-27-04
In (MB): 3.2662
Out (MB): 5.3946
Total (MB): 8.6608

2023-28-04
In (MB): 5.90898
Out (MB): 50.2143
Total (MB): 56.1233

2023-29-04
In (MB): 0.204847
Out (MB): 2.31729
Total (MB): 2.52214
</pre>


## Conclusion

The data above indicates that there was a significant spike in network usage on 2023-28-04, with a total of 56.12 MB of data transferred. On the other days, the network usage was relatively low, ranging from 0.25 MB to 8.66 MB. This could potentially indicate an increase in network activity, such as more transactions or data-availability requests, on the day with the spike. It is important to monitor these trends and investigate any unusual spikes in network usage to ensure that the Celestia Node is functioning optimally and to identify any potential issues that may arise.
