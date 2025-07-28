{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [ nodejs_20 ];

  shellHook = ''
        echo "Node.js development environment loaded"
        echo "Node: $(node --version)"
        echo "npm: $(npm --version)"

        if [ ! -f index.js ]; then
          echo "Creating a basic Node.js server in index.js"
          cat > index.js <<'EOF'
    // Simple Node.js HTTP server
    const http = require('http');

    const port = 3000;

    const server = http.createServer((req, res) => {
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/html');
      res.end('<h1>Hello from Nix Shell!</h1><p>Your Node.js server is running.</p>');
    });

    server.listen(port, () => {
      console.log(`Server running at http://localhost:3000/`);
    });
    EOF
        fi

        echo ""
        echo "To start the server, run: node index.js"
  '';
}
