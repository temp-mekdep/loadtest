#!/bin/bash

# Default values
url=""
method="GET"
data=""
token=""

# Function to display usage
usage() {
    echo "Usage: $0 -u <url> -m <method> -t <token> [-d <data>]"
    echo "  -u   URL to be tested with k6"
    echo "  -m   HTTP method (GET or POST)"
    echo "  -d   Request body (only required for POST method)"
    echo "  -t   Authentication token"
    exit 1
}

# Parse the command-line arguments
while getopts "u:m:d:t:" opt; do
    case $opt in
        u) 
            url=$OPTARG
            ;;
        m)
            method=$OPTARG
            ;;
        d)
            data=$OPTARG
            ;;
        t)
            token=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

# Validate required arguments
if [ -z "$url" ] || [ -z "$token" ]; then
    echo "Error: URL and token are required."
    usage
fi

# Validate method
if [[ "$method" != "GET" && "$method" != "POST" ]]; then
    echo "Error: Invalid method. Supported methods are GET and POST."
    usage
fi

# Construct the k6 script
echo "Running k6 test with:"
echo "URL: $url"
echo "Method: $method"
echo "Token: $token"

# Run the k6 script based on the method
if [ "$method" == "GET" ]; then
    k6 run -e URL="$url" -e METHOD="$method" -e TOKEN="$token" k6script.js
elif [ "$method" == "POST" ]; then
    if [ -z "$data" ]; then
        echo "Error: Request body (-d) is required for POST method."
        usage
    fi
    k6 run -e URL="$url" -e METHOD="$method" -e DATA="$data" -e TOKEN="$token" k6script.js
fi
