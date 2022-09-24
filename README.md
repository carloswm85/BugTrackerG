# Bug Tracker Project

Local Description: 1 | BugTrackerG | ASP.NET Core Web App (Model-View-Controller) | Newer Web App | .NET Core 3.1 | Console Application

## Description

A bug tracking system (BTS) is a software application that is designed to help programmers to keep track of reported software bugs in their work. A major component of bug tracking system is a database that records facts and known bugs submitted by the tester. Bug Tracking System is an ideal solution to track the bugs of a product, solution or an application. Bug Tracking System allows individual or groups of developers to keep track of outstanding bugs in their product effectively.

- Bug tracking is a system which is used to solve out any type of bugs in any software. 
- Bug Tracking System ensures the user of it will be able track the bug details as well as the status of debugging.
- Bugs will be assigned to a person along with a bug id, screenshot, description, project name, etc.
- Bug can be submitted to the tester with an attachment for detailed report of the bug.
- Admin can maintain users, projects, organizations, bug categories, bug priorities, status of bug, etc.

## Functionality (Justification)

1. Web Based: A web application is superior in many ways to locally installed systems.
2. Increased Productivity: It can dramatically increase the productivity and accountability of individual employees by providing a documented workflow and positive feedback for good performance.
3. Quality of the Software: Better developed software.
3. One Shared, Central Location: No dependance of work tracking on emails, spreadsheets or local files is a must.
3. Accountability: Specific people is made accountable on what they're doing.
3. Paper Trails: Every update is permanently logged.


## Objectives

a. Application to keep track of bugs detected in a project being developed.
b. Real-time tracking solution to keep track of the bugs detected.
c. Tool to track the performance of the developer
d. To make an application bug free.
e. Efficient communication medium for project manager, developer and tester.
f. Maximum possibility for reporting a bug and debugging the issue.
g. Bug Tracking System is to test the application for the bugs and report it to the project manager and developer.
h. Store the bug information with a unique id in the database.
i. Easy to keep track of the bug and its resolving status.

## User permissions

- Developer
- Tester
- Project Manager
- Admin


## Data Base Diagram

https://dbdiagram.io/d/630d18910911f91ba5eda63e

### Reading

- https://dbdiagram.io/docs/ Tool to draw database diagrams (ERDs) by typing DSL code.
- https://www.dbml.org/home/ dbdiagram uses the popular DBML (Database Markup Language).

---

# IDEAS

## Some ideas I could implement

1. Background tasks (tareas en segundo plano).
2. Asynchronous programming:
  ```csharp
  var exists = await _ctx.Users.AnyAsync(u => u.Number == number);
  if (exists) return Conflict();

  _ctx.Users.Add(new User {
      // ...
  });
  await _ctx.SaveChangesAsync();
  ```
3. Real time requests (aplicaciones en tiempo real): Signal Alarm (?), Sockets (?)
4. Desing Patterns (types, and their classification):
    - Singleton (easier, common)
    - Mediator
    - Observable
    - Builder
    - Factory
    - Strategy
    - State
    - Fasate
    - Repository
    - Decorator
5. Unit Testing and Unit Coverage. Include TDD?