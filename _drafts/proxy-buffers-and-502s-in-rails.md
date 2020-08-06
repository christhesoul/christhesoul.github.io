On my first day back at work after a week-long break, getting to the bottom of some annoying 502s on our beta (staging) server was not really what I had in mind.

But I did it anyway. And here's some things I discovered (and reacquainted myself with) along the way.

The dreaded 502.

A quick Google will tell you that:

> 502 Bad Gateway server error response code indicates that the server, while acting as a gateway or proxy, received an invalid response from the upstream server.

Okay. So this begs a couple of questions:

1. What is my server acting as a gateway or proxy?
2. What is my upstream server?

In my case, the server acting as gateway or proxy is the Nginx web server, and the upstream server is Puma, running my Rails application. So, basically, Rails is sending a response that Nginx can't handle.

Now the problem is that because the Rails application isn't _failing_ per se, you're not going to find an error in Rollbar, or whatever error monitoring tool you happen to use.

What we need here is to dig into the Nginx logs to see what's happening.

Now, I feel very uncomfortable digging around in servers, so the prospect of trying to find these Nginx logs fills me dread. But finding them will be the fast route to solving this problem.

My fear is exacerbated when I remember that we are using a magical Docker tool called `nginx_proxy`. This sets up a Docker container running Nginx and reloads Nginx when other containers are started and stopped.

Which is brilliant. But where are my logs?
