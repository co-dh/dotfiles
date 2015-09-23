

from wsgiref.simple_server import make_server

# A relatively simple WSGI application. It's going to print out the
# environment dictionary after being updated by setup_testing_defaults
def simple_app(environ, start_response):
    from subprocess import call
    call(['./refresh_chrome.sh'])

    status = '200 OK'
    headers = [('Content-type', 'text/plain')]

    start_response(status, headers)

    return 'ok' 

httpd = make_server('', 8002, simple_app)
print "Serving on port 8002..."
httpd.serve_forever()
