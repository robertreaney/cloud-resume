# PM Handoff Document

## Project Overview:

This cloud portfolio project is a public showcase of my skills as an Engineer (Data/ML/MLOps) and Data Scientist. The goal for this effort is to have proof of my abilities for both future job seeking. Additionally, this repo will allow myself and other contributors to have ownership of reusable code for solutions to common Data Science/ML/Software/DevOps challenges. I currently have an accessible website at `robertreaney.com` where a preliminary proof of concept is available.

## Key Objectives:

- Have a website for my resume at `robertreaney.com`
- Have a github respository impressive to headhunters at `https://github.com/robertreaney/cloud-resume`
- Have entire project structures and coded in a reusable way for leveraging as off-the-shelf solutions in futures efforts.

## Scope and Deliverables:

1. "Full-stack" engineering
    - Deliverable: `robertreaney.com`
    - Tasks:
        - obtain domain name
        - create proof of concept website front-end
        - create proof of concept website back-end with an api
        - serve website to the public via https
        - secure website by implementing https
2. MLOps
    - Deliverable: speech interaction with ChatGpt embedded in the website
    - Tasks:
        - Upgrade to https to access visitor microphone
        - Ingest visitor audio recording
        - Translate audio to text
        - Send text to chatGpt
        - Display output in UI
3. MLEng
    - Deliverable: Visitor interaction with ML model embedded in website
    - Tasks:
        - Define ML objective
        - Collect data for model
        - Train model
        - Deploy model behind an api
        - Create front-end for users to interact with the model
        - Create model monitoring Ops pipeline for deployment
4. Presentation
    - Deliverable: Add a "blog" page to website with a video showcasing communication skills

## Key Personnel:
Introduce team members and their roles, including the project manager taking over.

- **Robert Reaney**: Technical lead and responsible for all development.
- **Abby Paul**: Project manager.
- **Travis Brown**: Will be the lead on security and serve as reviewer for pull requests.
- **Kayla Kelly**: Will design UI/UX for the website.
- **Ryan Baxter**: Advisor on general codebase advancement and will assit in modernizing the front-end.
- **Alejandro Rojas**: Will assist with development of Machine Learning algorithms utilizes in the effort.
- **Ryan Abbott**: A Jr. Developer interested in becoming a Data Scientist wanting to get involved and grow his skills.

## Current Status:
Detail progress made, completed tasks, ongoing work, and challenges faced.

### Completed

1. Full Stack Engineering
    - created website prototype front-end
        - created html/css/js website
        - inputed my resume information into placeholder html template
        - put in some basic UI elements for the speech recognition demo (buttons + text box w/ scrollbar)
    - created website prototype back-end
        - created API with flask API
        - demonstrated initial audio file interaction with endpoints for speech recognition (record + playback) 
        - demonstrated s3 api interaction by storing audio files in s3
    - setup developer environment
        - structure repo with the following folders
            - `.github`: github action definition files (CI/CD automation)
            - `infrastrcuture`: infrastructure as code
            - `scripts`: helper scripts
            - `services`: application
                - `lambda`: AWS Lambda
                - `nginx`: NGINX server to serve our application to visitors and handle authentication (http/https)
                - `website`: front-end (html/css/js) and backend (python)
            - `docker-compose*`: automation logic to stand up application
        - created microservice acritecture to stand up our application stack with Docker and compose files for local development and production
        - automatically redirected logs to host machine
    - deployed website
        - created AWS EC2 instance as the hardware to serve the website on
        - cloned repo and stood up website with production docker compose
        - purchased `robertreaney.com` domain from AWS 53
        - setup elastic IP for redirection (static public IP address so our site address doesn't change every time we update our code)
        - redirected domain to elastic IP on AWS 53 to make our website public.
        - UNFINISHED: established https serving of website to allow access to visitor microphone
    - established infrastucture as code for AWS environment
        - EC2 & startup script
        - IAM identity management
        - ECR container registry
        - automated docker build/push to ECR


## Technical Overview:
Explain the technology stack, tools, and frameworks being used.

- `devops`: github actions, terraform, docker, docker compose, bash
- `front-end`: html/css/js
- `back-end`: python
- `productionization`: flask, 

## Minimum Viable Product (MVP):
Define core features and functionality constituting the MVP.

## Expectations and Goals:
Clearly state expectations for the new project manager.

- create proof of abilities to show potential employers
- the website is really just a vehicle to start writing code that I own for generally useful solutions 
- create a community of practice for general engineering for my friends to engage with and benefit from easy "lift and shifts" for their own resumes
- get experience delivering end to end solutions for problems in my domain 
- discover potential business ideas the comunity of practice would be able to work together to exploit

## Next Steps:
List immediate actions for the new project manager.

1. Full Stack Eng
    - Finish `https` authentication
        - I am having trouble figuring out the Certificate Authority registration
        - I have successfully made `robertreaney.com` public with http
    - finished audio record/playback handling placeholder demo
        - I need https to use visitor's microphones in production
        - In dev we can record/playback audio
    - integrate speech recognition model for speech-to-text
        - need to deploy a model to handle speech-to-text
        - need to mount S3 storage on our EC2 instance and establish file management for multiple visitors
    - prototype openai utilization with chatgpt passthrough speech generated text question
        - I have obtained and OpenAI API key
        - I also did some trivial querying of the api in python

## Additional Information

### MLEng

Q: Can you share more details about the ML objective you defined for visitor interaction with the embedded ML model?

A: I am imagining a rectangle that a user can draw lines in. When a user presses the 'start' button, water will flow across the canvas and display true physics against the drawn lines. The physics will be a machine learning model instead of a physics engine. There will be visuals to convey the complexities of the underlying model.

### Presentation

Q. For the "blog" page and video showcasing communication skills, what specific content or topics were you planning to cover?

A. Kayla had the idea to have me record some video describing some success/challenges/interesting pieces of the project as it progress.
    - discovering security: https motivation and journey