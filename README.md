# Splashbox

Hi-resolution photos delivered to your Dropbox.

Special thanks to [unsplash.com](http://unsplash.com) because without them this project would've never existed. This project was initially private and was intended to serve wide audience of users, not a single user. Now being open-source, it could ideally serve an individual or a small group of friends.

## Testimonials

#### [Luke Chesser](https://twitter.com/lukechesser), Product Designer @ Crew Labs

> I use Splashbox to store Unsplash photos locally. It makes it so easy to find and drop photos into any design. Splashbox also saves me a ton of time and gives me constant access to high-res photos, regardless of an internet connection.

#### [Pete Heslop](https://twitter.com/pwheslop), Director @ BrightByte Studio

> Splashbox allows us, as a small agency to deliver high quality stock images every time. We no longer have to search through fake, forced and expensive photography, we now have them delivered to our Dropbox. The seamless and simple integration with Dropbox means we never have to think again about our source of imagery.

#### [Matthew Smith](https://twitter.com/whale), Entrepreneur & Designer

> Splashbox has become a part of the innovative internet. Photographers get known and I get hundreds of visually interesting non-stock high-res photos at my disposal whenever I need them. Bonus.

#### [Owen Williams](https://twitter.com/ow)

> Splashbox delivers you the most beautiful wallpapers you can find online straight into your Dropbox. I dig having hundreds of wallpapers that automatically change on my Mac so I don't see the same thing every day, plus you can use them quickly when you need something for a project! I'll never go back.

## As Seen On

- [Unsplash](http://365.unsplash.com/)
- [Product Hunt](http://www.producthunt.com/posts/splashbox)
- [Function](http://wefunction.com/8-unique-places-to-find-quality-free-photos)
- [Charged](http://us8.campaign-archive2.com/?u=7ba9643cb80dac69c6818848c&id=d7df6165a7)
- [Universe](http://blog.uniiverse.com/2014/07/31/3-simple-tips-design-eye-catching-event-flyer)
- [Bianca Board](http://blog.web123partners.com.au/blog/9-free-non-stock-photos-sites.aspx)
- [SiteBuilderReport](http://www.sitebuilderreport.com/blog/where-the-best-designers-go-to-find-photos-and-graphics)

## Instructions

I. [Create a Dropbox application](https://www.dropbox.com/developers/apps) and grab your `DROPBOX_APP_KEY` and `DROPBOX_APP_SECRET`.

II. [Create an Embedly account](https://app.embed.ly/signup) and grab your `EMBEDLY_KEY`.

III. Setup the following environment variables in your local `.env` file and Heroku app(s):

````
DROPBOX_APP_KEY
DROPBOX_APP_SECRET
EMBEDLY_KEY
APP_HOST
````

IV. Setup the following scheduled rake tasks in Heroku Scheduler:

````
rake scrape
rake extract_colors
rake consumers_save_photos
````

## Features

### Gallery

Easily traverse through your images using the gallery located in the dashboard.

### Color Palette Extraction

Every photo extracted from [http://unsplash.com](http://unsplash.com) is sent through a color extraction process which associates an RGB color palette with every photo.

### Waitlist

By default a waitlist mechanism is enabled. All new user accounts are put into a "holding" pattern until an admin grants them access (through the console).

## Screenshots

![Screenshot 1](https://s3.amazonaws.com/f.cl.ly/items/3T2H3a0t0W3a3F0R2422/screenshot-1.jpg)

-----------------------------

![Screenshot 2](https://s3.amazonaws.com/f.cl.ly/items/0O2W101Z3V3z1m3q073j/screenshot-2.jpg)

-----------------------------

![Screenshot 3](https://s3.amazonaws.com/f.cl.ly/items/0G0e0443310b2b0m0L0X/screenshot-3.jpg)

## Credit

- [suspenders](https://github.com/thoughtbot/suspenders) — A Rails 4 template with Thoughbot standard defaults, ready to deploy to Heroku.
- [mechanize](http://mechanize.rubyforge.org/) — A library used for automating interaction with websites.
- [dropbox-api](https://github.com/futuresimple/dropbox-api) — Dropbox API Ruby Client.
- [embedly](https://github.com/embedly/embedly-ruby) — Ruby Embedly Client

## Authors

Christopher Hopkins

- [http://twitter.com/hopkinschris](http://twitter.com/hopkinschris)
- [http://github.com/hopkinschris](http://github.com/hopkinschris)

## License

You may use the Splashbox project under the terms of the [MIT License](https://github.com/hopkinschris/splashbox/blob/master/LICENSE).
