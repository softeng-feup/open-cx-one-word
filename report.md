  

  

# openCX-*One Word* Development Report

  

  

  

  

Welcome to the documentation pages of MyConference of **openCX**!

  

  

  

  

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP):

  

  

  

  

* Business modeling

  

  

  

*  [Product Vision](#Product-Vision)

  

  

  

*  [Elevator Pitch](#Elevator-Pitch)

  

  

  

* Requirements

  

  

  

*  [Use Case Diagram](#Use-case-diagram)

  

  

  

*  [User stories](#User-stories)

  

  

  

*  [Domain model](#Domain-model)

  

  

  

* Architecture and Design

  

  

  

*  [Logical architecture](#Logical-architecture)

  

  

  

*  [Physical architecture](#Physical-architecture)

  

  

  

*  [Prototype](#Prototype)

  

  

  

*  [Implementation](#Implementation)

  

  

  

*  [Test](#Test)

  

  

  

*  [Configuration and change management](#Configuration-and-change-management)

  

  

  

*  [Project management](#Project-management)

  

  

  

  

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

  

  

  

  

Please contact us!

  

  

  

Thank you!

  

  

  

Henrique Maciel de Freitas - 201707046

  

  

João Pedro Pinheiro de Lacerda Campus - 201704982

  

  

Luís Pedro Rodrigues de Morais - 200800621

  

  

Maria Inês Fernandes Alves - 201605335

  

  

Miguel Silveira Rosa - 201706956

  

  

  

---

  

  

  

  

## Product Vision

  

  

  

Greatly improve your conference experience while sharing memories and connecting with others.

  

  

  

  

---

  

  

  

## Elevator Pitch

  

  

Isn't connecting with other people one of the best parts of a conference? Our app, MyConference, makes sure that your experience is the best it could possibly be. Much like any other social network, you are able to add people at the conference as friends, create new posts - perhaps some thoughts about that amazing talk you just went to, or even a picture of your friends attending the event - and, naturally, comment and like your friend's posts. Besides that, our app will allow you to check all the events currently happening so you won't miss anything!

  

  

---

  

  

## Requirements

  

  

  

As a social network, MyConference aims at creating a way to let people interact and share experiences, making them able to create posts with pictures about their experience.

  

  

  

Security is something very important to MyConference. Once you create a post, nobody can alter your post, moreover nobody can create a post in your name, making your account truly yours.

  

  

  

MyConference focus on being user friendly. To this end, posting and creating an account is extremely streamlined, being both simple and fast.

  

  

  

### Use case diagram

  

  

  

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/79272077_618252938981359_473030337723629568_n.png?_nc_cat=107&_nc_ohc=q2zSkzByjYQAQmVVKFakLLzDjK8ItPtCis5SMyKlWZQcSfWvBTaeClPUg&_nc_ht=scontent.flis7-1.fna&oh=9e499acc9bf82192b0ac8ab3e278316c&oe=5E6D13F9)

  

  

  

**Create an account**

  

  

-  **Actor:** Conference attendee

  

-  **Description:** The user is able to create an account on our app.

  

-  **Preconditions and postconditions:**

  

- The user attending the conference must create an account to use our app.

  

- After creating an account, said account and its data is added to the data base.

  

  

  

-  **Normal flow:** to do

  

-  **Alternative flows and exceptions:** to do

  

  

**Log in the account**

  

  

-  **Actor:** Conference attendee

  

-  **Description:** The user is able to log in on their account.

  

-  **Preconditions and postconditions:**

  

- The user attending the conference must have an account previously created.

  

- After logging in correctly, the user is able to access the app and its features.

  

  

-  **Normal flow:**

  

- The user, when writing the correct info about their email and password, gains permission to access the rest of the app.

  

  

-  **Alternative flows and exceptions:** to do

  

  

**See other people's posts**

  

-  **Actor:** Conference attendee

  

-  **Description:** The user is able to see other people's posts on the main page.

  

-  **Preconditions and postconditions:**

  

- The user attending the conference must be logged in on their account and follow the people whose posts they want to see.

  

- While on the home page, the user can see all the posts of the users they follow.

  

-  **Normal flow:** to do

  

-  **Alternative flows and exceptions:** to do

  

  

**Create a post**

  

-  **Actor:** Conference attendee

  

-  **Description:** The user is able to create a post with and image and a description.

  

-  **Preconditions and postconditions:**

  

- The user attending the conference must be logged in on their account.

  

- After creating a post, its info is then added to the database.

  

-  **Normal flow:** to do

  

-  **Alternative flows and exceptions:** to do

  

  

### User stories

  

  

-  **As a participant of the conference, I want to be able to create a post.**

  

**Value: Must have**

**Effort: L**

Given that the user has already logged in the account, when he is a participant of the conference, then he is able to create a new post with an image.

  

  

  

-  **As a new user, I want to be able to create an account.**

  

  

**Value: Must have**

**Effort: M**

Given that the user has interest in the events of the conference, the user wants an account to see all the posts and to identify his own posts.

  

  

  

-  **As an already registered user, I want to log in to access the system.**

  

  

**Value: Must have**

**Effort: M**

Given that the user is already registered through an account, then he is able to log in to access the system.

  

  

  

-  **As a user, I want to be able to log off my account.**

  

  

**Value: Must have**

**Effort: M**

Given that the user is already registered through an account and is also logged in, then he is able to log off the session.

  

  

  

-  **As a user, I want to be able to edit my profile. This includes changing my current profile picture and basic info such as name, date of birth...**

  

  

**Value: Must have**

**Effort: L**

Given that the user is logged in, then he is able to edit his profile, namely name, picture, date of birth, etc.

  

  

  

-  **As a user, I want to be able to add someone else as a friend.**

  

  

**Value: Could have**

**Effort: M**

Given that the user is already logged in, then he is able to see his friend's profile, namely name, picture and posts.

  

  

  

-  **As a user, I want to be able to check my friends' profiles and like/comment their posts.**

  

  

**Value: Could have**

**Effort: L**

Given that the user is already logged in and his friend also has an account on the app, the user is able to add as his friend and like/comments his posts.

  

  

  

-  **As a user, I want to be able to check my calendar and the conference's event board.**

  

**Value: Could have**


**Effort: L**

  

  

Given that the user is logged in, the user is able to check the conference events schedule.

  

  

  

-  **As a user, I want to be able to upload a story.**

  

  

**Value: Could have**

**Effort: L**

Given that the user is logged in, the user is able to publish a quick story.

  

  

  

-  **As a forgetful user, I want to be able to request a password reset.**

  

  

**Value: Could have, not really necessary**

**Effort: M**

Given that the user has already an account and is a human being that forgets things, he can reset his password and change it as much as he needs.

  

  

  

**Mockup of the main page of the app**

 
![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/79737748_2852805594743671_8669470226611437568_n.png?_nc_cat=103&_nc_ohc=dM7VnA79NMkAQmqID835YcLYnrDmWG7FHbnlR-wJa8gEpY06-wox2VMCg&_nc_ht=scontent.flis7-1.fna&oh=932499bb52089740c9fc6e14210a6014&oe=5E718C51)

 **Mockup of a user's profile**

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/80016499_597417391017262_3422261316188897280_n.png?_nc_cat=108&_nc_ohc=wgsgwJpVKVgAQnnbmVGnJhnCr9sP0BBzbpU5Rpdx3alK49cAEkGW324Tg&_nc_ht=scontent.flis7-1.fna&oh=140ae56e72c4b9380e86bf7647b5e1db&oe=5EABF676) 

**Mockup of creating a post**


![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/79766803_450380825910113_7817101591256760320_n.png?_nc_cat=110&_nc_ohc=WCSAInrFto4AQlhpDqpgxWDLfeGxy_G9mwy6sBzX-ZGXbZbUmEGhLltcw&_nc_ht=scontent.flis7-1.fna&oh=226cc77ed884bea4c8a9ba423bf8ac32&oe=5EB1F0D4)
  
**Mockup of the event board**

  
![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/79860323_589007741833506_4829327460313071616_n.png?_nc_cat=103&_nc_ohc=OkTbtolSwW4AQm1Wox4n1tI834itTRNJL0tT9m2AM4FZcgvc6G-h93aEw&_nc_ht=scontent.flis7-1.fna&oh=a1bde0b7c659c1bc71eda693c22de394&oe=5E687798)

  

### Domain model

  

  

  

Use cases should be described textually.

  

  



  

  

Acceptance tests automated?

  

  

  

 
  

  

  

---

  

  

  

  

## Architecture and Design

  

The main focus of our architecture is based on the communication between the app and the server. This structure is due to the fact that almost all (if not all) of the user's possible interactions require communicating with the server's data base, be it the user creating a new post, or simply seeing all the posts of the other users: communicating with the server is essential.

The design of our server is established by elements "Collections" of Firebase. We chose this design because it was compatible/easy to implement with Flutter.

In our app we kept a simple and comprehensible design for the user. With this in mind, the functionalities of our app are separated into individual pages, making sure the user's experience is simple and new functionalities are relatively easy to implement.

### Logical architecture

  

Os diferentes inputs e outputs de data da conecção server-aplication

  

  

The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

  

  

  

  

It can be beneficial to present the system both in a horizontal or vertical decomposition:

  

  

  

* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts;

  

  

  

* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

  

  

  

  

### Physical architecture

The physical structure is simple, having only a route of communication between the app and the server - the app then gains access to the data base, being able to extract all the necessary information for its various functionalities.

  ![enter image description here](https://raw.githubusercontent.com/softeng-feup/open-cx-one-word/master/fisical%20diagram.png)  

### Prototype

  

  

  

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

  

  

  

  

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

  

  

  

  

---

  

  

  

  

## Implementation

  

**descrever o que fizemos em cada iteração, decisoes q tomamos etc**

  

  

---

  

  

  

## Test

  

  

  

  

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

  

  

  

  

In this section it is only expected to include the following:

  

  

  

* test plan describing the list of features to be tested and the testing methods and tools;

  

  

  

* test case specifications to verify the functionalities, using unit tests and acceptance tests.

  

  

  

A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

  

  

  

  

---

  

  

  

## Configuration and change management

  

**como seguimos a github flow, etc etc**

  

  

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

  

  

  

  

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).

  

  

  

  

---

  

  

  

  

## Project management

  

  

The following pictures represent our Trello's state in each iteration, with labels for each one of them.

  

  

**[Link to our Trello](https://trello.com/b/Q5mBN4ES)**

  

  

**Iteration 1:**

  

  

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/77237769_3353677271339142_4044629775623389184_n.png?_nc_cat=109&_nc_ohc=iOR9xpF5cYcAQmY8U48dzYHNowcy20ShsWa2qpgMd5k7N1pXrkT5x5Akg&_nc_ht=scontent.flis7-1.fna&oh=7d3e18d92655d3d77b4145da60ef8b44&oe=5E486DFC)

  

  

  

**Iteration 2:**

  

  

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/76937839_467558353870479_7474790013411000320_n.png?_nc_cat=101&_nc_ohc=AS3lslmtIgUAQlkdEEYiXtFlaiBEqcpYYsq_kMVvtf3oLzCZZZ1hawm7w&_nc_ht=scontent.flis7-1.fna&oh=991ff23d99370d50b51c576543ec5559&oe=5E444F05)

  

  

  

**Iteration 3:**

  

  

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/76936388_533023950611187_3340751757557891072_n.png?_nc_cat=103&_nc_ohc=x6P8t4JIYsgAQlX1_ztjx0oJf0f7fSEjMvI4G8IWaanyMP7_AKlhVuNLg&_nc_ht=scontent.flis7-1.fna&oh=40dc26758a1bfc2cf44c3beb6d2c1be9&oe=5E7DE658)

  

  

**Iteration 4:**


![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/80487873_575798133196154_1166426470923370496_n.png?_nc_cat=110&_nc_ohc=KBuPUx8p2XcAQnMqCktehD_gN9eqT76NgJsCfu7rSBlXqjFBdBrs2oRYQ&_nc_ht=scontent.flis7-1.fna&oh=ce817ed8290234590f478ac05e496c3e&oe=5E885C1B)

