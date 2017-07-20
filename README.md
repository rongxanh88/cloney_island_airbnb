# Cloney Island Airbnb

![Alt text](https://github.com/rongxanh88/cloney_island_airbnb/blob/development/app/screen_shots/first_homepage_shot.png?raw=true "Cloney Island Airbnb Homepage")

Cloney Island is a greenfield development project aiming to clone much of the functionality and design of Airbnb's platform. Some of the tasks included are as follows:

  * Meeting with an instructor to mimic a client and development team interaction
  * Test Driven Development
  * Tracking workflow on Pivatol Tracker
  * Supporting multitenancy
  * Using OAuth for user authentication
  * Creating a rake task that loads enough objects to create a somewhat realistic scale for production
  * Serving up an internal API
  * Using Javascript to update pages dynamically
  * Incorporating Twilio
  * Incorporating Action Cable to create real-time messaging

This project was developed by a group of 5 developers over a 10 day sprint. The project will be handed off to another team of 5 once completed for another 10 day, round 2 sprint. The second group will add onto functionality as they see fit.


### Prerequisites to Run Locally

  * [Rails version 5.1.2](http://installrails.com/)

  * [Ruby version 2.3.1](https://www.ruby-lang.org/en/documentation/installation/)
  
### Install Figaro

  * From the command line, input figaro exec bundle install. This command will create an application.yml file within the config directory to store all sensitive data. 
  
### Syncing with Twilio

  * Sign Up with a Trial Twilio Account. Set up a trial phone number on the Twilio website. Also provide a phone number that will be used as the phone to communicate with in development. Go to the console section and copy both the account SID and auth token. Inside of the config/application.yml file, (it may be hidden depending on your text editor and its current settings) enter the keys with the following environment variables:
  
TWILIO_ACCOUNT_SID: '#############################'  
TWILIO_AUTH_TOKEN: '############################'  
TWILIO_NUMBER: '+1 720-###-####'  

Once this is complete, your application should be able to send a verification code to the phone number provided on the Twilio website.

### Running Locally

  * Clone this repo.
  * cd into it
  * ```bundle install```
  * ```rake db:schema:load```
  * ```rake db:setup```
  *```rake import:all```
  *```rails server```
  * visit ```localhost:3000```

### Built With

 * Rails, Ruby, ActiveRecord, HTML, CSS, Sass, ERB, Haml, Postgresql, Twilio, ActionCable, OmniAuth Facebook

### To Run the Automated Rspec Test Suite

 * Simply input rspec from the command line

## Round 1 Authors

* **Adam Gunther** - [Github](https://github.com/adamgunther1)
* **William Thomas** - [Github](https://github.com/wthoma22)
* **Padraic O'Neill** - [Github](https://github.com/podoglyph)
* **Bao Nguyen** - [Github](https://github.com/rongxanh88)
* **Benjamin Ross** - [Github](https://github.com/Benja-Ross)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Turing School of Software & Design
