
  

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

  

Create an account: When the user creates an account, a new account and its data are added in the data base.

  

Log in: When the user puts the its correct information about email and password, he gain permission to the rest of the features in the app (excluding create an account).

  

See other people posts: When the user goes to the main page, he can see the other users posts.

  

Create a post: The user can create a post, adding a description and an image, that it then added to the database.

  

### User stories

  

  

-  **As a participant of the conference, I want to be able to create a post.**

  

Given that the user has already logged in the account, when he is a participant of the conference, then he is able to create a new post with an image.

  

-  **As a new user, I want to be able to create an account.**

  

Given that the user has interest in the events of the conference, the user wants an account to see all the posts and to identify his own posts.

  

-  **As an already registered user, I want to log in to access the system.**

  

Given that the user is already registered through an account, then he is able to log in to access the system.

  

-  **As a user, I want to be able to log off my account.**

  

Given that the user is already registered through an account and is also logged in, then he is able to log off the session.

  

-  **As a user, I want to be able to edit my profile. This includes changing my current profile picture and basic info such as name, date of birth...**

  

Given that the user is logged in, then he is able to edit his profile, namely name, picture, date of birth, etc.

  

-  **As a user, I want to be able to add someone else as a friend.**

  

Given that the user is already logged in, then he is able to see his friend's profile, namely name, picture and posts.

  

-  **As a user, I want to be able to check my friends' profiles and like/comment their posts.**

  

Given that the user is already logged in and his friend also has an account on the app, the user is able to add as his friend and like/comments his posts.

  

-  **As a user, I want to be able to check my calendar and the conference's event board.**

  

Given that the user is logged in, the user is able to check the conference events schedule.

  

-  **As a user, I want to be able to upload a story.**

  

Given that the user is logged in, the user is able to publish a quick story.

  

-  **As a forgetful user, I want to be able to request a password reset.**

  

Given that the user has already an account and is a human being that forgets things, he can reset his passoword and change it as much as he need.

  

**Mockup of the main page of the app**


![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/78345999_902245270177249_7848125922447196160_n.png?_nc_cat=102&_nc_ohc=SmWd1eH1DxsAQkPfCvnz6aiqFUW5SIEmA7MSClp-LqALZN8q92SZCTO9Q&_nc_ht=scontent.flis7-1.fna&oh=79faa27d737f79619cd5d0849f49e934&oe=5E4A680F)


**Mockup of a user's profile**

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/78100273_460598017795339_7395637176349753344_n.png?_nc_cat=103&_nc_ohc=58YX60gdIKMAQnfPT6549Vo3zX8MFbykp94kWbdEKnG-5srADABqR8RwA&_nc_ht=scontent.flis7-1.fna&oh=8cd5f9d24fae0bac7076009c738f87b9&oe=5E76807D)

  
  

  

### Domain model

  

  

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

  

  

---

  

  

## Architecture and Design

  

The architecture of a software system encompasses the set of key decisions about its overall organization.

  

  

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

  

  

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them.

  

  

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

  

  

### Logical architecture

  

The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

  

  

It can be beneficial to present the system both in a horizontal or vertical decomposition:

  

* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts;

  

* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

  

  

### Physical architecture

  

The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

  

  

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

  

  

### Prototype

  

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

  

  

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

  

  

---

  

  

## Implementation

  

Regular product increments are a good practice of product management.

  

  

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

  

  

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

  

  

---

  

## Test

  

  

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

  

  

In this section it is only expected to include the following:

  

* test plan describing the list of features to be tested and the testing methods and tools;

  

* test case specifications to verify the functionalities, using unit tests and acceptance tests.

  

A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

  

  

---

  

## Configuration and change management

  

  

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

  

  

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).

  

  

---

  

  

## Project management

The following pictures represent our Trello's state in each iteration, with labels for each one of them.

  

**Iteration 1:**

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/77237769_3353677271339142_4044629775623389184_n.png?_nc_cat=109&_nc_ohc=iOR9xpF5cYcAQmY8U48dzYHNowcy20ShsWa2qpgMd5k7N1pXrkT5x5Akg&_nc_ht=scontent.flis7-1.fna&oh=7d3e18d92655d3d77b4145da60ef8b44&oe=5E486DFC)

  

**Iteration 2:**

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/76937839_467558353870479_7474790013411000320_n.png?_nc_cat=101&_nc_ohc=AS3lslmtIgUAQlkdEEYiXtFlaiBEqcpYYsq_kMVvtf3oLzCZZZ1hawm7w&_nc_ht=scontent.flis7-1.fna&oh=991ff23d99370d50b51c576543ec5559&oe=5E444F05)

  

**Iteration 3:**

![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/76936388_533023950611187_3340751757557891072_n.png?_nc_cat=103&_nc_ohc=x6P8t4JIYsgAQlX1_ztjx0oJf0f7fSEjMvI4G8IWaanyMP7_AKlhVuNLg&_nc_ht=scontent.flis7-1.fna&oh=40dc26758a1bfc2cf44c3beb6d2c1be9&oe=5E7DE658)

**Iteration 4:**
![enter image description here](https://scontent.flis7-1.fna.fbcdn.net/v/t1.15752-9/80487873_575798133196154_1166426470923370496_n.png?_nc_cat=110&_nc_ohc=KBuPUx8p2XcAQnMqCktehD_gN9eqT76NgJsCfu7rSBlXqjFBdBrs2oRYQ&_nc_ht=scontent.flis7-1.fna&oh=ce817ed8290234590f478ac05e496c3e&oe=5E885C1B)