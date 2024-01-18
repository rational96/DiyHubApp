# diyhubapp

this app has an older version i created but crashed and corrupted.
i had a hard copy on my drive from before the crash so i started a new project with the backup


the app starts in the main page which directs it to login.

from login, it takes the user info and looks it up on the db. 

if login was succesful it will push the user info to the next page which is mainPage.dart.

this mainPage handles the navigation bar so that it doesnt neeed to be recoded.

every click on the navigation bar checks the data base and updates user info.

the mainPage opens the other screens such as projectPage, searchPage, and accountPage. 

the user info is also passed in everytime a new page is accessed. 

starting from the account page, it is supposed to display a list of projects that is stored in the users account file in the account collection.

clicking on a project does a search in the project collections to pull the info of the project. the project displays according to the project file in the collection.

using navigator.pop, we can go back to previous page.

we can create a project that saves the info inputed following the schema.

the account page has a signout which routes page back to login and also has a changePassword which handles password change.

password change looks up user info and chacks if old password matches.

then it updates with the new password and takes you back to account page.

the search page looks up a project with near similar names ffrom the projects collection and displays all info returned by the database.
