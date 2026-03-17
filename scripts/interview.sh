#!/bin/bash
# Interactive interview for AGENTS.md generation
# Usage: interview.sh [--non-interactive] [--output path]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_FILE=".agents-md-context.json"
NON_INTERACTIVE=false
PROJECT_PATH="${PROJECT_PATH:-.}"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --non-interactive)
            NON_INTERACTIVE=true
            shift
            ;;
        --output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --project)
            PROJECT_PATH="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

cd "$PROJECT_PATH"

# Colors for interactive mode
if [ "$NON_INTERACTIVE" = false ] && [ -t 0 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

echo -e "${BLUE}=== AGENTS.md Interview ===${NC}"
echo ""

# Initialize context object
CONTEXT='{
  "projectName": "",
  "primaryTasks": [],
  "codeStyle": {},
  "testing": {},
  "safety": {},
  "dos": [],
  "donts": [],
  "customSections": {}
}'

# Helper function to prompt for input
prompt() {
    local question="$1"
    local default="${2:-}"
    local var_name="$3"
    
    if [ "$NON_INTERACTIVE" = true ]; then
        # Use default in non-interactive mode
        eval "$var_name='$default'"
        return
    fi
    
    if [ -n "$default" ]; then
        echo -e "${YELLOW}$question${NC} [$default]: "
    else
        echo -e "${YELLOW}$question${NC}: "
    fi
    
    read -r response
    
    if [ -z "$response" ] && [ -n "$default" ]; then
        response="$default"
    fi
    
    eval "$var_name='$response'"
}

# Helper for multi-line input
prompt_multiline() {
    local question="$1"
    local var_name="$2"
    
    if [ "$NON_INTERACTIVE" = true ]; then
        eval "$var_name=''"
        return
    fi
    
    echo -e "${YELLOW}$question${NC} (enter blank line to finish):"
    local lines=()
    while IFS= read -r line; do
        [ -z "$line" ] && break
        lines+=("$line")
    done
    
    # Join with newlines
    local result
    result=$(IFS=$'\n'; echo "${lines[*]}")
    eval "$var_name='$result'"
}

# Helper for yes/no questions
prompt_yesno() {
    local question="$1"
    local default="${2:-n}"
    local var_name="$3"
    
    if [ "$NON_INTERACTIVE" = true ]; then
        eval "$var_name='$default'"
        return
    fi
    
    local yn_default
    if [ "$default" = "y" ]; then
        yn_default="[Y/n]"
    else
        yn_default="[y/N]"
    fi
    
    echo -e "${YELLOW}$question${NC} $yn_default: "
    read -r response
    
    response=${response:-$default}
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        eval "$var_name='yes'"
    else
        eval "$var_name='no'"
    fi
}

# Detect project name
if [ -f "package.json" ]; then
    DEFAULT_NAME=$(cat package.json | jq -r '.name' 2>/dev/null || basename "$(pwd)")
elif [ -f "go.mod" ]; then
    DEFAULT_NAME=$(head -1 go.mod | awk '{print $2}' | cut -d'/' -f3)
elif [ -f "Cargo.toml" ]; then
    DEFAULT_NAME=$(grep '^name' Cargo.toml | head -1 | cut -d'"' -f2)
else
    DEFAULT_NAME=$(basename "$(pwd)")
fi

# 1. Project Name
echo -e "${GREEN}## Project Information${NC}"
prompt "Project name" "$DEFAULT_NAME" PROJECT_NAME

# 2. Primary Tasks
echo ""
echo -e "${GREEN}## Primary Tasks${NC}"
echo "What should the agent focus on? (comma-separated)"
echo "Examples: feature development, bug fixes, refactoring, documentation, testing"
prompt "Primary tasks" "feature development, bug fixes" PRIMARY_TASKS

# Convert to array
IFS=',' read -ra TASK_ARRAY <<< "$PRIMARY_TASKS"
TASKS_JSON=$(printf '%s\n' "${TASK_ARRAY[@]}" | jq -R . | jq -s .)

# 3. Code Style
echo ""
echo -e "${GREEN}## Code Style Preferences${NC}"

prompt "Indentation (spaces/tabs)" "spaces" INDENTATION
prompt "Indentation size" "2" INDENT_SIZE
prompt_yesno "Use semicolons?" "y" USE_SEMICOLONS
prompt_yesno "Use trailing commas?" "y" TRAILING_COMMAS
prompt "Quote style (single/double)" "single" QUOTE_STYLE
prompt "Max line length" "100" MAX_LINE_LENGTH

