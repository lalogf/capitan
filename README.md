# Capitán: Agile education LMS ([Agile in the classroom](https://medium.com/laboratoria/the-agile-classroom-embracing-an-agile-mindset-in-education-ae0f19e801f3#.a4ii4k31d))

This project implements the main feature needed to support an [Agile classroom](https://medium.com/laboratoria/the-agile-classroom-embracing-an-agile-mindset-in-education-ae0f19e801f3#.a4ii4k31d). It is meant to be a shell around for our curricula and to include tools that help students learn more effectively along their learning journeys.

The project has been open-sourced so many others can benefit from a Learning Management System that supports agile from day one. Also it is a resource for students who want to see how the tools they are using are built and to give students the opportunity to contribute to a real open-source project.

## Contributing to the Site

If you're interested in contributing to the project, take a look at the [Contributing Page]() for more information.
For minor fixes, submit a pull request. Please coordinate with the project maintainers if you are interested in working on a large feature to avoid duplicate work.

### Getting Set Up

This site runs on **Ruby 2.3.1** and **Rails 4.2.1**

#### Installing the Site on your Local Machine

1. Make sure to fork this repository
2. When you have it cloned to your local machine make sure your Ruby version is 2.3.1.

##### Populating the Database

The `db/seeds.rb` file is used to populate essential information in order to use the system.  Use the command `rake db:seed` to populate the database. You can run it as many times as you'd like, it deletes all meta data and repopulates it with each run.  For now the seed file creates an administrator user but eventually when the curricula get open-sourced like this project it will create a demo site for you to use.

##### Custom configuration files

To avoid conflicts between developers and to store private environment variables like Github API key we use `figaro` gem. `figaro` creates a file called `application.yml` that's located in the `config/` directory but not checked into git (no, you can't have my passwords).

Check out the [Figaro Documentation](https://github.com/laserlemon/figaro) for a very easy-to-understand explanation of how the gem works. You basically just need to run `rails generate figaro:install` and populate the missing variables in `application.yml`.  You can find an example of the requested variables in `config/application.yml.example`.

##### Running the server

Run `rails server` the app should be running at `http://localhost:3000`.

This is basically all you need to get yourself set up with the repository. Of course, things not always go according to plan when installing things but I'm certain your google skills will light the way.

## Significant Contributors

Special thanks to all our Contributors, Translators and everyone that is using the project.

### Core maintainers (laboratoria's team)
* [Giancarlo Corzo](https://github.com/giancorzo)
* [Iván Medina](https://github.com/ivandevp)
* [Mercedes Zubieta](https://github.com/MercedesZubieta)
* [Maritza Sinti](https://github.com/MaritzaVst)

### External Contributors
* [Arun Kumar](https://github.com/arun1595)
