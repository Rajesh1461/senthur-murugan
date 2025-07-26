#!/bin/bash

echo "🤖 Setting up JARVIS AI Assistant..."
echo "================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is not installed. Please install Python 3.7+ first.${NC}"
    exit 1
fi

echo -e "${BLUE}Python version:${NC}"
python3 --version

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}pip3 is not installed. Please install pip3 first.${NC}"
    exit 1
fi

# Create virtual environment
echo -e "${YELLOW}Creating virtual environment...${NC}"
python3 -m venv jarvis_env

# Activate virtual environment
echo -e "${YELLOW}Activating virtual environment...${NC}"
source jarvis_env/bin/activate

# Upgrade pip
echo -e "${YELLOW}Upgrading pip...${NC}"
pip install --upgrade pip

# Install system dependencies for audio
echo -e "${YELLOW}Installing system dependencies...${NC}"
if command -v apt-get &> /dev/null; then
    echo "Detected Ubuntu/Debian system"
    sudo apt-get update
    sudo apt-get install -y portaudio19-dev python3-pyaudio alsa-utils pulseaudio
elif command -v yum &> /dev/null; then
    echo "Detected RedHat/CentOS system"
    sudo yum install -y portaudio-devel alsa-lib-devel
elif command -v brew &> /dev/null; then
    echo "Detected macOS system"
    brew install portaudio
else
    echo -e "${YELLOW}Unknown system. You may need to install portaudio manually.${NC}"
fi

# Install Python dependencies
echo -e "${YELLOW}Installing Python dependencies...${NC}"
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file...${NC}"
    cp .env.example .env
    echo -e "${BLUE}Please edit .env file and add your API keys if you want advanced features.${NC}"
fi

# Make scripts executable
chmod +x jarvis.py
chmod +x web_jarvis.py

echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${BLUE}🚀 How to run JARVIS:${NC}"
echo ""
echo -e "${YELLOW}1. Command Line Version:${NC}"
echo "   source jarvis_env/bin/activate"
echo "   python3 jarvis.py"
echo ""
echo -e "${YELLOW}2. Web Interface Version:${NC}"
echo "   source jarvis_env/bin/activate"
echo "   python3 web_jarvis.py"
echo "   Then open http://localhost:5000 in your browser"
echo ""
echo -e "${BLUE}📝 Features:${NC}"
echo "   ✓ Voice Recognition"
echo "   ✓ Text-to-Speech"
echo "   ✓ System Monitoring"
echo "   ✓ Wikipedia Search"
echo "   ✓ Time/Date Commands"
echo "   ✓ Calculator"
echo "   ✓ Web Interface"
echo "   ✓ Iron Man Style UI"
echo ""
echo -e "${YELLOW}🔧 Optional:${NC}"
echo "   - Add OpenAI API key to .env for advanced AI features"
echo "   - Add Weather API key for weather information"
echo "   - Add News API key for news updates"
echo ""
echo -e "${GREEN}Enjoy your JARVIS AI Assistant! 🤖${NC}"