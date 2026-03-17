#!/bin/bash
# Validate AGENTS.md file structure and content
# Usage: validate-agents-md.sh [path/to/AGENTS.md]

set -euo pipefail

AGENTS_FILE="${1:-AGENTS.md}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Check file exists
if [ ! -f "$AGENTS_FILE" ]; then
    echo -e "${RED}❌ Error: File not found${NC}"
    echo "   File: $AGENTS_FILE"
    echo "   Solution: Create AGENTS.md first using a template:"
    echo "     cp templates/standard.md AGENTS.md"
    exit 1
fi

echo "Validating $AGENTS_FILE..."
echo ""

# Word count validation (335-535 optimal per research)
WORDS=$(wc -w < "$AGENTS_FILE" | tr -d ' ')
LINES=$(wc -l < "$AGENTS_FILE" | tr -d ' ')

echo "📏 Length Check:"
if [ "$WORDS" -gt 800 ]; then
    echo -e "   ${RED}❌ ERROR: Too long${NC}"
    echo "      Current: $WORDS words, $LINES lines"
    echo "      Target: 335-535 words (max 800)"
    echo "      Solution: Move detailed documentation to references/"
    echo "                Example: Move API details → references/api-guide.md"
    ERRORS=$((ERRORS + 1))
elif [ "$WORDS" -gt 600 ]; then
    echo -e "   ${YELLOW}⚠️  WARNING: Long${NC}"
    echo "      Current: $WORDS words, $LINES lines"
    echo "      Target: 335-535 words"
    echo "      Suggestion: Consider shortening or using references/"
    WARNINGS=$((WARNINGS + 1))
elif [ "$WORDS" -lt 100 ]; then
    echo -e "   ${YELLOW}⚠️  WARNING: Very short${NC}"
    echo "      Current: $WORDS words"
    echo "      Minimum: 100 words for basic context"
    echo "      Suggestion: Add build commands and testing instructions"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "   ${GREEN}✅ Good length${NC}: $WORDS words, $LINES lines"
fi

# Required sections
echo ""
echo "📋 Section Check:"
REQUIRED_SECTIONS=("Dev Setup" "Build" "Test" "Code Style")
for section in "${REQUIRED_SECTIONS[@]}"; do
    if grep -qi "## .*$section" "$AGENTS_FILE"; then
        echo -e "   ${GREEN}✅ $section${NC}"
    else
        echo -e "   ${RED}❌ Missing: $section${NC}"
        case "$section" in
            "Dev Setup")
                echo "      Add: ## Dev Setup"
                echo "           - Install: npm install"
                echo "           - Dev: npm run dev" ;;
            "Build")
                echo "      Add: ## Build & Test"
                echo "           - Build: npm run build"
                echo "           - Test: npm test" ;;
            "Test")
                echo "      Add: ## Testing"
                echo "           - Run: npm test"
                echo "           - Coverage: npm run test:coverage" ;;
            "Code Style")
                echo "      Add: ## Code Style"
                echo "           - Linter: eslint"
                echo "           - Formatter: prettier" ;;
        esac
        ERRORS=$((ERRORS + 1))
    fi
done

# Check for common issues
echo ""
echo "🔍 Quality Check:"

# Check for AI vocabulary
AI_WORDS=("delve" "tapestry" "crucial" "vibrant" "pivotal" "underscore" "intricate" "testament")
FOUND_AI=()
for word in "${AI_WORDS[@]}"; do
    if grep -qi "\b$word\b" "$AGENTS_FILE"; then
        FOUND_AI+=("$word")
    fi
done

if [ ${#FOUND_AI[@]} -gt 0 ]; then
    echo -e "   ${YELLOW}⚠️  AI vocabulary detected${NC}"
    echo "      Found: ${FOUND_AI[*]}"
    echo "      These words trigger AI detectors."
    echo "      Replacements:"
    echo "        delve → explore"
    echo "        crucial → important"
    echo "        vibrant → active"
    echo "        pivotal → key"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "   ${GREEN}✅ No AI vocabulary${NC}"
fi

# Check for tool-specific syntax
if grep -q "@" "$AGENTS_FILE" | grep -v "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"; then
    if grep -q "@path\|@import\|@include" "$AGENTS_FILE"; then
        echo -e "   ${RED}❌ Tool-specific syntax detected${NC}"
        echo "      Found: @path, @import, or @include"
        echo "      These only work in specific tools."
        echo "      Solution: Use standard Markdown links instead"
        ERRORS=$((ERRORS + 1))
    else
        echo -e "   ${GREEN}✅ Standard Markdown${NC}"
    fi
else
    echo -e "   ${GREEN}✅ Standard Markdown${NC}"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Validation Summary:"
echo "   Word count: $WORDS (optimal: 335-535)"
echo "   Errors: $ERRORS"
echo "   Warnings: $WARNINGS"
echo ""

if [ "$ERRORS" -gt 0 ]; then
    echo -e "${RED}❌ VALIDATION FAILED${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Fix the errors listed above"
    echo "  2. Re-run: ./scripts/validate-agents-md.sh $AGENTS_FILE"
    echo "  3. Only proceed when validation passes"
    exit 1
elif [ "$WARNINGS" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  VALIDATION PASSED WITH WARNINGS${NC}"
    echo ""
    echo "Consider addressing warnings for best results."
    exit 0
else
    echo -e "${GREEN}✅ VALIDATION PASSED${NC}"
    echo ""
    echo "Your AGENTS.md is ready for use with AI coding agents."
    exit 0
fi
