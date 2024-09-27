var http = require('http');
var fs = require('fs');
var path = require('path');

// This function return index.html file in case that the path is / or /index.html
http.createServer(function (req, res) {
    if (req.url === '/index.html' || req.url === '/') {
        fs.readFile(path.join(__dirname, 'index.html'), function (err, data) {
            if (err) {
                res.writeHead(500);
                res.end('Error loading index.html');
            } else {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.end(data);
            }
        });
    } else {
        res.writeHead(404);
        res.end('Not Found');
    }
    }
).listen(3000);

console.log('Server running at http://localhost:3000/');

// Create a connection to a local Redis instance
var redis = require('redis');
var client = redis.createClient({
    port: 6379,
    host: 'redis',
    password: 'password'
});

client.on('error', function (err) {
    console.log('Redis error: ' + err);
});
// Set a value
client.set('my test key', 'my test value', redis.print);
// Retrieve a value
client.get('my test key', function (error, result) {
    if (error) {
        console.log(error);
        throw error;
    }
    console.log('GET result ->' + result);
});
// Disconnect from the Redis client
client.quit();
