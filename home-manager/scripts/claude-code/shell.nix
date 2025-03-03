{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Required
    nodejs_18
    # Optional tools
    git
    gh # GitHub CLI
    ripgrep # Fast file search
  ];
  shellHook = ''
    # Create a local npm directory for global installs
    mkdir -p ./.npm-global
    export NPM_CONFIG_PREFIX=$PWD/.npm-global
    export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

    echo "Development environment loaded:"
    echo "- Node.js $(node --version)"
    echo "- Git $(git --version)"
    echo "- GitHub CLI $(gh --version | head -n1)"
    echo "- ripgrep $(rg --version | head -n1)"
    echo "- npm global prefix set to: $NPM_CONFIG_PREFIX"

    # Instructions for the user
    echo ""
    echo "To install Claude Code, run:"
    echo "npm install -g @anthropic-ai/claude-code"
    echo ""
  '';
}
