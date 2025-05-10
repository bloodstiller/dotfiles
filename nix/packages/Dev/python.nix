{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [ python3 ];

  shellHook = ''
        echo "Python development environment loaded"
        echo "Python: $(python3 --version)"

        if [ ! -f server.py ]; then
          echo "Creating a basic Python HTTP server in server.py"
          cat > server.py <<'EOF'
    # Simple Python 3 HTTP server
    import http.server
    import socketserver

    PORT = 8000

    Handler = http.server.SimpleHTTPRequestHandler

    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"Serving at http://localhost:{PORT}")
        httpd.serve_forever()
    EOF
        fi

        echo ""
        echo "To start the server, run: python3 server.py"
  '';
}
