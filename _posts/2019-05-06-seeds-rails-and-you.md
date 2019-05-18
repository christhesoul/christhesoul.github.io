---
title: Why you should Seed well in Rails
---
:seedling:

_This post is an extraction of my talk at Railsconf 2019, Minneapolis_.

<br>

Seeds in Rails have been around since the dinosaurs.

And the reason they live on is because putting a whole bunch of dummy data into your app is still a very good idea indeed.

If you're struggling to find the time and enthusiasm to work on your seeds file, then here's a whole bunch of benefits you'll find at the end of this particular rainbow.

### 1. Varied Local Environment

It is likely your application is in some way configurable by the user. And likely that your product team sees patterns of similar user configurations. These become implicit _stories_ in how your product is used.

Uncommon configurations will inevitably lead to bugs. Developers won't be aware of these configurations and their respective _gotchas_, meaning they won't write any tests for such contexts. And unless you've got a ridiculously-diligent QA process (which, let's be honest, will seriously slow down shipping frequency), it's likely those bugs will find their way up to production.

Seeding enables you to put those tricky accounts in the hands of the developer. A kind of _If it works here, it'll work anywhere!_ mentally.

(Disclaimer! It's highly unlikely the resulting code will actually work anywhere and everywhere, obviously, but those new lines should be _way_ more resilient.)

### 2. Consistent Local Environment

Using seeds gives everybody the _same_ varied local environments, and this gives your developers a common language with which to talk about problems.

Seed deliberate names of users and/or companies that evoke particular configurations in your app.

For example, our seeds file (for an accommodation booking platform) creates an inn with only single rooms called _The Lone Wolf_. Granted, such an establishment in real life would be uncommon, but this account immediately highlights issues if the developer writes code that makes some bad occupancy assumptions.

Developers now have a shortcut for testing new code in uncommon configurations. _"Have you tried this in The Lone Wolf?"_ becomes a perfectly valid code review comment.

### 3. Instant Local Environment

Setting up a local environment that gives the developer a clearer picture of what your application code actually _achieves_ in the real world makes onboarding new developers a truckload easier.

No more Slack calls to walk through setting up a local environment. No need for scrappy internal documentation on how to recreate a given scenario.

Just a seeds file and a simple command. (`rake db:reset` in Rails.) Lovely.

### 4. Resilient Local Environment

Production databases should be protected with all the care in the world.

But with a large application and a sloppy seeds file, your devs will start to consider their own local environment – built though the grit and pain of many years – to be just as precious as production.

Give them the freedom to experiment; to cataclysmically cock it all up – and then run `rake db:reset` to restore everything to its rightful place.

### 5. Prosperous Local Environment

As your app flourishes, so should your seeds file.

New models should bring new seeds, new columns will bring more colour, new features may bring entirely new contexts.

Give your developers the joy of a fully-loaded seeds file, and ask them to pass on that joy to the next developer by updating those seeds as necessary.

### 6. Buggy Local environment

Banish the _"I can't recreate the problem!"_ problem to a faraway land by *literally recreating the problem* in your seeds file.

No longer do you need to write Jira tickets that flap around trying to explain the problem – just a branch that fails horribly when I seed, go here, and do this.

### 7. Proud Local Environment

If you have customers that use your product regularly, or pay for it continually, then :clap: these :clap: claps :clap: are :clap: for :clap: you.

Your customers are probably reaping the rewards of having lots of organised data loaded into your application. In fact, the more data loaded into an account, the more you can see just how valuable your product actually is.

But a sloppy seeds file hides from your developers the joy your application brings to its valued customers.

Seeds give you the opportunity to build the most beautiful example of your account that your sales people could only dream of. Show your devs why your customers are using your product – make them proud to be working on something that looks this good!

### [BONUS] 8. Better Staging Environment

There's no need to limit your seeding to your local environment.

Staging often becomes a terrifying ode to what your product would look like if your customers truly hated it, but were forced to use it occasionally.

So use your seeds file in staging too. Nobody can stop you.

Now even your team members responsible for QA have a way to communicate issues more succinctly with your developers.

:ocean:
