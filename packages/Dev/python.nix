{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
  ];

  shellHook = ''
        echo "Python development environment loaded"
        echo "Python: $(python3 --version)"
        echo "pip: $(pip --version)"

        if [ ! -f app.py ]; then
          echo "Creating a basic Python web application in app.py"
          cat > app.py <<'EOF'
    # Simple Python 3 HTTP server with routing
    from http.server import HTTPServer, BaseHTTPRequestHandler
    import json
    from urllib.parse import urlparse, parse_qs

    class SimpleHandler(BaseHTTPRequestHandler):
        def do_GET(self):
            parsed_path = urlparse(self.path)
            
            if parsed_path.path == '/':
                self.send_response(200)
                self.send_header('Content-Type', 'text/html')
                self.end_headers()
                self.wfile.write("""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Python Nix Shell Server</title>
        <style>
            body { font-family: Arial, sans-serif; margin; 40px }
            .container { max-width: 600px; margin: 0 auto; }
            .endpoint { background: #f5f5f5; padding: 10px; margin: 10px 0; border-radius: 5px; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🐍 Python Development Server</h1>
            <p>Your Python server is running successfully!</p>
            
            <h2>Available Endpoints:</h2>
            <div class="endpoint"><strong>GET /</strong> - This page</div>
            <div class="endpoint"><strong>GET /api/hello</strong> - JSON API endpoint</div>
            <div class="endpoint"><strong>GET /health</strong> - Health check</div>
        </div>
    </body>
    </html>
               """ .encode('utf-8'))
            elif parsed_path.path == '/api/hello':
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                response = {
                    'message': 'Hello from Python!',
                    'status': 'success',
                    'server': 'Python HTTP Server'
                }
                self.wfile.write(json.dumps(response, indent=2).encode())
            elif parsed_path.path == '/health':
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                response = {'status': 'healthy', 'service': 'python-dev-server'}
                self.wfile.write(json.dumps(response).encode())
            else:
                self.send_response(404)
                self.send_header('Content-Type', 'text/html')
                self.end_headers()
                self.wfile.write(b'<h1>404 - Page Not Found</h1>')

        def log_message(self, format, *args):
            print(f"[{self.date_time_string()}] {format % args}")

    if __name__ == '__main__':
        PORT = 8000
        server = HTTPServer(('localhost', PORT), SimpleHandler)
        print(f"🚀 Server starting at http://localhost:{PORT}")
        print(f"📖 Visit http://localhost:{PORT} to see your application")
        print(f"🔍 API endpoint: http://localhost:{PORT}/api/hello")
        print(f"❤️  Health check: http://localhost:{PORT}/health")
        print("Press Ctrl+C to stop the server")
        
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped")
            server.shutdown()
    EOF
        fi

        if [ ! -f requirements.txt ]; then
          echo "Creating requirements.txt file"
          cat > requirements.txt <<'EOF'
    # Add your Python dependencies here
    # Example:
    # requests==2.31.0
    # flask==2.3.3
    # fastapi==0.104.1
    EOF
        fi

        if [ ! -f .gitignore ]; then
          echo "Creating .gitignore file"
          cat > .gitignore <<'EOF'
    # Python
    __pycache__/
    *.py[cod]
    *$py.class
    *.so
    .Python
    build/
    develop-eggs/
    dist/
    downloads/
    eggs/
    .eggs/
    lib/
    lib64/
    parts/
    sdist/
    var/
    wheels/
    *.egg-info/
    .installed.cfg
    *.egg

    # Virtual environments
    venv/
    env/
    ENV/

    # IDE
    .vscode/
    .idea/
    *.swp
    *.swo

    # OS
    .DS_Store
    Thumbs.db
    EOF
        fi

        echo ""
        echo "🐍 Python Development Environment Ready!"
        echo "📁 Files created:"
        echo "   • app.py - Sample web application with routing"
        echo "   • requirements.txt - Dependencies file"
        echo "   • .gitignore - Git ignore patterns"
        echo ""
        echo "🚀 Quick start:"
        echo "   python3 app.py              # Start the development server"
        echo "   pip install -r requirements.txt  # Install dependencies"
        echo "   python3 -m venv venv        # Create virtual environment"
        echo "   source venv/bin/activate    # Activate virtual environment"
        echo ""
        echo "🌐 Server will run at: http://localhost:8000"
  '';
}
