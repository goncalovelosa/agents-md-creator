#!/bin/bash
# Gather project context for AGENTS.md generation
# Usage: gather-context.sh [--output json|text] [--save] [project-path]

set -euo pipefail

PROJECT_PATH="."
OUTPUT_FORMAT="text"
SAVE_OUTPUT=false
OUTPUT_FILE=".agents-md-context.json"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --output)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        --save)
            SAVE_OUTPUT=true
            shift
            ;;
        --project)
            PROJECT_PATH="$2"
            shift 2
            ;;
        *)
            # Assume it's the project path if no flag
            PROJECT_PATH="$1"
            shift
            ;;
    esac
done

cd "$PROJECT_PATH" 2>/dev/null || {
    echo "❌ Error: Directory not found"
    echo "   Path: $PROJECT_PATH"
   Solution: Verify path exists"
   Example: ./scripts/gather-context.sh /path/to/project"
   exit 1
}

# Initialize context object for JSON output
CONTEXT='{
  "generatedAt": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'",
  "projectPath": "'$(pwd)'",
  "structure": "",
  "packageManager": "",
  "techStack": {},
  "existingConfig": [],
  "documentation": [],
  "ciCd": {},
  "scripts": {}
}'

# Detect project structure
detect_structure() {
    if [ -f "pnpm-workspace.yaml" ] || [ -f "lerna.json" ] || [ -d "packages" ]; then
        echo "monorepo"
    elif [ -f "package.json" ]; then
        echo "node"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "Pipfile" ]; then
        echo "python"
    elif [ -f "Gemfile" ]; then
        echo "ruby"
    elif [ -f "composer.json" ]; then
        echo "php"
    elif [ -f "pom.xml" ] || [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
        echo "java"
    else
        echo "unknown"
    fi
}

STRUCTURE=$(detect_structure)
CONTEXT=$(echo "$CONTEXT" | jq --arg str "$STRUCTURE" '.structure = $str')

# Detect package manager
detect_package_manager() {
    case "$STRUCTURE" in
        monorepo|node)
            if [ -f "pnpm-lock.yaml" ]; then echo "pnpm"
            elif [ -f "yarn.lock" ]; then echo "yarn"
            elif [ -f "package-lock.json" ]; then echo "npm"
            elif [ -f "bun.lockb" ]; then echo "bun"
            else echo "npm"
            fi
            ;;
        go)
            echo "go mod"
            ;;
        rust)
            echo "cargo"
            ;;
        python)
            if [ -f "poetry.lock" ]; then echo "poetry"
            elif [ -f "Pipfile" ]; then echo "pipenv"
            elif [ -f "uv.lock" ]; then echo "uv"
            else echo "pip"
            fi
            ;;
        ruby)
            if [ -f "Gemfile.lock" ]; then echo "bundler"
            else echo "gem"
            fi
            ;;
        php)
            echo "composer"
            ;;
        java)
            if [ -f "pom.xml" ]; then echo "maven"
            elif [ -f "build.gradle.kts" ]; then echo "gradle-kotlin"
            else echo "gradle"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

PKG_MGR=$(detect_package_manager)
CONTEXT=$(echo "$CONTEXT" | jq --arg mgr "$PKG_MGR" '.packageManager = $mgr')

