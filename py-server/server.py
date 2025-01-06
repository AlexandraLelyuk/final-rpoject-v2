from flask import Flask, render_template_string

app = Flask(__name__)

VERSION = "1.0.2"
MESSAGE = "Welcome to the main page!"

@app.route('/')
def home():
    html = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Main Page</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                text-align: center;
                background-color: #f9f9f9;
                color: #555;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #ff69b4;
                margin-top: 50px;
            }
            .message {
                font-size: 18px;
                margin-bottom: 20px;
                color: #888;
            }
            .buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 30px;
            }
            .button {
                text-decoration: none;
                padding: 12px 24px;
                background-color: #ff69b4;
                color: white;
                font-weight: bold;
                border-radius: 8px;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .button:hover {
                background-color: #ff85c9;
            }
            footer {
                margin-top: 50px;
                font-size: 14px;
                color: #aaa;
            }
        </style>
    </head>
    <body>
        <h1>Welcome!</h1>
        <p class="message">{{ message }}</p>
        <p>Version: {{ version }}</p>
        <div class="buttons">
            <a href="/page1" class="button">Go to Page 1</a>
            <a href="/page2" class="button">Go to Page 2</a>
        </div>
        <footer>© 2025 Sandra's Project</footer>
    </body>
    </html>
    """
    return render_template_string(html, message=MESSAGE, version=VERSION)

@app.route('/page1')
def page1():
    html = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page 1</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                text-align: center;
                background-color: #fce4ec;
                color: #444;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #e91e63;
                margin-top: 50px;
            }
            a {
                color: #e91e63;
                text-decoration: none;
                font-weight: bold;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <h1>Welcome to Page 1!</h1>
        <p><a href="/">Back to Home</a></p>
    </body>
    </html>
    """
    return html

@app.route('/page2')
def page2():
    html = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page 2</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                text-align: center;
                background-color: #e3f2fd;
                color: #444;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #1976d2;
                margin-top: 50px;
            }
            a {
                color: #1976d2;
                text-decoration: none;
                font-weight: bold;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <h1>Welcome to Page 2!</h1>
        <p><a href="/">Back to Home</a></p>
    </body>
    </html>
    """
    return html

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
