
# ✈️ Flight Booking Simulator with Dynamic Pricing

A Django-based web application written in **Python, HTML, CSS, and JavaScript**, designed to simulate flight bookings with **dynamic pricing logic** instead of fixed ticket prices.
This project was developed as part of an **internship**, focusing on backend logic, frontend interaction, and realistic airline-like booking simulation.

---

## 🎥 Project Overview


## 🌟 Features

* Users can **create an account**, **login**, and **logout** securely.
* Allows users to **search and book flights** with dynamically changing prices.
* Prices vary based on factors like **seat availability**, **time to departure**, and **demand**.
* Displays **booking details** and **ticket confirmation pages** after payment.
* Supports **one-way and round-trip** booking simulations.
* Users can **view their booking history**.
* **Admin panel** for managing flights, prices, and users.
* Clean and responsive UI for both desktop and mobile.
* Fully **self-contained** — no external airline APIs required.

---

## 🧩 Tech Stack

**Frontend:**

* HTML5
* CSS3
* JavaScript
* Bootstrap (optional layer for styling)

**Backend:**

* Python (Django Framework)

**Database:**

* PostgreSQL

**Development Tools:**

* Visual Studio Code
* Git & GitHub
* Django Template Engine
* SQLite (for initial testing)

---

## 🏗️ System Architecture

The project follows a **Three-Tier Architecture**:

### 1️⃣ Presentation Layer (Frontend)

* User interface for flight search, booking, and ticket management.
* Displays dynamic pricing updates in real time.

### 2️⃣ Application Layer (Backend - Django)

* Implements all business logic, including pricing algorithms, seat management, and payment simulation.
* Handles user authentication, flight search, and booking flow.

### 3️⃣ Data Layer (Database)

* Stores user, flight, and booking information.
* Maintains price adjustments and transaction records.

**Flow:**
`User → Django Views → Models → PostgreSQL Database → Response Rendered to Templates`

---

## ⚙️ Differentiation from Existing Systems

* **Pricing Model:** Existing systems use fixed or API-based prices, while this project applies **dynamic pricing algorithms**.
* **Purpose:** Commercial systems are built for real-world sales, while this focuses on **learning and experimentation**.
* **Integration:** Unlike real airline sites, it works **without any external APIs** — completely self-contained.
* **Complexity:** Real systems have heavy backend integrations; this project provides a **simplified yet realistic** logic-based simulation.
* **Customization:** Developers can easily modify or extend **pricing logic and business rules** for testing.

---

## 📂 Files & Directories

* **flight/** – main Django app directory.
* **templates/flight/** – contains all frontend templates.

  * `index.html` – Home page.
  * `search.html` – Flight search results page.
  * `book.html` – Flight booking form.
  * `payment.html` – Payment simulation page.
  * `payment_process.html` – Booking confirmation.
  * `ticket.html` – Printable flight ticket page.
  * `bookings.html` – User booking history.
  * `layout.html` – Base layout for all pages.
* **static/** – static files for frontend.

  * `css/` – Stylesheets.
  * `js/` – JavaScript files.
  * `img/` – Images.
* **models.py** – Contains database models for flights, bookings, and users.
* **views.py** – Contains all Django view functions.
* **urls.py** – Handles URL routing.
* **utils.py** – Contains helper functions.
* **requirements.txt** – Python dependencies.
* **manage.py** – Django management utility.

---

## 🧠 Future Scope

* 💡 **Coupon Code System:** Apply discounts during booking.(working on it)
* 💬 **Email Notifications:** Send booking and payment confirmations.
* 🔁 **in Flight Cancellation adding Refund Module.**
* 🧭 **Integration with Real Airline APIs** (like Amadeus, Skyscanner).
* 📊 **Admin Analytics Dashboard** – visualize pricing and booking trends.
---

## ⚡ Justification

* Fully **self-contained** — no need for live airline data.
* **Dynamic pricing simulation** teaches real-world airline strategies.
* **Mobile responsive** and easy to extend for academic or research purposes.
* Designed with **clear architecture** and **scalable logic**.

---

## 🛠️ Installation

1. **Install Python 3.9+**
   Download from [Python.org](https://www.python.org/downloads/).

2. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/flight-booking-simulator.git
   cd flight-booking-simulator
   ```

3. **Install Dependencies**

   ```bash
   pip install -r requirements.txt
   ```

4. **Run Migrations**

   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. **Create a Superuser (optional)**

   ```bash
   python manage.py createsuperuser
   ```

6. **Run the Server**

   ```bash
   python manage.py runserver
   ```

7. **Access the App**
   Visit `http://127.0.0.1:8000` in your browser.

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 👩‍💻 Author

**Roja Lakshmi Madduri**
Internship Project — *Flight Booking Simulator with Dynamic Pricing*
Developed using Django, PostgreSQL, and dynamic pricing logic.



