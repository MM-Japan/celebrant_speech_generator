# CelebrantGPT

CelebrantGPT is an AI-powered web application designed to assist in generating heartfelt celebrant speeches, using personalized input about the individual being honored.

---

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Technology Stack](#technology-stack)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Introduction
CelebrantGPT is crafted to help users quickly generate personalized speeches for loved ones. With user-friendly prompts, speech-to-text capabilities, and sentiment analysis, it simplifies the process of creating heartfelt and memorable tributes.

---

## Features
- **Sentiment Analysis**: Analyze the tone to ensure it captures the right sentiment.
- **Speech-to-Text**: Dictate thoughts directly into text fields for convenience.
- **Follow-Up Questions**: Gather detailed information with dynamically generated questions.
- **Responsive Design**: Mobile and desktop-friendly interface.

---

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/celebrantgpt.git
    cd celebrantgpt
    ```

2. **Install dependencies**:
    ```bash
    bundle install
    yarn install
    ```

3. **Set up the database**:
    ```bash
    rails db:create db:migrate db:seed
    ```

4. **Run the server**:
    ```bash
    rails server
    ```

---

## Usage

1. Navigate to `http://localhost:3000` in your web browser.
2. Start creating speeches by filling in initial information, answering follow-up questions, and generating a draft.
3. Customize and refine the generated speech, then view and download the final version.

---

## Technology Stack
- **Backend**: Ruby on Rails
- **Frontend**: HTML, CSS (Bootstrap), JavaScript
- **Database**: PostgreSQL
- **APIs**: ChatGPT API for generating speech content
- **Other Libraries**: Font Awesome for icons

---

## Contributing

1. Fork the repository.
2. Create a new branch for your feature (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

---

## License
This project is licensed under the MIT License.

---

## Contact
Creator: [Max McCain](http://www.maximmccain.com)