# Detect tech stack
detect_tech_stack() {
    local stack="{}"

    case "$STRUCTURE" in
        monorepo|node)
            if [ -f "package.json" ]; then
                # Runtime
                local runtime=$(node -e "const p=require('./package.json'); console.log(p.engines?.node || 'any')" 2>/dev/null || echo "any")
                stack=$(echo "$stack" | jq --arg rt "$runtime" '.runtime = $rt')

                # Framework detection
                local deps=$(cat package.json | jq -r '.dependencies // {} | keys[]' 2>/dev/null || echo "")
                local dev_deps=$(cat package.json | jq -r '.devDependencies // {} | keys[]' 2>/dev/null || echo "")
                local all_deps="$deps $dev_deps"

                local frameworks=()
                if echo "$all_deps" | grep -q "react"; then frameworks+=("React"); fi
                if echo "$all_deps" | grep -q "vue"; then frameworks+=("Vue"); fi
                if echo "$all_deps" | grep -q "svelte"; then frameworks+=("Svelte"); fi
                if echo "$all_deps" | grep -q "next"; then frameworks+=("Next.js"); fi
                if echo "$all_deps" | grep -q "express"; then frameworks+=("Express"); fi
                if echo "$all_deps" | grep -q "fastify"; then frameworks+=("Fastify"); fi
                if echo "$all_deps" | grep -q "nestjs"; then frameworks+=("NestJS"); fi

                if [ ${#frameworks[@]} -gt 0 ]; then
                    stack=$(echo "$stack" | jq --arg arr "$(IFS=,; echo "${frameworks[*]}")" '.frameworks = ($arr | split(","))')
                fi

                # Testing
                local testing=()
                if echo "$all_deps" | grep -q "jest"; then testing+=("Jest"); fi
                if echo "$all_deps" | grep -q "vitest"; then testing+=("Vitest"); fi
                if echo "$all_deps" | grep -q "mocha"; then testing+=("Mocha"); fi

                if [ ${#testing[@]} -gt 0 ]; then
                    stack=$(echo "$stack" | jq --arg arr "$(IFS=,; echo "${testing[*]}")" '.testing = ($arr | split(","))')
                fi

                # Linting
                local linting=()
                if echo "$all_deps" | grep -q "eslint"; then linting+=("ESLint"); fi
                if echo "$all_deps" | grep -q "prettier"; then linting+=("Prettier"); fi

                if [ ${#linting[@]} -gt 0 ]; then
                    stack=$(echo "$stack" | jq --arg arr "$(IFS=,; echo "${linting[*]}")" '.linting = ($arr | split(","))')
                fi
            fi
            ;;
        go)
            if [ -f "go.mod" ]; then
                local go_version=$(head -3 go.mod | grep go | awk '{print $2}')
                stack=$(echo "$stack" | jq --arg ver "$go_version" '.goVersion = $ver')
            fi
            ;;
        rust)
            if [ -f "Cargo.toml" ]; then
                local edition=$(grep edition Cargo.toml | head -1 | cut -d'"' -f2)
                stack=$(echo "$stack" | jq --arg ed "$edition" '.rustEdition = $ed')
            fi
            ;;
        python)
            if [ -f "pyproject.toml" ]; then
                local py_version=$(grep python pyproject.toml | head -1 | grep -oE '[0-9]+\.[0-9]+' || echo "")
                if [ -n "$py_version" ]; then
                    stack=$(echo "$stack" | jq --arg ver "$py_version" '.pythonVersion = $ver')
                fi
            fi
            ;;
        ruby)
            if [ -f ".ruby-version" ]; then
                local ruby_version=$(cat .ruby-version)
                stack=$(echo "$stack" | jq --arg ver "$ruby_version" '.rubyVersion = $ver')
            fi
            ;;
        php)
            if [ -f "composer.json" ]; then
                local php_version=$(cat composer.json | jq -r '.require.php // "any"' 2>/dev/null || echo "any")
                stack=$(echo "$stack" | jq --arg ver "$php_version" '.phpVersion = $ver')
            fi
            ;;
        java)
            if [ -f "pom.xml" ]; then
                local java_version=$(grep -oP '(?<=<java.version>)[^<]+' pom.xml | head -1 || echo "")
                if [ -n "$java_version" ]; then
                    stack=$(echo "$stack" | jq --arg ver "$java_version" '.javaVersion = $ver')
                fi
            fi
            ;;
    esac

    echo "$stack"
}

TECH_STACK=$(detect_tech_stack)
CONTEXT=$(echo "$CONTEXT" | jq --argjson stack "$TECH_STACK" '.techStack = $stack')

