alias gwl='git worktree list'

gw() {
# 1. Check arguments
    if [ -z "$1" ]; then
        echo "Usage: gw <branch-name> [base-branch]"
        echo "Example: gw my-feature (Creates from current branch)"
        echo "Example: gw my-feature main (Creates from main)"
        return
    fi

    local branch_name=$1
    # 2. Defaults to HEAD (current branch) if no second argument provided
    local base_branch=${2:-HEAD}    # 2. Find the absolute path of the git root

    local git_root=$(git rev-parse --show-toplevel)

    if [ -z "$git_root" ]; then
        echo "❌ Error: Not in a git repository."
        return 1
    fi

    # 3. Handle .gitignore
    # Ensure .worktrees/ is ignored to prevent accidental commits
    local gitignore_path="$git_root/.gitignore"
    local ignore_pattern=".worktrees"

    if [ -f "$gitignore_path" ]; then
        # Check if pattern already exists (ignoring comments)
        if ! grep -q "^$ignore_pattern" "$gitignore_path"; then
            echo "" >> "$gitignore_path"
            echo "# Added by gw function" >> "$gitignore_path"
            echo "$ignore_pattern/" >> "$gitignore_path"
            echo "📝 Added .worktrees/ to .gitignore"
        fi
    else
        # Create .gitignore if it doesn't exist
        echo "# Created by gw function" > "$gitignore_path"
        echo "$ignore_pattern/" >> "$gitignore_path"
        echo "📝 Created .gitignore and added .worktrees/"
    fi

    # 4. Create .worktrees directory if it doesn't exist
    local worktree_dir="$git_root/.worktrees"
    if [ ! -d "$worktree_dir" ]; then
        echo "📁 Creating .worktrees directory..."
        mkdir -p "$worktree_dir"
    fi

    # 5. Define the full path for the new worktree
    local worktree_path="$worktree_dir/$branch_name"

    # 6. Create the worktree
    echo "🌳 Creating worktree for '$branch_name' in .worktrees/..."

    git worktree add -b "$branch_name" "$worktree_path" "$base_branch"

    # 7. Check if successful, then cd
    if [ $? -eq 0 ]; then
        echo "✅ Switching to: $worktree_path"
        cd "$worktree_path"
    else
        echo "❌ Failed to create worktree."
    fi
}


gwmerge() {
    if [ -z "$1" ]; then
        echo "Usage: gwmerge <feature-branch-name> [target-branch]"
        echo "Example: gwmerge feature-login (Merges into main)"
        echo "Example: gwmerge feature-login develop (Merges into develop)"
        return
    fi

    local feature_branch=$1
    local target_branch=${2:-main}

    # 1. Ensure we are not currently inside a worktree
    # (In a worktree, .git is a file, not a directory)
    if [ -f ".git" ]; then
        echo "⚠️  You are currently inside a worktree."
        echo "🚫 Please navigate back to your main root folder to run this command."
        return 1
    fi

    local git_root=$(git rev-parse --show-toplevel)
    cd "$git_root" || return

    # 2. Checkout the target branch
    echo "🔄 Switching to '$target_branch'..."
    git checkout "$target_branch"

    # 3. Merge the feature branch
    echo "🔀 Merging '$feature_branch' into '$target_branch'..."
    git merge "$feature_branch"

    # Check if merge succeeded
    if [ $? -ne 0 ]; then
        echo "❌ Merge failed or had conflicts. Please resolve them before cleaning up."
        return 1
    fi

    echo "✅ Merge successful."

    # 4. Prompt for deletion (Zsh/Bash compatible)
    if [[ -n "$ZSH_VERSION" ]]; then
        # Zsh specific read
        read -k 1 -r "REPLY?🗑️  Delete worktree and branch '$feature_branch'? [y/N] "
        echo
    else
        # Bash specific read
        read -p "🗑️  Delete worktree and branch '$feature_branch'? [y/N] " -n 1 -r
        echo
    fi

    case "$REPLY" in
        [yY])
            local wt_path="$git_root/.worktrees/$feature_branch"

            if [ -d "$wt_path" ]; then
                echo "🧹 Removing worktree directory..."
                git worktree remove "$wt_path"
            fi

            echo "🗑️  Deleting branch..."
            git branch -d "$feature_branch"
            echo "✅ Cleanup complete."
            ;;
        *)
            echo "👋 Worktree and branch preserved."
            ;;
    esac
}
