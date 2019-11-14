# openCX-*One Word* Development Report

  

Welcome to the documentation pages of the *your (sub)product name* of **openCX**!

  

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

  

*team members names*

  

---

  

## Product Vision

Greatly improve your conference experience while sharing memories and connecting with others.
  

---

## Elevator Pitch
Isn't connecting with other people one of the best parts of a conference? Our app, MyConference, makes sure that your experience is the best it could possibly be. Much like any other social network, you are able to add people at the conference as friends, create new posts - perhaps some thoughts about that amazing talk you just (went to?), or even a picture of your friends attending the event - and, naturally, comment and like your friend's posts. Besides that, our app will allow you to check all the events
currently happening so you won't miss anything!
  
---
## Requirements

  

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

  

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

  

### Use case diagram

  

Create a use-case diagram in UML with all high-level use cases possibly addressed by your module.

  

Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun.

  

Briefly describe each use case mentioning the following:

  

*  **Actor**. Name only the actor that will be initiating this use case, i.e. a person or other entity external to the software system being specified who interacts with the system and performs use cases to accomplish tasks.

*  **Description**. Provide a brief description of the reason for and outcome of this use case, or a high-level description of the sequence of actions and the outcome of executing the use case.

*  **Preconditions and Postconditions**. Include any activities that must take place, or any conditions that must be true, before the use case can be started (preconditions) and postconditions. Describe also the state of the system at the conclusion of the use case execution (postconditions).

  

*  **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system.

*  **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions.

  

### User stories

  

-  **As a participant of the conference, I want to be able to create a post.**

Given that the user has already logged in the account, when he is a participant of the conference, then he is able to create a text post.

-  **As a new user, I want to be able to create an account.**

?????

-  **As an already registered user, I want to log in to access the system.**

Given that the user has already registered an account, then he is able to log in to access the system.
-  **As a user, I want to be able to log off my account.**

Given that the user has already registered an account,  then he is able to log off the account.
-  **As a user, I want to be able to edit my profile. This includes changing my current profile picture and basic info such as name, date of birth...**

Given that the user is logged in, then he is able to edit his profile, namely name, picture, date of birth, etc.

-  **As a user, I want to be able to add someone else as a friend.**

Given that the user is already logged in, then he is able to edit his profile, namely name, picture, date of birth, etc.
-  **As a user, I want to be able to check my friends' profiles and like/comment their posts.**

Given that the user is already logged in and his friend also has an account on the app, the user is able to add his friend and like/comments his posts.
-  **As a user, I want to be able to check my calendar and the conference's event board.**

-  **As a user, I want to be able to upload a story.**

-  **As a forgetful user, I want to be able to request a password reset.**

  

Here is a simple mockup of our app:

  

![Mockup](https://scontent.fopo2-1.fna.fbcdn.net/v/t1.15752-9/72754104_500403967470192_3034766695274119168_n.png?_nc_cat=111&_nc_oc=AQnn9mLuEGrXANtZ_W-uuwwv4JwYcRG1U_5Jlja9NQLRstANSQpyCZUceXOtihJY8ky-XU63pRRRs3FSIVXj5B_7&_nc_ht=scontent.fopo2-1.fna&oh=b7ef8be069947c60a3b1d1f61aea98c6&oe=5E629E81)

  
  

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

  

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

  

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

  

Example of tools to do this are:

*  [Trello.com](https://trello.com)

*  [Github Projects](https://github.com/features/project-management/com)

*  [Pivotal Tracker](https://www.pivotaltracker.com)

*  [Jira](https://www.atlassian.com/software/jira)

  

We recommend to use the simplest tool that can possibly work for the team.