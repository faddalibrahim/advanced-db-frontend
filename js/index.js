document.addEventListener("DOMContentLoaded", () => {
  const BASE_URL = "http://localhost:3000";

  const loginForm = document.getElementById("loginForm");

  loginForm.addEventListener("submit", function (e) {
    e.preventDefault();

    const loginData = {
      email: loginForm["email"].value,
      password: loginForm["password"].value,
    };

    fetch(`${BASE_URL}/login`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(loginData),
    }).then((res) => {
      if (res.status === 200) {
        window.location.href = "http://localhost:3000/dashboard";
      } else {
        console.log("Invalid Credentials");
      }
    });
  });
});
