unraveled
==
[unraveled](unraveled.schenkc.com) is a clone of [ravelry](www.ravelry.com).  Unraveled was made by [Candace Schenk](schenkc.com) in the spring of 2014.


What is ravelry?
===

To quote them: Ravelry is a place for knitters, crocheters, designers, spinners, weavers and dyers to keep track of their yarn, tools, project and pattern information, and look to others for ideas and inspiration.

unraveled's features
===

Unraveled is smaller in scope, with social features more prominent.

* adding and tagging patterns

* searching patterns, tags, and users

* photo and pdf uploading

* notifications

* messaging

* following

* collecting other people's patterns

technologies used
=== 

The backend is Ruby on Rails.

The frontend has a little Backbone.js.  All styling was done by hand using CSS.  The HTML is semantic.

* the form for adding a pattern has nested attributes, and creates patterns along with associated tags, multiple photos, and pdf instructions.  File upload is handled using paperclip and AWS.

* searching is implemented using pg-search and displayed across multiple pages using kaminari

* notifications are implemented using a polymorphic model and some hand crafted callbacks.

* the messaging section is a full Backbone.js installation.  Multiple collections of data are bootstrapped in.

TODO
===

In the future, I hope to implement

* voting/rating to feature trending patterns and users

* password recovery/change email

* add icons

* photo carrousels on patterns' show pages
