
#!/bin/bash

echo "------------------------------------------"
echo "  Docker Hub Repository Viewer (Amazon Linux)"
echo "------------------------------------------"

# Install jq if not present
if ! command -v jq &> /dev/null
then
    echo "jq not found. Installing..."
    sudo yum install -y jq
fi

# Ask for username
read -p "Enter your Docker Hub Username: " USERNAME

# Ask for token (hidden)
read -s -p "Enter your Docker Hub Access Token: " TOKEN
echo ""

echo ""
echo "Choose an option:"
echo "1) View ALL repositories (Public + Private)"
echo "2) View ONLY Private repositories"
read -p "Enter choice (1/2): " CHOICE

API_URL="https://hub.docker.com/v2/repositories/$USERNAME/?page_size=100"

echo ""
echo "Fetching repositories..."
echo ""

# Fetch data
DATA=$(curl -s -u "$USERNAME:$TOKEN" "$API_URL")

if [ "$CHOICE" == "1" ]; then
    echo "Your Repositories (All):"
    echo "--------------------------------------------"
    echo "$DATA" | jq -r '.results[].name'
elif [ "$CHOICE" == "2" ]; then
    echo "Your Private Repositories:"
    echo "--------------------------------------------"
    echo "$DATA" | jq -r '.results[] | select(.is_private == true) | .name'
else
    echo "Invalid Input!"
    exit 1
fi

echo ""
echo "Done!"