CODE_STYLE=$(cat <<EOF
{
  "indentation": "$INDENTATION",
  "indentSize": $INDENT_SIZE,
  "semicolons": "$USE_SEMICOLONS",
  "trailingCommas": "$TRAILING_COMMAS",
  "quoteStyle": "$QUOTE_STYLE",
  "maxLineLength": $MAX_LINE_LENGTH
}
EOF
)

# 4. Testing
echo ""
echo -e "${GREEN}## Testing Preferences${NC}"

prompt "Testing framework" "vitest" TEST_FRAMEWORK
prompt "Test file pattern" "**/*.test.{ts,tsx}" TEST_PATTERN
prompt "Coverage threshold (%)" "80" COVERAGE_THRESHOLD
prompt_yesno "Run tests before commits?" "y" TEST_BEFORE_COMMIT

TESTING=$(cat <<EOF
{
  "framework": "$TEST_FRAMEWORK",
  "pattern": "$TEST_PATTERN",
  "coverageThreshold": $COVERAGE_THRESHOLD,
  "runBeforeCommit": "$TEST_BEFORE_COMMIT"
}
EOF
)

# 5. Safety
echo ""
echo -e "${GREEN}## Safety Rules${NC}"

prompt_yesno "Require tests for new features?" "y" REQUIRE_TESTS
prompt_yesno "Block force pushes?" "y" BLOCK_FORCE_PUSH
prompt_yesno "Require PR reviews?" "y" REQUIRE_REVIEWS
prompt "Protected branches (comma-separated)" "main,master" PROTECTED_BRANCHES

# Convert to array
IFS=',' read -ra BRANCH_ARRAY <<< "$PROTECTED_BRANCHES"
BRANCHES_JSON=$(printf '%s\n' "${BRANCH_ARRAY[@]}" | jq -R . | jq -s .)

SAFETY=$(cat <<EOF
{
  "requireTests": "$REQUIRE_TESTS",
  "blockForcePush": "$BLOCK_FORCE_PUSH",
  "requireReviews": "$REQUIRE_REVIEWS",
  "protectedBranches": $BRANCHES_JSON
}
EOF
)

# 6. Dos and Don'ts
echo ""
echo -e "${GREEN}## Best Practices${NC}"

echo "What SHOULD the agent always do?"
prompt_multiline "List one practice per line" DOS

echo ""
echo "What should the agent NEVER do?"
prompt_multiline "List one restriction per line" DONTS

# Convert to JSON arrays
if [ -n "$DOS" ]; then
    DOS_JSON=$(echo "$DOS" | jq -R . | jq -s .)
else
    DOS_JSON="[]"
fi

if [ -n "$DONTS" ]; then
    DONTS_JSON=$(echo "$DONTS" | jq -R . | jq -s .)
else
    DONTS_JSON="[]"
fi

# 7. Custom Sections
echo ""
echo -e "${GREEN}## Custom Sections${NC}"
prompt_yesno "Add custom sections?" "n" ADD_CUSTOM

CUSTOM_SECTIONS="{}"

if [ "$ADD_CUSTOM" = "yes" ]; then
    while true; do
        echo ""
        prompt "Section name (or leave blank to finish)" "" SECTION_NAME
        
        if [ -z "$SECTION_NAME" ]; then
            break
        fi
        
        prompt_multiline "Section content (one item per line)" SECTION_CONTENT
        
        if [ -n "$SECTION_CONTENT" ]; then
            SECTION_CONTENT_JSON=$(echo "$SECTION_CONTENT" | jq -R . | jq -s .)
            CUSTOM_SECTIONS=$(echo "$CUSTOM_SECTIONS" | jq --arg name "$SECTION_NAME" --argjson content "$SECTION_CONTENT_JSON" '. + {($name): $content}')
        fi
    done
fi

# Build final context object
CONTEXT=$(cat <<EOF
{
  "projectName": "$PROJECT_NAME",
  "primaryTasks": $TASKS_JSON,
  "codeStyle": $CODE_STYLE,
  "testing": $TESTING,
  "safety": $SAFETY,
  "dos": $DOS_JSON,
  "donts": $DONTS_JSON,
  "customSections": $CUSTOM_SECTIONS,
  "generatedAt": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
)

# Write to file
echo "$CONTEXT" | jq '.' > "$OUTPUT_FILE"

echo ""
echo -e "${GREEN}✅ Interview complete!${NC}"
echo "Context saved to: $OUTPUT_FILE"
echo ""
echo "Next steps:"
echo "  1. Review the generated context: cat $OUTPUT_FILE"
echo "  2. Generate AGENTS.md: Use the skill with this context"
echo ""

# Output context for programmatic use
if [ "$NON_INTERACTIVE" = false ]; then
    echo "$CONTEXT"
fi