# Detect existing AI config files
detect_existing_config() {
    local configs=()

    for file in ".cursorrules" "CLAUDE.md" ".windsurfrules" "copilot-instructions.md" "AGENTS.md"; do
        if [ -f "$file" ]; then
            local lines=$(wc -l < "$file" | xargs)
            configs+=("$file:$lines")
        fi
    done

    if [ ${#configs[@]} -gt 0 ]; then
        printf '%s\n' "${configs[@]}" | jq -R . | jq -s .
    else
        echo "[]"
    fi
}

EXISTING_CONFIG=$(detect_existing_config)
CONTEXT=$(echo "$CONTEXT" | jq --argjson config "$EXISTING_CONFIG" '.existingConfig = $config')

# Detect documentation
detect_documentation() {
    local docs=()

    for file in "README.md" "CONTRIBUTING.md" "DEVELOPMENT.md" "docs/README.md"; do
        if [ -f "$file" ]; then
            docs+=("$file")
        fi
    done

    if [ ${#docs[@]} -gt 0 ]; then
        printf '%s\n' "${docs[@]}" | jq -R . | jq -s .
    else
        echo "[]"
    fi
}

DOCUMENTATION=$(detect_documentation)
CONTEXT=$(echo "$CONTEXT" | jq --argjson docs "$DOCUMENTATION" '.documentation = $docs')

# Detect CI/CD
detect_cicd() {
    local cicd="{}"

    if [ -d ".github/workflows" ]; then
        local workflow_count=$(ls -1 .github/workflows/*.yml 2>/dev/null | wc -l | xargs || echo 0)
        cicd=$(echo "$cicd" | jq --arg count "$workflow_count" '.githubActions = ($count | tonumber)')
    fi

    if [ -f ".gitlab-ci.yml" ]; then
        cicd=$(echo "$cicd" | jq '.gitlabCI = true')
    fi

    if [ -f "Jenkinsfile" ]; then
        cicd=$(echo "$cicd" | jq '.jenkins = true')
    fi

    if [ -f ".circleci/config.yml" ]; then
        cicd=$(echo "$cicd" | jq '.circleCI = true')
    fi

    echo "$cicd"
}

CICD=$(detect_cicd)
CONTEXT=$(echo "$CONTEXT" | jq --argjson cicd "$CICD" '.ciCd = $cicd')

# Detect scripts (for Node.js projects)
detect_scripts() {
    local scripts="{}"

    if [ -f "package.json" ] && [ "$STRUCTURE" != "monorepo" ]; then
        scripts=$(cat package.json | jq '.scripts // {}' 2>/dev/null || echo "{}")
    fi

    echo "$scripts"
}

SCRIPTS=$(detect_scripts)
CONTEXT=$(echo "$CONTEXT" | jq --argjson scripts "$SCRIPTS" '.scripts = $scripts')

# Output
if [ "$OUTPUT_FORMAT" = "json" ]; then
    echo "$CONTEXT" | jq '.'
else
    # Text output (human-readable)
    echo "# Project Context Analysis"
    echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo ""

    echo "## Project Structure"
    echo "- Type: $(echo "$STRUCTURE" | sed 's/^./\U&/')"
    echo ""

    echo "## Package Manager"
    echo "- Manager: $PKG_MGR"
    echo ""

    echo "## Tech Stack"
    echo "$TECH_STACK" | jq -r 'to_entries[] | "- \(.key): \(.value)"' 2>/dev/null || true
    echo ""

    echo "## Existing AI Config Files"
    if [ "$(echo "$EXISTING_CONFIG" | jq 'length')" -gt 0 ]; then
        echo "$EXISTING_CONFIG" | jq -r '.[]' | while read line; do
            echo "- Found: $line"
        done
    else
        echo "- No existing AI config files found"
    fi
    echo ""

    echo "## Documentation"
    if [ "$(echo "$DOCUMENTATION" | jq 'length')" -gt 0 ]; then
        echo "$DOCUMENTATION" | jq -r '.[]' | while read file; do
            echo "- Found: $file"
        done
    else
        echo "- No documentation files found"
    fi
    echo ""

    echo "## CI/CD"
    if [ "$(echo "$CICD" | jq 'keys | length')" -gt 0 ]; then
        echo "$CICD" | jq -r 'to_entries[] | "- \(.key): \(.value)"' 2>/dev/null || true
    else
        echo "- No CI/CD detected"
    fi
    echo ""

    if [ "$STRUCTURE" = "node" ] || [ "$STRUCTURE" = "monorepo" ]; then
        echo "## Available Scripts"
        if [ "$(echo "$SCRIPTS" | jq 'keys | length')" -gt 0 ]; then
            echo "$SCRIPTS" | jq -r 'to_entries[] | "- \(.key): \(.value)"' 2>/dev/null || true
        else
            echo "- No scripts defined"
        fi
        echo ""
    fi

    # Monorepo packages
    if [ "$STRUCTURE" = "monorepo" ] && [ -d "packages" ]; then
        echo "## Packages"
        for pkg in packages/*/; do
            if [ -f "$pkg/package.json" ]; then
                NAME=$(cat "$pkg/package.json" | jq -r '.name' 2>/dev/null || basename "$pkg")
                echo "- $NAME"
            fi
        done
        echo ""
    fi
fi

# Save to file if requested
if [ "$SAVE_OUTPUT" = true ]; then
    echo "$CONTEXT" | jq '.' > "$OUTPUT_FILE"
    if [ "$OUTPUT_FORMAT" = "text" ]; then
        echo "💾 Context saved to: $OUTPUT_FILE"
    fi
fi
